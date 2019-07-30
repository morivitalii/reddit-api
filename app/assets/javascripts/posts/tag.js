$(document).ready(function() {
    $(document).on('ajax:success', '.tag', function(e) {
        $(this).closest('.post').append(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        $('.modal').modal('show');
    });

    $(document).on('keyup', '.tagForm .search', function(e) {
        $('.tagForm .tag').show();
        var value = $('.tagForm .search').val();
        $('.tagForm .tag:not(:contains("' + value + '"))').hide();
    });

    $(document).on('click', '.tagForm .tag', function(e) {
        console.log($(this).text());
        var tag = $.trim($(this).text());
        $('#update_post_tag').val(tag);
    });

    $(document).on('ajax:success', '.post .tagForm', function (e) {
        var new_tag = e.detail[0].tag;
        var current_tag = $(this).closest('.post').find('.info .tag');

        if(new_tag.length === 0) {
            $(current_tag).remove();
        } else {
            if ($(current_tag).length === 0) {
                $(this).closest('.post').find('.info').append('<span class="tag">' + new_tag + '</span>');
            } else {
                $(current_tag).text(new_tag);
            }
        }

        $('.modal').modal('hide');
    });
});