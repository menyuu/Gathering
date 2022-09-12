/* global $ */

$(document).on('turbolinks:load', function() {
  $('#searchMenuTrigger').on('click', function(){
    $('.search-form-out').toggleClass('search-form-in');
  });
  $('.menu-btn').on('click', function() {
    $('.header-menu').toggleClass('header-menu-active');
  });
  $(document).on('click', function(e) {
    if(!$(e.target).closest('.menu-btn').length) {
      $('.header-menu').removeClass('header-menu-active');
    }
  });
  $('.notification-btn-container').on('click', function() {
    $('.notification-index').toggleClass('notification-index-active');
  });
  $(document).on('click', function(e) {
    if(!$(e.target).closest('.notification-btn-container').length) {
      $('.notification-index').removeClass('notification-index-active');
    }
  });
});

