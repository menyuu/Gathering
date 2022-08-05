/* global $*/
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    padding: 10,
    nextSelector: 'a.next',
  });
})