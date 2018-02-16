// FUNCIONES DE APOYO

function isNumero(valor) {
	if (/^([0-9])*$/.test(valor)) {
		return true;
	} else {
		return false;
	}
}

function isNumberKey(evt) {
	var charCode = ((evt.which) ? evt.which : evt.keyCode);
	if (charCode > 31 && (charCode < 48 || charCode > 57))
		return false;
	return true;
}



function soloLetras(e){
	alert(e);
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = "8-37-39-46";

    tecla_especial = false
    for(var i in especiales){
         if(key == especiales[i]){
             tecla_especial = true;
             break;
         }
     }

     if(letras.indexOf(tecla)==-1 && !tecla_especial){
         return false;
     }
 }

function isEmailValido(valor) {
	if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test(valor))
		return true;
	else
		return false;
}

function f5(that,val){
	if(val)
	{
	that.on('keydown',function(e){
	var code = (e.keyCode ? e.keyCode : e.which);
	if(code == 116 ) {e.preventDefault();}
	})
	}
	else
	{
	that.off('keydown');
	}

	}


function validatefechaMayorQue(fechaInicial,fechaFinal)

{

	var estado = false;
	
  var  valuesStart=fechaInicial.split("/");

   var valuesEnd=fechaFinal.split("/");



    // Verificamos que la fecha no sea posterior a la actual

    var dateStart=new Date(valuesStart[2],(valuesStart[1]-1),valuesStart[0]);

    var dateEnd=new Date(valuesEnd[2],(valuesEnd[1]-1),valuesEnd[0]);

    if(dateStart>dateEnd)

    {
    	estado = true;
        return estado;

    }else{
    	
    	return estado;
    	
    }

    

}
