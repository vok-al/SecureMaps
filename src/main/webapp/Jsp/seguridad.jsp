<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>SecureMaps - Seguridad</title>
        <link rel="stylesheet" href="../Css/Seguridad.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
        <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
        <link rel="shortcut icon" type="image/jpg" href="../Imagenes/favicon.ico"/>
        <%
                //CONEXIÓN A LA BASE - inicio
                conector conexion = new conector();
                
                Connection con = null;
                Statement sta = null;
                ResultSet res = null;
                
                con = conexion.getConnection();
                sta = con.createStatement();
                //CONEXIÓN A LA BASE - fin
                
                String sql = "select * from SEGURIDAD";
                int aux = 0;
                String [][] zonass = new String[36][5];
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    res = sta.executeQuery(sql);
                    
                    while(res.next()) { 
                        zonass[aux][0] = String.valueOf(res.getDouble(2));
                        zonass[aux][1] = String.valueOf(res.getDouble(3));
                        zonass[aux][2] = res.getString(4);
                        zonass[aux][3] = res.getString(5);
                        zonass[aux][4] = res.getString(6);
                        aux++;
                    }
                    
                    con.close();
                    sta.close();
                    res.close(); 
                }
                catch(SQLException e) {
                    out.print(e.toString());
                }
        %>
        <script> 
            let map;
            var zonasR = [180];
            
            <%int aux2 = 0; 
              for (int i=0; i<36; i++) { %>
                <%for(int j=0; j<5; j++) {%>
                    zonasR[<%=aux2%>] = "<%=zonass[i][j]%>";
                    <%aux2++;%>
            <% }} %>
            
            function initMap() {
                
                
                const myLoc = {lat: 19.453861, lng: -99.175133};
                map = new google.maps.Map(
                document.getElementById("map"), 
                {center: myLoc,
                zoom: 11,
                mapTypeId: google.maps.MapTypeId.ROADMAP});  //ROADMAP, SATELLITE, HYBRYD, TERRA

                loc = new google.maps.Marker({
                position: myLoc,
                icon: "../Images/loc.png", 
                map: map, 
                title: "yo"});
            
                var scolor;
                var fcolor;

                for(i=0; i<180; i+=5) {
                    switch(parseInt(zonasR[i+2], 10)) {
                        case 1:
                            scolor = "#F51B17"; //rojo
                            fcolor = "#F51B17";
                            break;
                        case 2:
                            scolor = "#F67B0F"; //naranja
                            fcolor = "#F67B0F";
                            break;
                        case 3:
                            scolor = "#F2F918"; //amarillo
                            fcolor = "#F2F918";
                            break;
                        case 4:
                            scolor = "#1D51EC"; //azul
                            fcolor = "#1D51EC";
                            break;
                    }
                    
                    var zonaCircle = new google.maps.Circle({
                    strokeColor: scolor,
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: fcolor,
                    fillOpacity: 0.35,
                    map: map,
                    center: {lat: parseFloat(zonasR[i]), lng: parseFloat(zonasR[i+1])},
                    radius: 700
                    });

                    var marker = new google.maps.Marker({    
                    position: {lat: parseFloat(zonasR[i]), lng: parseFloat(zonasR[i+1])},    
                    map: map,
                    title: zonasR[i+3],
                    icon: ".."
                    }); 

                    var riesgo;
                    if(zonasR[i+2] == 4) 
                        riesgo = "Contagios por mes: ";
                    else
                        riesgo = "Homicidios al mes: ";

                    var content = "<div><h2>Colonia " + zonasR[i+3] + "</h2><br><h3>" + riesgo + zonasR[i+4] + "</h3></div>";     

                    var infowindow = new google.maps.InfoWindow();

                    google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){ 
                        return function() {
                           infowindow.setContent(content);
                           infowindow.open(map,marker);
                        };
                    })(marker,content,infowindow));
                }
            }
        </script>
        <link rel="stylesheet" href="../Css/Seguridad.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <!-- Barra de navegación -->
            <nav>
                <section class="contenedor nav">
                    <div class="logo">
                        <a href="../index.html">SecureMaps</a>
                    </div>
                    <div class="enlaces-header">
                        <a href="Ubicacion.jsp">Ubicación</a>
                        <a href="seguridad.jsp">Seguridad</a>
                        <a href="busqueda.jsp">Búsqueda</a>
                        <a href="cuenta.jsp">Login</a>
                    </div>
                    <div class="hamburguer">
                        <i class="fas fa-bars"></i>
                    </div>
                </section>
            </nav>
        </header>
        
        
        <!-- Cuerpo -->
        <section class="content-area">
            <h2>Zonas en las que tu vida está en riesgo</h2>
            <br><br>
            <div id="map" class="map"></div>
            <script
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfOd4UISFajb7rJjrqFzETG0fOZATDXKk&callback=initMap&v=weekly"
                async
            ></script>
            <br><br>
            <div class="tabla"><img src="../Images/tablaseg.png"></div>
        </section>
    </body>
</html>