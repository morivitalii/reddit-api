//= require jquery
//= require rails-ujs
//= require moment/moment
//= require moment/locale/ru
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require bootstrap-select/dist/js/bootstrap-select
//= require bootstrap-select/dist/js/i18n/defaults-ru_RU
//= require_tree ./errors
//= require datetime
//= require notification
//= require_tree .

$(document).ready(function() {
    // Format datetime after page load
    format_datetime();

  // Trigger tooltips after page load
  $('[data-toggle="tooltip"]').tooltip();

  // Remove modal after close
  $(document).on('hidden.bs.modal', '.modal', function (e) {
    $('.modal').remove();
  });

  // Redirect after form successful confirmation
  $(document).on('ajax:success', 'form', function (e) {
    if(e.detail[2].getResponseHeader('Location') !== null) {
      window.location.href = e.detail[2].getResponseHeader('Location');
    }
  });

  // Header navigation
  $('.first-header__communities-navigation').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
    window.location.href = $('.first-header__communities-navigation option').eq(clickedIndex).data("href");
  });
});

