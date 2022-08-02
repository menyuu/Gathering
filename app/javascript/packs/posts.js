/* global $*/
/* global location */
$(document).on('turbolinks:load', function() {
  $('.post-link').on('click', function(e) {
    e.stopPropagation();
    e.preventDefault();
    location.href = $(this).attr('data-link');
    location.href = $(this).attr('data-favorite-link');
  });
});
