$(document).ready(function() {
    $(document).on('ajax:success', '#contributors .create', function(e) {
        $('#contributors').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('click', '#contributors .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});
