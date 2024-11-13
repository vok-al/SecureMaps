document.querySelector('.img-btn').addEventListener('click', function()
	{
		document.querySelector('.cont').classList.toggle('s-signup')
	}
);

function nombre(e) {
    var letras= "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
        var x= e.which || e.keyCode;
        var letra= String.fromCharCode(x);
        var n= letras.indexOf(letra);
        if(n=== -1)
            return false;
        else
            return true;
}

function username(e) {
    var nums = "abcdefghijklmnñopqrstuvwxyz0123456789-_.";
    var x = e.which || e.keyCode;
    var num = String.fromCharCode(x);
    var n = nums.indexOf(num);
    if(n === -1)
        return false;
    else
        return true;
}

function boleta(e) {
    var nums = "0123456789";
    var x = e.which || e.keyCode;
    var num = String.fromCharCode(x);
    var n = nums.indexOf(num);
    if(n === -1)
        return false;
    else
        return true;
}

function validaContra(){
    var contra = document.getElementById("contra1").value;
    var confirma = document.getElementById("contra2").value;
    var lon= contra.length;
    
    if(lon <6)
        alert("La contraseña debe contener mínimo 6 caracteres");
    else if(contra !== confirma) 
        alert("Las contraseñas no coinciden");
    else
        return true;
}

function validaVacio() {
    var nom = document.getElementById("user").value;
    var nom = document.getElementById("name").value;
    var bol = document.getElementById("correo2").value;
    var con1 = document.getElementById("contra1").value;
    var con2 = document.getElementById("contra2").value;
    if(nom === ""){
        alert("El cuadro de nombre de usuario está vacío");
        return false;
    }
    if(bol === ""){
        alert("El cuadro de nombre de usuario está vacío");
        return false;
    }
    if(nom===""){
        alert("El cuadro de nombre está vacío");
        return false;
    }
    if(con1===""){
        alert("El cuadro de contraseña está vacío");
        return false;
    }
    if(con2===""){
        alert("El cuadro de confirmación de contraseña está vacío");
        return false;
    }
    return true;
}

function valida(){
    // Ninguno vacìo
    if(!validaVacio())
        return false;

    // Contraseña coinicide
    if(!validaContra())
        return false;

    document.registro.submit();
}

function valVacCon(){
    var ant = document.getElementById("anterior").value;
    var con1 = document.getElementById("contra1").value;
    var con2 = document.getElementById("contra2").value;
    if(ant === ""){
        alert("El cuadro de contraseña actual está vacío");
        return false;
    }
    if(con1===""){
        alert("El cuadro de nueva contraseña");
        return false;
    }
    if(con2===""){
        alert("El cuadro de confirmación está vacío");
        return false;
    }
    return true;
}

function conCorrecta(contra){
    var ant = document.getElementById("anterior").value;
    if(ant=== contra)
        return true;
    else{
        return false;
        alert("La contraseña no es correcta");
    }
}

function valCambio(contra){
    //Ninguna contraseña vacía
    if(!valVacCon())
        return false;
    
    // Contraseña correcta
    if(!conCorrecta(contra))
        return false;
    
    // Contraseña coincide
    if(!validaContra())
        return false;
    
    alert("se ha realizado el cambio exitosamente");
    document.cambiaContra.submit();
}
