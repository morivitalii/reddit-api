$(document).ready(function() {
    $(document).on("ajax:success", ".vote", function (e) {
        var type = e.detail[0].type;
        var score = e.detail[0].score;
        var up_active_class = "text-success";
        var down_active_class = "text-danger";
        var data_attribute = "data-params";
        var up_data = "create_vote[type]=up";
        var down_data = "create_vote[type]=down";
        var meh_data = "create_vote[type]=meh";
        var up_vote_link = $(this).find(".up");
        var down_vote_link = $(this).find(".down");
        var score_element = $(this).find(".score");

        $(score_element).text(score);

        if (type === "up") {
            $(up_vote_link).attr(data_attribute, meh_data);
            $(down_vote_link).attr(data_attribute, down_data);
            $(up_vote_link).addClass(up_active_class);
            $(down_vote_link).removeClass(down_active_class);
        } else if(type === "down") {
            $(up_vote_link).attr(data_attribute, up_data);
            $(down_vote_link).attr(data_attribute, meh_data);
            $(up_vote_link).removeClass(up_active_class);
            $(down_vote_link).addClass(down_active_class);
        } else if(type === "meh") {
            $(up_vote_link).attr(data_attribute, up_data);
            $(down_vote_link).attr(data_attribute, down_data);
            $(up_vote_link).removeClass(up_active_class);
            $(down_vote_link).removeClass(down_active_class);
        }
    });
});