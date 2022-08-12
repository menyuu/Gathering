/* global $*/
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="spinner"><div class="dot1"></div><div class="dot2"></div></div>`
  });
})