$ ->

  clickActiveTab = () ->
    activeTab = $('#active_tab').val()
    if(activeTab)
      $('#my-page-tab_'+activeTab).click()

  clickActiveTab()

  $('.js-my-page-tab').on('click', (e) ->
    $('.active').removeClass('active')
    $(this).closest('.js-my-page-tab').addClass('active')
  )