$(document).ready(function() {
  $(document).on("ajax:success", ".vote", function (e) {
    var up_vote_link = e.detail[0].up_vote_link;
    var down_vote_link = e.detail[0].down_vote_link;
    var score = e.detail[0].score;

    $(this).find(".score").replaceWith(score);
    $(this).find(".up").replaceWith(up_vote_link);
    $(this).find(".down").replaceWith(down_vote_link);
  });
});