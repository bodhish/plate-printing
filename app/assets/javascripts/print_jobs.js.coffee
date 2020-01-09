class App.PrintJobs extends App.Base
  new: =>
    $('#plate_usages').on 'cocoon:after-insert', (e, insertedItem, originalEvent) ->
      $('.plate-dimension-dropdown').change ->
        plateDimensionId = $(this).val()
        customerId = $('#print_job_customer_id').val()
        priceInput = $(this).closest('.nested-fields').find("input[id$='_price']").first()
        if plateDimensionId < 1 || customerId < 1
          priceInput.val(0)
        else
          # TODO: Set value from preloaded data
          priceInput.val(customerId + plateDimensionId)