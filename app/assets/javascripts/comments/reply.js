$(document).ready(function() {
    $(document).on('ajax:success', '.comment .reply', function(e) {
        var comments = $(this).closest('.comment').find('.comments').first();

        $('.replyCommentForm').remove();
        $(comments).prepend(e.detail[0].activeElement.innerHTML);
    });

    $(document).on('click', '.replyCommentCancel', function(e) {
        $(this).closest('.replyCommentForm').remove();
    });

    $(document).on('ajax:success', '.replyCommentForm', function(e) {
        $(this).replaceWith(e.detail[0].activeElement.innerHTML);
        format_datetime();
        // TODO
    });
});