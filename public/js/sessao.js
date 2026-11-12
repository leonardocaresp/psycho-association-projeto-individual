// sessão
function limparSessao() {
    sessionStorage.clear();
    trocarTela("../index.html")
}

function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var b_usuario = document.getElementById("b_usuario");
    var e_usuario = document.getElementById("e_usuario");

    if (email != null && nome != null) {
        b_usuario.innerHTML = nome;
        e_usuario.innerHTML = email;
    } else {
        trocarTela("../login.html");
    }
}

function limparFormulario(tipo) {
    ipt_email.value = ''
    ipt_password.value = ''
    if (tipo == 'cadastro') {
        ipt_name.value = ''
        ipt_password_confirmed.value = ''
    }
}
