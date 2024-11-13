<%@page import="Java.conector"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Securemaps</title>
        <link rel="stylesheet" href="../Css/index.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800&display=swap" rel="stylesheet"> 

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Zen+Kurenaido&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/jpg" href="../Images/favicon.ico"/>
    </head>
    <body>
    <header>
        <div class="container">
            <nav>
                <a href="#" id="icono" class="icono">Menú</a>
                <div class="enlaces uno" id="enlaces">
                    <a href="#">Inicio</a>
                    <a href="cuenta.jsp">Mi cuenta</a>
                    <a href="visitados.jsp">Mis lugares</a>
                    <a href="seguridad.jsp">Buscar lugares seguros</a>
                    <a href="../Html/sobreEmpresa">Sobre nosotros</a>
                    <a href="../Html/sobreEmpresa">Contacto</a>
                </div>
            </nav>
            <%
            //CONEXIÓN A LA BASE - inicio
            conector conexion = new conector();
            
            Connection con = null;
            Statement sta = null;
            ResultSet res = null;
            
            con = conexion.getConnection();
            sta = con.createStatement();
            //CONEXIÓN A LA BASE - fin
            
            HttpSession sesion = request.getSession();

            String cor = request.getParameter("email");
            String psw = request.getParameter("password");
            
            try{
                res = sta.executeQuery("SELECT * FROM USUARIO WHERE USERNAME='"+cor+"';");
                
                if (res.next()) {
                    String usu = res.getString("USERNAME");
                    String nombre = res.getString("NOMBRE");
                    String correo = res.getString("CORREO");
                    String contra = res.getString("PSW");
                    
                    sesion.setAttribute("USERNAME", usu);
                    sesion.setAttribute("NOMBRE", nombre);
                    sesion.setAttribute("CORREO", correo);
                    sesion.setAttribute("PASSWORD", contra);
                    
                    if(psw.equals(contra)){
            %>
            <div class="textos">
                <h1>Bienvenido <%out.print(sesion.getAttribute("USERNAME"));%></h1>
                <h2>ha iniciado sesión exitosamente!</h2>
                <a href="cuenta.jsp">Mi Cuenta</a>
            </div>
            
            <img src="../Images/vector.png" alt="">
        </div>
    </header>        
                
        <%          }
                    else{
        %>
            <div class="der">
                    <h1>La contraseña es incorrecta</h1>
                </div>
                <div class="botoncito">
                    <a href="../Html/login.html" class="boton">Regresar</a>
                </div>
<%                    }
            } 
                    else {
                    out.println("<script>alert('No hay registros, <a href = '#'>crea una cuenta</a>')</script>");
                    out.print("");
                    out.print("<h1>");
                    out.println("No hay registros");
                    out.print("<br>");
                    out.println("<a href ='../Html/login.html' >Crea una cuenta aquí</a>");
                    out.print("</h1>");
                }
            }
            catch(SQLException error){
                out.println(error.toString());
            }     
            %>
    <div class="wave">
        <div style="height: 150px; overflow: hidden;" ><svg viewBox="0 0 500 150" preserveAspectRatio="none" style="height: 100%; width: 100%;">
            <path d="M0.00,49.98 C150.00,150.00 349.20,-50.00 500.00,49.98 L500.00,150.00 L0.00,150.00 Z" style="stroke: none; fill: #fff;"></path></svg></div>
    </div>
            <script src="../Js/index.js"></script>
    </body>
</html>
