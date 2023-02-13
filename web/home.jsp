<%-- 
    Document   : home
    Created on : 13-feb-2023, 18:17:50
    Author     : hugop
--%>

<%@page import="entities.Usuario"%>
<%@page import="entities.Playa"%>
<%@page import="entities.Municipio"%>
<%@page import="entities.Provincia"%>
<%@page import="entities.Ccaa"%>
<%@page import="java.util.List"%>
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
      <%  Ccaa ccaa;
          Provincia provincia;
          Municipio municipio;
          List<Ccaa> comunidades = (List<Ccaa>) session.getAttribute("comunidades");
          List<Provincia> provincias = (List<Provincia>) session.getAttribute("provincias");
          List<Municipio> municipios = (List<Municipio>) session.getAttribute("municipios");
          List<Playa> playas = (List<Playa>) session.getAttribute("playas");
          Usuario usuario = (Usuario) session.getAttribute("usuario");%>
          
    <div class="container">
        <div class="row">
            <div class="col-4"><img src="./img/logo.png" alt=""> </div>
            <div class="col-8">
                <div class="row">
                    <div class="ml-auto">
                        <%if (usuario==null){%>
                        <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#modelLogin">Login</button>
                        <%} else {%>
                        <span>Welcome <%=usuario.getNick()%></span>
                        <a href="Controller?op=logout"><button type="button" class="btn btn-danger">Logout</button></a>
                        <%}%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <form action="Controller?op=getprovincias" method="post">
                        <div class="form-group">
                          <label for=""></label>
                          <select class="form-control" name="cbcomunidad" id="cbcomunidad" onchange="this.form.submit()">
                            <option disabled selected value="null">Elige comunidad</option>
                            <%for (int i=0; i<comunidades.size() ;i++) {
                            ccaa = comunidades.get(i);%>
                            <option value="<%=i%>"><%=ccaa.getNombre()%></option>
                            <%}%>
                          </select>
                        </div>
                    </form>
                    </div>
                    <div class="col-lg-4">
                        <form action="Controller?op=getmunicipios" method="post">
                        <div class="form-group">
                          <label for=""></label>
                          <select class="form-control" name="cbprovincia" id="cbprovincia" onchange="this.form.submit()">
                            <option disabled selected value="null">Elige provincia</option>
                            <%if(provincias!=null){                                                         
                                for (int i=0; i<provincias.size() ;i++) {
                                    provincia = provincias.get(i);%>
                            <option value="<%=i%>"><%=provincia.getNombre()%></option>
                            <%}}%>
                          </select>
                        </div>
                    </form>
                    </div>
                    <div class="col-lg-4">
                        <form action="Controller?op=getplayas" method="post" >
                        <div class="form-group">
                          <label for=""></label>
                          <select class="form-control" name="cbmunicipio" id="cbmunicipio" onchange="this.form.submit()">
                            <option disabled selected value="null">Elige municipio</option>
                             <%if(municipios!=null){                                                         
                                for (int i=0; i<municipios.size() ;i++) {
                                    municipio = municipios.get(i);%>
                            <option value="<%=i%>"><%=municipio.getNombre()%></option>
                            <%}}%>
                          </select>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
            </div>
                          <!-- Cards -->   
        <div class="row justify-content-center">
            <%if(playas!=null){
                for (Playa playa : playas) {%>
                <div class="col-6">
                    <div class="card">
                        <img class="card-img-top" src="img/<%=playa.getId()%>_<%=playa.getImagesList().get(0).getId()%>.jpg" alt="">
                        <div class="card-body">
                            <h4 class="card-title"><%=playa.getNombre()%></h4>
                            <p class="card-text"><%=playa.getDescripcion()%></p>
                        </div>
                        <%if(usuario!=null){%>
                        <div class="justify-content-between d-flex p-2">
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalinfo" data-nombreplaya="<%=playa.getNombre()%>" data-idplaya="<%=playa.getId()%>" >info</button>
                            <a href="Controller?op=detail&det=<%=playa.getId()%>"> <button type="button" class="btn btn-primary"> detail </button> </a>
                        </div>
                        <%}%>
                    </div>
                </div>
                        <%}}%>
            </div>
        </div>
        
        <div class="modal fade" id="modelLogin" tabindex="-1" role="dialog" aria-labelledby="modelTitleId" aria-hidden="true">
        <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Login/Register</h5>
      </div>
      <form action="Controller?op=login" method="POST">
        <div class="modal-body">
              <div class="form-group">
                <label for="exampleInputEmail1">Nick</label>
                <input type="text" class="form-control" name="nick" placeholder="Enter Nick" required="">
              </div>
              <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password" class="form-control" name="pass" placeholder="Enter Paswword" required="">
              </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
          <button class="btn btn-primary" type="submit">Login/Register</button>
        </div>
      </form>

    </div>
  </div>
    </div>
            
            <!-- Modal info -->
    <div class="modal fade" id="modalinfo" tabindex="-1" role="dialog" aria-labelledby="modelTitleId" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title text-center bg-primary w-100 text-white">Calificación de la playa</h5>
          </div>
          <div class="modal-body table-responsive">
              <h4 class="text-primary w-100 text-center">  <!-- se rellena con Ajax --></h4>
              <div>  <!-- se rellena con Ajax --></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="./js/myjs.js"></script>
    <script>
        $('#cbcomunidad').val("<%=session.getAttribute("cbcomunidad")%>");
        $('#cbprovincia').val("<%=session.getAttribute("cbprovincia")%>");
        $('#cbmunicipio').val("<%=session.getAttribute("cbmunicipio")%>");
    </script>

</body>
</html>
