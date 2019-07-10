function load_things_actions(things) {
    var ids = things.map(function() { return $(this).data("id") }).get();
    var user_signed_in = $('.user-signed-in').length > 0;

    if(ids.length > 0 && user_signed_in) {
        Rails.ajax({
            url: "/t/actions",
            type: "POST",
            data: "ids=" + ids,
            success: function(data) {
                $('[data-toggle="tooltip"]').tooltip('hide');

                $(".thing").each(function() {
                    var actions_html = $(data).find("[data-id=\"" + $(this).data("id") + "\"]");

                    if ($(actions_html).length > 0) {
                        var comments_count = $(actions_html).find(".comments_count");
                        $(this).find(".actions .comments_count").replaceWith(comments_count);

                        var votes = $(actions_html).find(".vote");
                        $(this).find(".actions .vote").replaceWith(votes);

                        var bookmark = $(actions_html).find("> .bookmark");
                        if($(this).find(".actions .bookmark").length > 0) {
                            $(this).find(".actions .bookmark").replaceWith(bookmark);
                        } else {
                            $(this).find(".actions").append(bookmark);
                        }

                        var approve = $(actions_html).find("> .approve");
                        if($(approve).length > 0) {
                            if($(this).find(".actions .approve").length > 0) {
                                $(this).find(".actions .approve").replaceWith(approve);
                            } else {
                                $(this).find(".actions").append(approve);
                            }
                        }

                        var destroy = $(actions_html).find("> .delete");
                        if($(destroy).length > 0) {
                            if($(this).find(".actions .delete").length > 0) {
                                $(this).find(".actions .delete").replaceWith(destroy);
                            } else {
                                $(this).find(".actions").append(destroy);
                            }
                        }

                        var menu = $(actions_html).find(".menu");
                        if($(menu).length > 0) {
                            if($(this).find(".actions .menu").length > 0) {
                                $(this).find(".actions .menu").replaceWith(menu);
                            } else {
                                $(this).find(".actions").append(menu);
                            }
                        }
                    }
                });

                $('[data-toggle="tooltip"]').tooltip();
            }
        });
    }
}

$(document).ready(function() {
    load_things_actions($(".thing"));

    $(document).on('ajax:success', '.thing .vote', function (e) {
        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .bookmark', function(e) {
        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .actions .explicit', function(e) {
        var explicit = $(this).closest('.thing').find('.info .explicit');

        if (explicit.length === 0) {
            $(this).closest('.thing').find('.info').append('<span class="explicit">18+</span>');
        } else {
            explicit.remove();
        }

        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .actions .spoiler', function(e) {
        var spoiler = $(this).closest('.thing').find('.info .spoiler');

        if (spoiler.length === 0) {
            $(this).closest('.thing').find('.info').append('<span class="spoiler">Спойлер</span>');
        } else {
            spoiler.remove();
        }

        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .actions .ignore_reports', function(e) {
        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .actions .notifications', function(e) {
        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .approve', function(e) {
        load_things_actions($(this).closest('.thing'));
    });

    $(document).on('ajax:success', '.thing .delete', function(e) {
        $(this).closest('.thing').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');

        if($(this).hasClass("dropdown-item") === true) {
            $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        }
    });

    $(document).on('ajax:success', '.thing .deleteForm', function (e) {
        load_things_actions($(this).closest('.thing'));
        $('.modal').modal('hide');
    });

    $(document).on('change', '.thing .deleteForm .removalReasons', function() {
        if ($(this).val().length !== 0) {
            $('#mark_thing_as_deleted_deletion_reason').val($(this).val());
        }
    });

    $(document).on('ajax:success', '.thing .reports', function(e) {
        $(this).closest('.thing').append(e.detail[0].activeElement.innerHTML);
        $('[data-toggle="tooltip"]').tooltip();
        format_datetime();
        $('.modal').modal('show');

        if($(this).hasClass("dropdown-item") === true) {
            $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        }
    });

    $(document).on('click', '#reports .toggleDetails', function() {
        $(this).closest('.entry').find('.details').toggleClass('d-none');
    });

    $(document).on('ajax:success', '.thing .actions .tag', function(e) {
        $(this).closest('.thing').append(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        $('.modal').modal('show');
    });

    $(document).on('keyup', '.thing .tagForm .search', function(e) {
        $('.tagForm .tag').show();
        var value = $('.tagForm .search').val();
        $('.tagForm .tag:not(:contains("' + value + '"))').hide();
    });

    $(document).on('click', '.thing .tagForm .tag', function(e) {
        var value = $.trim($(this).text());
        $('#update_thing_tag_tag').val(value);
    });

    $(document).on('ajax:success', '.thing .tagForm', function (e) {
        var tag = $(this).closest('.thing').find('.info .tag');

        if(e.detail[0].tag.length === 0) {
            tag.remove();
        } else {
            if (tag.length === 0) {
                $(this).closest('.thing').find('.info').append('<span class="tag">' + e.detail[0].tag + '</span>');
            } else {
                tag.text(e.detail[0].tag);
            }
        }

        $('.modal').modal('hide');
    });

    $(document).on('ajax:success', '.thing .report', function(e) {
        $(this).closest('.thing').append(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.dropdown-toggle').dropdown('toggle');
        $('.modal').modal('show');
    });

    $(document).on('show.bs.collapse', '.thing .reportForm #sub-reasons', function () {
        $('#other-reasons').collapse('hide');
        $('#custom-reason').collapse('hide');

        $('#reportModal').find('.collapse').find('input[type="radio"]').prop('checked', false);
        $('#create_thing_report_text').val('');
    });

    $(document).on('show.bs.collapse', '.thing .reportForm #other-reasons', function () {
        $('#sub-reasons').collapse('hide');
        $('#custom-reason').collapse('hide');

        $('#reportModal').find('.collapse').find('input[type="radio"]').prop('checked', false);
        $('#create_thing_report_text').val('');
    });

    $(document).on('show.bs.collapse', '.thing .reportForm #custom-reason', function () {
        $('#sub-reasons').collapse('hide');
        $('#other-reasons').collapse('hide');

        $('#reportModal').find('.collapse').find('input[type="radio"]').prop('checked', false);
        $('#create_thing_report_text').val('');
    });

    $(document).on('change', '.thing .reportForm .report-rule', function() {
        $('#reportModal').find('.collapse').find('input[type="radio"]').prop('checked', false);
        $(this).prop('checked', true);
        $('#create_thing_report_text').val($(this).val());
    });

    $(document).on('ajax:success', '.thing .reportForm', function (e) {
        $('.modal').modal('hide');
        notification('Спасибо за активное участие');
    });

    $(document).on('ajax:error', '.thing .reportForm', function (e) {
        $('#sub-reasons').collapse('hide');
        $('#other-reasons').collapse('hide');
        $('#custom-reason').collapse('show');
    });

    $(document).on('ajax:success', '.createCommentForm', function (e) {
        $('.comments').first().prepend(e.detail[0].activeElement.innerHTML);
        format_datetime();
        load_things_actions($(e.detail[0].activeElement.innerHTML));
        $('#create_thing_comment_text').val('');
    });

    $(document).on('ajax:success', '.thing .reply', function(e) {
        var comments = $(this).closest('.thing').find('.comments').first();

        $('.replyCommentForm').remove();
        $(comments).prepend(e.detail[0].activeElement.innerHTML);
    });

    $(document).on('click', '.replyCommentCancel', function(e) {
        $(this).closest('.replyCommentForm').remove();
    });

    $(document).on('ajax:success', '.replyCommentForm', function(e) {
        $(this).replaceWith(e.detail[0].activeElement.innerHTML);
        format_datetime();
        load_things_actions($(e.detail[0].activeElement.innerHTML));
    });

    $(document).on('ajax:success', '.thing .update', function(e) {
        $('.content').show();
        $('.updateCommentForm').remove();
        $(this).closest('.thing').find('.content').first().hide();
        $(this).closest('.thing').find('.content').first().after(e.detail[0].activeElement.innerHTML);
        $(this).closest('.actions').find('.menu .dropdown-toggle').dropdown('toggle');
    });

    $(document).on('click', '.updateCommentCancel', function(e) {
        $(this).closest('.thing').find('.content').first().show();
        $(this).closest('.updateCommentForm').remove();
    });

    $(document).on('ajax:success', '.updateCommentForm', function(e) {
        var text = $(e.detail[0].activeElement.innerHTML).find('.content').html();
        $(this).closest('.thing').find('.content').first().html(text);
        $(this).closest('.thing').find('.content').first().show();
        $(this).remove();
    });

    $(document).on('ajax:success', '.loadMore', function(e) {
        $(this).parent('.comments').find('.toBranch').remove();
        $(this).parent('.comments').append($(e.detail[0].activeElement.innerHTML).html());
        $(this).remove();

        load_things_actions($(e.detail[0].activeElement.innerHTML).find(".thing"));
    });
});