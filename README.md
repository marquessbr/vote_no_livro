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
* uma tabela "votacao_usr" que recebe, inicialmente os votos escolhido pelo usuario "guest" e posteriormente
  essas informações são atualizadas com os dados informados pelo usuario real quando o mesmo for concluir
  a sua enquete
* as informações variaveis são obtidas de dois views, como segue:
* a view "livros_votados" monta a query dos livros escolhidos por um usuario qualquer
* a view "resultado_enquete" monta a query do ranck dos livros votados, geral e de cada usuario

- Modo Operandis
- 
* o aplicativo foi todo escrito usando JSP puro
* Conforme segue, ao acessar localhost:8080/vote_no_livro abre uma pagina com dois livros com 
  titulo, autor, uma resenha e a capa, logo abaixo da capa tem um botao para votar nesse livro
  no fim da lista tem dois botoes um para votar em mais livros e outro para concluir a enquete
* A página mais livros é igual a primeira com a diferença de un dos botoes do final da lista
  que em vez de ser para escolher mais livros, serve para voltar ao inicio
* uma vez clicado no botão concluir a pesquisa, o usuario é posicionado em uma pagina com 
  a lista dos livros que ele escolheu e um campo para informar seu nome e seu email, o sistema
  atualiza os dados do usuario automaticamente
* apos informar os dados pertinentes o sistema direciona o usuario para uma pagina com uma lista
* dos livros votados com a quantidade de votos que cada livro obteve e a media de votos por usuario
* 
qualquer duvida me contate por email
