module PrintJobs
  class NewPresenter < ::ApplicationPresenter
    def plate_dimensions
      options = PlateDimension.all.map do |plate|
        ["#{plate.dimension} (#{plate.name})", plate.id]
      end

      [["Select a plate", 0]] + options
    end

    def customers
      options = Customer.all.map do |customer|
        [customer.name, customer.id]
      end

      [["Select a customer", 0]] + options
    end

    def next_ref_no
      (PrintJob.last&.ref_no || 0) + 1
    end

    def plate_pricings
      PlatePricing.all.group_by(&:customer_id).each_with_object({}) do |(k, v), result|
        result[k] = v.each_with_object({}) do |plate_price, mapping|
          mapping[plate_price.plate_dimension_id] = plate_price.price
        end
      end
    end
  end
end
