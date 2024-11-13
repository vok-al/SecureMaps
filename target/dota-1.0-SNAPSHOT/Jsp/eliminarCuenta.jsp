<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Eliminar - ScureMaps</title>
        <link rel="icon" href="../../IMG/taco.svg">
        <link rel="stylesheet" href="../Css/cuenta.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <!-- Barra de navegación -->
            <nav>
                <section class="contenedor nav">
                    <div class="logo">
                        <a href="../HTML/principal.html">Ojo de Agua</a>
                    </div>
                    <div class="enlaces-header">
                        <a href="../HTML/conocenos.html">Conócenos</a>
                        <a href="menu.jsp">Menú</a>
                        <a href="../HTML/ordenar.html">Ordenar</a>
                        <a href="cuenta.jsp">Cuenta</a>
                    </div>
                    <div class="hamburguer">
                        <i class="fas fa-bars"></i>
                    </div>
                </section>
            </nav>
        </header>
        
        <%
            //CONEXIÓN A LA BASE - inicio
            conector conexion = new conector();
            
            Connection con = null;
            Statement sta = null;
            ResultSet res= null;
            
            con = conexion.getConnection();
            PreparedStatement pst = null;
            sta = con.createStatement();
            //CONEXIÓN A LA BASE - fin
            
            try{
            HttpSession sesion =request.getSession();
            String clave= (String)sesion.getAttribute("boleta");
            String sql1 = "DELETE FROM PASOS WHERE IDUSUARIO = ?";
            String sql2 = "DELETE FROM DIRECUSUARIO WHERE IDUSUARIO = ?";
            String sql3 = "DELETE FROM VISITA WHERE IDUSUARIO = ?";
            String sql4 = "DELETE FROM REVIEW WHERE IDUSUARIO = ?";
            String sql5 = "DELETE FROM HISTBUSQUEDA WHERE IDUSUARIO = ?";
            String sql6 = "DELETE FROM USUARIO WHERE IDUSUARIO = ?";

            pst = con.prepareStatement(sql1);
            pst.setString(1, clave);
                pst.executeUpdate();

            pst = con.prepareStatement(sql2);
                pst.setString(1, clave);
                pst.executeUpdate();

            pst = con.prepareStatement(sql3);
            pst.setString(1, clave);
                pst.executeUpdate();

            pst = con.prepareStatement(sql4);
            pst.setString(1, clave);
                pst.executeUpdate();

            pst = con.prepareStatement(sql5);
            pst.setString(1, clave);
                pst.executeUpdate();

            pst = con.prepareStatement(sql6);
            pst.setString(1, clave);
                pst.executeUpdate();
        %>
                <!--Contenido-->
                <script>alert('Borrado exitosamente')</script>
          <%
            sesion.setAttribute("USERNAME", null);
            sesion.setAttribute("NOMBRE", null);
            sesion.setAttribute("CORREO", null);
            sesion.setAttribute("PASSWORD", null);
            request.getRequestDispatcher("cuenta.jsp").forward(request, response);
            }
            catch(Exception error){
                out.print(error.toString());
            }
        %>
    </body>
</html>