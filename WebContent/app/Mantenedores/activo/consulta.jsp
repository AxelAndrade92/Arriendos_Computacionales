<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">

.dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

}

</style>




<title>Mantenedor de Activo</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
	$(document).ready(function() {
		  $("#idRol").hide();


		  $('#lstUEN').on('change', function() {

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
			 
			});


			

		  
	      $('a.distribuir').click(function(){

	          var modeloEquipo = $(this).parents("tr").find("td").eq(0).html();  
              var serie = $(this).parents("tr").find("td").eq(1).html();
              var idUsuario = $(this).parents("tr").find("td").eq(2).html();  
              var nombre = $(this).parents("tr").find("td").eq(3).html();
              var cc = $(this).parents("tr").find("td").eq(4).html();  
              var UEN = $(this).parents("tr").find("td").eq(5).html();
              var fono = $(this).parents("tr").find("td").eq(6).html();
              var email = $(this).parents("tr").find("td").eq(7).html();
              var fecha = $(this).parents("tr").find("td").eq(8).html();
          
              var idRol = $(this).parents("tr").find("td").eq(11).html();
			  var fecha2 = fecha.split('/')
				//alert(fecha2[0]+"/"+fecha2[1]+"/"+fecha2[2]);
			
              $("#numParteUpdate").val(serie);
			  $("#nomUsuarioUpdate").val(nombre);
			  $("#fonoUpdate").val(fono);
			  $("#correoUpdate").val(email);
			  //$("#datepicker1").val(fecha2[0]+"/"+fecha2[1]+"/"+fecha2[2]);
			  $("#datepicker1").datepicker('setDate',new Date(fecha2[2]+"/"+fecha2[1]+"/"+fecha2[0]));
			  $("#lstUENUpdate").val(String(UEN));
			  
			  $("#lstRolUpdate").val(idRol);

			if(modeloEquipo == ""){
				$("#lstModeloEquipoUpdate").val("0");
				}else{
					$("#lstModeloEquipoUpdate").val(modeloEquipo);
					}
			 
			  $("#idUsuarioUpdate").val(idUsuario);	
			  $("#centroCosto").val(cc);
              
              $("#levantarModalUpdate").click();
           
          });

		$('#tabla').DataTable();
		$("#datepicker1").datepicker();
		$("#datepicker2").datepicker();
		
	});


	function verDetalle(idActivo) {

		document.unidadNegocio.numActivo.value = idActivo;
		document.unidadNegocio.param.value = "detalle";
		document.unidadNegocio.submit();
		return false;

	}

	function aMays(e, elemento) {
		tecla=(document.all) ? e.keyCode : e.which; 
		 elemento.value = elemento.value.toUpperCase();
		}


	function insertar(){

		if (validar()) {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {

				document.insertarActivo.param.value = "insert";
				document.insertarActivo.submit();
			}
		});
		}

		}


	function update(){

		if (validarUpdate()) {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {

				document.updateActivo.param.value = "update";
				document.updateActivo.submit();
			}
		});
		}

		}

	function crearExcel(unidad, activo, usuario, centro) {

		document.unidadNegocio.param.value = "excel";
		document.unidadNegocio.unidadNegocio.value = unidad;
		document.unidadNegocio.numActivo.value = activo;
		document.unidadNegocio.nomUsuario.value = usuario;
		document.unidadNegocio.centro.value = centro;
		document.unidadNegocio.submit();

	}

	function buscar() {

		
			document.frmActivo.param.value = "buscar";
			document.frmActivo.submit();
		
	}

	function nuevo() {

		document.frmActivo.param.value = "nuevo";
		document.frmActivo.submit();

	}

	function validar() {

		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;

		if (document.insertarActivo.numParteNew.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Número de serie computador  <br> ";
			control = false;
		}

		if (document.insertarActivo.nomUsuario.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de Usuario  <br> ";
			control = false;
		}


		if (document.insertarActivo.modeloEquipoInsert.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo Equipo  <br> ";
			control = false;
		}



		if (document.insertarActivo.modeloEquipoInsert.value == "ESPECIAL") {

			if (document.insertarActivo.especialInsert.value == "") {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> Debe especificar modelo especial a ingresar   <br> ";
				control = false;
			}
		}


		
		if (document.insertarActivo.nomUsuario.value != "") {

		
			var nombre = document.insertarActivo.nomUsuario.value;
			
			var largoNombre = nombre.length;
		
			if (largoNombre < 6) {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre debe tener un mínino de 6 caractéres <br> ";
				control = false;
			}
			
			
		}
		
	
		if (document.insertarActivo.idUsuarioInsert.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> ID de Usuario  <br> ";
			control = false;
		}
		
		if (document.insertarActivo.idUsuarioInsert.value != "") {
			var fono = document.insertarActivo.idUsuarioInsert.value;
			var largo = fono.length;
		
			if (largo < "2") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> ID Usuario debe tener un mínino de 2 caracteres <br> ";
				control = false;
			}
		}





		if (document.insertarActivo.centroCostoInsert.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Centro de Costo  <br> ";
			control = false;
		}
		
		if (document.insertarActivo.centroCostoInsert.value != "") {
			var fono = document.insertarActivo.centroCostoInsert.value;
			var largo = fono.length;
		
			if (largo < "2") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> Centro de Costo debe tener un mínino de 2 caracteres <br> ";
				control = false;
			}
		}
		



		
		if (document.insertarActivo.fechaTerminoNew.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fecha Término  <br> ";
			control = false;
		}

		if (document.insertarActivo.fono.value != "") {
			var fono = document.insertarActivo.fono.value;
			var largo = fono.length;
		
			if (largo < "9") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono debe tener un mínino de 9 dígitos <br> ";
				control = false;
			}
		}

		if (document.insertarActivo.unidadNegocioNew.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> UEN (Unidad de Negocio)  <br> ";
			control = false;
		}

		if (document.insertarActivo.nomRol.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Rol  <br> ";
			control = false;
		}


		if (document.insertarActivo.fechaTerminoNew.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fecha Término  <br> ";
			control = false;
		}
		
		if (document.insertarActivo.correo.value != "") {
			if (isEmailValido(document.insertarActivo.correo.value)) {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> La direcci&oacute;n de e-mail tiene un formato invalido. <br> ";
				control = false;
			}

		}

		if (document.insertarActivo.unidadNegocioNew.value == "OTRO") {

			if (document.insertarActivo.UENnew.value == "") {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> Nueva UEN (Unidad de Negocio)  <br> ";
				control = false;
			}
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

	

		if (document.updateActivo.nomUsuarioUpdate.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de Usuario  <br> ";
			control = false;
		}


		if (document.updateActivo.idUsuarioUpdate.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> ID de Usuario  <br> ";
			control = false;
		}
		
		if (document.updateActivo.idUsuarioUpdate.value != "") {
			var fono = document.updateActivo.idUsuarioUpdate.value;
			var largo = fono.length;
		
			if (largo < "2") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> ID Usuario debe tener un mínino de 2 caracteres <br> ";
				control = false;
			}
		}





		if (document.updateActivo.centroCosto.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Centro de Costo  <br> ";
			control = false;
		}
		
		if (document.updateActivo.centroCosto.value != "") {
			var fono = document.updateActivo.centroCosto.value;
			var largo = fono.length;
		
			if (largo < "2") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> Centro de Costo debe tener un mínino de 2 caracteres <br> ";
				control = false;
			}
		}



		if (document.updateActivo.modeloEquipoUpdate.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo Equipo  <br> ";
			control = false;
		}



		if (document.updateActivo.modeloEquipoUpdate.value == "ESPECIAL") {

			if (document.updateActivo.modeloEquipoUpdate.value == "") {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> Debe especificar modelo especial a ingresar   <br> ";
				control = false;
			}
		}
		
		
		if (document.updateActivo.fonoUpdate.value != "") {
			var fono = document.updateActivo.fonoUpdate.value;
			var largo = fono.length;
		
			if (largo < "9") {
	
				mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono debe tener un mínino de 9 dígitos <br> ";
				control = false;
			}
		}

		if (document.updateActivo.unidadNegocioUpdate.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> UEN (Unidad de Negocio)  <br> ";
			control = false;
		}

		if (document.updateActivo.nomRolUpdate.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Rol  <br> ";
			control = false;
		}


		
		if (document.updateActivo.correoUpdate.value != "") {
			if (isEmailValido(document.updateActivo.correoUpdate.value)) {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> La direcci&oacute;n de e-mail tiene un formato invalido. <br> ";
				control = false;
			}

		}




		if (document.updateActivo.unidadNegocioUpdate.value == "OTRO") {

			if (document.updateActivo.UENupdate.value == "") {

				mensaje += "<span class='glyphicon glyphicon-edit'></span> Nueva UEN (Unidad de Negocio)  <br> ";
				control = false;
			}
		}
		


		

		if (control) {

			return control;
		} else {

			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}

	}



	
	function levantar() {

		if (document.frmActivo.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		}
	}

	function subirArchivo() {

		if (validarArchivo()) {

			document.frmArchivo.param.value = "archivo";
			document.frmArchivo.submit();

		}

	}

	function validarArchivo() {

		var mensaje = "";
		var verificar = 0;
		var control = true;

		if (document.frmArchivo.fileUpload.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Debe adjuntar archivo  <br> ";
			control = false;
		}

		if (control) {

			return control;
		} else {

			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}

	}

	

	
	function soloLetras(e) {
	    key = e.keyCode || e.which;
	    tecla = String.fromCharCode(key).toString();
	    letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ";//Se define todo el abecedario que se quiere que se muestre.
	    especiales = [8, 37, 39, 46, 6]; //Es la validación del KeyCodes, que teclas recibe el campo de texto.

	    tecla_especial = false
	    for(var i in especiales) {
	        if(key == especiales[i]) {
	            tecla_especial = true;
	            break;
	        }
	    }

	    if(letras.indexOf(tecla) == -1 && !tecla_especial){
	
	        return false;
	      }
	}

	function limpiarInsert() {

		$("#numParteNew").val("");
		$("#lstUEN").val("0");
		$("#nomUsuario").val("");
		$("#fono").val("");
		$("#correo").val("");
		$("#lstRol").val("0");
		$("#datepicker2").val("");
	}

	function limpiarUpdate() {

		
		$("#lstUENUpdate").val("0");
		$("#nomUsuarioUpdate").val("");
		$("#fonoUpdate").val("");
		$("#correoUpdate").val("");
		$("#lstRolUpdate").val("0");
		$("#datepicker1").val("");
	}

	function subirArchivo(){

		document.uploadFile.submit();


		}

	function crearExcel() {
		document.excel.param.value = "excel";
		document.excel.submit();
	

	}


	
</script>
</head>
<body onload="levantar()" background="recursos/image/fondo.jpg">


	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> Portal de Renovaciones

			</div>
		</div>

		

		
			<s:form action="ccu-admin" name="frmActivo" method="POST"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Búsqueda de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="La serie del computador, se encuentra por lo general en la parte trasera del computador o bajo la batería del mismo. La sigla como figura esta información es: Serial, S/N o Serie">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numActivo">Número de serie
										computador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="numActivo" value="${numActivo}" maxlength="12"/> 
								</div>
							</div>



								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta es la Unidad de Negocios a la cual te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">UEN:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<s:select headerKey="0" headerValue="Todas"
										name="unidadNegocio" id="lstReporte" list="reporteUEN"
										listKey="unidadNegocio" listValue="unidadNegocio"
										theme="simple" class="form-control" />

								</div>
							</div>
						</div>
					

						

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Buscar Activo"
									onclick="buscar()" class="btn btn-success">&nbsp;
								
								
							
							</div>
						</div>
					</div>
				</div>
			</s:form>
		<button type="button" value="" data-toggle="modal"
								data-target="#myModalInsert" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Ingresar Activo
								</button>

							<br>
							<br>
		<c:if test="${ver==1}">
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">

				<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="reporte" list="reporte"
					export="false" requestURI="">
					
					<display:column property="modeloEquipo" title="Modelo Equipo" style="text-align:center;" />
					
					<display:column property="serieEquipo" title="N° de Serie" style="text-align:center;" />
					
					<display:column property="idUsuario" title="Usuario" style="text-align:center;" />
					
					<display:column property="usuarioEquipo" title="Nombre Usuario" style="text-align:center;" />
					
					<display:column property="centroCosto" title="CC" style="text-align:center;" />
									
					<display:column property="unidadNegocio" title="UEN" style="text-align:center;" />
					<display:column property="fonoUsuario" title="Fono" style="text-align:center;" />
					<display:column property="correoUsuario" title="Correo" style="text-align:center;" />
					<display:column property="fechaTermino" title="Fecha Término" style="text-align:center;" />
					<display:column property="nomRol" title="Rol" style="text-align:center;" />
					<display:column property="especial" title="Especial" style="text-align:center;" />
					<div style="display:none;">
					<display:column property="idRol" title=" id Rol" style="text-align:center;" class="hidden" headerClass="hidden" media="html"/>
					</div>
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

				</display:table>
				
					<form action="ccu-admin" name="excel" method="POST">
				<input type="hidden" name="numSerieExcel" id="numSerieExcel" value="<s:property value="%{numActivo}" />" />
				<input type="hidden" name="unidadNegocioExcel" id="unidadNegocioExcel" value="<s:property value="%{unidadNegocio}" />" />
				<input type="hidden" name="param" id="param" value="" />
					<button type="button" href="javascript:void(0)" onclick="crearExcel()" value=" Ingresar Reporte " class="btn btn-default btn-sm " style="outline: none;">
						<img alt="" src="recursos/image/excel.png" width="45"
									height="35">&nbsp; Exportar Excel
					</button>
				
				</form>
			

			</div>
		</div>
		</div>
		</div>
		</c:if>
	
		</div>
		
		
		
			
		
		
		
		
	
	<div class="modal fade" id="myModalInsert" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			data-backdrop="static">
			<div class="modal-dialog modal-lg">

				<s:form action="ccu-admin" name="insertarActivo">
					<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Ingresar Activo
							</h3>
						</div>
				<div class="modal-body">
						
						
									<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">N° de serie:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="numParteNew" size="13" id="numParteNew" value=""
												class="form-control"  onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Fecha Término:</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="fechaTerminoNew" maxlength="10"
													value="" id="datepicker2" size="10" class="form-control"
													 />



											</div>

										</div>
									</div>
							</div>
													
						
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Modelo Equipo:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
												<s:select headerKey="0" headerValue="Seleccione.." name="modeloEquipoInsert" id="lstModeloEquipo" list="lstModeloEquipo"
											listKey="modeloEquipo" listValue="modeloEquipo" theme="simple" value="" class="form-control" />
																				
												
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">UEN:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-italic"></span>
											</div>
											
												
												<s:select headerKey="0" headerValue="Seleccione.." name="unidadNegocioNew" id="lstUEN" list="reporteUEN"
											listKey="unidadNegocio" listValue="unidadNegocio" theme="simple" value="" class="form-control" />
										</div>
									</div>
								</div>
							</div>
							
							
									<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">ID usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="idUsuarioInsert" size="13" id="idUsuarioInsert" value=""
												class="form-control"  />
										</div>

									</div>
								</div>

								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Nombre usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="nomUsuario" size="13" id="nomUsuario" value=""
												class="form-control"  onkeypress="return soloLetras(event)" onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>
										</div>

									</div>
								</div>

							</div>
							
							
							
							
							
							
							
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Fono:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-usd"></span>
											</div>
										
												<input name="fono" size="13" id="fono" value=""
												class="form-control" onkeypress="return isNumberKey(event)" maxlength="9"/>
										</div>

									</div>
								</div>

									<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Correo:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
											<input name="correo" size="13" id="correo" value=""
												class="form-control"  />
										</div>
									</div>
								</div>

							</div>
									<div class="row">
								<div class="form-group  col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Rol:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
									
												
												<s:select headerKey="0" headerValue="Seleccione.." name="nomRol" id="lstRol" list="lstRol"
											listKey="idRol" listValue="nomRol" theme="simple" value="" class="form-control" />
										</div>
									</div>
								</div>
								<div class="form-group  col-sm-6 col-md-6">
									<label class="col-sm-4 control-label"
										style="text-align: right;">Centro de Costo:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-usd"></span></span>
											<input name="centroCostoInsert" size="13" id="centroCostoInsert" value=""	class="form-control"  onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>
										</div>
									</div>
								</div>
							</div>
					
							
							<div class="row">
							
									<div class="form-group col-sm-6 col-md-6" style="display: none;" id="EspecialOculto">
										<label class="col-sm-4 control-label"
											style="text-align: right;"></label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-pencil"></span>
												</div>
												<s:textarea theme="simple" name="especialInsert" value=""
													id="especialInsert" cols="50" rows="7" class="form-control" maxlength="140"/>



											</div>

										</div>
									</div>
							
											
							<div class="form-group col-sm-6 col-md-6" style="display: none;" id="oculto">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Nueva UEN:</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-lock"></span>
												</div>
												<input type="text" name="UEN" maxlength="10"
													id="UENnew" size="10" class="form-control"
													value="" onkeypress="return soloLetras(event)" onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>



											</div>

										</div>
									</div>
							
							
							</div>
							
							
							
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="insertar()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg"
								onclick="limpiarInsert()">
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
	









		<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			data-backdrop="static">
			<div class="modal-dialog modal-lg">

				<s:form action="ccu-admin" name="updateActivo">
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
									<label  class="col-sm-4 control-label"
										style="text-align: right;">N° de serie:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="numParteUpdate" size="13" id="numParteUpdate" value=""
												class="form-control"  readonly="readonly" />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Fecha Término:</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="fechaTerminoUpdate" maxlength="10"
													value="" id="datepicker1" size="10" class="form-control"/>



											</div>

										</div>
									</div>
							</div>
													
						
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Modelo Equipo:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<s:select headerKey="0" headerValue="Seleccione.." name="modeloEquipoUpdate" id="lstModeloEquipoUpdate" list="lstModeloEquipo"
											listKey="modeloEquipo" listValue="modeloEquipo" theme="simple" value="" class="form-control" />
													
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">UEN:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-italic"></span>
											</div>
											
												
												<s:select headerKey="0" headerValue="Seleccione.." name="unidadNegocioUpdate" id="lstUENUpdate" list="reporteUEN"
											listKey="unidadNegocio" listValue="unidadNegocio" theme="simple" value="%{unidadNegocio}" class="form-control" />
										
										</div>
									</div>
								</div>
							</div>
							
							
									<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">ID usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="idUsuarioUpdate" size="13" id="idUsuarioUpdate" value=""
												class="form-control"  />
										</div>

									</div>
								</div>

								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Nombre usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="nomUsuarioUpdate" size="13" id="nomUsuarioUpdate" value=""
												class="form-control"  onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>
										</div>

									</div>
								</div>

							</div>
							
							
							
							
							
							
							
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Fono:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-usd"></span>
											</div>
										
												<input name="fonoUpdate" size="13" id="fonoUpdate" value=""
												class="form-control" onkeypress="return isNumberKey(event)" />
										</div>

									</div>
								</div>

									<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Correo:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
											<input name="correoUpdate" size="13" id="correoUpdate" value=""	class="form-control"  />
										</div>
									</div>
								</div>

							</div>
									<div class="row">
								<div class="form-group  col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Rol:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
									
												
												<s:select headerKey="0" headerValue="Selecccione.." name="nomRolUpdate" id="lstRolUpdate" list="lstRol"
											listKey="idRol" listValue="nomRol" theme="simple" value="" class="form-control" />
										</div>
									</div>
								</div>
								<div class="form-group  col-sm-6 col-md-6">
									<label class="col-sm-4 control-label"
										style="text-align: right;">Centro de Costo:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicon glyphicon-usd"></span></span>
											<input name="centroCosto" size="13" id="centroCosto" value=""	class="form-control"  onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>
										</div>
									</div>
								</div>
							</div>
							</div>
							<div class="row">
							
											<div class="form-group col-sm-6 col-md-6" style="display: none;" id="EspecialOcultoUpdate">
										<label class="col-sm-4 control-label"
											style="text-align: right;"></label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-pencil"></span>
												</div>
												<s:textarea theme="simple" name="especialUpdate" value=""
													id="especialUpdate" cols="50" rows="7" class="form-control" maxlength="140"/>



											</div>

										</div>
									</div>
									
											<div class="form-group col-sm-6 col-md-6" style="display: none;" id="oculto2">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Nueva UEN:</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-lock"></span>
												</div>
												<input type="text" name="UENupdate" maxlength="10"
													 id="UENupdate" size="10" class="form-control"
													value="" onkeypress="return soloLetras(event)" onkeyup="aMays(event, this)" onblur="aMays(event, this)"/>



											</div>

										</div>
									</div>
							
							
							</div>

						
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="update()">
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
	








	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
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
	<!-- /.modal -->


	<!-- Modal insertar datos -->
	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-info-sign"></i>&nbsp;Información
					</h3>
				</div>
				<div class="modal-body">
					<h4>
						<label id="texto2"></label>
					</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger btn-lg"
						data-dismiss="modal">
						<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->




		




	<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>
		
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	
		
		
	<button type="button" id="levantarModalInsert"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal3" style="display: none;"></button>


	<!-- Modal alerta datos -->

<div class="copyright">
  <div class="container">
    <div class="col-md-6">
      <p>© 2016 - Desing by ST-Computación</p>
    </div>

  </div>
</div>
</body>
</html>