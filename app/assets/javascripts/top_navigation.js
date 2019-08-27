$(document).ready(function() {
  $('#navigation').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
    window.location.href = $('#navigation option').eq(clickedIndex).data("href");
  });
});