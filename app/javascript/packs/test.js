const milliseconds = 60000
const sync = () => {
  $.ajax({
    type: 'GET',
    url: $(location).attr('href'),
    dataType: 'script'
  })
}
const interval = setInterval(sync, milliseconds)
$(document).on('turbolinks:before-cache turbolinks:before-render', () => clearTimeout(interval))