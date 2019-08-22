$(document).ready(function() {
  var fields_to_hide_on_init = ["url", "media"];

  $.each(fields_to_hide_on_init, function(index, value) {
      $(".createPostForm #create_post_" + value).parent(".form-group").addClass("d-none");
  });

  $(document).on("click", "#newPost .nav-item a", function(e) {
    $("#newPost .nav-item a").removeClass("active");
    $(this).addClass("active");

    var fields = ["text", "url", "media"];
    $.each(fields, function(index, value) {
        $(".createPostForm #create_post_" + value).parent(".form-group").addClass("d-none");
    });

    var target = $(this).data("target");
    $(".createPostForm #create_post_" + target).parent(".form-group").removeClass("d-none");
  });
});