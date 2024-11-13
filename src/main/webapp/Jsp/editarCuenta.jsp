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
        <title>Editar Cuenta - SecureMaps</title>
        <link rel="icon" href="../Images/favicon.ico">
        <link rel="stylesheet" href="../Css/editarCuenta.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    </head>
    <body>
        <header>
            <!-- Barra de navegación -->
            <nav class="nav__hero">
            <div class="container nav__container">
                <div class="logo">
                    <h3 style="color: #fff" class="logo__name" href="../index.html" id="inicio">Securemaps<span class="point">.</span></h3>
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
            
            res= sta.executeQuery("SELECT * FROM USUARIO WHERE USERNAME='" +clave +"';");
            if(res.next()){
                String nombre = res.getString("NOMBRE");
                String correo = res.getString("CORREO");
                String ubi= (String)sesion.getAttribute("ubica");
                String ubicación = "";
        %>
        <!--Contenido-->
        <section class="exterior">
            <div class="relleno">
                <div class="centro">
                <form action="updateCuenta.jsp" method="post" name="cambios" class="formulario-productos">
                    <h2>Usuario: <input type="text" name="user" readonly="readonly" required value=<%=clave%>></h2>
                    <h2>Nombre: <input type="text" name="nombre" onkeypress="return nombre(event)" required value=<%=nombre%>></h2>
                    <h2>Correo: <input type="email" name="correo" required value=<%=correo%>></h2>
                    <h2>Ubicación: <input type="text" name="ubica" onkeypress="return nombre(event)" required value=<%=ubicación%>></h2>  
                </form>
            </div>
                <div class="inf">
                    <div class="botoncito" onclick="document.cambios.submit();" value="Guardar cambios">
                        <a class="boton">Guardar cambios</a>
                    </div>
                    <div class="botoncito">
                        <a href="cambiarContra.jsp" class="boton">Cambiar Contraseña</a>
                    </div>
                    <div class="botoncito">
                        <!--aquí debería haber un modal que dice "¿seguro de que quiere eliminar su cuenta? Los datos no podrán recuperarse"-->
                        <a href="eliminarCuenta.jsp" class="boton">Eliminar Cuenta</a> 
                        <!-- <input type="button" value="Abrir Ventana Modal" class="btn-abrir"> -->
                    </div>
                </div>
            </div>
        </section>
        <%
            }
            else{%>
                <h2>La cuenta ha expirado<h2>
                <a href="../../index.html" class="boton">Ir al inicio</a>
          <%}
            
            }
            catch(Exception error){
                out.print(error.toString());
            }
        %>
        <script src="https://kit.fontawesome.com/c15b744a04.js" crossorigin="anonymous"></script>
        <script src="../Js/login.js"></script>
    </body>
</html>
