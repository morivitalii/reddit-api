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