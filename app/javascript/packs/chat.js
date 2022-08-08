/* global$ */
  window.onload = function() {
  if (document.getElementById("group-chat-area")) {
    const scrollHeight = document.getElementById("group-chat-area").scrollHeight;
    document.getElementById("group-chat-area").scrollTop = scrollHeight;
  }
};