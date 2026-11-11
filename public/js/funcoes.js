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

  let navAberta = true

  function fecharNav() {
    let nav = document.querySelector('nav');
    let main = document.querySelector('main');
    let navWidth = 11
    let navPadding = 40

    if (navAberta) {
      nav.style.width = '0px'
      nav.style.padding = '0px'

      main.style.marginLeft = '0px'

      nav.innerHTML = `<button class="close-nav" onclick="fecharNav()">
      >
    </button>
    `

      navAberta = false
    } else {
      nav.style.width = `${navWidth}%`
      nav.style.padding = `${navPadding}px`
      nav.style.display = 'flex'

      main.style.marginLeft = `calc(${navWidth + 2}% + ${navPadding}px)`

      nav.innerHTML = `<button class="close-nav" onclick="fecharNav()">
      <
    </button>
    <div class="nav-button selected">
      <span>PAINEL DE CONTROLE</span>
      <span><i class="material-icons">dashboard</i></span>
    </div>
    <div class="nav-button" onclick="window.location = 'ocorrencias.html'">
      <span>OCORRÊNCIAS</span>
     <span><i class="material-icons">view_comfy</i></span>
    </div>
    <div class="nav-button" onclick="window.location = 'paranormais.html'">
      <span>ARQUIVO DE INDIVÍDUOS</span>
      <span><i class="material-icons"">group</i></span>
    </div>
    <div class="nav-button" onclick="window.location = 'quiz.html'">
      <span>EXAME DE APTIDÃO</span>
      <span><i class="material-icons">quiz</i></span>
    </div>

    <button class="disconnect" onclick="window.location = '../index.html'">
      DESCONECTAR
    </button>`

      navAberta = true
    }
    
  }