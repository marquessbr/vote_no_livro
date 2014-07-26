<%-- 
    Document   : maislivros
    Created on : 17-Jul-2014, 23:50:15
    Author     : armando
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="_Livros" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT id,titulo,autor,resenha,capa FROM livros WHERE id > 2
</sql:query>

<c:if test="${param.favoritou == 1}">
    <c:if test="${param.livro > 0}">
        <sql:query var="votacao_usrid" dataSource="jdbc/VOTE_NO_LIVRO">
            SELECT COUNT(id) as c FROM votacao_usr
        </sql:query>
    
        <c:forEach var="row" items="${votacao_usrid.rows}">
            <c:set var="c_vus" scope="session" value="${row.c + 1}"/>
        </c:forEach>            

        <sql:update var="_Votar" dataSource="jdbc/VOTE_NO_LIVRO">
            INSERT INTO votacao_usr (id, livro_id, usuario_id, votos)
            VALUES (${c_vus}, <c:out value="${param.livro}"/>, 1,1)
        </sql:update>
    </c:if>
</c:if>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vote no Livro - Cotinuação</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
    
        <table border="0">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${_Livros.columnNames}">
                    <c:if test="${columnName != 'ID'}">
                        <th><c:out value="${columnName}"/></th>
                    </c:if>
                </c:forEach>
            </tr>
        </table>
        <table>
            <c:forEach var="row" items="${_Livros.rows}" varStatus="lc">
                <tr>                    
                    <td><span class="titulo"><c:out value="${row.titulo}"/></span></td>
                    <td><span class="autor"><c:out value="${row.autor}"/></span></td>
                    <td><span class="resenha"><c:out value="${row.resenha}"/></span></td>
                    <td><img src="<c:out value="${row.capa}"/>" 
                             alt="<c:out value="${row.titulo}"/>" 
                             width="120" height="200"><br />
                        <a href="maislivros.jsp?favoritou=1&livro=${row.id}"><input name="votar" class="button" value="Votar nesse Livro" type="button"></a>
                    </td>
                </tr>
            </c:forEach>    
        </table>
        <table border = "0" style="width:980px">
            <tr>
                <td style="text-align:right;border-top: 1px solid;">
                    <a href="concluir_enquete.jsp?votos_concluidos=true"><input name="concluir_enquete" class="button" value="Concluir a Enquete" type="button"></a>
                </td>                        
            </tr>
            <tr>
                <td style="text-align:right;">                
                    <a href="index.jsp?favoritou=0"><input name="voltar" class="button" value="Voltar ao Início" type="button"></a>
                </td>                        
            </tr>            
        </table>
    </body>
</html>
