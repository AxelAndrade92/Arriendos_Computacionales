<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.dataTable td.hidden {
	display: none;
}

.dataTable th.hidden {
	display: none;
}

.validoo[style]{
font-color:#F20505;
font-family: Arial, Helvetica, sans-serif;
display:inline-block;
text-align:center;
}


</style>

<title>Registro de Personas</title>
<script>

function traerUenes(numero){
	
	var data = {};
	var empresa = {};
	var SelectEmpresa = $('#SelectEmpresa');
	data['idEmpresa'] = SelectEmpresa.find(':selected').val();

	var SelectUen = $('#SelectUen');

	$
			.ajax({
				url : 'Json/UenJson', // url where to submit the request
				type : "POST", // type of action POST || GET
				dataType : 'json', // data type
				contentType : 'application/json',
				data : JSON.stringify(data),
				success : function(result) {
					SelectUen.empty();
					SelectUen
							.append('<option value=0 selected>--- Seleccione ---</option>');
					var option = '';
					for (var i = 0; i < result.uenes.length; i++) {
						option = '<option value="'+ result.uenes[i].id + '">'
								+ result.uenes[i].nombre
								+ '</option>';
						SelectUen
								.append(option);
						if(numero != 0){
							SelectUen.val(numero);
						}
					}
					SelectUen = $('#SelectUen');
					SelectEmpresa = $('#SelectEmpresa');
				},
				error : function(xhr, resp,
						text) {
					console
							.log(xhr, resp,
									text);
				}
			})
}
function comprobarUsuario(e){

	if(e.which == 13) {
	
		var data = {};
		var persona = {};
		persona['rutPer'] = document.Persona.Rut.value;
		
		data['personaBean'] = persona;//atributo de la clase PersonaAction
		
		$.ajax({
	    url: 'Json/PersonaPorRut', // url where to submit the request
	    type : "POST", // type of action POST || GET
	    dataType : 'json',//'json', // data type
	    contentType: 'application/json',
	    data : JSON.stringify(data), // post data || get data
	    success : function(result) {
		    
		    var SelectEmpresa = $('#SelectEmpresa');
			var SelectRol = $('#SelectRol');
			var valido = $('#valido'); 
			SelectEmpresa.val(result.personaBean.empresaPer);
			SelectRol.val(result.personaBean.rolPer);
			traerUenes(result.personaBean.uenPer);
			var SelectUen = $('#SelectUen');								
			$('#idPersona').val(result.personaBean.id);
			$('#Rut').val(result.personaBean.rutPer);
			$('#nombrePer').val(result.personaBean.nombre);
			$('#apellPat').val(result.personaBean.apellidoP);
			$('#apellMat').val(result.personaBean.apellidoM);
			$('#nomCorto').val(result.personaBean.nombreCortoPer);
			$('#fonoPer').val(result.personaBean.fonoPer);
			$('#correoPer').val(result.personaBean.correoPer);

			$('#botonInsertar').hide();
			$('#botonActualizar').show();
			valido.empty();	
	    },
	    error: function(xhr, resp, text) {
	        console.log(xhr, resp, text);
	    }
	})  
	}
};


	$(document)
			.ready(
					function() {

						$('#botonActualizar').hide();
						
						var SelectEmpresa = $('#SelectEmpresa');
						var SelectUen = $('#SelectUen');
						var SelectRol = $('#SelectRol'); 

						$("#Rut").keypress(function(e){

							comprobarUsuario(e);
						
						});

						//cargando select con roles de usuario
						$
								.ajax({
									url : 'Json/RolesJson', // url where to submit the request
									type : "POST", // type of action POST || GET
									success : function(result) {
										var option = '';
										console.log(result.roles.length);//roles es la lista de la clase RolesAction
										for (var i = 0; i < result.roles.length; i++) {
											option = '<option value="'+ result.roles[i].idRol + '">'
													+ result.roles[i].nombreRol
													+ '</option>';
											SelectRol.append(option);
										}
										SelectRegion = $('#SelectRegion');
										SelectComuna = $('#SelectComuna');
										SelectUen = $('#SelectUen');
										SelectEmpresa = $('#SelectEmpresa');
										SelectRol = $('#SelectRol');
									},
									error : function(xhr, resp, text) {
										console.log(xhr, resp, text);
									}
								})

						//cargando el select con Empresas
						$
								.ajax({
									url : 'Json/EmpresaJson', // url where to submit the request
									type : "POST", // type of action POST || GET
									success : function(result) {
										var option = '';
										console.log(result.empresas.length);
										for (var i = 0; i < result.empresas.length; i++) {
											option = '<option value="'+ result.empresas[i].id + '">'
													+ result.empresas[i].nombre
													+ '</option>';
											SelectEmpresa.append(option);
										}
										SelectRegion = $('#SelectRegion');
										SelectComuna = $('#SelectComuna');
										SelectUen = $('#SelectUen');
										SelectEmpresa = $('#SelectEmpresa');
									},
									error : function(xhr, resp, text) {
										console.log(xhr, resp, text);
									}
								})

						SelectEmpresa
								.change(function() {
									/* var SelectUen = $("#SelectUen"); */
									traerUenes(0);
								});
						$('a.distribuir').click(
								function() {

									var rutPersona = $(this).parents("tr")
											.find("td").eq(0).html();
									var NombrePersona = $(this).parents("tr")
											.find("td").eq(1).html();
									var FonoPersona = $(this).parents("tr")
											.find("td").eq(2).html();
									var CorreoPersona = $(this).parents("tr")
											.find("td").eq(3).html();
									var ApellidoP = $(this).parents("tr").find(
											"td").eq(4).html();
									var ApellidoM = $(this).parents("tr").find(
											"td").eq(5).html();
									var nombreCPersona = $(this).parents("tr")
											.find("td").eq(6).html();
									var EmpresaPersona = $(this).parents("tr")
											.find("td").eq(7).html();
									var SbuPersona = $(this).parents("tr")
											.find("td").eq(8).html();
									var RolPersona = $(this).parents("tr")
											.find("td").eq(9).html();

									$("#Rut").val(rutPersona);
									$("#nombrePer").val(NombrePersona);
									$("#fonoPer").val(FonoPersona);
									$("#correoPer").val(CorreoPersona);
									$("#apellPat").val(ApellidoP);
									$("#apellMat").val(ApellidoM);
									$("#nomCorto").val(nombreCPersona);
									$("#SelectEmpresa").val(EmpresaPersona);
									$("#SelectUen").val(SbuPersona);
									$("#SelectRol").val(RolPersona);

									$("#levantarModalUpdate").click();

								});

						$('#tabla').DataTable();



					});//fin document

	function insertar() {

		if (validar()) {
			jConfirm(
					'Seguro que desea continuar?',
					'Confirmación',
					function(r) {
						if (r) {
							var data = {};
							var persona = {};
							//atributos de la clase PersonaBean
							persona['nombre'] = document.Persona.nombrePer.value;
							persona['apellidoP'] = document.Persona.apellPat.value;
							persona['apellidoM'] = document.Persona.apellMat.value;
							persona['empresaPer'] = $(SelectEmpresa).find(
									':selected').val();
							persona['uenPer'] = $(SelectUen).find(':selected')
									.val();
							persona['rutPer'] = document.Persona.Rut.value;
							persona['correoPer'] = document.Persona.correoPer.value;
							persona['fonoPer'] = document.Persona.fonoPer.value;
							persona['nombreCortoPer'] = document.Persona.nomCorto.value;
							persona['rolPer'] = $(SelectRol).find(':selected')
									.val();
							data['personaBean'] = persona;//atributo de la clase PersonaAction

							$.ajax({
								url : 'insercion_persona', // url where to submit the request //Struts 
								type : "POST", // type of action POST || GET
								dataType : 'html', // data type
								contentType : 'application/json',
								data : JSON.stringify(data), // post data || get data
								success : function(result) {
									alert(result);
									var SelectEmpresa = $('#SelectEmpresa');
									var SelectRol = $('#SelectRol');
									var SelectUen = $('#SelectUen');
									var valido = $('#valido');
									$(SelectEmpresa).prop('selectedIndex',0);
									$(SelectRol).prop('selectedIndex',0);
									$(SelectUen).prop('selectedIndex',0);								
									$('#Rut').val('');
									$('#nombrePer').val('');
									$('#apellPat').val('');
									$('#apellMat').val('');
									$('#nomCorto').val('');
									$('#fonoPer').val('');
									$('#correoPer').val('');
									valido.empty();			
									
								},
								error : function(xhr, resp, text) {
									console.log(xhr, resp, text);
								}
							})
						}
					});
		}

	}

	function actualizar() {

		if (validar()) {
			jConfirm(
					'¿Seguro que desea continuar?',
					'Confirmación',
					function(r) {
						if (r) {
							var data = {};
							var persona = {};
							//atributos de la clase PersonaBean
							persona['id'] = $('#idPersona').val();
							persona['nombre'] = document.Persona.nombrePer.value;
							persona['apellidoP'] = document.Persona.apellPat.value;
							persona['apellidoM'] = document.Persona.apellMat.value;
							persona['empresaPer'] = $(SelectEmpresa).find(
									':selected').val();
							persona['uenPer'] = $(SelectUen).find(':selected')
									.val();
							persona['rutPer'] = document.Persona.Rut.value;
							persona['correoPer'] = document.Persona.correoPer.value;
							persona['fonoPer'] = document.Persona.fonoPer.value;
							persona['nombreCortoPer'] = document.Persona.nomCorto.value;
							persona['rolPer'] = $(SelectRol).find(':selected')
									.val();
							data['personaBean'] = persona;//atributo de la clase PersonaAction

							$.ajax({
								url : 'update_persona', // url where to submit the request //Struts 
								type : "POST", // type of action POST || GET
								dataType : 'html', // data type
								contentType : 'application/json',
								data : JSON.stringify(data), // post data || get data
								success : function(result) {
									alert(result);
									var SelectEmpresa = $('#SelectEmpresa');
									var SelectRol = $('#SelectRol');
									var SelectUen = $('#SelectUen');
									var valido = $('#valido');
									$(SelectEmpresa).prop('selectedIndex',0);
									$(SelectRol).prop('selectedIndex',0);
									$(SelectUen).prop('selectedIndex',0);								
									$('#Rut').val('');
									$('#nombrePer').val('');
									$('#apellPat').val('');
									$('#apellMat').val('');
									$('#nomCorto').val('');
									$('#fonoPer').val('');
									$('#correoPer').val('');
									valido.empty();		
									$('#botonActualizar').hide();
									$('#botonInsertar').show();	
									
								},
								error : function(xhr, resp, text) {
									console.log(xhr, resp, text);
								}
							})
						}
					});
		}

	}

	
	function soloLetras(e) {
		key = e.keyCode || e.which;
		tecla = String.fromCharCode(key).toString();
		letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ";//Se define todo el abecedario que se quiere que se muestre.
		especiales = [ 8, 37, 39, 46, 6 ]; //Es la validación del KeyCodes, que teclas recibe el campo de texto.

		tecla_especial = false
		for ( var i in especiales) {
			if (key == especiales[i]) {
				tecla_especial = true;
				break;
			}
		}
		if (letras.indexOf(tecla) == -1 && !tecla_especial) {

			return false;
		}
	}

	function validar() {

		var mensaje = "";
		var verificar = 0;
		var control = true;

		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;

		if (document.Persona.Rut.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Rut de Persona <br> ";
			control = false;
		}

		
		if (document.Persona.nombrePer.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombres <br> ";
			control = false;
		}

		if (document.Persona.apellPat.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Apellido Paterno <br> ";
			control = false;
		}

		if (document.Persona.apellMat.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Apellido Materno <br> ";
			control = false;
		}

		if (document.Persona.nomCorto.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre Abreviado <br> ";
			control = false;
		}

		if (document.Persona.fonoPer.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono <br> ";
			control = false;
		}
		
		if (document.Persona.fonoPer.value.length <9) {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Largo de Fono <br> ";
			control = false;
		}

		if (document.Persona.correoPer.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Correo <br> ";
			control = false;
		}

		if ($(SelectEmpresa).find(':selected').text() == "--- Seleccione ---") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresa  <br> ";
			control = false;
		}

		if ($(SelectUen).find(':selected').text() == "--- Seleccione ---") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Sbu  <br> ";
			control = false;
		}

		if ($(SelectRol).find(':selected').text() == "--- Seleccione ---") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Rol  <br> ";
			control = false;
		}
		
		var rut = $('#valido').text();
		
		if (rut == "Rut ingresado Incorrecto") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Rut valido  <br> ";
			control = false;
		}
		
		
		
		

		if (control) {

			return control;
		} else {

			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}
	}
	
	function tab(e){
	var rut =  $('Rut').val();

	if (e.keycode == 9) {
		alert("apretaste el tab");
	} 



		}
	
	
	function valida_Rut( )
	 {
		var sRut1 = document.getElementById("Rut").value;
		sRut1=sRut1.replace('-', '');// se elimina el guion
		sRut1=sRut1.replace('.', '');// se elimina el primer punto
		sRut1=sRut1.replace('.', '');// se elimina el segundo punto
		sRut1 = sRut1.replace(/k$/,"K");
		document.getElementById("Rut").value=sRut1;
		//contador de para saber cuando insertar el . o la -
		var nPos = 0;
		//Guarda el rut invertido con los puntos y el guion agregado
		var sInvertido = "";
		//Guarda el resultado final del rut como debe ser
		var sRut = "";
		for(var i = sRut1.length - 1; i >= 0; i-- )
		{
		sInvertido += sRut1.charAt(i);
		if (i == sRut1.length - 1 )
		sInvertido += "-";
		else if (nPos == 3)
		{
		sInvertido += ".";
		nPos = 0;
		}
		nPos++;       
		}
		for(var j = sInvertido.length - 1; j >= 0; j-- )
		{
		if (sInvertido.charAt(sInvertido.length - 1) != ".")
		sRut += sInvertido.charAt(j);
		else if (j != sInvertido.length - 1 )
		sRut += sInvertido.charAt(j);
		}
		//Pasamos al campo el valor formateado
		document.getElementById("Rut").value = sRut.toUpperCase();	 	
	 }

	function VldRut( Objeto )
	 {
	 	var tmpstr = "";
	 	var intlargo = Objeto.value
	 	if (intlargo.length> 0)
	 	{
	 		crut = Objeto.value
	 		largo = crut.length;
	 		if ( largo <8 )
	 		{
	 			/* alert('rut inválido'); */
	 				$('#parrafo').slideDown("slow");
	 				$('#valido').text('Rut ingresado Incorrecto');
		 			$('#valido').css('color','red');
		 			
	 			Objeto.focus()
	 			return false;
	 		}
	 		for ( i=0; i <crut.length ; i++ )
	 		if ( crut.charAt(i) != ' ' && crut.charAt(i) != '.' && crut.charAt(i) != '-' )
	 		{
	 			tmpstr = tmpstr + crut.charAt(i);
	 		}
	 		rut = tmpstr;
	 		crut=tmpstr;
	 		largo = crut.length;
	  
	 		if ( largo> 2 )
	 			rut = crut.substring(0, largo - 1);
	 		else
	 			rut = crut.charAt(0);
	  
	 		dv = crut.charAt(largo-1);
	  
	 		if ( rut == null || dv == null )
	 		return 0;
	  
	 		var dvr = '0';
	 		suma = 0;
	 		mul  = 2;
	  
	 		for (i= rut.length-1 ; i>= 0; i--)
	 		{
	 			suma = suma + rut.charAt(i) * mul;
	 			if (mul == 7)
	 				mul = 2;
	 			else
	 				mul++;
	 		}
	  
	 		res = suma % 11;
	 		if (res==1)
	 			dvr = 'k';
	 		else if (res==0)
	 			dvr = '0';
	 		else
	 		{
	 			dvi = 11-res;
	 			dvr = dvi + "";
	 		}
	  
	 		if ( dvr != dv.toLowerCase() )
	 		{
	 			/* alert('El Rut Ingreso es Invalido'); */
	 			
	 			    $('#parrafo').slideDown("slow");
	 				$('#valido').text('Rut ingresado Incorrecto');
		 			$('#valido').css('color','red');
		 			
	 			Objeto.focus()
	 			return false;
	 		}
	 		/* alert('El Rut Ingresado es Correcto!');	 	 */
	 		    $('#parrafo').slideDown("slow");
	 			$('#valido').text('Rut Ingresado es Correcto');	
		 	    $('#valido').css('color','green');
		 			
	 		Objeto.focus()
	 		return true;
	 		
	 	}
	 }

	

	
	function valida(e) {
		tecla = (document.all) ? e.keyCode : e.which;

		//Tecla de retroceso para borrar, siempre la permite
		if (tecla == 8) {
			return true;
		}

		// Patron de entrada, en este caso solo acepta numeros
		patron = /[0-9]/;
		tecla_final = String.fromCharCode(tecla);
		return patron.test(tecla_final);
	}
	function validateMail(email) {
		//Creamos un objeto 
		object = document.getElementById('correoPer');
		valueForm = object.value;

		// Patron para el correo
		var patron = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
		if (valueForm.search(patron) == 0) {
			//Mail correcto
			object.style.color = "#000";
			return;
		}
		//Mail incorrecto
		object.style.color = "#f00";
	}

	function buscar() {
		console.log("Ingresa a Funcion Buscar");
		
		cargaPersona();
	}

	function cargaPersona(){

		var miTabla = $('#miTabla').DataTable();
		miTabla.clear().draw();
		
		var data = {};
		var persona = {};
		persona['rutPer'] = document.Persona.Rut.value;
		data['personaBean'] = persona;

		$.ajax({
			url : 'Json/buscar_persona', // url where to submit the request
			type : "POST", // type of action POST || GET
			dataType : 'json', // data type
			contentType : 'application/json',
			data : JSON.stringify(data),
			success : function(result) {
				if (result.BusquedaPersonaBean.length != 0) {
					for (var i = 0; i < result.BusquedaPersonaBean.length; i++) {
						miTabla.row
								.add(
										[
										result.BusquedaPersonaBean[i].rutPer,
										result.BusquedaPersonaBean[i].nombre,
										result.BusquedaPersonaBean[i].apellidoP,
										result.BusquedaPersonaBean[i].apellidoM,
										result.BusquedaPersonaBean[i].fonoPer,
										result.BusquedaPersonaBean[i].correoPer,
										result.BusquedaPersonaBean[i].rolPer,
										'<center><a onclick="funcionTabla();" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center> ' ])
						.draw(false);
						}
				} else {
					miTabla.clear().draw();
				}
				
			},
			error : function(xhr, resp, text) {
				
			}
		})

		}
</script>

</head>
<body background="recursos/image/fondo.jpg">

	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> Portal de
				Renovaciones

			</div>
		</div>

		<s:form action="insercion_persona" name="Persona" method="POST"
			autocomplete="off" class="form-inline">
			<input type="hidden" name="param" id="param" value="" />
			<input type="hidden" name="mensaje" id="mensaje"
				value="<s:property value="%{mensaje}" />" />
			<div class="panel panel-success">
				<div class="panel-heading" align="center">Mantenedor de
					Persona</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#" title="Aqui debes ingresar el Rol Unico Tributario">
									<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								</a> <label for="Rut">RUT:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="Rut"  placeholder="Ej: 12.333.444-5" oninput="valida_Rut();VldRut(this);comprobarUsuario(this);"
									name="Rut" value="${Rut}" 
									maxlength="12" />
									<input type="hidden" name="mensaje" id="idPersona" value="" />
									<div name="parrafo" id = "valido"></div>
									
							</div>
						</div>


						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar los Nombres de la Persona "><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="nombrePer">Nombres:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="nombrePer" onKeyDown="tab(this,event)"
									name="nombrePer" value="${nombrePer}" maxlength="80" 
									onkeypress="return soloLetras(event)" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el Apellido Paterno de la Persona "><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="apellPat">Apellido Paterno:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="apellPat"
									name="apellPat" value="${apellPat}" maxlength="80"
									onkeypress="return soloLetras(event)" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el Apellido Materno de la Persona "><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="apellMat">Apellido Materno:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="apellMat"
									name="apellMat" value="${apellMat}" maxlength="80"
									onkeypress="return soloLetras(event)" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar un 'alias' para poder identificar mejor a la Persona (Ejemplo : AFigueroa)"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="nomCorto">Nombre Abreviado:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="nomCorto"
									name="nomCorto" value="${nomCorto}" maxlength="80"
									onkeypress="return soloLetras(event)" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#" title="Aqui debes ingresar el Fono de la Persona"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="fonoPer">Fono:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="fonoPer" placeholder="Prefijo+Numero Telefonico"
									onkeypress="return valida(event)" name="fonoPer"
									value="${fonoPer}" maxlength="10" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#" title="Aqui debes ingresar el Correo de la Persona"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="correoPer">Correo:&nbsp;</label>
							</div>

						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="email" class="form-control"
									id="correoPer" placeholder="Ej.: usuario@servidor.com"
									name="correoPer" value="${correoPer}" maxlength="50"
									onKeyUp="javascript:validateMail('email')" /> <span
									id="emailOK"></span>
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el rol de la persona a ingresar"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="SelectRol">Rol:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<select id="SelectRol" class="form-control">
									<option value="0" selected>--- Seleccione ---</option>
									<!--    <option value="0" selected>--- Seleccione ---</option>
								          <option value="1">UEN 1</option>
								          <option value="2">UEN 2</option>
								          <option value="3">UEN 3</option>-->
								</select>
							</div>
						</div>



						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar la Empresa en la cual la persona pertenece"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="SelectEmpresa">Empresa:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<select id="SelectEmpresa" class="form-control">
									<option value="0" selected>--- Seleccione ---</option>
									<!--    <option value="0" selected>--- Seleccione ---</option>
								          <option value="1">UEN 1</option>
								          <option value="2">UEN 2</option>
								          <option value="3">UEN 3</option>-->
								</select>
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar la unidad estratégica de negocio en la cual la persona pertenece"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="SelectUen">SBU:&nbsp;</label>
							</div>



						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<select id="SelectUen" class="form-control">
									<option value="0" selected>--- Seleccione ---</option>
									<!--    <option value="0" selected>--- Seleccione ---</option>
								          <option value="1">UEN 1</option>
								          <option value="2">UEN 2</option>
								          <option value="3">UEN 3</option>-->
								</select>
							</div>
						</div>



					</div>
					<br>




					<div class="row">
						<div class="col-sm-12 col.md-6" align="center">
							<input type="button" value="Ingresar Registro"
								onclick="insertar()" class="btn btn-success" id="botonInsertar">&nbsp;
						<div class="col-sm-12 col.md-6" align="center">
							<input type="button" value="Actualizar Registro"
								onclick="actualizar()" class="btn btn-success" id="botonActualizar">&nbsp;
							<!--  <input type="button" value="Buscar Persona"
									onclick="buscar()" class="btn btn-success">&nbsp; 
						</div> -->

						<!--		<div class="col-sm-12 col.md-12" display ="inline">
								
								
							</div>
						
							  -->
							 
					</div>






				</div>
			</div>
		</s:form>

		<!-- ****************************************************************************************** -->
		<%-- <c:if test="${ver==1}">  --%>
	<!-- 	<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">
               
					<table class="table table-hover table-bordered table-condensed" id="miTabla">
				<thead><tr><th>Rut</th><th>Nombres</th><th>A.P.</th><th>A.M.</th><th>Fono</th><th>Correo</th><th>Rol</th><th>Empresa</th><th>Sbu</th></tr></thead>
				<tbody>
				</tbody>
				
				</table>
				
			</div>
		</div>
		</div>
		</div>
 -->
		<%-- </c:if> --%>

	</div>

	<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>

	<button type="button" id="levantarModalInsert"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal2" style="display: none;"></button>


	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Falta
						por ingresar
					</h3>
				</div>
				<div class="modal-body">
					<h4>
						<label id="texto"></label>
					</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-lg"
						data-dismiss="modal">
						<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>


	<!--  Modal informacion -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Información
					</h3>
				</div>
				<div class="modal-body">
					<h4>
						<label id="texto2"></label>
					</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-lg"
						data-dismiss="modal">
						<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog modal-lg">

			<s:form action="Update_sbu" name="Update_sbu">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
				<div class="modal-content">
					<div class="modal-header modal-header-warning">

						<h3>
							<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Activo
						</h3>
					</div>
					<div class="modal-body">


						<div class="row">
							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">N°
									identificador:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-barcode"></span>
										</div>

										<input name="idsbuu" size="13" id="idsbuu" value=""
											class="form-control" readonly="readonly" />
									</div>

								</div>
							</div>
							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Nombre
									de Sbu :</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="nombreSbuu" maxlength="10" value=""
											id="nombreSbuu" size="10" class="form-control" readonly="readonly"/>



									</div>

								</div>
							</div>

							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Centro
									de Costo :</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="centroCostoUpdate" maxlength="20"
											value="" id="centroCostoUpdate" size="10"
											class="form-control" />



									</div>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta son las Empresas las cuales debes indicar a la cual se encuentra relacionada la SBU"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">Empresas:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<%-- <s:select headerKey="0" headerValue="Todas"
										name="Empresas" id="lstReporte" list="reporteEmpresa"
										listKey="id" listValue="nombre" value=""
										theme="simple" class="form-control" /> --%>
								</div>
							</div>


						</div>














					</div>



					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-lg"
							data-dismiss="modal" onclick="update()">
							<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
						</button>
						&nbsp;
						<button type="button" class="btn btn-default btn-lg"
							onclick="limpiarUpdate()">
							<span class="glyphicon glyphicon-erase"></span>&nbsp;Limpiar
						</button>
						&nbsp;
						<button type="button" class="btn btn-default btn-lg"
							data-dismiss="modal">
							<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
						</button>
					</div>
				</div>
			</s:form>

		</div>
		<!-- /.modal-content -->
	</div>


	<button type="button" id="levantarModalUpdate"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModalUpdate" style="display: none;"></button>
		
		<script type="text/javascript">
		function funcionTabla() {
			$("#levantarModalUpdate").click(); // The function returns the product of p1 and p2
		}
	</script>
</body>
</html>