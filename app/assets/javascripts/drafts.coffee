$ ->
  $('#item_content').on("keyup", (e) ->
    text = $(this).val()
    $.ajax(
      type: 'GET',
      url: '/markdown/preview',
      data: { text: text }
    )
  )

  selectCurrentItem = () ->
    current_id = $('#current_id').val()
    if(current_id)
      $('#draft_item_'+current_id).click()

  selectCurrentItem()

  $('.draft_item').on('click', (e) ->
    $('.selected').removeClass('selected')
    $(this).children().addClass('selected')
  )