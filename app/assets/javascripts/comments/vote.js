$(document).ready(function() {
  $(document).on("ajax:success", ".comment__votes", function (e) {
    var up_vote_link = e.detail[0].up_vote_link;
    var down_vote_link = e.detail[0].down_vote_link;
    var score = e.detail[0].score;

    $(this).find(".comment__score").replaceWith(score);
    $(this).find(".comment__up-vote-link").replaceWith(up_vote_link);
    $(this).find(".comment__down-vote-link").replaceWith(down_vote_link);
  });
});