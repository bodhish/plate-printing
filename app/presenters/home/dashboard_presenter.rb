module Home
  class DashboardPresenter < ::ApplicationPresenter
    def jobs
      PrintJob.all.includes(:customer, plate_jobs: :plate_dimension).last(10).reverse
    end
  end
end
