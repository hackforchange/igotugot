function get_location() {
  navigator.geolocation.getCurrentPosition(set_location);
}

function set_location(position) {
  console.log([position])
   
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  $.post("/location", {lat: lat, lng: lng}, function(){
     if (window.location.pathname == '/') {
        window.location = "/posts" 
        
      } else {
         window.location = window.location
      }
     
  })
}
