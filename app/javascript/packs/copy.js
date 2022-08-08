/* global $*/
$(document).on('turbolinks:load', function() {
  $('#copy_btn').on('click', function(e) {
    const text = $('#copy_id').val();
    const $textarea = $('<textarea><textarea>');
    $textarea.val(text);
    $(this).append($textarea);
    $textarea.select();
    document.execCommand('copy');
    $textarea.remove();
    const btnText = $(this).text();
    $(this).text('コピーしました！');
    setTimeout(() => {
      $(this).text(btnText);
    }, 800);
  });
});