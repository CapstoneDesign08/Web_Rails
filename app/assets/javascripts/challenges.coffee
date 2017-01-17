# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).bind('click', '.Apprised',->
  waitime();
);

run = ->
  $(document).bind('click', '.Apprised',->
    waitime();
  );

waitime =->
  $(document).unbind('click');
  $ dt = new Date()
  $ dt.setMinutes(dt.getMinutes()+1);
  $('.result').text("prediction time - "+dt.toTimeString())
  $('.Apprised').value("wait...")
  setTimeout(run, 60000)

