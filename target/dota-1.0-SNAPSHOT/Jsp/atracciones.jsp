<%@page import="Java.conector"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Atracciones  |  SecureMaps</title>
        <!-- <link rel="stylesheet" href="../Css/Ubicacion.css"> -->
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
              
            HttpSession sesion=request.getSession();
        %>
        <script>
            var geocoder;
            var map;
            var lat, lng;

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
                const pos= results[0].geometry.location
                sesion.setAttribute("UBI", pos);
            }
            
            function ubicame() {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(
                      (position) => {
                        const pos = {
                          lat: position.coords.latitude,
                          lng: position.coords.longitude,
                        };

                        const marker = new google.maps.Marker({
                            position: pos,
                            map: map
                        });


                        marker.setPosition(pos);
                        marker.open(map);
                        map.setCenter(pos);
                      },
                      () => {
                        handleLocationError(true, infoWindow, map.getCenter());
                      }
                    );

                } else {
                  // Browser doesn't support Geolocation
                  handleLocationError(false, infoWindow, map.getCenter());
                }
                sesion.setAttribute("UBI", pos);
            }
            
            function addPlaces(places, map) {
                const placesList = document.getElementById("places");

                for (const place of places) {
                  if (place.geometry && place.geometry.location) {
                    const image = {
                      url: place.icon,
                      size: new google.maps.Size(71, 71),
                      origin: new google.maps.Point(0, 0),
                      anchor: new google.maps.Point(17, 34),
                      scaledSize: new google.maps.Size(25, 25),
                    };

                    new google.maps.Marker({
                      map,
                      icon: image,
                      title: place.name,
                      position: place.geometry.location,
                    });

                    const li = document.createElement("li");

                    li.textContent = place.name;
                    placesList.appendChild(li);
                    li.addEventListener("click", () => {
                      map.setCenter(place.geometry.location);
                    });
                  }
                }
            }
            
            function cercanos() {
                alert("funciona");
                const pyrmont= sesion.getAttribute("NOMBRE")
                
                //Create de places service
                const service = new google.maps.places.PlacesService(map);
                let getNextPage;
                const moreButton = document.getElementById("more");

                moreButton.onclick = function () {
                  moreButton.disabled = true;
                  if (getNextPage) {
                    getNextPage();
                  }
                };
                
                // Perform a nearby search.
                service.nearbySearch(
                  { location: pyrmont, radius: 500, type: "store" },
                  (results, status, pagination) => {
                    if (status !== "OK" || !results) return;

                    addPlaces(results, map);
                    moreButton.disabled = !pagination || !pagination.hasNextPage;
                    if (pagination && pagination.hasNextPage) {
                      getNextPage = () => {
                        // Note: nextPage will call the same handler function as the initial call
                        pagination.nextPage();
                      };
                    }
                  }
                );
            }

            window.initMap = initMap;
            
        sesion.setAttribute("LAT", usu);
        sesion.setAttribute("LNG", usu);
        </script>
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
            
            .buscador #cloc {
                margin:0 auto;
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
                        <a href="pruebita.jsp">Pruebita</a>
                        <a href="atracciones.jsp">Atracciones</a>
                    </div>
                </section>
            </nav>
        </header>
        
        
        <!-- Cuerpo -->
        <div class="buscador">
            <h2>Ingresa tu ubicación actual</h2>
            <input type="text" id="address" required>
            <button onclick="localizar()" id="btn">Buscar</button>
            <button id="cloc" onclick="ubicame()">Encuéntrame</button>
            <button id="cloc" onclick="cercanos()">Buscar lugares cercanos</button>
        </div>

        <div id="map" class="map"></div>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfOd4UISFajb7rJjrqFzETG0fOZATDXKk&callback=initMap&v=weekly"
                defer >
        </script>
    </body>
</html>