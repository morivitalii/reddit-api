$(document).ready(function() {
  $(document).on('ajax:success', '.sidebar__community-follow-link', function (e) {
    var follow = e.detail[0].follow;
    var followers_count = e.detail[0].followers_count;

    $(".sidebar__community-followers-counter").text(followers_count);

    if(follow === true) {
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