# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getLocationData = () ->
  navigator.geolocation.getCurrentPosition (position) ->
    document.cookie = "lat_long=#{position.coords.latitude}|#{position.coords.longitude}"
    location.reload()

getLocationData() unless /lat_long=/.test(document.cookie)
