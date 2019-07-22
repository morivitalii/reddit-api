$(document).ready(function() {
    $(document).on('ajax:success', '#blacklisted_domains .create', function(e) {
        $('#blacklisted_domains').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });
});
