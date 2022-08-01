/* global $*/
$(document).on('turbolinks:load', function() {
  $('#form').click(function() {
    const name = $('#input-name').val();
    const email = $('#input-email').val();
    const password = $('#input-password').val();
    const passwordConfirmation = $('#input-password-confirmation').val();
    $('#output-name').val(name);
    $('#output-email').val(email);
    $('#output-password').val(password);
    $('#output-password-confirmation').val(passwordConfirmation);
  });
});