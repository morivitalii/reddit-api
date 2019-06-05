$(document).ready(function() {
    $(document).on('ajax:success', '.signIn', function (e) {
        $('.modal').modal('hide');
        $('body').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:error', '.signInForm, .signUpForm, .forgotPasswordForm', function (e) {
        grecaptcha.reset();
    });

    $(document).on('ajax:success', '.signUp', function (e) {
        $('.modal').modal('hide');
        $('body').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.forgotPassword', function (e) {
        $('.modal').modal('hide');
        $('body').append(e.detail[0].activeElement.innerHTML);
        $('.modal').modal('show');
    });

    $(document).on('ajax:success', '.forgotPasswordForm', function (e) {
        if(e.detail[2].status === 204) {
            $('.modal').modal('hide');
            notification('Письмо с ссылкой на изменение пароля отправлено на указанный email');
        }
    });
});