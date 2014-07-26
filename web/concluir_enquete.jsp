<%-- 
    Document   : confirmar_voto
    Created on : 18-Jul-2014, 10:15:56
    Author     : armando
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="exist_vt" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT COUNT(id) as e FROM votacao_usr WHERE usuario_id = 1
</sql:query>

<c:forEach var="row" items="${exist_vt.rows}">
    <c:set var="c_vus" scope="session" value="${row.e}"/>
</c:forEach>

<c:set var="vtf" scope="session" value="${param.votos_concluidos}"/>
<c:set var="has_usr" scope="session" value="${1}"/>
<c:set var="exu" scope="session" value="${true}"/>
<c:set var="enquete_finalizada" scope="session" value="${0}"/>    

<c:if test="${param.finalizar_enquete == 1}">

    <sql:query var="usr_exist" dataSource="jdbc/VOTE_NO_LIVRO">
        SELECT COUNT(id) as e FROM usuarios WHERE email = '${param.email}'
    </sql:query>

    <c:forEach var="row" items="${usr_exist.rows}">
        <c:set var="has_usr" scope="session" value="${row.e}"/>
    </c:forEach>
    
    <c:if test="${has_usr == 0}">
        <sql:query var="usr_exist" dataSource="jdbc/VOTE_NO_LIVRO">
            SELECT COUNT(id) as e FROM usuarios
        </sql:query>
        <c:forEach var="row" items="${usr_exist.rows}">
            <sql:update var="insere_usuario" dataSource="jdbc/VOTE_NO_LIVRO">
                INSERT INTO usuarios (id, nome, email) VALUES (${row.e + 1}, '${param.nome}','${param.email}')
            </sql:update>
        </c:forEach>            
    </c:if>

    <sql:query var="usrid" dataSource="jdbc/VOTE_NO_LIVRO">
        SELECT id as e FROM usuarios WHERE email = '${param.email}'
    </sql:query>

    <c:forEach var="row" items="${usrid.rows}">
        <c:set var="has_usr" scope="session" value="${row.e}"/>
    </c:forEach>
                
    <sql:update dataSource="jdbc/VOTE_NO_LIVRO">
        UPDATE votacao_usr SET usuario_id = ${has_usr} WHERE usuario_id = 1
    </sql:update>

    <sql:query var="exist_vt" dataSource="jdbc/VOTE_NO_LIVRO">
        SELECT COUNT(id) as e FROM votacao_usr WHERE usuario_id = ${has_usr}
    </sql:query>

    <c:forEach var="row" items="${exist_vt.rows}">
        <c:set var="c_vus" scope="session" value="${row.e}"/>
    </c:forEach>
        
    <c:set var="enquete_finalizada" scope="session" value="${1}"/>    
    <c:set var="usr_id" scope="session" value="${has_usr}"/> 
    <c:set var="usr_nome" scope="session" value="${param.nome}"/>     
    <c:set var="usr_email" scope="session" value="${param.email}"/>             
    <c:set var="vtf" scope="session" value="${false}"/>
    <c:set var="exu" scope="session" value="${false}"/>
</c:if>
        
<sql:query var="_Votados" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT titulo, autor, resenha, capa FROM livros_votados WHERE usuario_id = ${has_usr}
</sql:query>
        
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Concluir a Enquete</title>
        <link rel="stylesheet" type="text/css" href="style.css">        
    </head>
    <body>
        <c:choose>
            <c:when test="${c_vus == 0}">
                <table border = "0" style="width:980px">
                    <tr>
                        <td style="text-align:left;">
                            <p>Nenhum livro foi escolhido ...<br /> Necessário escolher pelo menos um livro!</p>
                        </td>                        
                    </tr>
                    <tr>
                        <td style="text-align:right;">
                            <a href="index.jsp?favoritou=0"><input name="voltar" class="button" value="Voltar ao Início" type="button"></a>
                        </td>                        
                    </tr>
                </table>

            </c:when>
            <c:otherwise>
                <c:if test="${exu == true}">
                    <table border = "0" style="width:980px">               
                        <tr>
                            <td style="text-align:center;"><h2> Informe seu nome e seu Email para concluir a enquete!</h1></td>                        
                        </tr>
                        <tr>
                            <td style="text-align:right;border-bottom: 1px solid;">
                                <form name="form_cfv" action="concluir_enquete.jsp" method="POST">
                                    <input type="hidden" name="finalizar_enquete" value="1" />
                                    <input type="hidden" name="inserir_usuario" value="1" />
                                    Email : <input type="text" name="email" value="" /><br />
                                    Nome  : <input type="text" name="nome" value="" /><br />
                                    <input type="submit" value="Finalizar Enquete" name="concluir" />
                                </form>
                            </td>                        
                        </tr>
                    </table>                                
                </c:if>
                <c:if test="${enquete_finalizada == 1}">
                    <sql:query var="ranck" dataSource="jdbc/VOTE_NO_LIVRO">
                        SELECT capa, titulo, usuario, votos, ranck FROM resultado_enquete
                    </sql:query>
                    <table border="0">
                        <!-- column headers -->
                        <tr>
                            <c:forEach var="columnName" items="${ranck.columnNames}">
                                <th><c:out value="${columnName}"/></th>
                            </c:forEach>
                        </tr>
                        <c:forEach var="row" items="${ranck.rows}" >
                            <tr style="text-align:left;">
                                <td><img src="<c:out value="${row.capa}"/>" 
                                         alt="<c:out value="${row.titulo}"/>" 
                                         width="120" height="200">
                                </td>
                                <td><c:out value="${row.titulo}"/></td>
                                <td><c:out value="${row.usuario}"/></td>
                                <td><c:out value="${row.votos}"/></td>
                                <td><c:out value="${row.ranck}"/></td>
                            </tr>                            
                        </c:forEach>
                    </table>    
                </c:if>                
                <c:if test="${vtf == true}">
                    <table border="0">
                        <!-- column headers -->
                        <tr>
                            <c:forEach var="columnName" items="${_Votados.columnNames}">
                                <th><c:out value="${columnName}"/></th>
                            </c:forEach>
                        </tr>
                    </table>
                    <table>
                        <c:forEach var="row" items="${_Votados.rows}" varStatus="lc">
                            <tr>                    
                                <td><span class="titulo"><c:out value="${row.titulo}"/></span></td>
                                <td><span class="autor"><c:out value="${row.autor}"/></span></td>
                                <td><span class="resenha"><c:out value="${row.resenha}"/></span></td>
                                <td><img src="<c:out value="${row.capa}"/>" 
                                         alt="<c:out value="${row.titulo}"/>" 
                                         width="120" height="200"><br />
                                </td>
                            </tr>
                        </c:forEach>    
                    </table>
                </c:if>                    
            </c:otherwise>
        </c:choose>
    </body>
</html>
