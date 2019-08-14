$(document).ready(function() {
    $(document).on('ajax:success', '.follow', function (e) {
        if($(this).data('method') === 'post') {
            $(this).attr('data-method', 'delete');
            $(this).data('method', 'delete');
            $(this).text('Отписаться');
        } else {
            $(this).attr('data-method', 'post');
            $(this).data('method', 'post');
            $(this).text('Подписаться');
        }
    });
});