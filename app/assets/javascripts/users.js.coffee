# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#pay_with_free').click ->
  alert("HI");
  $('#paid').hide()
  $('#free').show()
  true
$('#pay_with_paypal').click ->
  $('#paid').show()
  $('#free').hide()
  true