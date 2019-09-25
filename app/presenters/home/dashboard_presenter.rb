module Home
  class DashboardPresenter < ::ApplicationPresenter
    def date
      params[:date_filter] ? Time.zone.strptime(params[:date_filter][:for_date], '%d-%m-%y'): Time.zone.now
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
      PrintJob.where(created_at: date_window).includes(:customer, plate_jobs: :plate_dimension).order(created_at: :desc)
    end

    private

    def jobs_in_month
      PrintJob.where(created_at: month_window)
    end

    def plates_in_month
      PlateJob.where(print_job: jobs_in_month).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_in_month
      PlateJob.where(print_job: jobs_in_month).sum(:wastage)
    end

    def plates_on_day
      PlateJob.where(print_job: jobs_on_day).map { |pj| pj.set * pj.color }.sum
    end

    def wastage_on_day
      PlateJob.where(print_job: jobs_on_day).sum(:wastage)
    end

    def date_window
      date.beginning_of_day..date.end_of_day
    end

    def month_window
      date.beginning_of_month..date.end_of_month
    end
  end
end
