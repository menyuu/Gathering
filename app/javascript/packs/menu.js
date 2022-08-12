/* global $ */

$(document).on('turbolinks:load', function() {
  $('#searchMenuTrigger').on('click', function(){
    $('.search-form-out').toggleClass('search-form-in');
  });
});

