<%-- 
    Document   : votar
    Created on : 17-Jul-2014, 22:57:16
    Author     : armando
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="_Votar" dataSource="jdbc/VOTE_NO_LIVRO">
    SELECT id,titulo,autor,resenha,capa FROM livros WHERE 
    livros.id = ? <sql:param value="${param.livro}"/>
</sql:query>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Votar nesse livro</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table border="0">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${_Votar.columnNames}">
                    <c:if test="${columnName != 'ID'}">
                        <th><c:out value="${columnName}"/></th>
                    </c:if>
                </c:forEach>
            </tr>
        </table>
        <table>
                <c:forEach var="row" items="${_Votar.rows}" varStatus="lc">
                    <tr>                    
                        <td><span class="titulo"><c:out value="${row.titulo}"/></span></td>
                        <td><span class="autor"><c:out value="${row.autor}"/></span></td>
                        <td><span class="resenha"><c:out value="${row.resenha}"/></span></td>
                        <td><img src="<c:out value="${row.capa}"/>" 
                                 alt="<c:out value="${row.titulo}"/>" 
                                 width="120" height="200"><br />
                            <a href="confirmar_voto.jsp?livro=${row.id}&concluir=0"><input name="confirma_voto" class="button" value="Confirmar o Voto" type="button"></a>
                        </td>
                    </tr>
                </c:forEach>    
        </table>
        <table border = "0" style="width:980px">
            <tr>
                <td style="text-align:right;border-top: 1px solid;">
                    <a href="index.jsp"><input name="voltar" class="button" value="Voltar ao Início" type="button"></a>
                </td>                        
            </tr>
        </table>        
    </body>
</html>
