/* INSTRUCOES PARA O DATABASE */

/* DATABASE UTILIZADO: APACHE DERBY
   NOME DO DATABASE: ENQUETE
   SEGUE A ESTRUTURA DAS TABELAS
   E 5 EXEMPLOS PARA RODAR O APLICATIVO
*/

CREATE TABLE livros (id INTEGER, 
                     titulo varchar(120), 
                     autor varchar(120), 
                     resenha varchar(920), 
                     capa varchar(60), PRIMARY KEY(id));

insert into livros (id, titulo, autor, resenha, capa) values (1, 'A Origem Da Tragédia', 'Friedrich Nietzsche', 'Este livro é mais um estudo sobre a decadência de um gênero teatral do que propriamente uma Investigação histórica ou uma incursão mítica na esfera da vida sobrenatural. Representa, em primeiro lugar, uma homenagem a Richard Wagner, uma interpretação dos seus dramas musicais como obras de arte totais que igualam às tragédias antigas.', 'images/aorigemdatragedia.jpg');
insert into livros (id, titulo, autor, resenha, capa) values (2, 'A Onda', 'Susan Casey', 'Surfe, adrenalina e teorias científicas avançadas são os ingredientes de A Onda, que investiga um dos fenômenos naturais mais impressionantes. Numa narrativa de tirar o fôlego, a jornalista Susan Casey acompanha surfistas radicais, cientistas de ponta e marinheiros pelos trechos mais temíveis do oceano em busca de ondas gigantes, e em seu relato sentimos toda a emoção de ver de perto verdadeiros monstros aquáticos. A autora mostra, ainda, a indústria em torno do surfe, que movimenta milhões de dólares em patrocínio e permite que muitos atletas se dediquem a levar o esporte a suas máximas possibilidades – mas que também expõe dezenas de amadores aos perigos do oceano.', 'images/aonda.jpg');
insert into livros (id, titulo, autor, resenha, capa) values (3, 'Reparação', 'Ian McEwan', 'Na tarde mais quente do verão de 1935, na Inglaterra, a adolescente Briony Tallis vê uma cena que vai atormentar a sua imaginação: sua irmã mais velha, sob o olhar de um amigo de infância, tira a roupa e mergulha, apenas de calcinha e sutiã, na fonte do quintal da casa de campo. A partir desse episódio e de uma sucessão de equívocos, a menina, que nutre a ambição de ser escritora, contrói uma história fantasiosa sobre uma cena que presencia. Comete um crime com efeitos devastadores na vida de toda a família e passa o resto de sua existência tentando desfazer o mal que causou.', 'images/reparacao.jpg');
insert into livros (id, titulo, autor, resenha, capa) values (4, 'A Tregua', 'Mario Benedetti', 'Prestes a completar 50 anos, viúvo há mais de vinte, Santomé mora com os três filhos. Não se relaciona bem com nenhum deles, tem poucos amigos e mantém uma rotina monótona e cinzenta. No diário, conta os dias que faltam para a aposentadoria; mas não tem idéia do que fará assim que se livrar do trabalho maçante. Seu destino, no entanto, mudará quando conhecer Laura Avellaneda, uma jovem discreta e tímida contratada para ser sua subalterna. Com ela, Martín Santomé voltará a conhecer o amor, numa luminosa trégua para uma vida até então triste e opaca.', 'images/atregua.jpg');
insert into livros (id, titulo, autor, resenha, capa) values (5, 'Memórias de uma Gueixa', 'Artur Golden', 'Seu relato tem início numa vila pobre de pescadores, em 1929, onde a menina de nove anos é tirada de casa e vendida como escrava. Pouco a pouco, vamos acompanhar sua transformação pelas artes da dança e da música, do vestuário e da maquilagem; e a educação para detalhes como a maneira de servir saquê revelando apenas um ponto do lado interno do pulso – armas e mais armas para as batalhas pela atenção dos homens. Mas a Segunda Guerra Mundial força o fechamento das casas de gueixas e Sayuri vê-se forçada a se reinventar em outros termos, em outras paisagens. E ainda, como uma descrição minuciosa da alma de uma mulher já apresentada por um homem.', 'images/ana.jpg');

CREATE TABLE usuarios (id INTEGER,
                       nome varchar(120), 
                       email varchar(120), PRIMARY KEY(id));

INSERT INTO usuarios (id, nome, email) VALUES (1, 'guest','guest@vote_no_livro.com');
/* necessário um usuario guest para entrar votando com ele e depois atualizar 
com o nome e o email do usuario real */

CREATE TABLE votacao_usr (id INTEGER, 
                          usuario_id int, 
                          livro_id int, 
                          votos int, PRIMARY KEY(id));

CREATE VIEW livros_votados AS 
    (SELECT vu.id as voto_nr, lv.titulo, lv.autor, lv.resenha, lv.capa, vu.votos, 
          vu.usuario_id, us.nome as usuario 
     FROM votacao_usr vu, livros lv, usuarios us 
     WHERE vu.livro_id = lv.id AND vu.usuario_id = us.id);

CREATE VIEW resultado_enquete AS 
    (SELECT DISTINCT MIN(vu.id) as voto_nr, 
            lv.titulo, 
            lv.capa, 
            COUNT(vu.votos) as votos, 
            AVG(vu.votos) as ranck, 
            us.nome as usuario 
     FROM votacao_usr vu, livros lv, usuarios us 
     WHERE vu.livro_id = lv.id AND vu.usuario_id = us.id
     GROUP BY lv.TITULO, lv.CAPA, us.NOME);
