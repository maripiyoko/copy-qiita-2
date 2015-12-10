$ ->
  $('#item_content').on("keyup", (e) ->
    text = $(this).val()
    $.ajax(
      type: 'GET',
      url: '/markdown/preview',
      data: { text: text }
    )
  )