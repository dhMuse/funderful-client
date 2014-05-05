# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.ajax
    url: "http://localhost:3000/api/v1/campaigns"
    dataType: "json"
    method: "get"
    error: ->
      alert("error")
    success: (data) ->
      template = $("#campaign-listing-template").html()
      Mustache.parse(template)
      for campaign in data
        rendered_template = Mustache.render(template, campaign)
        $("#campaigns").append(rendered_template)
  $("#campaigns").on "click", ".title", ->
    $.ajax
      url: "http://localhost:3000/api/v1/campaigns/" + $(@).data("id")
      dataType: "json"
      method: "get"
      error: ->
        alert("Error")
      success: (data) ->
        template = $("#single-campaign-display").html()
        rendered = Mustache.render(template, data)
        $("#single-campaign-container").hide()
        $("#single-campaign-container").html rendered
        $("#campaigns").fadeOut 700, ->
          $("#single-campaign-container").fadeIn(300)
    false