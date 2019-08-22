$(document).ready(function() {
  $(document).on('ajax:success', '.bookmark', function(e) {
    var bookmark_link = e.detail[0].bookmark_link;

    $(this).tooltip("hide");
    $(this).replaceWith(bookmark_link);
    $('[data-toggle="tooltip"]').tooltip();
  });
});