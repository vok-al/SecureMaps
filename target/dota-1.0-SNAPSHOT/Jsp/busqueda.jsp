<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Búsqueda  |  SecureMaps</title>
    <style>
            html, body {
                margin: 0;
                font-family: 'Ubuntu', sans-serif;
                height: 100%;
                width: 100%;
                padding: 0;
            }

            /* Estilos scrollbar */

            ::-webkit-scrollbar {
                width: 10px; /* ancho barra */
            }

            ::-webkit-scrollbar-track {
                background: #fff; /* color fondo barra */
            }

            ::-webkit-scrollbar-thumb {
                background: #b0b8c9; /* color barra */
                border-radius: 10px; /* borde barra */
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #9b9eb8;
                transition: .5s /* color barra hover */
            }


            .contenedor {
                width: 90%;
                max-width: 1050px;
                margin: auto;
                overflow: hidden;
            }

            .contenedor1 {
                box-sizing: border-box;
                width: 90%;
                max-width: 1000px;
                margin: auto;
                overflow: hidden;
                padding: 60px 0;
            }

            /* Header */

            header::before {
                content: "";
                display: block;
                margin-bottom: 80px;
            }

            nav {
                width: 100%;
                height: 80px;
                background: #042599;
                border-bottom: 1px solid transparent;
                box-shadow: 1px 1px 10px 0 rgba(0, 0, 0, .2);
                position: fixed;
                top: 0;
                z-index: 100;
                transition: ease-in-out 0.5s;
            }

            .nav {
                display: flex;
                justify-content: space-between;
                height: 80px;
                align-items: center;
                padding: 0 40px;
                color: #fff;
            }

            .nav .logo {
                width: 30%;
                text-decoration: none;
                color: #fff;
                letter-spacing: 5px;
            }

            .nav .logo a {
                font-size: 30px;
                vertical-align: center;
                text-decoration: none;
                color: #fff;
                letter-spacing: 5px;
            }

            .nav .contenedor nav a {
                height: center;
                vertical-align: top;
                text-decoration: none;
                margin-left: 20%;
            }

            .enlaces-header {
                font-weight: 300;
                transition: ease-in-out 0.5s;
            }

            .nav .enlaces-header a {
                color: #fff;
                text-decoration: none;
                margin-left: 20px;
                padding: 7px 5px;
                border-radius: 3px;
                letter-spacing: 5px;
            }

            .nav .enlaces-header a:hover {
                color: black;
                background: #dddddd;
                transition: .5s
            }

            /* Cuerpo */
            .content-area {
                width: 80%;
                height: auto;
                position: relative;
                margin: auto;
                display: grid;
                text-align: center;
                overflow: hidden;
            }

            .buscador {
                text-align:center;
                padding:30px 0px;
                width:30%;
                margin: auto;
            }

            .buscador #address {
                margin:10px;
                margin-top: 20px;
                margin-bottom: 20px;
                padding:7px;
                max-width:250px;
            }

            .buscador #btn {
                margin:0 auto;
                max-width:250px;
                padding:7px;
                color:#FFFFFF;
                background:#f2777a;
                border:2px solid #f2777a;
                cursor:pointer;
            }
            
            .xd {
                margin: auto;
                text-align: center;
                max-width: 300px;
            }
            
            #btn2 {
                margin: auto;
                max-width:250px;
                padding:7px;
                color:#FFFFFF;
                background:#f2777a;
                border:2px solid #f2777a;
                cursor:pointer;
            }

            .map {
                height: 70%;
                width: 90%;
                margin: auto;
            }

            /* Breakpoints responsive */

            @media screen and (max-width: 2560px) {
                /* Barra de navegación*/
                .nav .enlaces-header a {
                    font-size: 20px;
                }
            }

            @media screen and (max-width:1920px) {
                /* Barra de navegación*/
                .nav .enlaces-header a {
                    font-size: 20px;
                }
            }

            @media screen and (max-width: 1440px) {
                .nav .enlaces-header a {
                    font-size: initial;
                }
            }

            @media screen and (max-width: 985px) {
                .nav .logo {
                    width: 50%;
                    text-align: center;
                }
                .nav .logo a {
                    font-size: 30px;
                    text-align: center;
                }
                .contenido-header {
                    height: 650px;
                }
                .nav {
                    padding: 0 10px;
                }
                .enlaces-header {
                    position: fixed;
                    background: #232526;
                    background: -webkit-linear-gradient(to top, #414345, #232526);
                    background: linear-gradient(to top, #414345, #232526);
                    top: 0;
                    right: 0;
                    width: 100%;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    flex-direction: column;
                    justify-content: space-evenly;
                    clip-path: circle(0.0% at 100% 0);
                }
                .nav .menudos {
                    -webkit-clip-path: circle(150% at 100% 0);
                    clip-path: circle(150% at 100% 0);
                }
                .nav .enlaces-header a {
                    color: #fff;
                    font-size: 22px;
                }
                nav .enlaces-header a:hover {
                    color: black;
                    background: #dddddd;
                    transition: .5s
                }
            }

            @media screen and (max-width:600px) {
                .nav .logo {
                    width: 70%;
                }
                .nav .logo a {
                    font-size: 28px;
                    float: left;
                }
                .nav {
                    padding: 0 10px;
                }
                .enlaces-header {
                    position: fixed;
                    background: #232526;
                    background: -webkit-linear-gradient(to top, #414345, #232526);
                    background: linear-gradient(to top, #414345, #232526);
                    top: 0;
                    right: 0;
                    width: 100%;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    flex-direction: column;
                    justify-content: space-evenly;
                    clip-path: circle(0.0% at 100% 0);
                    font-size: 30px;
                }
                .nav .menudos {
                    -webkit-clip-path: circle(150% at 100% 0);
                    clip-path: circle(150% at 100% 0);
                }
            }

            @media screen and (max-width: 425px) {
                .nav .logo {
                    width: 90%;
                }
                .nav .logo a {
                    font-size: 24px;
                }
                .nav {
                    padding: 0 10px;
                }
                .enlaces-header {
                    position: fixed;
                    background: #232526;
                    background: -webkit-linear-gradient(to top, #414345, #232526);
                    background: linear-gradient(to top, #414345, #232526);
                    top: 0;
                    right: 0;
                    width: 100%;
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    flex-direction: column;
                    justify-content: space-evenly;
                    clip-path: circle(0.0% at 100% 0);
                    font-size: 30px;
                }
                .nav .menudos {
                    -webkit-clip-path: circle(150% at 100% 0);
                    clip-path: circle(150% at 100% 0);
                }
                .nav .enlaces-header a {
                    color: #fff;
                }
            } 
        </style>
    <script>
            var geocoder;
            var map;

            function initialize() {
                geocoder = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(19.453861, -99.175133);
                var mapOptions = {
                    zoom: 12,
                    center: latlng,
                    scrollwheel: true,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControl: false
                }
                map = new google.maps.Map(document.getElementById('map'), mapOptions);
            }

            function localizar() {
                var address = document.getElementById("address").value;

                geocoder.geocode( { 'address' : address}, function(results, status) {
                    if (status == 'OK') {
                        map.setCenter(results[0].geometry.location);
                        var marker = new google.maps.Marker({
                            map: map,
                            position: results[0].geometry.location
                        });
                    }
                    else {
                        var mensajeError = "";
                        if (status === "ZERO_RESULTS") {
                            mensajeError = "No hubo resultados para la dirección ingresada.";
                        } else if (status === "OVER_QUERY_LIMIT" || status === "REQUEST_DENIED" || status === "UNKNOWN_ERROR") {
                            mensajeError = "Error general del mapa.";
                        } else if (status === "INVALID_REQUEST") {
                            mensajeError = "Error de la web. Contacte con Name Agency.";
                        }
                        alert(mensajeError);
                    }
                });
            }

            window.initMap = initMap;
        </script>
</head>

<body onload="initialize()">
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
    
    <div class="buscador">
        <h2>Ingresa una dirección o el nombre de algún lugar</h2>
        <input type="text" id="address" required>
        <button onclick="localizar()" id="btn">Buscar</button>
    </div>

    <div id="map" class="map"></div>
    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfOd4UISFajb7rJjrqFzETG0fOZATDXKk&callback=initMap&v=weekly"
            defer >
    </script>
    <!--AIzaSyCfOd4UISFajb7rJjrqFzETG0fOZATDXKk Key de Fer-->
    <br><br>
    <div class="xd">
        <button id="btn2" onclick= "document.action = 'traslado.jsp'">Ir a la ruta</button>
    </div>
    <br><br>
</body>
</html>