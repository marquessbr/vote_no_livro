<%-- 
    Document   : confirmar_voto
    Created on : 18-Jul-2014, 10:15:56
    Author     : armando
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:update var="_Votar" dataSource="jdbc/VOTE_NO_LIVRO">
    <c:if test="${param.concluir == 1}">
        INSERT INTO usuarios (nome, email) 
        VALUES ('<c:out value="${param.nome}"/>',
                '<c:out value="${param.email}"/>')
    </c:if>
    <c:if test="${param.concluir == 0}">                
        INSERT INTO votacao_usr ( livro_id, usuario_id, votos)
        VALUES (<c:out value="${param.livro}"/>, 1,1)
    </c:if>
</sql:update>

<sql:query var="_Votados" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT titulo, autor, resenha, capa FROM livros_votados
</sql:query>
        
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>confirmando o voto</title>
        <link rel="stylesheet" type="text/css" href="style.css">        
    </head>
    <body>
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
        <table border = "0" style="width:980px">
            <tr>
                <td style="text-align:right;border-top: 1px solid;">
                    <form name="form_cfv" action="confirmar_voto.jsp" method="POST">
                        <input type="hidden" name="concluir" value="1" />
                        <a id="email" Email : ><input type="text" name="email" value="" /><br /></a>
                        <input type="text" name="nome" value="" /><br />
                        <input type="submit" value="Concluir Votação" name="concluir" />
                    </form>
                </td>                        
            </tr>
        </table>        
    </body>
</html>
