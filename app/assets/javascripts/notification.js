function notification (text) {
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
  )

  window.setTimeout(function () {
    $('.notification').remove()
  }, 5500)
}
