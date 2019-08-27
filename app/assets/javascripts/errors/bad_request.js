document.addEventListener('ajax:error', function (e) {
  if(e.detail[2].status === 400) {
    notification('Ошибка сервера');
  }
});