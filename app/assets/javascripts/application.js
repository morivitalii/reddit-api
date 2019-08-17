//= require jquery
//= require rails-ujs
//= require moment/moment
//= require moment/locale/ru
//= require popper.js/dist/umd/popper
//= require bootstrap/dist/js/bootstrap
//= require bootstrap-select/dist/js/bootstrap-select
//= require bootstrap-select/dist/js/i18n/defaults-ru_RU
//= require plyr/dist/plyr
//= require_tree .

function notification(text) {
    $('body').append(
        '<div class="notification container fixed-bottom">\n' +
        '  <div class="row">\n' +
        '    <div class="col-md-6 offset-md-2 col-sm-12">\n' +
        '      <div class="alert alert-light alert-dismissible fade show text-dark border" role="alert">\n' +
        '        ' + text + '\n' +
        '        <button type="button" class="close" data-dismiss="alert" aria-label="Close">\n' +
        '          <span aria-hidden="true">&times;</span>\n' +
        '        </button>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>'
    );

    window.setTimeout(function() {
        $('.notification').remove();
    }, 5500);
}

$(document).on('click', '.delete', function(e) {
    var url = $(this).data("url");
    var modal = '<div class="modal" tabindex="-1" role="dialog">\n' +
        '  <div class="modal-dialog role="document">\n' +
        '    <div class="modal-content">\n' +
        '      <div class="modal-header">\n' +
        '        <h5 class="modal-title">Подтверждение удаления</h5>\n' +
        '        <button type="button" class="close" data-dismiss="modal" aria-label="Close">\n' +
        '          <span aria-hidden="true">&times;</span>\n' +
        '        </button>\n' +
        '      </div>\n' +
        '      <div class="modal-body text-right">\n' +
        '        <button type="button" class="btn btn-primary" data-dismiss="modal">Отменить</button>\n' +
        '        <a class="confirm-deletion btn btn-primary" data-remote="true" rel="nofollow" data-method="delete" href="' + url + '">Подтвердить</a>\n' +
        '      </div>\n' +
        '    </div>\n' +
        '  </div>\n' +
        '</div>';

    $(this).closest('.entry').append(modal);
    $('.modal').modal('show');
});


$(document).on('ajax:success', '.confirm-deletion', function() {
    var entry = $(this).closest('.entry');
    $('.modal').modal('hide');
    entry.remove();
});

function format_datetime() {
    $(".datetime-short, .datetime-ago").each(function (index) {
        $(this).tooltip({
            title: moment($(this).data("timestamp"), "X").format("ddd, D MMMM YYYY, HH:mm:ss"),
        });
    });

    $(".datetime-short").each(function (index) {
        $(this).html(moment($(this).data("timestamp"), "X").format("D MMMM YYYY"));
    });

    $(".datetime-ago").each(function (index) {
        $(this).html(moment($(this).data("timestamp"), "X").fromNow());
    });
}

$(document).ready(function() {
    format_datetime();

    $(document).on('ajax:success', 'form', function (e) {
        if(e.detail[2].getResponseHeader('Location') !== null) {
            window.location.href = e.detail[2].getResponseHeader('Location');
        }
    });

    $('video').each(function( index ) {
        var player = new Plyr($(this));

        player.on('ready', function (e) {
            player.toggleControls(false);
        });
    });

    // Trigger tooltips after page load
    $('[data-toggle="tooltip"]').tooltip();

    // Remove modal after close
    $(document).on('hidden.bs.modal', '.modal', function (e) {
        $('.modal').remove();
    });

    $('#navigation').on('changed.bs.select', function (e, clickedIndex, isSelected, previousValue) {
        window.location.href = $('#navigation option').eq(clickedIndex).data("href");
    });
});

document.addEventListener('ajax:error', function (e) {
    if(e.detail[2].status === 401) {
        $('.modal').modal('hide');
        $('body').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    } else if (e.detail[2].status === 406) {
        notification('У вас нету доступа к этому действию');
    } else if (e.detail[2].status === 422) {
        var form = $(this);

        form.find('.form-text').remove();

        $.each(e.detail[0], function(field, messages) {
            var input = form.find('input, select, textarea').filter(function() {
                var name = $(this).attr('name');
                if (name) {
                    return name.match(new RegExp('\\[' + field + '\\(?'));
                }
            });

            if (messages.length > 0) {
                input.parent().append('<span class="form-text text-danger">' + messages.join('<br>') + '</span>');
            }
        });
    } else {
        notification('Ошибка сервера');
    }
});