module Home
  class DashboardPresenter < ::ApplicationPresenter
    def date
      @date ||= params[:filter].try(:[], :date) ? Time.zone.strptime(params[:filter][:date], '%d-%m-%Y') : Time.zone.now
    end

    def monthly_stats
      {
        jobs: jobs_in_month.count,
        plates: plates_in_month,
        wastage: wastage_in_month
      }
    end

    def daily_stats
      {
        jobs: jobs_on_day.count,
        plates: plates_on_day,
        wastage: wastage_on_day
      }
    end

    def weekly_target_stats
      week_start = prior_saturday(date)
      target = WeeklyTarget.find_by(start_on: week_start)&.plate_count || 450

      plates_used = PlateUsage.joins(:print_job).where(print_job: PrintJob.where(job_on: week_start..(week_start + 6.days))).map { |pj| pj.set * pj.color }.sum
      percentage_completed = ((plates_used.to_f / target) * 100).to_i

      {
        target: target,
        plates_used: plates_used,
        week_start: week_start.strftime('%b %e'),
        week_end: (week_start + 6.days).strftime('%b %e'),
        percentage_completed: percentage_completed,
        color_class: (percentage_completed < 25 ? 'bg-danger' : (percentage_completed < 75 ? 'bg-warning' : 'bg-success'))
      }
    end

    def jobs_on_day
      @jobs_on_day ||= begin
        if job_id.present?
          PrintJob.where(id: job_id)
        else
          PrintJob.where(customer_id: filtered_customer_ids).where(job_on: date_window).includes(:customer, plate_usages: :plate_dimension).order(created_at: :desc)
        end
      end
    end

    def customer_dropdown_options
      Customer.all.order(:name).map { |c| [c.name, c.id] }
    end

    private

    def jobs_in_month
      PrintJob.where(customer_id: filtered_customer_ids).where(job_on: month_window)
    end

    def plates_in_month
      PlateUsage.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_in_month).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_in_month
      PlateUsage.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_in_month).sum(:wastage)
    end

    def plates_on_day
      PlateUsage.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_on_day).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_on_day
      PlateUsage.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_on_day).sum(:wastage)
    end

    def date_window
      date.beginning_of_day..date.end_of_day
    end

    def month_window
      date.beginning_of_month..date.end_of_month
    end

    def job_id
      @job_id ||= params[:filter].try(:[], :date) ? params[:filter][:job_id] : ""
    end

    def filtered_customer_ids
      @filtered_customer_ids ||= params[:filter].try(:[], :customer_id).present? ? params[:filter][:customer_id] : Customer.all.pluck(:id)
    end

    def prior_saturday(date)
      days_before = (date.wday + 1) % 7
      date.to_date - days_before
    end
  end
end
