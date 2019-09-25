$(document).ready(function() {
  $(document).on('ajax:success', '.post__approve-link', function(e) {
    var new_approve_link = e.detail[0].approve_link;
    var new_remove_link = e.detail[0].remove_link;
    var approve_link = $(this);
    var remove_link = $(this).siblings(".post__remove-link");

    $(".modal").modal("hide");
    $(approve_link).tooltip("hide");
    $(remove_link).tooltip("hide");
    $(approve_link).replaceWith(new_approve_link);
    $(remove_link).replaceWith(new_remove_link);
    $('[data-toggle="tooltip"]').tooltip();
  });
});