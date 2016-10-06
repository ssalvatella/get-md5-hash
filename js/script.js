// Cuando se clica en el botón "Generate Hash" se ejecuta
// la función devuelve_md5() y se añade el resultado al 
// panel para mostrarlo.
$(document).ready(function() {
    $('#button').click(function() {
      document.getElementById("result").innerHTML = devuelve_md5(document.getElementById("textID").value);
    });
});

// Activa el botón cuando el usuario pulsa ENTER 
// escribiendo el texto a cifrar.
$(document).ready(function(){
    $('#textFormID').keypress(function(e){

      if(e.keyCode==13) {
    	$('#button').click();
        e.preventDefault(); 
      } 

    });
});