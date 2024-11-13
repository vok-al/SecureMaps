<%@page import="javax.servlet.http.HttpSession"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession sesion=request.getSession();
            sesion.setAttribute("USERNAME", null);
            sesion.setAttribute("NOMBRE", null);
            sesion.setAttribute("CORREO", null);
            sesion.setAttribute("PASSWORD", null);
        %>
        <script>window.open('../index.html', '_self')</script>
    </body>
</html>
