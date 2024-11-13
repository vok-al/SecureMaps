<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Cuenta - SecureMaps</title>
        <link rel="icon" href="../Images/favicon.ico">
        <link rel="stylesheet" href="../Css/cuenta.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    </head>
    <body>
        <header>
            <!-- Barra de navegación -->
            <nav class="nav__hero">
            <div class="container nav__container">
                <div class="logo">
                    <h3 class="logo__name" href="../index.html" id="inicio">Securemaps<span class="point">.</span></h3>
                </div>
                <div class="links">
                    <a href="#" class="link">Buscar</a>
                    <a href="seguridad.jsp" class="link">Seguridad</a>
                    <a href="#" class="link">Atracciones</a>
                    <a href="#" class="link link--active">Cuenta</a>
                </div>
            </div>
        </nav>
        </header>
    <%
        HttpSession sesion=request.getSession();

        // redirigir cuando la cuenta haya expirado
        if(sesion.getAttribute("USERNAME") == null){
            out.print("<script>window.open('../Html/login.html', '_self')</script>");
        }
        else{
            String contri= (String)sesion.getAttribute("PASSWORD");
            int cuantos= contri.length();
            contri= "";
            for(int i=0; i<cuantos; i++){
                contri= contri +"*";
        }
    %>
        
        <!-- Contenido -->
        <section class="exterior">
            <div class="relleno">
                <div class="centro">
                    <h2>Usuario: <%out.print(sesion.getAttribute("USERNAME"));%></h2>
                    <h2>Nombre: <%out.print(sesion.getAttribute("NOMBRE"));%></h2>
                    <h2>Correo: <%out.print(sesion.getAttribute("CORREO"));%></h2>
                    <h2>Contraseña: <%out.print(contri);%></h2>
                    <h2>Dirección: <%out.print(sesion.getAttribute("ubica"));%></h2>
                    
                </div>
                <div class="der">
                    <a title="edit" href="editarCuenta.jsp"><img src="../Images/edit.png" alt="edit" /></a>
                </div>
                <div class="inf">
                    <div class="botoncito">
                        <a href="#" class="boton">Ver lugares</a>
                    </div>
                    <div class="botoncito">
                        <a href="#" class="boton">Ver Contapasos</a>
                    </div>
                    <div class="botoncito">
                        <a href="cerrarSesión.jsp" class="boton">Cerrar Sesión</a>
                    </div>
                </div>
            </div>
        </section>
    <%}%>
