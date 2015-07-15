massUpdate = ->
  $(".update-all-numbers").click( (e) ->
    # e.preventDefault()
    $("form.edit_phone_number, form.edit_ppc_number").each( ->
      formDetails = $(this).serialize()
      action = $(this).attr('action')
      $.ajax( {
                type: "PUT",
                url: action,
                data: formDetails
              } )
    )

    $("form.new_ppc_number").each( ->
      formDetails = $(this).serialize()
      action = $(this).attr('action')
      $.ajax( {
                type: "POST",
                url: action,
                data: formDetails
              } )
    )

    alert "All phone numbers for this location are being updated. If you don't see your changes right away, please refresh the page in a few seconds."
  )

$(document).ready(massUpdate)
$(document).on('page:load', massUpdate)