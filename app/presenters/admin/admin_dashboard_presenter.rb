module Admin
  class AdminDashboardPresenter < ::ApplicationPresenter


    def plates_used_array
      [
        {
          title: 'Today',
          plates: plates_used_on_day
        },
        {
          title: 'This Month',
          plates: plates_used_in_month,
        },
        {
          title: 'By customers',
          plates: total_plates_by_customer,
          key: 'Name'
        }
      ]
    end

    def total_jobs_array
      [
        {
          title: 'Jobs Today',
          date_window: date.strftime('%b %e'),
          customers: total_jobs_on_day
        },
        {
          title: 'Jobs This Week',
          date_window: "#{week_start.strftime('%b %e')}..#{week_end.strftime('%b %e')}",
          customers: total_jobs_in_week
        },
        {
          title: 'Jobs This Month',
          date_window: "#{date.beginning_of_month.strftime('%b %e')}..#{date.end_of_month.strftime('%b %e')}",
          customers: total_jobs_in_month
        }
      ]
    end

    def plates_wasted_array
      [
        {
          title: 'Today',
          jobs: wastage_on_day
        },
        {
          title: 'This Week',
          jobs: wastage_in_week
        },
        {
          title: 'This Month',
          jobs: wastage_in_month
        }
      ]
    end

    private

    def plates_used_on_day
      plates_used_by_size(plates_on_day)
    end

    def plates_used_in_month
      plates_used_by_size(plates_in_month)
    end

    def total_jobs_on_day
      total_jobs_by_customers(jobs_on_day)
    end

    def total_jobs_in_week
      total_jobs_by_customers(jobs_in_week)
    end

    def total_jobs_in_month
      total_jobs_by_customers(jobs_in_month)
    end

    def jobs_on_day
      @jobs_on_day ||= PrintJob.where(job_on: date_window)
    end

    def jobs_in_week
      @jobs_in_week ||= PrintJob.where(job_on: week_window)
    end

    def jobs_in_month
      @jobs_in_month ||= PrintJob.where(job_on: month_window)
    end

    def plates_in_month
      @plates_in_month ||= PlateJob.joins(:print_job).where(print_job: jobs_in_month)
    end

    def plates_on_day
      @plates_on_day ||= PlateJob.joins(:print_job).where(print_job: jobs_on_day)
    end

    def plates_in_week
      @plates_in_week ||= PlateJob.joins(:print_job).where(print_job: jobs_in_week)
    end

    def wastage_in_month
      total_wastage(plates_in_month.where.not(wastage: 0))
    end

    def wastage_on_day
      total_wastage(plates_on_day.where.not(wastage: 0))
    end

    def wastage_in_week
      total_wastage(plates_in_week.where.not(wastage: 0))
    end

    def date_window
      @date_window ||= date.beginning_of_day..date.end_of_day
    end

    def month_window
      @month_window ||= date.beginning_of_month..date.end_of_month
    end

    def week_window
      @week_window ||= week_start..week_end
    end

    def week_end
      @week_end ||= week_start + 6.days
    end

    def date
      @date ||= Time.zone.now
    end

    def week_start
      @week_start ||= prior_saturday(date)
    end

    def prior_saturday(date)
      days_before = (date.wday + 1) % 7
      date.to_date - days_before
    end

    def plates_used_by_size(plates)
      dimension_ids_count = plates.group('plate_dimension_id').sum('color * set')
      PlateDimension.all.map do |d|
        {
          size: d.dimension,
          qty: dimension_ids_count[d.id] || 0
        }
      end.sort_by { |pd| -pd[:qty] }
    end

    def total_jobs_by_customers(jobs)
      customer_ids_count = jobs.group('customer_id').count
      Customer.where(id: customer_ids_count.keys).map do |c|
        {
          name: c.name,
          qty: customer_ids_count[c.id]
        }
      end.sort_by { |c| -c[:qty] }
    end

    def total_plates_by_customer
      customer_plates = {}
      jobs_in_month.includes(:plate_jobs).each do |pm|
        customer_plates[pm.customer.id] = (customer_plates[pm.customer.id] || 0) + pm.plate_jobs.map { |pj| pj.set * pj.color }.sum
      end

      Customer.where(id: customer_plates.keys).map do |c|
        {
          size: c.name,
          qty: customer_plates[c.id]
        }
      end.sort_by { |c| -c[:qty] }
    end

    def total_wastage(jobs)
      cache = {}
      jobs.pluck(:print_job_id, :wastage).each do |id, count|
        cache[id] = count
      end
      PrintJob.where(id: cache.keys).map do |p|
        {
          ref_no: p.ref_no,
          wastage: cache[p.id]
        }
      end.sort_by { |pj| -pj[:wastage] }
    end
  end
end
