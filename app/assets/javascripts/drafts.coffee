$ ->
  $('#draft-form').on("ajax:success", (e, data, status, xhr) ->
    # do nothing on success (redirect to drafts index)
  ).on("ajax:error", (e, xhr, status, error) ->
    message = xhr.responseText
    alert(message)
  )