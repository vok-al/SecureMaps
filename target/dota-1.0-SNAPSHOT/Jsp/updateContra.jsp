<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Editar - My Order</title>
        <link rel="icon" href="../../IMG/taco.svg">
        <link rel="stylesheet" href="../Css/registro.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
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
        //CONEXIÓN A LA BASE - inicio
        conector conexion = new conector();

        Connection con = null;
        Statement sta = null;

        con = conexion.getConnection();
        sta = con.createStatement();
        CallableStatement cs = null;
        //CONEXIÓN A LA BASE - fin
        
        String boleta= "";
        String anterior= "";
        String contra1= "";
        String contra2= "";
        String real= "";
        HttpSession sesion=request.getSession();
        
        boleta= (String)sesion.getAttribute("USERNAME");
        real= (String)sesion.getAttribute("PASSWORD");

        anterior= request.getParameter("anterior");
        contra1= request.getParameter("contra1");
        contra2= request.getParameter("contra2");

        if(contra1.equals(contra2)){
            if(anterior.equals(real)){
                try{
                    sta.executeUpdate("USE SECUREMAPS;");
                    cs = con.prepareCall("CALL cambiar_contra(?,?);");
                    cs.setString(1, boleta);
                    cs.setString(2, contra1);
                    cs.execute();
                    
                    sesion.setAttribute("PASSWORD", contra1);
                }
                catch(Exception error){
                    out.print(error.toString());
                }
                con.close();
                sta.close();
                %>
<!--            Cambio realizado exitosamente-->
        <section>
            <div class="mensaje">
                <div class="izq">
                    <img src="../Images/bien.png"> 
                </div>
                <div class="der">
                    <h1>El cambio se ha realizado exitosamente</h1>
                </div>
                <div class="botoncito">
                    <a href="cuenta.jsp" class="boton">Regresar</a>
                </div>
            </div>
        </section>
            <%}
            else{%>
<!--                La contraseña actual es incorrecta-->
        <section>
            <div class="mensaje">
                <div class="izq">
                    <img src="../Images/mal.png"> 
                </div>
                <div class="der">
                    <h1>La contraseña actual es incorrecta</h1>
                </div>
                <div class="botoncito">
                    <a href="editarCuenta.jsp" class="boton">Regresar</a>
                </div>
            </div>
        <%}
        }
        else{%>
<!--            La nueva contraseña y la confirmación no coinciden-->
        <section>
            <div class="mensaje">
                <div class="izq">
                    <img src="../Images/mal.png"> 
                </div>
                <div class="der">
                    <h1>La nueva contraseña y la confirmación no coinciden</h1>
                </div>
                <div class="botoncito">
                    <a href="cambiarContra.jsp" class="boton">Regresar</a>
                </div>
            </div>
        </section>
        <%}
        %>
        <script src="https://kit.fontawesome.com/c15b744a04.js" crossorigin="anonymous"></script>
        <script src="../../JS/main.js"></script>
    </body>
</html>