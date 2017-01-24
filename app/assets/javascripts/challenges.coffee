# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ cnt=1

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
      if(json==""&&cnt<4)
        $('.result').text("don't touch button. retry - "+ cnt)
        $ cnt=cnt+1
        setTimeout(chgresult,20000)
      else if(cnt>=4)
        $('.result').text("Time Over. Please, Restart.")
    )
    error: (request, status, error) ->(
#alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      $('.result').text("TEST error")
    )
  );

run = ->
  chgresult();
  cnt=1
  $('.Apprised').click(->waitime());

waitime =->
  $('.Apprised').unbind("click");
  $ dt = new Date()
  $ dt.setSeconds(dt.getSeconds()+60);
  $('.result').text("prediction time - "+dt.toTimeString())
  setTimeout(run, 40000);
