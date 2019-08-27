function format_datetime() {
  $(".datetime-short, .datetime-ago").each(function (index) {
    $(this).tooltip({
      title: moment($(this).data("timestamp"), "X").format("ddd, D MMMM YYYY, HH:mm:ss"),
    });
  });

  $(".datetime-short").each(function (index) {
    $(this).html(moment($(this).data("timestamp"), "X").format("D MMMM YYYY"));
  });

  $(".datetime-ago").each(function (index) {
    $(this).html(moment($(this).data("timestamp"), "X").fromNow());
  });
}