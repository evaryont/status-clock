$(function(){
  if (typeof(CHECKIN_LAT_LONG) !== "undefined" && $('#checkin-map').length !== 0) {
    // CHECKIN_LAT_LONG is defined, assume that there is an element called
    // checkin-map and that we should display a map within it. Yay leaflet!
    window.console.log('Creating Leaflet map')
    var map = L.map('checkin-map').setView(CHECKIN_LAT_LONG, 17)
    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
        maxZoom: 18
    }).addTo(map);
    var marker = L.marker(CHECKIN_LAT_LONG).addTo(map);
  }
});
