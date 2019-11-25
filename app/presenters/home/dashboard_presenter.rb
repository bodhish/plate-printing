module Home
  class DashboardPresenter < ::ApplicationPresenter
    def date
      @date ||= params[:filter].try(:[],:date) ? Time.zone.strptime(params[:filter][:date], '%d-%m-%Y'): Time.zone.now
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

    def jobs_on_day
     @jobs_on_day ||= PrintJob.where(customer_id: filtered_customer_ids).where(job_on: date_window).includes(:customer, plate_jobs: :plate_dimension).order(created_at: :desc)
    end

    def customer_dropdown_options
      Customer.all.order(:name).map { |c| [c.name, c.id] }
    end

    private

    def jobs_in_month
      PrintJob.where(customer_id: filtered_customer_ids).where(job_on: month_window)
    end

    def plates_in_month
      PlateJob.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_in_month).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_in_month
      PlateJob.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_in_month).sum(:wastage)
    end

    def plates_on_day
      PlateJob.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_on_day).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_on_day
      PlateJob.joins(:print_job).where(print_jobs: { customer_id: filtered_customer_ids }).where(print_job: jobs_on_day).sum(:wastage)
    end

    def date_window
      date.beginning_of_day..date.end_of_day
    end

    def month_window
      date.beginning_of_month..date.end_of_month
    end

    def filtered_customer_ids
      @filtered_customer_ids ||= params[:filter].try(:[],:customer_id).present? ? params[:filter][:customer_id] : Customer.all.pluck(:id)
    end
  end
end
