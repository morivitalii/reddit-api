$(document).ready(function() {
    $(document).on("ajax:success", ".vote", function (e) {
        var new_up_vote_link = e.detail[0].up_vote_link;
        var new_down_vote_link = e.detail[0].down_vote_link;
        var new_score = e.detail[0].score;

        $(this).find(".score").replaceWith(new_score);
        $(this).find(".up").replaceWith(new_up_vote_link);
        $(this).find(".down").replaceWith(new_down_vote_link);
    });
});