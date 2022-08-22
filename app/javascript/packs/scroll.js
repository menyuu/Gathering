/* global $*/
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    autoTrigger: true,
    loadingHtml: `<div class="spinner"><div class="dot1"></div><div class="dot2"></div></div>`,
    padding: 10,
    contentSelector: '.jscroll',
    nextSelector: 'a.next',
  });
});