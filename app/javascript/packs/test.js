/* global $*/
/* global location $*/
$(document).on('turbolinks:load', function() {
  const milliseconds = 10000;
  const sync = function() {
    $.ajax({
      type: 'GET',
      url: $(location).attr('href'),
      dataType: 'script'
    });
  };
  const interval = setInterval(sync, milliseconds);
$(document).on('turbolinks:before-cache turbolinks:before-render', () => clearTimeout(interval));
});