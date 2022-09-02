 /*global $*/
$(document).on('turbolinks:load', function(){
  $('#text-input-area').on("keyup", function() {
    let countNum = $(this).val().length;
    if (Math.sign(200 - countNum) === 1) {
      $('#counter').text("残り" + String(200 - countNum) + "文字").css('color', 'black');
    } else {
      $('#counter').text("残り" + String(200 - countNum) + "文字").css('color', 'red');
    }
  });
});