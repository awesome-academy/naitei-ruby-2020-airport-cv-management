/* Theme Name: Jobya - Responsive Landing Page Template
   Author: Themesdesign
   Version: 1.0.0
   File Description: Main JS file of the template
*/

import 'selectize/dist/js/selectize.min.js'
import './nice-select'

(function ($) {

  'use strict';


  // Loader 
  $(window).on('load', function () {
    $('#status').fadeOut();
    $('#preloader').delay(350).fadeOut('slow');
    $('body').delay(350).css({
      'overflow': 'visible'
    });
  });

  $(document).ready(function () {
    $('#status').fadeOut();
    $('#preloader').delay(350).fadeOut('slow');
    $('body').delay(350).css({
      'overflow': 'visible'
    });
  });

  // Selectize
  $('#select-category, #select-lang,#select-country').selectize({
    create: true,
    sortField: {
      field: 'text',
      direction: 'asc'
    },
    dropdownParent: 'body'
  });

  // Checkbox all select
  $('#customCheckAll').click(function () {
    $('.all-select').prop('checked', $(this).prop('checked'));
  });

  // Nice Select
  $(document).on('turbolinks:load', function() {
    $('select.nice-select').niceSelect('destroy');
    $('select.nice-select').niceSelect();
  })

  // Back to top
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $('.back-to-top').fadeIn();
    } else {
      $('.back-to-top').fadeOut();
    }
  });

  $('.back-to-top').click(function () {
    $('html, body').animate({ scrollTop: 0 }, 3000);
    return false;
  });

  if (window.location.href.includes('/signup') || window.location.href.includes('/login') || window.location.href.includes('/password_resets')) {
    $('#topnav').hide()
    $('.footer').hide()
  }

})(jQuery)
