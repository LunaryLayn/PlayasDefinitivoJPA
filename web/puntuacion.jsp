<%-- 
    Document   : puntuacion
    Created on : 13-feb-2023, 20:34:44
    Author     : hugop
--%>

<%@page import="entities.PuntoView"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
List<PuntoView> puntuaciones = (List<PuntoView>)request.getAttribute("puntuaciones");
%>
<table class="table table-striped text-primary w-50 m-auto">
  <tbody>
      <% for (PuntoView puntoview : puntuaciones) {%>
          <tr>
            <td><img src="img/ic_<%=puntoview.getPunto() %>.png" alt=""></td>
            <td><%=puntoview.getCuenta() %></td>
          </tr>

      <%}%>
  </tbody>
</table>
