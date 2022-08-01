/* global $*/
/* global location $*/
  const milliseconds = 300000;
  const sync = function() {
    $.ajax({
      type: 'GET',
      url: $(location).attr('href'),
      dataType: 'script'
    });
  };
  const interval = setInterval(sync, milliseconds);
  $(document).on('turbolinks:before-cache turbolinks:before-render', () => clearTimeout(interval));
