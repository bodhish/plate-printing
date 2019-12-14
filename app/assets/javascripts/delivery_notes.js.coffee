class App.DeliveryNotes extends App.Base
  index: =>
    $('#delivery_note_print_jobs').parent().hide()
    jobs = $('#delivery_note_print_jobs').html()
    $('#delivery_note_customer_id').change ->
      customer = $('#delivery_note_customer_id :selected').text()
      jobOptions = $(jobs).filter("optgroup[label='#{customer}']").html()
      if jobOptions
        $('#delivery_note_print_jobs').html(jobOptions)
        $('#delivery_note_print_jobs').parent().show()
      else
        $('#delivery_note_print_jobs').empty()
        $('#delivery_note_print_jobs').parent().hide()