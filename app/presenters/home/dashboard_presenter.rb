module Home
  class DashboardPresenter < ::ApplicationPresenter
    def jobs_to_display
      PrintJob.where(created_at: date_window).includes(:customer, plate_jobs: :plate_dimension).reverse
    end

    def jobs_in_month
      PrintJob.where(created_at: month_window)
    end

    def plates_used
      PlateJob.where(print_job: jobs_in_month).map { |pj| pj.set * pj.color }.sum
    end

    def date
      params[:for_date] ? Time.zone.parse(params[:for_date]) : Time.zone.now
    end

    private

    def date_window
      date.beginning_of_day..date.end_of_day
    end

    def month_window
      date.beginning_of_month..date.end_of_month
    end
  end
end
