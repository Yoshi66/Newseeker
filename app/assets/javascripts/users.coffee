# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "form#sign_up_user", (e, data, status, xhr) ->
    if data.success
      window.location.href = ''
      $('#sign_up').modal('hide')
      $('#sign_up_button').hide()
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      $('#text').html("Please type correct email")

#http://natashatherobot.com/devise-sign-up-ajax-rails/