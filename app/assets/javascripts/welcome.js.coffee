$ ->
  $.ajax
    url: "http://localhost:3000/api/v1/campaigns"
    dataType: "json"
    method: "get"
    data:
      access_token: "8a821b27dea0720bb4f6829215dd4b4a"
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
      data:
        access_token: "8a821b27dea0720bb4f6829215dd4b4a"
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
  $("#single-campaign-container").on "click", ".back", ->
    $("#single-campaign-container").fadeOut 700, ->
      $("#campaigns").fadeIn(300)