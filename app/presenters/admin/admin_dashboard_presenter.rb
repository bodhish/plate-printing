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
          plates: plates_used_in_month
        }
      ]
    end

    def plates_used_on_day
      plates_used_by_size(plates_on_day)
    end

    def plates_used_in_month
      plates_used_by_size(plates_in_month)
    end

    def total_jobs_on_day
      total_jobs_by_customers(jobs_on_day)
    end

    def total_jobs_in_month
      total_jobs_by_customers(jobs_in_month)
    end

    def jobs_on_day
      @jobs_on_day ||= PrintJob.where(job_on: date_window)
    end

    def jobs_in_month
      @jobs_in_month ||= PrintJob.where(job_on: month_window)
    end

    def plates_in_month
      PlateJob.joins(:print_job).where(print_job: jobs_in_month)
    end

    def wastage_in_month
      jobs_in_month.where.not(wastage: nil)
    end

    def plates_on_day
      @plates_on_day ||= PlateJob.joins(:print_job).where(print_job: jobs_on_day)
    end

    def wastage_on_day
      jobs_on_day.where.not(wastage: nil)
    end

    def date_window
      @date_window ||= date.beginning_of_day..date.end_of_day
    end

    def month_window
      @month_window ||= date.beginning_of_month..date.end_of_month
    end

    def week_window
      @week_window ||= week_start..(week_start + 6.days)
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
      dimension_ids_count = plates.group('plate_dimension_id').count
      PlateDimension.all.map do |d|
        {
          size: d.dimension,
          qty: dimension_ids_count[d.id] || 0
        }
      end
    end

    def total_jobs_by_customers(jobs)
      customer_ids_count = jobs.group('customer_id').count
      Customer.where(id: customer_ids_count.keys).map do |c|
        {
          name: c.name,
          qty: customer_ids_count[c.id]
        }
      end
    end
  end
end
