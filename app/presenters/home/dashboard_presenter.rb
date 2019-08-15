module Home
  class DashboardPresenter < ::ApplicationPresenter
    def jobs
      PrintJob.all.includes(:customer, plate_jobs: :plate_dimension).take(10)
    end
  end
end
