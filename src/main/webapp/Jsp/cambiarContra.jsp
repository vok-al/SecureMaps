<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Cambiar - SecureMaps</title>
        <link rel="icon" href="../../IMG/taco.svg">
        <link rel="stylesheet" href="../Css/cambiarContra.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <!-- Barra de navegación -->
            <nav class="nav__hero">
            <div class="container nav__container">
                <div class="logo">
                    <h2 style="color: #ffffff" class="logo__name" href="../index.html" id="inicio">Securemaps<span class="point">.</span></h2>
                </div>
                <div class="links">
                    <a href="#" class="link">Buscar</a>
                    <a href="seguridad.jsp" class="link">Seguridad</a>
                    <a href="#" class="link">Atracciones</a>
                    <a href="cuenta.jsp" class="link link--active">Cuenta</a>
                </div>
            </div>
        </nav>
        </header>
        
    <%
        //CONEXIÓN A LA BASE - inicio
        conector conexion = new conector();

        Connection con = null;
        Statement sta = null;
        ResultSet res= null;

        con = conexion.getConnection();
        sta = con.createStatement();
        //CONEXIÓN A LA BASE - fin

        try{
            HttpSession sesion=request.getSession();
            String clave= (String)sesion.getAttribute("USERNAME");
            String contra= "";
            res= sta.executeQuery("SELECT * FROM USUARIO WHERE USERNAME='" +clave +"';");
            if(res.next()){
                contra = res.getString("PSW");
            %>
    <!--Contenido-->
    <section>
        <div class="cajita">
            <form action="updateContra.jsp" method="post" class="" name="cambiaContra" class="formulario-productos">
                <div class="sup">
                    <h2>Contraseña actual: <input type="password"  name="anterior" id="anterior" placeholder="Escribe tu contraseña" required></h2>
                    <h2>Nueva contraseña: <input type="password" name="contra1" id="anterior" placeholder="Escribe tu nueva contraseña" required></h2>
                    <h2>Confirmar la contraseña nueva: <input type="password" name="contra2" id="anterior" placeholder="Confirma tu nueva contraseña" required></h2>
                </div>            
                <div class="inf">
                    <div class="botoncito">
                        <input type='submit' class='boton' value='Cambiar'>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <%}
    else
        out.print("<script>window.open('../../index.html', '_self')</script>");
    }
        catch(Exception error){
            out.print(error.toString());
        }
    %>
    <!--Pie de Página-->
        <footer>
            <div class="partFooter">
                <a href="https://ipn.mx" target="black">
                    <img src="https://www.encb.ipn.mx/assets/files/encb/img/escudos/logo-ipn.png">
                </a>
            </div>
            <div class="partFooter">
                <h4>Servicios</h4>
                <a href="#">Servicio 1</a>
                <br>
                <a href="#">Servicio 2</a>
                <br>
                <a href="#">Servicio 3</a>
            </div>
            <div class="partFooter">
                <h4>Acerca de</h4>
                <a href="../HTML/conocenos.html">Equipo</a>
                <br>
                <a href="../HTML/ordenar.html">Pedidos</a>
                <br>
                <a href="../HTML/ordenar.html">Formas de entrega</a>
            </div>
            <div class="partFooter">
                <h4>Redes sociales</h4>
                <div class="social-media">
                    <a href="https://www.facebook.com/Juan-de-Dios-B%C3%A1tiz-Oficial-813458352356480"
                       target="blank">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="https://twitter.com/_cecyt9" target="blank">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <i class="fab fa-discord"></i>
                    <a href="https://open.spotify.com/playlist/3nrH8IHqasW8D8XfmCWnUo?si=OPp1KVT1SQO0VGvHokwpBw" target="blank">
                        <i class="fab fa-spotify"></i>
                    </a>
                </div>
            </div>
        </footer>
        <script src="https://kit.fontawesome.com/c15b744a04.js" crossorigin="anonymous"></script>
        <script src="../../JS/login.js"></script>
    </body>
</html>