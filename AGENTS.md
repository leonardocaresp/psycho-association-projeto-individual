# AGENTS.md

## Visão geral

**Psycho Association** é uma aplicação web interativa que simula o sistema interno de uma organização especializada na investigação de fenômenos paranormais, inspirada no universo do anime *Mob Psycho 100*.

O objetivo é proporcionar uma experiência na qual o usuário é recrutado pela organização e passa a integrar sua equipe, tendo acesso a ferramentas internas para documentar ocorrências, consultar indivíduos relacionados ao universo paranormal e realizar avaliações de aptidão.

A aplicação possui quatro áreas principais:

- **Painel de Controle (Dashboard):** apresenta indicadores e gráficos relacionados às ocorrências registradas e ao desempenho dos membros nos exames de aptidão.
- **Central de Ocorrências:** permite consultar, cadastrar, editar e excluir relatórios de fenômenos paranormais.
- **Arquivo de Indivíduos:** apresenta personagens e indivíduos conhecidos pela organização, incluindo humanos, paranormais e entidades espirituais.
- **Exame de Aptidão Paranormal:** questionário de múltipla escolha com 20 questões, alternativas corretas e incorretas e cálculo de pontuação.

O sistema também possui páginas públicas de apresentação da organização, cadastro e login.

A identidade visual deve equilibrar a aparência de um sistema institucional com o tom descontraído e humorístico de *Mob Psycho 100*. Evitar interfaces excessivamente corporativas, formais ou genéricas.

O projeto possui finalidade acadêmica e está sendo desenvolvido individualmente como parte do primeiro semestre do curso de Análise e Desenvolvimento de Sistemas.

O agente deve considerar que o desenvolvedor está em processo de aprendizagem. Portanto, priorizar soluções simples, didáticas e compatíveis com os conhecimentos adquiridos durante o primeiro semestre.

## Tecnologias

O projeto deve respeitar as tecnologias permitidas no escopo acadêmico.

### Front-end

- **HTML5:** estruturação das páginas e componentes.
- **CSS3:** estilização, layouts, animações e responsividade.
- **JavaScript:** lógica da aplicação, manipulação do DOM, validações, interatividade e comunicação com a API.
- **Chart.js:** criação dos gráficos da Dashboard.

### Back-end

- **Node.js:** ambiente de execução do servidor.
- **Express:** framework utilizado pela API para gerenciamento de requisições e rotas.
- **MySQL:** banco de dados relacional utilizado para persistência das informações.
- **mysql2:** biblioteca utilizada para conexão e execução de consultas no MySQL.
- **Web-Data-Viz:** projeto-base disponibilizado pelos professores da São Paulo Tech School, utilizado como estrutura inicial da API.

### Bibliotecas e recursos externos

- `dotenv`: gerenciamento de variáveis de ambiente.
- `cors`: configuração de compartilhamento de recursos entre origens.
- `path`: manipulação de caminhos de arquivos.
- `nodemon`: ferramenta para reinicialização automática do servidor.
- Google Fonts: carregamento das fontes utilizadas na interface.
- Material Icons: utilização de ícones na interface.
- Chart.js Annotation e Chart.js DataLabels: plugins utilizados na Dashboard.

As bibliotecas externas utilizadas atualmente devem ser preservadas. Não adicionar novas dependências sem autorização explícita.

### Restrições tecnológicas

- Priorizar JavaScript puro (Vanilla JavaScript).
- Não utilizar React, Angular, Vue ou outros frameworks.
- Não introduzir bibliotecas adicionais sem autorização.
- Não substituir a API Web-Data-Viz por outra arquitetura de back-end.
- Não introduzir linguagens ou tecnologias que ultrapassem o escopo acadêmico estabelecido.

## Comandos

Os comandos abaixo devem ser executados no diretório raiz do projeto.

### Instalação das dependências

```bash
npm install
```

### Inicialização do servidor

```bash
npm start
```

O comando executa o script `start` definido no `package.json`, que inicializa o arquivo `app.js`.

### Desenvolvimento com reinicialização automática

```bash
npm run dev
```

O comando utiliza o Nodemon para reiniciar o servidor automaticamente após alterações nos arquivos monitorados.

### Encerramento

Para interromper o servidor, utilizar `CTRL + C`.

### Configuração do ambiente

O projeto utiliza arquivos de configuração de ambiente:

- `.env`: configuração do ambiente de produção.
- `.env.dev`: configuração do ambiente de desenvolvimento.

A seleção do arquivo utilizado é realizada no `app.js`, por meio da variável `ambiente_processo`.

Não modificar as configurações de ambiente sem necessidade.

Nunca expor, sobrescrever ou versionar credenciais e informações sensíveis.

Não presumir que o banco de dados esteja disponível apenas porque o servidor foi iniciado.

## Arquitetura

A aplicação utiliza uma arquitetura dividida entre front-end, API e banco de dados.

O front-end é servido pelo Express a partir do diretório `public/`.

A API utiliza uma estrutura inspirada no padrão MVC, com separação entre `routes`, `controllers`, `models` e `database`.

### Estrutura de diretórios

```text
projeto/
│
├── app.js
├── package.json
├── package-lock.json
│
├── public/
│   ├── index.html
│   ├── login.html
│   ├── cadastro.html
│   │
│   ├── css/
│   │   ├── geral.css
│   │   ├── home.css
│   │   ├── sistema.css
│   │   ├── painel.css
│   │   ├── ocorrencias.css
│   │   ├── paranormais.css
│   │   └── quiz.css
│   │
│   ├── js/
│   │   ├── funcoes.js
│   │   └── sessao.js
│   │
│   ├── assets/
│   │   ├── imgs/
│   │   └── icon/
│   │
│   └── dashboard/
│       ├── dashboard.html
│       ├── ocorrencias.html
│       ├── paranormais.html
│       └── quiz.html
│
└── src/
    ├── routes/
    ├── controllers/
    ├── models/
    └── database/
        ├── config.js
        └── script-tabelas.sql
```

A árvore acima representa os principais diretórios e arquivos identificados. Antes de criar ou alterar arquivos, consultar a estrutura atual do repositório, pois novos arquivos podem ter sido adicionados.

### Responsabilidade dos diretórios

**Raiz do projeto**

Contém os arquivos principais de configuração e inicialização da aplicação.

- `app.js`: configura e inicializa o servidor Express.
- `package.json`: declara as dependências e os comandos disponíveis.
- `package-lock.json`: registra as versões resolvidas das dependências.

**public/**

Contém os arquivos disponibilizados ao navegador.

- `index.html`: página inicial e apresentação da organização.
- `login.html`: autenticação dos membros.
- `cadastro.html`: cadastro de novos membros.
- `css/`: folhas de estilo da aplicação.
- `js/`: scripts JavaScript compartilhados entre diferentes páginas.
- `assets/`: imagens, ícones e recursos gráficos.
- `dashboard/`: páginas internas acessadas após a autenticação.

Os scripts específicos de cada página são implementados diretamente dentro das respectivas tags `<script>` no HTML.

Não transferir automaticamente esses scripts para arquivos JavaScript separados. Manter o padrão atual, salvo solicitação explícita de refatoração.

**src/routes/**

Contém os arquivos responsáveis pelo registro das rotas da API.

Uma rota define o endereço HTTP, o método utilizado e qual função do controller será executada.

**src/controllers/**

Contém as funções responsáveis por receber e processar as requisições.

Os controllers:

- Recuperam informações de `req.body`, `req.params` e `req.query`.
- Realizam validações necessárias.
- Chamam as funções correspondentes dos models.
- Retornam respostas HTTP por meio de `res`.

**src/models/**

Contém as funções responsáveis pelas operações com o banco de dados.

Os models:

- Elaboram instruções SQL.
- Utilizam a configuração de conexão com o banco.
- Executam consultas por meio de `database.executar()`.
- Retornam os resultados das operações aos controllers.

**src/database/**

Contém os arquivos relacionados à conexão e à estrutura do banco de dados.

- `config.js`: configura a conexão com o MySQL e disponibiliza a função `executar()`.
- `script-tabelas.sql`: contém o script SQL de referência disponibilizado no projeto-base.

O script SQL existente é originalmente relacionado ao exemplo Aquatech. Não assumir que suas tabelas correspondem integralmente à modelagem atual da Psycho Association.

### Inicialização da API

O arquivo `app.js` é responsável por:

1. Carregar as configurações de ambiente.
2. Inicializar o Express.
3. Configurar o CORS.
4. Configurar o processamento de JSON e formulários.
5. Disponibilizar os arquivos estáticos de `public/`.
6. Registrar os routers da aplicação.
7. Inicializar o servidor na porta configurada.

As rotas atualmente registradas no `app.js` incluem:

- `/`: rota inicial.
- `/usuarios`: gerenciamento de usuários.
- `/avisos`: gerenciamento de avisos.
- `/medidas`: consulta de medidas.
- `/aquarios`: gerenciamento de aquários.
- `/empresas`: gerenciamento de empresas.

Essas rotas fazem parte da estrutura original do Web-Data-Viz. Verificar o estado atual do código antes de presumir que todas continuam sendo utilizadas ou que novas rotas já foram registradas.

### Fluxo de uma requisição

O fluxo de comunicação entre as camadas é:

```text
HTML
  |
  v
JavaScript
  |
  | fetch()
  v
Routes
  |
  v
Controllers
  |
  v
Models
  |
  v
MySQL
  |
  v
Models
  |
  v
Controllers
  |
  v
Resposta HTTP (JSON)
  |
  v
JavaScript
  |
  v
Atualização da interface
```

Exemplo baseado na autenticação existente:

1. O usuário preenche o formulário de login.
2. A função JavaScript `entrar()` coleta o e-mail e a senha.
3. O `fetch()` envia uma requisição POST para `/usuarios/autenticar`.
4. A rota encaminha a requisição para `usuarioController.autenticar()`.
5. O controller chama `usuarioModel.autenticar()`.
6. O model consulta o banco de dados.
7. O controller verifica o resultado e retorna os dados do usuário.
8. O JavaScript recebe a resposta e armazena os dados necessários no `sessionStorage`.

### Como adicionar novas funcionalidades

Sempre que uma funcionalidade precisar consultar ou persistir informações no banco:

1. Identificar a página responsável pela funcionalidade.
2. Identificar os elementos HTML envolvidos.
3. Implementar a interação no JavaScript da página, respeitando o padrão atual.
4. Identificar se existe uma rota adequada na API.
5. Caso seja necessário criar ou modificar uma rota, verificar o padrão já utilizado.
6. Criar ou adaptar a função correspondente no controller.
7. Criar ou adaptar a função correspondente no model.
8. Verificar se a estrutura do banco possui as tabelas, colunas e relacionamentos necessários.
9. Testar o fluxo completo, desde o front-end até o banco de dados.

Para novos recursos, seguir o padrão utilizado pelos professores no CRUD de `avisos`, adaptando-o à necessidade da Psycho Association.

Não implementar toda a lógica de banco de dados diretamente no HTML ou no front-end.

Não criar endpoints, tabelas ou relacionamentos sem verificar sua necessidade e a estrutura existente.

### Funcionalidades e estado atual identificado

**Cadastro e login**

As páginas `cadastro.html` e `login.html` já possuem integração com a API.

O cadastro utiliza:

```http
POST /usuarios/cadastrar
```

O login utiliza:

```http
POST /usuarios/autenticar
```

**Gerenciamento de ocorrências**

A página `dashboard/ocorrencias.html` possui a estrutura visual da central de ocorrências, filtros, cards e formulário de cadastro em popup.

Na versão analisada, os registros exibidos são estáticos e as operações completas de CRUD ainda precisam ser verificadas ou implementadas.

**Arquivo de indivíduos**

A página `dashboard/paranormais.html` apresenta cards de personagens, imagens e descrições.

O conteúdo apresentado é estático e não deve ser confundido com registros dinâmicos do banco de dados.

**Exame de Aptidão**

A página `dashboard/quiz.html` possui um questionário de 20 questões armazenadas em um array de objetos no próprio HTML.

Cada questão possui:

- `pergunta`
- `alternativaA`
- `alternativaB`
- `alternativaC`
- `alternativaD`
- `alternativaCorreta`

A lógica atual calcula a pontuação no navegador.

Não presumir que os resultados já são armazenados no MySQL.

**Dashboard**

A página `dashboard/dashboard.html` utiliza Chart.js para apresentar indicadores e gráficos de ocorrências.

Na versão analisada, os valores dos KPIs e dos gráficos estão definidos diretamente no código.

Ao implementar consultas reais, substituir os valores estáticos pelos dados retornados pela API, preservando a estrutura visual existente.

## Padrões de desenvolvimento

### JavaScript

- Utilizar `const` por padrão.
- Utilizar `let` somente quando houver necessidade de reatribuição.
- Evitar `var` em código novo.
- Utilizar `camelCase` para variáveis e funções.
- Utilizar nomes descritivos e semanticamente claros.
- Evitar abreviações que prejudiquem a compreensão.
- Preferir funções simples e com responsabilidades bem definidas.
- Evitar abstrações desnecessárias.
- Não utilizar operador ternário (`condicao ? valorA : valorB`) em código novo; utilizar `if/else` explícito.
- Sempre que surgir necessidade de usar função, método ou recurso que ainda não é utilizado no projeto, solicitar autorização explícita do desenvolvedor antes de aplicar.
- Manter os scripts específicos de cada página dentro das respectivas tags `<script>` no HTML.
- Manter os scripts compartilhados em `public/js/`.
- Não introduzir módulos, bundlers ou ferramentas de compilação sem autorização.
- Reutilizar funções existentes antes de criar novas implementações equivalentes.

Exemplos:

```javascript
const nomeUsuario = "Leonardo";
let pontuacaoFinal = 0;

function cadastrarOcorrencia() {
    // implementação
}

function buscarOcorrencias() {
    // implementação
}
```

### HTML

- Utilizar HTML semântico.
- Manter a estrutura e a hierarquia dos elementos.
- Preservar os IDs utilizados pelos scripts JavaScript.
- Utilizar nomes de IDs e atributos de forma consistente.
- Evitar duplicação desnecessária de estruturas.
- Preservar a organização visual e funcional das páginas.

### CSS

- Utilizar `kebab-case` para nomes de classes.
- Preferir nomes em inglês para treinar a utilização do idioma.
- Manter os nomes descritivos.
- Utilizar o tipo do componente no nome quando fizer sentido, como `input-container`, `button-login` e `card-bottom`.
- Utilizar seletores dependentes do elemento pai quando isso ajudar a contextualizar o componente.
- Reutilizar variáveis CSS globais definidas em `geral.css`.
- Evitar duplicação de propriedades e regras.
- Não utilizar `camelCase` para nomes de classes CSS.

Exemplos:

```css
.main-section {
    display: flex;
}

.main-content {
    align-items: center;
}

.input-container {
    display: flex;
}

.universe-cards .card-bottom {
    background-color: white;
}
```

### Identidade visual

Preservar a identidade visual já estabelecida.

As principais cores globais identificadas em `geral.css` são:

- Azul escuro: `#0A0D24`
- Azul claro: `#36F0C8`
- Rosa choque: `#E22672`
- Roxo claro: `#D250FF`
- Verde claro: `#3FE275`
- Amarelo forte: `#FDB123`

A tipografia global utiliza principalmente Oswald e Roboto.

Os elementos visuais devem manter coerência com a estética existente: formas geométricas, recortes diagonais, contornos, cores vibrantes, contrastes e composições inspiradas na identidade do anime.

Não substituir a identidade visual por componentes genéricos ou estilos prontos de frameworks.

### Comunicação com a API

- Utilizar `fetch()` para comunicação com a API, seguindo o padrão existente.
- Respeitar os métodos HTTP utilizados pelas rotas.
- Enviar dados no formato esperado pelo controller.
- Utilizar `Content-Type: application/json` quando enviar JSON.
- Verificar o status da resposta antes de processar os dados.
- Tratar erros de comunicação e respostas inesperadas.
- Não presumir endpoints ou propriedades de objetos retornados pela API.
- Consultar as rotas, controllers e models antes de implementar integrações.

### Métodos HTTP e operações CRUD

Seguir a convenção utilizada no projeto:

| Método HTTP | Operação | SQL |
|---|---|---|
| POST | Criar | INSERT |
| GET | Consultar | SELECT |
| PUT | Atualizar | UPDATE |
| DELETE | Excluir | DELETE |

### Banco de dados

- Utilizar MySQL.
- Respeitar os nomes reais de tabelas e colunas.
- Consultar a modelagem existente antes de escrever instruções SQL.
- Preservar os relacionamentos entre as entidades.
- Verificar dependências antes de excluir registros.
- Não presumir que a existência de um arquivo SQL significa que a estrutura já foi executada no banco.

### Autenticação e sessão

A autenticação atual utiliza a API para verificar as credenciais cadastradas no banco.

Após o login bem-sucedido, o front-end armazena os seguintes dados no `sessionStorage`:

- `EMAIL_USUARIO`
- `NOME_USUARIO`
- `ID_USUARIO`

As funções compartilhadas de gerenciamento de sessão estão em `public/js/sessao.js`.

As principais funções identificadas são:

- `validarSessao()`
- `limparSessao()`
- `limparFormulario()`

A função `validarSessao()` verifica os dados armazenados e controla o acesso às páginas internas.

A função `limparSessao()` limpa o `sessionStorage` e redireciona o usuário.

Preservar o funcionamento atual dessas funções ao modificar a autenticação ou a navegação.

Não confundir `sessionStorage` com sessões autenticadas no servidor. O mecanismo atual mantém os dados da sessão no navegador.

## Cuidados e restrições

### Aprovação obrigatória antes de implementar

**O agente nunca deve realizar alterações no código sem a aprovação prévia e explícita do desenvolvedor.**

Antes de implementar qualquer alteração, o agente deve obrigatoriamente:

1. Analisar o código existente e identificar os arquivos envolvidos.
2. Compreender o funcionamento atual da funcionalidade.
3. Apresentar um plano de implementação detalhado, explicando:
   - O que pretende fazer.
   - Quais arquivos serão criados, modificados ou removidos.
   - Quais alterações serão realizadas em cada arquivo.
   - Como a implementação funcionará.
   - Quais tecnologias e recursos serão utilizados.
   - Se haverá impacto em outras funcionalidades, rotas, controllers, models ou tabelas do banco de dados.
   - Quais testes pretende realizar após a implementação.
4. Aguardar a avaliação do desenvolvedor.

O desenvolvedor poderá:

- **Aprovar:** autorizar a implementação exatamente como apresentada.
- **Reprovar:** cancelar a implementação.
- **Solicitar alterações:** pedir ajustes no planejamento antes de aprovar.

Somente após uma confirmação explícita do desenvolvedor o agente poderá começar a modificar os arquivos.

Se o desenvolvedor solicitar alterações no planejamento, o agente deverá apresentar a versão atualizada e aguardar uma nova aprovação.

A aprovação deve corresponder ao plano apresentado. Caso, durante a implementação, seja identificada a necessidade de realizar alterações relevantes que não estavam previstas, o agente deverá interromper o trabalho, explicar a situação e solicitar uma nova aprovação antes de prosseguir.

Essa regra também se aplica a:

- Refatorações.
- Correções de bugs.
- Alterações estruturais.
- Criação ou exclusão de arquivos.
- Modificações no banco de dados.
- Criação ou alteração de rotas.
- Implementação de novas funcionalidades.
- Instalação ou remoção de dependências.

Não interpretar pedidos como "analise", "investigue", "explique", "sugira" ou "o que você acha?" como autorização para modificar o código.

**Regra fundamental: primeiro analisar, depois planejar, em seguida solicitar aprovação e somente então implementar.**

### Restrições acadêmicas

- Respeitar as tecnologias permitidas no primeiro semestre.
- Não introduzir frameworks front-end.
- Não adicionar dependências sem autorização.
- Não substituir a API Web-Data-Viz.
- Priorizar soluções compatíveis com HTML, CSS, JavaScript, MySQL e Chart.js.

### Preservação da arquitetura

- Não reorganizar os diretórios sem necessidade.
- Não transferir scripts específicos das páginas HTML para arquivos externos sem solicitação.
- Não criar estruturas paralelas para funcionalidades que já possuem uma implementação.
- Não modificar o funcionamento geral do `app.js` sem compreender as rotas registradas.
- Não remover funcionalidades herdadas do projeto-base sem verificar suas dependências.

### Segurança e integridade dos dados

- Nunca expor credenciais ou senhas.
- Não armazenar informações sensíveis desnecessárias no `sessionStorage`.
- Não retornar senhas em respostas da API.
- Não criar consultas SQL sem verificar os parâmetros recebidos.
- Ao modificar consultas existentes, priorizar parâmetros preparados quando compatíveis com a estrutura atual.
- Não executar operações destrutivas no banco sem autorização.
- Não presumir que uma requisição foi concluída com sucesso sem verificar sua resposta.

### Desenvolvimento e aprendizado

- Priorizar soluções simples e compreensíveis.
- Evitar padrões arquiteturais excessivamente avançados.
- Não introduzir complexidade desnecessária.
- Não reescrever arquivos inteiros quando uma alteração pontual for suficiente.
- Explicar alterações relevantes e conceitos novos quando solicitado.
- Não entregar soluções que escondam completamente a lógica do funcionamento.
- Considerar que o desenvolvedor deseja compreender o código e evoluir tecnicamente.

### Git e histórico

O agente não possui autorização para realizar operações de commit.

- Não criar commits.
- Não alterar mensagens de commits.
- Não modificar o histórico do Git.
- Não realizar push ou merge.
- Não criar ou excluir branches sem autorização explícita.
- Não executar operações que possam descartar alterações locais do desenvolvedor.

## Regra geral

Antes de implementar qualquer alteração, siga as tecnologias, a arquitetura, as convenções e as restrições descritas neste documento.

**Na ausência de aprovação explícita, o agente deve limitar sua atuação à análise, explicação e elaboração de propostas, sem modificar qualquer arquivo do projeto.**

Caso alguma informação esteja ausente, analise o código existente e siga os padrões já adotados no projeto.

Se não for possível determinar o comportamento correto apenas pela análise do código, solicite esclarecimentos ao desenvolvedor.

A prioridade é preservar a integridade do Psycho Association, respeitar seu escopo acadêmico e desenvolver soluções simples, organizadas, funcionais e coerentes com a arquitetura existente.
