/* global $ */
$(document).on('turbolinks:load', function() {
    window.onload = function() {
    const scrollHeight = document.getElementById("group-chat-area").scrollHeight;
    document.getElementById("group-chat-area").scrollTop = scrollHeight;
  };
});