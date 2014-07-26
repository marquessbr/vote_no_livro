Aplicativo de teste VOTE-NO-LIVRO solicitado pela BlueSoft
------------------------------------------------------------------------------------------------------------------
* Aplicativo criado pelo netbeans IDE 8.0 usando GlassFish Server 4.0 como servidor e apache derby como database.


- Instruções
- 
* Necessário inicializar um servidor GlassFish antes de rodar a aplicação.
* Necessário criar um db apache derby de nome "enquete" e rodar o script "enquete.sql" localizado 
  em "vote_no_livro/src/conf" para criar a estrutura das tabelas utilizadas

- Esclarecimento
- 
* A referida estrutura compoe-se de:
* uma tabela "livros", com as colunas id, titulo, autor, resenha e capa
* uma tabela "usuarios" com as colunas id, nome, email e que é inicializada com um usuario "guest"
* uma tabela "votacao-usr" com as colunas id, usuario-id, livro-id e votos. 
  Através das páginas de escolha, o usuario  "guest" (um usuario qualquer) escolhe os livros que 
  deseja favoritar e o sistema acrescenta a essa tabela um novo registro com a id do livro  
  escolhido na coluna "livro-id" juntamente com o valor "1" (um) para a coluna "usuario-id", 
  valor relativo ao usuario "guest".
  ao concluir a enquete, o usuario real terá de passar suas informações para o sistema que irá 
  verificar se esse usuario já existe ou gravar um novo em caso negativo, com isso, o sistema
  obtem uma chave para esse usuario (chave existente ou nova) e com base nessa informação o sistema 
  subustitui todos os registro cujo valor na coluna "usuario-id" seja igual a "1" (um) pelo 
  valor dessa nova chave, atualizando a lista de livros que foram inseridos nessa tabela ao
  serem escolhidos por um usuario até então desconhecido para o sistema.

* as informações variaveis são obtidas de dois views, como segue:
  a view "livros_votados" monta a query dos livros escolhidos por um usuario qualquer
  a view "resultado_enquete" monta a query do ranck dos livros votados, geral e de cada usuario

- Modo Operandis
- 
* o aplicativo foi todo escrito usando JSP puro
* Conforme segue, ao acessar localhost:8080/vote_no_livro abre uma pagina com dois livros com 
  titulo, autor, uma resenha e a capa, logo abaixo da capa tem um botao para votar nesse livro
  no fim da lista tem dois botoes um para votar em mais livros e outro para concluir a enquete.
* A página mais livros é igual a primeira com a diferença de un dos botoes do final da lista
  que em vez de ser para escolher mais livros, serve para voltar para a página inicial.
* Uma vez clicado no botão "concluir a enquete", o usuario é posicionado em uma pagina com 
  a lista dos livros que ele escolheu e dois campos para informar seu nome e seu email, o sistema
  atualiza os dados do usuario automaticamente quando o usuario clica no botão "Finalizar a enquete",
* Se nenhum livro foi escolhido, essa pagina retorna apenas um aviso para o usuario e apresenta
  um botão para o mesmo voltar para a página inicial.
* apos informar os dados pertinentes o sistema direciona o usuario para uma pagina com uma lista
  dos livros votados com a quantidade de votos que cada livro obteve e a media dos votos de cada  
  usuario para esse livro.

qualquer duvida, entre em contato por email

