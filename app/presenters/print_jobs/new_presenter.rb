module PrintJobs
  class NewPresenter < ::ApplicationPresenter
    def plate_dimensions
      options = PlateDimension.all.map do |plate|
        [plate.dimension, plate.id]
      end

      [["Select a plate", 0]] + options
    end

    def customers
      options = Customer.all.map do |customer|
        [customer.name, customer.id]
      end

      [["Select a customer", 0]] + options
    end
  end
end