<%-- 
    Document   : index
    Created on : 17-Jul-2014, 11:16:17
    Author     : armando
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="_Livros" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT id,titulo,autor,resenha,capa FROM livros
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vote no Livro - Um programa de teste</title>
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
                <c:if test="${lc.count <= 2}">
                    <tr>                    
                        <td><span class="titulo"><c:out value="${row.titulo}"/></span></td>
                        <td><span class="autor"><c:out value="${row.autor}"/></span></td>
                        <td><span class="resenha"><c:out value="${row.resenha}"/></span></td>
                        <td><img src="<c:out value="${row.capa}"/>" 
                                 alt="<c:out value="${row.titulo}"/>" 
                                 width="120" height="200"><br />
                            <a href="votar.jsp?livro=${row.id}"><input name="votar" class="button" value="Votar nesse Livro" type="button"></a>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>    
        </table>
        <table border = "0" style="width:980px">
            <tr>
                <td style="text-align:right;border-top: 1px solid;">
                    <a href="maislivros.jsp"><input name="votar_mais" class="button" value="Votar em mais Livros" type="button"></a>
                </td>                        
            </tr>
        </table>
    </body>
</html>
