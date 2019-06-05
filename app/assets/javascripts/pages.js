$(document).ready(function() {
    $(document).on('ajax:success', '#pages .delete', function(e) {
        $(this).closest('.entry').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '#pages .confirm', function(e) {
        var entry = $(this).closest('.entry');
        $('.modal').modal('hide');
        entry.remove();
    });
});
