function get_location() {
  navigator.geolocation.getCurrentPosition(set_location);
}

function set_location(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  console.log([lat, lng])
  $.post("/location", {lat: lat, lng: lng}, function(){
    window.location = "/posts"
  })
}