$(document).ready(function() {
    $(document).on('click', '#logs .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });
});
