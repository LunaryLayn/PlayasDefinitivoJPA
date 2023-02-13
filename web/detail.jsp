<%-- 
    Document   : detail
    Created on : 13-feb-2023, 20:07:10
    Author     : hugop
--%>

<%@page import="entities.Images"%>
<%@page import="java.util.List"%>
<%@page import="entities.Playa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body>
      <%Playa playa = (Playa) session.getAttribute("playa");
        int puntuacion = (int) session.getAttribute("puntuacion");
        String star = puntuacion + "";%>
    <div class="container shadow">
        <div class="jumbotron bg-primary text-white my-2 text-center">
          <h1 class="display-3"><%=playa.getNombre() %></h1>
          <h3 class="display-3"><img width="20px" src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId() %>.png" alt=""> <%= playa.getMunicipio().getNombre() %> (<%= playa.getMunicipio().getProvincia().getNombre() %>) <img width="20px" src="img/ccaa_<%=playa.getMunicipio().getProvincia().getCcaa().getId() %>.png" alt=""></h3>
          <p class="lead"><%=playa.getDescripcion() %></p>
          <hr class="my-1">
          <p class="lead"><img src="img/ic_<%=star%>.png" alt=""></p>
        </div>
        <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel" >
          <div class="carousel-inner">
            <%
            List<Images> images = playa.getImagesList();
            String active;
            for (int i=0; i<images.size();i++){
              if (i==0) active=" active"; else active="";
              %>
              <div class="carousel-item<%=active%>" data-interval="3000">
                <img src="img/<%=playa.getId() %>_<%=images.get(i).getId() %>.jpg" class="d-block w-100"  alt="...">
              </div>
            <%}%>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
        <div id="votos" class="text-center py-2 bg-light">
            <% for (int i=1;i<=5;i++) {%>
            <a href="Controller?op=savePuntuacion&puntos=<%=i%>"><img src="img/ic_<%=i%>.png" alt=""></a>
            <%}%>
        </div>
      </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>
