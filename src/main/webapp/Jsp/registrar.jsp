<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Securemaps</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="../Css/login.css">
        <link href="https://fonts.googleapis.com/css2?family=Zen+Kurenaido&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/jpg" href="../Imagenes/favicon.ico"/>
    </head>
    <body>
         <%
            //CONEXIÓN A LA BASE - inicio
            conector conexion = new conector();

            Connection con = null;
            Statement sta = null;
            ResultSet res = null;

            con = conexion.getConnection();
            sta = con.createStatement();
            CallableStatement cs = null;
            //CONEXIÓN A LA BASE - fin
            
            String usu= "";
            String nombre= "";
            String correo= "";
            String contra= "";
            
            try{   
                usu = request.getParameter("user");
                nombre = request.getParameter("nombre");
                correo = request.getParameter("correo");
                contra = request.getParameter("contrasenia");

//               Este es un proceso para identificar si ya hay usuarios registrados en la base de datos
                String sql = "CALL CONSULTAR_USUARIO(?);";
                sta.executeQuery("USE SECUREMAPS;");
                cs = con.prepareCall(sql);
                cs.setString(1, usu);
                cs.execute();

                res = cs.executeQuery();
                
                if (res.next()) {
//                    Si encuentra un resultado 
                    %>
                    <script>alert('Este usuario ya ha sido registrado')</script>
                    <a href = '../Html/login.html'><h4 style='color: #2ecc71; font-family: sans-serif'>Intentar con otro usuario</h4></a>
                    <br><a href = '../Html/login.html'><h4 style='color: #2ecc71; font-family: sans-serif'>¿Olvidaste tu contraseña?</h4></a>
              <%}
                else{
                    String sql2 = "CALL REGISTRAR(?, ?, ?, ?);";
                    
                    sta.executeQuery("USE SECUREMAPS;");
                    cs = con.prepareCall(sql2);
                    cs.setString(1, usu);
                    cs.setString(2, nombre);
                    cs.setString(3, correo);
                    cs.setString(4, contra);
                    cs.execute();

                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("USERNAME", usu);
                    sesion.setAttribute("NOMBRE", nombre);
                    sesion.setAttribute("CORREO", correo);
                    sesion.setAttribute("PASSWORD", contra);
%>
                <script>alert('Usuario exitosamente registrado')</script>
            <script>window.open('../index.html', '_self')</script>
        <div class="wave">
            <div style="height: 150px; overflow: hidden;" ><svg viewBox="0 0 500 150" preserveAspectRatio="none" style="height: 100%; width: 100%;">
                <path d="M0.00,49.98 C150.00,150.00 349.20,-50.00 500.00,49.98 L500.00,150.00 L0.00,150.00 Z" style="stroke: none; fill: #fff;"></path></svg></div>
        </div>
                <script src="../Js/index.js"></script>
        </body>
    </html>
               <%}
            }
            catch(SQLException error){
//                out.println(error.toString());
            }
        %>
