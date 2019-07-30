$(document).ready(function() {
    $(document).on('ajax:success', '.createCommentForm', function (e) {
        $('.comments').first().prepend(e.detail[0].activeElement.innerHTML);
        format_datetime();
        // TODO
        $('#create_post_comment_text').val('');
    });
});