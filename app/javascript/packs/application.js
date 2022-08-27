// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

window.jQuery = window.$ = require('jquery')
import "jquery";
import "./jquery.jscroll.min.js";
import "popper.js";
import "bootstrap";
import '@fortawesome/fontawesome-free/js/all';
import "../stylesheets/application";
import "./scroll";
import "./menu";
import "./flash";
import "./input";
import "./copy";
import "./chat";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
