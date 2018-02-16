<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
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

td, a {
	text-align: center;
}
</style>
<title>Ingreso Empresa</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
    
    
	$(document).ready(function() {
		
		
		var filaTabla;
		
		var miTabla = $('#miTabla').DataTable({
		    "columnDefs": [
		                   {"className": "dt-center", "targets": "_all"}
		                 ]
		             });
        
		$('#miTabla tbody').on('click', 'tr', function() {
			filaTabla = miTabla.row(this).data();
			console.log(filaTabla);
			$("#numero_empresaUP").val(filaTabla[0]);
			$("#nombre_empresaUP").val(filaTabla[1]);
			$("#rut_EmpresaUP").val(filaTabla[2]);
			$("#dir_EmpresaUP").val(filaTabla[3]);
			$("#rep_LegalUP").val(filaTabla[4]);
			$("#email_ContactoUP").val(filaTabla[5]);
			$("#fono_ContactoUP").val(filaTabla[6]);
		});
		/* $('#lstUEN').on('change', function() {

		  if(this.value == 'OTRO'){

			  document.getElementById('oculto').style.display = 'block';

				
			  }else{

				  document.getElementById('oculto').style.display = 'none';

				  $("#UENnew").empty();
					
				  }
		 
		});


		$('#lstModeloEquipo').on('change', function() {

		  if(this.value == 'ESPECIAL'){

			  document.getElementById('EspecialOculto').style.display = 'block';

				
			  }else{

				  document.getElementById('EspecialOculto').style.display = 'none';

				  $("#especialInsert").val("");	
					
				  }
		 
		});



		$('#lstModeloEquipoUpdate').on('change', function() {

		  if(this.value == 'ESPECIAL'){

			  document.getElementById('EspecialOcultoUpdate').style.display = 'block';

				
			  }else{

				  document.getElementById('EspecialOcultoUpdate').style.display = 'none';

				  $("#especialUpdate").val("");	
					
				  }
		 
		});


		$('#lstUENUpdate').on('change', function() {

		  if(this.value == 'OTRO'){

			  document.getElementById('oculto2').style.display = 'block';

				
			  }else{

				  document.getElementById('oculto2').style.display = 'none';

				  $("#UENupdate").val("");
					
				  }
		 
		}); */

		/* $('a.distribuir').click(function(){
			
		    var nomEmp = $(this).parents("tr").find("td").eq(0).html();  
		    var rutEmp = $(this).parents("tr").find("td").eq(1).html();
		    var dirEmp = $(this).parents("tr").find("td").eq(2).html();
		    var repEmp = $(this).parents("tr").find("td").eq(3).html();
		    var emailEmp = $(this).parents("tr").find("td").eq(4).html();
		    var fonoEmp = $(this).parents("tr").find("td").eq(5).html();  
		    
			$("#nombre_empresaUP").val(nomEmp);
			$("#rut_EmpresaUP").val(rutEmp);
			$("#dir_EmpresaUP").val(dirEmp);
			$("#rep_LegalUP").val(repEmp);
			$("#email_ContactoUP").val(emailEmp);
			$("#fono_ContactoUP").val(fonoEmp);
			
			
			 //console.log(idMa);

			if(modeloEquipo == ""){
				$("#lstModeloEquipoUpdate").val("0");
				}else{
					$("#lstModeloEquipoUpdate").val(modeloEquipo);
					}
			 
		    $("#levantarModalUpdate").click();
		 
		}); */

		/* $('#mitabla').DataTable();  */

	});

	/*  function aMays(e, elemento) {
	 tecla=(document.all) ? e.keyCode : e.which; 
	 elemento.value = elemento.value.toUpperCase();
	 }  */

	function insertar() {

		if (validar()) {
			jConfirm(
					'Seguro que desea continuar?',
					'Confirmación',
					function(r) {
						if (r) {

							//document.Empresa.param.value = "insert";
							//document.Empresa.submit();
							var data = {};
							var empresa = {};
							//empresaBean['id'] = 0; llamamos nuestra clase y ponemos entre los[] atributos. despues les pasamos nuestros valores del jsp
							empresa['nombre'] = document.Empresa.nombreEmpresa.value;
							empresa['rut'] = document.Empresa.rutEmp.value;
							empresa['direccion'] = document.Empresa.direcc_Emp.value;
							empresa['representanteLegal'] = document.Empresa.rep_Emp.value;
							empresa['email'] = document.Empresa.email_Emp.value;
							empresa['fono'] = document.Empresa.fono_Emp.value;
							data['empresaBean'] = empresa;

							$.ajax({
								url : 'Insercion_empresa', // url where to submit the request
								type : "POST", // type of action POST || GET
								dataType : 'html', // data type
								contentType : 'application/json',
								data : JSON.stringify(data), // post data || get data
								success : function(result) {
									alert(result);
									cargaEmpresa();

								},
								error : function(xhr, resp, text) {
									alert(result);
								}
							})

						}
					});
		}

	}
	function limpiarInsert() {
		document.Empresa.idMarca.value == "";
		document.Empresa.marcaActivo.value == "";
		document.Empresa.modeloMarcaActivo.value == "";

	}

	function buscar() {
		console.log("Ingresa a Funcion Buscar");
		
		cargaEmpresa();
		
	}

	function cargaEmpresa(){
		
		var miTabla = $('#miTabla').DataTable();
		miTabla.clear().draw();
		
		var data = {};
		var empresa = {};
		empresa['nombre'] = document.Empresa.nombreEmpresa.value;
		data['empresaBean'] = empresa;

		$.ajax({
					url : 'Json/busqueda_empresa', // url where to submit the request
					type : "POST", // type of action POST || GET
					dataType : 'json', // data type
					contentType : 'application/json',
					data : JSON.stringify(data),
					success : function(result) {
						if (result.empresas.length != 0) {
							for (var i = 0; i < result.empresas.length; i++) {
								miTabla.row
										.add(
												[
												result.empresas[i].id,
												result.empresas[i].nombre,
												result.empresas[i].rut,
												result.empresas[i].direccion,
												result.empresas[i].representanteLegal,
												result.empresas[i].email,
												result.empresas[i].fono,
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

	function validar() {

		var mensaje = "";
		var verificar = 0;
		var control = true;

		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;

		if (document.Empresa.nombreEmpresa.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de Empresa  <br> ";
			control = false;
		}

		if (document.Empresa.rutEmp.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> rut de Empresa  <br> ";
			control = false;
		}
	
		if (document.Empresa.direcc_Emp.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Direccion de Empresa  <br> ";
			control = false;
		}

		if (document.Empresa.rep_Emp.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Representante Legal  <br> ";
			control = false;
		}

		if (document.Empresa.email_Emp.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Email de Contacto  <br> ";
			control = false;
		}

		if (document.Empresa.fono_Emp.value.length <9) {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Largo de Fono <br> ";
			control = false;
		}

		if (document.Empresa.fono_Emp.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono de Contacto  <br> ";
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

	function validarUpdate() {

		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;

		if (document.Update_Empresa.rut_EmpresaUP.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> rut de Empresa  <br> ";
			control = false;
		}

		if (document.Update_Empresa.dir_EmpresaUP.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Direccion de Empresa  <br> ";
			control = false;
		}

		if (document.Update_Empresa.rep_LegalUP.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Representante Legal  <br> ";
			control = false;
		}

		if (document.Update_Empresa.email_ContactoUP.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Email de Contacto  <br> ";
			control = false;
		}

		if (document.Update_Empresa.fono_ContactoUP.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono de Contacto  <br> ";
			control = false;
		}
		
		if (document.Update_Empresa.fono_ContactoUP.value.length <9) {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Largo de Fono <br> ";
			control = false;
		}
		

		if (control) {

			return control;
		} else {

			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}

	}

	function update() {

		if (validarUpdate()) {
			jConfirm(
					'Seguro que desea continuar?',
					'Confirmación',
					function(r) {
						if (r) {

							//document.Update_marca.param.value = "update";
							//document.Update_marca.submit();                
							var data = {};
							var empresa = {};
							empresa['id'] = document.Update_Empresa.numero_empresaUP.value;
							empresa['nombre'] = document.Update_Empresa.nombre_empresaUP.value;
							empresa['rut'] = document.Update_Empresa.rut_EmpresaUP.value;
							empresa['direccion'] = document.Update_Empresa.dir_EmpresaUP.value;
							empresa['representanteLegal'] = document.Update_Empresa.rep_LegalUP.value;
							empresa['email'] = document.Update_Empresa.email_ContactoUP.value;
							empresa['fono'] = document.Update_Empresa.fono_ContactoUP.value;
							data['empresaBean'] = empresa;
							console.log(data);
							$.ajax({
								url : 'Update_Empresa', // url where to submit the request
								type : "POST", // type of action POST || GET
								dataType : 'html', // data type
								contentType : 'application/json',
								data : JSON.stringify(data), // post data || get data
								success : function(result) {
									alert(result);
									cargaEmpresa();
									// you can see the result from the console
									// tab of the developer tools
									//console.log(result);
								},
								error : function(xhr, resp, text) {
									//console.log(xhr, resp, text);
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

	function levantar() {

		if (document.Empresa.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		}

	}
	function miTabla() {
		$('a.distribuir').click(function() {

			var nomEmp = $(this).parents("tr").find("td").eq(0).html();
			var rutEmp = $(this).parents("tr").find("td").eq(1).html();
			var dirEmp = $(this).parents("tr").find("td").eq(2).html();
			var repEmp = $(this).parents("tr").find("td").eq(3).html();
			var emailEmp = $(this).parents("tr").find("td").eq(4).html();
			var fonoEmp = $(this).parents("tr").find("td").eq(5).html();

			$("#nombre_empresaUP").val(nomEmp);
			$("#rut_EmpresaUP").val(rutEmp);
			$("#dir_EmpresaUP").val(dirEmp);
			$("#rep_LegalUP").val(repEmp);
			$("#email_ContactoUP").val(emailEmp);
			$("#fono_ContactoUP").val(fonoEmp);

			
			//console.log(idMa);

			/*if(modeloEquipo == ""){
				$("#lstModeloEquipoUpdate").val("0");
				}else{
					$("#lstModeloEquipoUpdate").val(modeloEquipo);
					}
			 */
			$("#levantarModalUpdate").click();

		});
	}
	function valida(e){
	    tecla = (document.all) ? e.keyCode : e.which;

	    //Tecla de retroceso para borrar, siempre la permite
	    if (tecla==8){
	        return true;
	    }
	        
	    // Patron de entrada, en este caso solo acepta numeros
	    patron =/[0-9]/;
	    tecla_final = String.fromCharCode(tecla);
	    return patron.test(tecla_final);
	}
	/* function checkRut(rut) {
	    // Despejar Puntos
	    var valor = rut.value.replace('.','');
	    // Despejar Guión
	    valor = valor.replace('-','');
	    
	    // Aislar Cuerpo y Dígito Verificador
	    cuerpo = valor.slice(0,-1);
	    dv = valor.slice(-1).toUpperCase();
	    
	    // Formatear RUN
	    rut.value = cuerpo + '-'+ dv
	    
	    // Si no cumple con el mínimo ej. (n.nnn.nnn)
	    if(cuerpo.length < 7) { rut.setCustomValidity("RUT Incompleto"); return false;}
	    
	    // Calcular Dígito Verificador
	    suma = 0;
	    multiplo = 2;
	    
	    // Para cada dígito del Cuerpo
	    for(i=1;i<=cuerpo.length;i++) {
	    
	        // Obtener su Producto con el Múltiplo Correspondiente
	        index = multiplo * valor.charAt(cuerpo.length - i);
	        
	        // Sumar al Contador General
	        suma = suma + index;
	        
	        // Consolidar Múltiplo dentro del rango [2,7]
	        if(multiplo < 7) { multiplo = multiplo + 1; } else { multiplo = 2; }
	  
	    }
	    
	    // Calcular Dígito Verificador en base al Módulo 11
	    dvEsperado = 11 - (suma % 11);
	    
	    // Casos Especiales (0 y K)
	    dv = (dv == 'K')?10:dv;
	    dv = (dv == 0)?11:dv;
	    
	    // Validar que el Cuerpo coincide con su Dígito Verificador
	    if(dvEsperado != dv) { rut.setCustomValidity("RUT Inválido"); return false; }
	    
	    // Si todo sale bien, eliminar errores (decretar que es válido)
	    rut.setCustomValidity('');
	}
 */
 function Valida_Rut(Objeto)
 {
 	var tmpstr = "";
 	var intlargo = Objeto.value
 	if (intlargo.length> 0)
 	{
 		crut = Objeto.value
 		largo = crut.length;
 		if ( largo <2 )
 		{
 			/* alert('rut inválido') */
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
 			/* alert('El Rut Ingreso es Invalido') */
 			$('#parrafo').slideDown("slow");
	 				$('#valido').text('Rut ingresado Incorrecto');
		 			$('#valido').css('color','red');
 			Objeto.focus()
 			return false;
 		}
 		/* alert('El Rut Ingresado es Correcto!') */
 		$('#parrafo').slideDown("slow");
	 			$('#valido').text('Rut Ingresado es Correcto');	
		 	    $('#valido').css('color','green');
 		Objeto.focus()
 		return true;
 	}
 }
	function validateMail(email)
	{
		//Creamos un objeto 
		object=document.getElementById('email');
		valueForm=object.value;
	 
		// Patron para el correo
		var patron=/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
		if(valueForm.search(patron)==0)
		{
			//Mail correcto
			object.style.color="#000";
			return;
		}
		//Mail incorrecto
		object.style.color="#f00";
	}
</script>
</head>
<body onload="levantar()" background="recursos/image/fondo2.jpg">

	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> <h1 style="background-color: #fc8d00">Portal de Renovaciones</h1>

			</div>
		</div>

		<s:form action="Insercion_empresa" name="Empresa" method="POST"
			autocomplete="off" class="form-inline">
			<input type="hidden" name="param" id="param" value="" />
			<input type="hidden" name="mensaje" id="mensaje"
				value="<s:property value="%{mensaje}" />" />
			<div class="panel panel-success">
				<div class="panel-heading" style="background-color: #fc8d00" align="center">Mantenedor de
					Empresas</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#" title="Aqui debes ingresar Nombre de la Empresa">
									<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
								</a> <label for="nombreEmpresa">Nombre de Empresa:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputName2"
									name="nombreEmpresa" value="${nombreEmpresa}" maxlength="80" />
							</div>
						</div>


						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#" title="Aqui debes ingresar el rut de la Empresa"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="rutEmp">Rut de Empresa:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputName2" oninput="Valida_Rut(this)" placeholder="Ej: 12.333.444-5"
									name="rutEmp" value="${rutEmp}" maxlength="13" />
									<div id="valido"></div>
							</div>
						</div>


						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar la Direccion de la Empresa"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="direcc_Emp">Direccion de la Empresa:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputName2"
									name="direcc_Emp" value="${direcc_Emp}" maxlength="100" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el nombre del Representante legal de la Empresa"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="rep_Emp">Representante Legal:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputName2"
									name="rep_Emp" value="${rep_Emp}" maxlength="100" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el Email de Contacto de la Empresa"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="email_Emp">Email Contacto:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="email" id="email" class="form-control" id="exampleInputName2" placeholder="Ej.: usuario@servidor.com" onKeyUp="javascript:validateMail('email')"
									name="email_Emp" value="${email_Emp}" maxlength="50" />
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<a href="#"
									title="Aqui debes ingresar el Fono Contacto de la Empresa"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="fono_Emp">Fono Contacto:&nbsp;</label>
							</div>
						</div>

						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input type="text" class="form-control" id="exampleInputName2" onkeypress="return valida(event)" placeholder="Prefijo+Numero Telefonico"
									name="fono_Emp" value="${fono_Emp}" maxlength="10" />
							</div>
						</div>





					</div>
					<br>




					<div class="row">
						<div class="col-sm-12 col.md-6" align="center">
							<input type="button" value="Ingresar Registro" style="background-color: #fc8d00"
								onclick="insertar();" class="btn btn-success">&nbsp; <input
								type="button" value="Buscar Empresa" onclick="buscar();" style="background-color: #fc8d00"
								class="btn btn-success">&nbsp;
						</div>

						<!--		<div class="col-sm-12 col.md-12" display ="inline">
								
								
							</div>
						
						
						 <div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Limpiar"
									onclick="limpiarInsert()" class="btn btn-success">&nbsp;
							</div>
							 
							  -->
					</div>






				</div>
			</div>
		</s:form>

		<!-- ****************************************************************************************** -->
		<%-- <c:if test="${ver==1}">  --%>
		<div class="panel panel-success">

			<div class="panel-body" style="margin: 6px;">
				<div class="row">

					<div class="table-responsive">
						<table id="miTabla"
							class="table table-hover table-bordered table-condensed">
							<thead>
								<tr>
									<th>Nº ID</th>
									<th>Nombre Empresa</th>
									<th>Rut Empresa</th>
									<th>Direccion</th>
									<th>R. Legal</th>
									<th>Email</th>
									<th>Fono</th>
									<th>Actualizar</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<%-- <display:table class="table table-hover table-bordered table-condensed" id="tabla" name="empresas" list="reporte"
					export="false" requestURI="">
					
					
					<display:column property="id" title="Numero identificador" style="text-align:center;" />
					
					<display:column property="nombre" title="Nombre de Empresa" style="text-align:center;" />
					
					<display:column property="rut" title="rut de Empresa" style="text-align:center;" />
					
					<display:column property="direccion" title="Direccion Empresa" style="text-align:center;" />
					
					<display:column property="representanteLegal" title="R.L." style="text-align:center;" />
					
					<display:column property="email" title="Email Contacto" style="text-align:center;" />
					
					<display:column property="fono" title="Fono Contacto" style="text-align:center;" />
					
					<display:column title="Actualizar" media="html">
							<center>

								<a href="javascript:void(0)" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a>

							</center>
						</display:column>
						
					<display:setProperty name="export.csv" value="false"></display:setProperty>
					<display:setProperty name="export.pdf" value="false"></display:setProperty>
					<display:setProperty name="export.excel.filename" value="Listado_Activos.xls" />
					<display:setProperty name="export.xml" value="false" />
					<display:setProperty name="export.pdf.filename" value="false" />
						
						
				</display:table> --%>

					</div>
				</div>
			</div>
		</div>
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

			<s:form action="Update_Empresa" name="Update_Empresa">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
				<div class="modal-content">
					<div class="modal-header modal-header-warning">

						<h3>
							<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Empresa
						</h3>
					</div>
					<div class="modal-body">


						<div class="row">
							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Numero
									Identificador:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-barcode"></span>
										</div>

										<input name="numero_empresaUP" size="13" id="numero_empresaUP"
											value="" class="form-control" readonly="readonly" />
									</div>

								</div>
							</div>
							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Nombre
									de Empresa:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group">
										<div class="input-group-addon">
											<span class="glyphicon glyphicon-barcode"></span>
										</div>

										<input name="nombre_empresaUP" size="13" id="nombre_empresaUP"
											value="" class="form-control" readonly="readonly" />
									</div>

								</div>
							</div>

							 <div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Rut
									de Empresa :</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="rut_EmpresaUP" maxlength="15"
											value="" id="rut_EmpresaUP" size="10" class="form-control" readonly="readonly" />



									</div>

								</div>
							</div> 

							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Direccion
									Empresa:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="dir_EmpresaUP" maxlength="100"
											value="" id="dir_EmpresaUP" size="10" class="form-control" />

									</div>
								</div>
							</div>

							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Representante
									Legal:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="rep_LegalUP" maxlength="100" value=""
											id="rep_LegalUP" size="10" class="form-control" />

									</div>
								</div>
							</div>

							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Email
									Contacto:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="email_ContactoUP" maxlength="50"
											value="" id="email_ContactoUP" size="10" class="form-control" />

									</div>
								</div>
							</div>

							<div class="form-group col-sm-6 col-md-6">
								<label class="col-sm-4 control-label" style="text-align: right;">Fono
									Contacto:</label>
								<div class="col-sm-8 col-md-8">
									<div class="input-group input-append date">
										<div class="input-group-addon">
											<span class="glyphicons glyphicons-calendar"></span>
										</div>
										<input type="text" name="fono_ContactoUP" maxlength="10" onkeypress="return valida(event)"
											value="" id="fono_ContactoUP" size="10" class="form-control" />

									</div>
								</div>
							</div>


						</div>














					</div>



					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-lg" data-dismiss="modal"
							onclick="update()">
							<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
						</button>
						&nbsp;
						
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
