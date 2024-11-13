<%-- 
    Document   : pruebita
    Created on : May 20, 2022, 3:59:46 AM
    Author     : alina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Ubicacion  |  SecureMaps</title>
        <!-- <link rel="stylesheet" href="../Css/Ubicacion.css"> -->
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu&display=swap" rel="stylesheet">
        <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
        <link rel="shortcut icon" type="image/jpg" href="../Imagenes/favicon.ico"/>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfOd4UISFajb7rJjrqFzETG0fOZATDXKk&callback=initMap&v=weekly"
                defer >
        </script>
    </head>
    <body>
        <script>function initMap() {
            // Create the map.
            const pyrmont = { lat: -33.866, lng: 151.196 };
            const map = new google.maps.Map(document.getElementById("map"), {
              center: pyrmont,
              zoom: 17,
              mapId: "8d193001f940fde3",
            });
            // Create the places service.
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

          window.initMap = initMap;
          </script>
    </body>
</html>
