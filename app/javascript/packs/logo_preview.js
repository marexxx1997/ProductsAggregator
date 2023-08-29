import axios from 'axios';

document.addEventListener("DOMContentLoaded", function() {
 
  var logoInput = document.getElementById("logo_url");
  var logoPicturePreview = document.getElementById("logoPicturePreview");
  var logoInput2 = document.getElementById("logo_url")
  if(logoInput && logoPicturePreview){
    logoInput.addEventListener("input", function() {
    var imageUrl = logoInput.value;
    var imageUrlPath = "/assets/" + imageUrl;
    axios.get(imageUrlPath , { responseType: 'blob' }).then(function(response){
      var imageUrlObject = URL.createObjectURL(response.data);
      logoPicturePreview.setAttribute("src", imageUrlObject);
    })
    .catch(function(error){
      logoPicturePreview.setAttribute("src", "/assets/image_not_found.png");
      console.log(logoInput2)
    });
  });
}
});
  