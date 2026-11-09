function apagarCarregamento() { window.addEventListener('pageshow', function (event) {
    var carregamentoExistente = document.querySelector('.carregamento');
    if (carregamentoExistente) {
        carregamentoExistente.remove();
    }
  })
}

  function trocarTela(link) {
    var carregamento = document.createElement('div')
    carregamento.classList.add('carregamento')
    carregamento.innerHTML = '<img src="/assets/carregamento.gif">'

    document.body.appendChild(carregamento)

    setTimeout(() => {
      window.location = link
    }, 1700)
    
  }