/* global $*/
/* global location */

// 5分に設定
const milliseconds = 300000;
// ajax処理を行う
const sync = function() {
  $.ajax({
    type: 'GET',
    url: $(location).attr('href'),
    dataType: 'script'
  });
};
const interval = setInterval(sync, milliseconds);
// 5分おきにajax処理を行ってトップページを更新する
$(document).on('turbolinks:before-cache turbolinks:before-render', () => clearTimeout(interval));
