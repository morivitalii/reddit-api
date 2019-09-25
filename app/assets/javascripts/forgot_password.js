$(document).ready(function() {
  $(document).on('ajax:success', '.sign-in__forgot-password-link, .sign-up__forgot-password-link', function (e) {
    $('.modal').modal('hide');
    $('body').append(e.detail[0].activeElement.innerHTML);
    $('.modal').modal('show');

    $(document).on('ajax:success', '.new_forgot_password_form', function (e) {
      if(e.detail[2].status === 204) {
        $('.modal').modal('hide');
        notification('Письмо с ссылкой на изменение пароля отправлено на указанный email');
      }
    });
  });

  $(document).on('ajax:error', '.new_forgot_password_form', function (e) {
    grecaptcha.reset();
  });
});