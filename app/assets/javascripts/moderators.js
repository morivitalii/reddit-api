$(document).ready(function() {
    $(document).on('ajax:success', '#moderators .create', function(e) {
        $('#moderators').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('click', '#moderators .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});