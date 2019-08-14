$(document).ready(function() {
    $(document).on('ajax:success', '.tag', function(e) {
        $(this).closest('.post').append(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        $('.modal').modal('show');
    });
});