<%@page import="Java.conector"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Editar - My Order</title>
        <link rel="icon" href="../../IMG/taco.svg">
        <link rel="stylesheet" href="../../CSS/registro.css">
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

        con = conexion.getConnection();
        sta = con.createStatement();
        //CONEXIÓN A LA BASE - fin
        
        String nombre= request.getParameter("nombre");
        String cor= request.getParameter("correo");
        String ubi= request.getParameter("ubica");
        
        HttpSession sesion=request.getSession();
        String clave= (String)sesion.getAttribute("USERNAME");

        try{
            sta.executeUpdate("update USUARIO set NOMBRE='" +nombre +"', CORREO='" +cor +"' "
                + "where USERNAME='" +clave +"';");
            sesion.setAttribute("CORREO", cor);
            sesion.setAttribute("NOMBRE", nombre);
            sesion.setAttribute("ubica", ubi);
           

            request.getRequestDispatcher("cuenta.jsp").forward(request, response);
        }
        catch(Exception error){
            out.print(error.toString());
        }
        con.close();
        sta.close();
    %>
        <!--    Pie de Página-->
        <script src="https://kit.fontawesome.com/c15b744a04.js" crossorigin="anonymous"></script>
        <script src="../../JS/main.js"></script>
    </body>
</html>
