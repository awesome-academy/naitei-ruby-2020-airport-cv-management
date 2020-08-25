const Rails = require("@rails/ujs");

$(document).ready(function () {
  $('li.option').on('click', function(event) {
    $(this).parents('div.nice-select').siblings('select.nice-select').val($(this).attr('data-value'))
    const form = $(this).closest("form")[0];

    Rails.fire(form, 'submit');
  });
})
