$(document).ready(function() {
    $(document).on('ajax:success', '.comment .update', function(e) {
        $('.content').show();
        $('.updateCommentForm').remove();
        $(this).closest('.comment').find('.content').first().hide();
        $(this).closest('.comment').find('.content').first().after(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.menu .dropdown-toggle').dropdown('toggle');
    });

    $(document).on('click', '.updateCommentCancel', function(e) {
        $(this).closest('.comment').find('.content').first().show();
        $(this).closest('.updateCommentForm').remove();
    });

    $(document).on('ajax:success', '.updateCommentForm', function(e) {
        var text = $(e.detail[0].activeElement.innerHTML).find('.content').html();
        $(this).closest('.comment').find('.content').first().html(text);
        $(this).closest('.comment').find('.content').first().show();
        $(this).remove();
    });
});