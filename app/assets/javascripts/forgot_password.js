$(document).ready(function() {
  $(document).on('ajax:success', '.forgotPassword', function (e) {
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');

    $(document).on('ajax:success', '.forgotPasswordForm', function (e) {
      if(e.detail[2].status === 204) {
        $('.modal').modal('hide');
        notification('Письмо с ссылкой на изменение пароля отправлено на указанный email');
      }
    });
  });

  $(document).on('ajax:error', '.forgotPasswordForm', function (e) {
    grecaptcha.reset();
  });
});