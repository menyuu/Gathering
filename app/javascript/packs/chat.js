/* global $ */
$(document).on('turbolinks:load', function() {
    window.onload = function() {
    if (document.getElementById("group-chat-area")) {
      const scrollHeight = document.getElementById("group-chat-area").scrollHeight;
      document.getElementById("group-chat-area").scrollTop = scrollHeight;
    }
  };
});

$(document).on('turbolinks:load', function() {
    window.onload = function() {
    if (document.getElementById("chat-area")) {
      const scrollHeight = document.getElementById("chat-area").scrollHeight;
      document.getElementById("chat-area").scrollTop = scrollHeight;
    }
  };
});