<%@page import="Java.conector"%>
<%@page import="Java.Array"%>
<%@page import="java.sql.*"%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Lugares - Cuenta</title>
        <link rel="icon" href="../Images/favicon.ico">
        <link rel="stylesheet" href="../Css/visitados.css">
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
                    <a href="#" class="link">Seguridad</a>
                    <a href="#" class="link">Atracciones</a>
                    <a href="#" class="link link--active">Cuenta</a>
        <%
            //CONEXIÓN A LA BASE - inicio
            conector conexion = new conector();
            Connection con;
            PreparedStatement pst;
            ResultSet res;
            String sql = "select * from comida where tipo = 'desayuno'";
            //CONEXIÓN A LA BASE - fin
            
            try {
                con = conexion.getConnection();
                pst = con.prepareStatement(sql);
                res = pst.executeQuery();
                
                int aux = 1;
        %>
                <section>
                <div class="wrapper">
        <%
                //Desayunos
                try {
                    %>
                    <div class="title">
                        <h4><span>Mis lugares</span>Lugares visitados</h4>
                    </div>
                    <div class="menu">
       <%
                        while(res.next()) {
                            pst.setString(1, res.getString(1));
                            res = pst.executeQuery();
                            res.next();
        %>
                            <div class="single-menu"> 
                                <img src="<%=res.getString(4)%>">
                                <div class="menu-content">
                                    <h4><%=res.getString(2)%><span>$<%=res.getString(5)%></span></h4> 
                                    <p><%=res.getString(3)%></p>
        <%              }
                }
                catch(SQLException e) {
                    out.print(e.toString());
                }
            }
            catch(SQLException e) {
                out.print(e.toString());
            }
        %>
        </nav>
        </header>
    </body>
</html>
