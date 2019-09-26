document.addEventListener('ajax:error', function (e) {
  // If user have no permissions for action
  if (e.detail[2].status === 403) {
    notification('У вас нету доступа к этому действию')
  }
})
