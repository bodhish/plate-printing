class App.PrintJobs extends App.Base
  new: =>
    $('#plate_usages').on 'cocoon:after-insert', (e, insertedItem, originalEvent) ->
      $('.plate-dimension-dropdown').change ->
        plateDimensionId = $(this).val()
        customerId = $('#print_job_customer_id').val()
        priceInput = $(this).closest('.nested-fields').find("input[id$='_price']").first()
        platePricings = priceInput.data('platePricings')
        if customerId > 0 and plateDimensionId > 0 and customerId of platePricings and plateDimensionId of platePricings[customerId]
          priceInput.val(platePricings[customerId][plateDimensionId])
        else
          priceInput.val(0)
    $('#print_job_customer_id').change ->
      $("input[id$='_price']").val(0)