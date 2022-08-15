/* global $*/
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="spinner"><div class="dot1"></div><div class="dot2"></div></div>`
  });
  $('.postTagsJscroll').jscroll({
    contentSelector: '.postTagsJscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="tag-spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>`
  });
  $('.tagsJscroll').jscroll({
    contentSelector: '.tagsJscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="tag-spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>`
  });
  $('.genresJscroll').jscroll({
    contentSelector: '.genresJscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="tag-spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>`
  });
  $('.gamesJscroll').jscroll({
    contentSelector: '.gamesJscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="tag-spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>`
  });
  $('.usersJscroll').jscroll({
    contentSelector: '.usersJscroll',
    padding: 10,
    nextSelector: 'a.next',
    loadingHtml: `<div class="tag-spinner"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>`
  });
});