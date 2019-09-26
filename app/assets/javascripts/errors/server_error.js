document.addEventListener('ajax:error', function (e) {
  if (e.detail[2].status === 500) {
    notification('Ошибка сервера')
  }
})
