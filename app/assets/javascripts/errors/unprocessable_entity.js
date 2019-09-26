document.addEventListener('ajax:error', function (e) {
  // If form is not valid
  if (e.detail[2].status === 422) {
    var form = $(this)

    form.find('.form-text').remove()

    $.each(e.detail[0], function (field, messages) {
      var input = form.find('input, select, textarea').filter(function () {
        var name = $(this).attr('name')
        if (name) {
          return name.match(new RegExp('\\[' + field + '\\(?'))
        }
      })

      if (messages.length > 0) {
        input.parent().append('<span class="form-text text-danger">' + messages.join('<br>') + '</span>')
      }
    })
  }
})
