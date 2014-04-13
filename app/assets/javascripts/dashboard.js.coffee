# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getLocationData = () ->
  offset = new Date().getTimezoneOffset() / 60
  navigator.geolocation.getCurrentPosition (position) ->
    document.cookie = "lat_long=#{position.coords.latitude}|#{position.coords.longitude}"
    document.cookie = "timezone_offset=#{offset}"
    location.reload()

getLocationData() unless /(?=.*lat_long)(?=.*timezone_offset)/.test(document.cookie)
