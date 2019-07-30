$(document).ready(function() {
    $(document).on('ajax:success', '.loadMore', function(e) {
        $(this).parent('.comments').find('.toBranch').remove();
        $(this).parent('.comments').append($(e.detail[0].activeElement.innerHTML).html());
        $(this).remove();

        // TODO remove
    });
});