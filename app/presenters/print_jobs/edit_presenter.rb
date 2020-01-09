module PrintJobs
  class EditPresenter < ::ApplicationPresenter
    def initialize(view_context, print_job)
      super(view_context)
      @print_job = print_job
    end

    def plate_dimensions
      PlateDimension.all.map do |plate|
        ["#{plate.dimension} (#{plate.name})", plate.id]
      end
    end

    def customers
      Customer.all.map do |customer|
        [customer.name, customer.id]
      end
    end

    def plate
      @print_job.plate_usages.where(is_wasted: false).last
    end
  end
end
