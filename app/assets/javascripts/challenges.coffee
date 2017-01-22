# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(->
  $('.Apprised').click(->waitime());
);

chgresult =->
  $.ajax(
    type : 'GET',
    url: '/applicants/logging/' + $('#current_id').val(),
    dataType: 'text',
    success: (json) ->(
      $('.result').text(json)
    )
    error: (request, status, error) ->(
#alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      $('.result').text("TEST error")
    )
  );
  $('.Apprised').unbind("click");

run = ->
  $('.Apprised').val("Apprise");
  chgresult();
  $('.Apprised').click(->waitime());

waitime =->
  $('.Apprised').unbind("click");
  $ dt = new Date()
  $ dt.setMinutes(dt.getMinutes()+1.5);
  $('.result').text("prediction time - "+dt.toTimeString())
  $('.Apprised').val("wait...")
  setTimeout(run, 10000);
