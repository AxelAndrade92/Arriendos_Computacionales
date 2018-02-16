<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />





<title>Mantenedor de Activo</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
$(document).ready(function(){
	var SelectEmpresas = $('#SelectEmpresas');
	$.ajax({
        url: 'Json/EmpresaJson', // url where to submit the request
        type : "POST", // type of action POST || GET
        success : function(result) { 	                  
      	  var option = '';	      	  
      	console.log(result.empresas.length);
		for (var i = 0; i < result.empresas.length; i++) {
			option = '<option value="' + result.empresas[i].id + '">' + result.empresas[i].nombre +'</option>';				
			SelectEmpresas.append(option);
		}	      	
        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
        }
    })	

    SelectEmpresas.change(function(){
    	  var  SelectUen = $('#SelectUen');
		  var data = {};
		  var idEmpresa = SelectEmpresas.find(':selected').val();
		  data['idEmpresa'] = idEmpresa;
		  $.ajax({
	          url: 'Json/UenJson', // url where to submit the request
	          type : "POST", // type of action POST || GET
            dataType : 'json', // data type
            contentType: 'application/json',
	          data : JSON.stringify(data),
	          success : function(result) {
		          SelectUen.empty();
		          SelectUen.append('<option value=0 selected>--- Selecciona ---</option>');
	        	  var option = '';
	        	  for (var i=0;i<result.uenes.length;i++){
	        	     option = '<option value="'+ result.uenes[i].id + '">' + result.uenes[i].nombre + '</option>';
	        	     SelectUen.append(option);
	        	  }
	        	  //SelectRegion = $('#SelectRegion');
	        	  //SelectComuna = $('#SelectComuna');
	        	  SelectUen = $('#SelectUen');	
	          },
	          error: function(xhr, resp, text) {
	              console.log(xhr, resp, text);
	          }
	      })
		  
  });  



	
});


function consultar(){

	if (validar()) {
	
	console.log("Pasando por consultar");
	console.log($('#numActivo').val());
	
var miTabla = $('#miTabla').DataTable();

var data = {};
var consulta = {};
var SelectEmpresas = $('#SelectEmpresas');
var  SelectUen = $('#SelectUen');
consulta['serie'] = document.frmActivo.numActivo.value;
consulta['nombre'] = document.frmActivo.nomUsuario.value;
consulta['correo'] = document.frmActivo.correo.value; 
consulta['fono'] = document.frmActivo.fono.value;
consulta['idEmpresa'] = SelectEmpresas.find(':selected').val();
consulta['idSbu'] = SelectUen.find(':selected').val();;
consulta['anexo'] = document.frmActivo.anexo.value;
consulta['direccion'] = document.frmActivo.direccion.value;
data['cb'] =  consulta;

$.ajax({
	url : 'Json/Consulta_serie_activo', // url where to submit the request
	type : "POST", // type of action POST || GET
	dataType : 'json', // data type
	contentType : 'application/json',
	data : JSON.stringify(data),
	success : function(result) {
		if (result.consulta.length != 0) {			
			for (var i = 0; i < result.consulta.length; i++) {
								
								var mensaje = "La serie consultada contiene la siguiente Información <br>"
									+"Usuario : "+result.consulta[i].nombre+" "+result.consulta[i].apellido+"<br>"
									+"Serie Activo : "+result.consulta[i].serie+"<br>"
									+"Modelo Activo : "+result.consulta[i].modelo+"<br>"
									
									if (result.mensaje == null) {
										mensaje += "";
									} else{
										mensaje += "Mensaje : "+result.mensaje+"<br>";
									}								
									
									if (result.consulta[i].fechainicio == null) {
										mensaje += "Fecha de instalación : No se encuentra instalada<br><br>";
									} else {
										mensaje += "Fecha de instalación : "+result.consulta[i].fechainicio+"<br><br>";
									}	
									
												 
								$("#texto").html(mensaje);
								$("#levantarModal").click();											
								/* result.consulta[i].nombre,
								result.consulta[i].apellido,
								result.consulta[i].rol,
								result.consulta[i].serie,
								result.consulta[i].modelo,
								result.consulta[i].fechainicio,
								result.consulta[i].fono */
								
				}
		}else {		
			var mensaje = "El número de Serie no se encontró resultados, será contactado por el equipo de renovación para evaluar su caso en las próximas 48 horas.<br><br>";
			$("#texto").html(mensaje);
			$("#levantarModal").click();	
			miTabla.clear().draw();
		}		
	},
	error : function(xhr, resp, text) {
		
	}	
  })
 }
}

function validar() {
	
	var mensaje = "";
	var verificar = 0;
	var control = true;

	var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
	var verificar = 0;
	var control = true;
	
	if (document.frmActivo.numActivo.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie <br> ";
		control = false;
	}

	if (document.frmActivo.nomUsuario.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre Completo <br> ";
		control = false;
	}

	if (document.frmActivo.correo.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Correo Corporativo <br> ";
		control = false;
	}

	if (document.frmActivo.fono.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono <br> ";
		control = false;
	}
	if (document.frmActivo.fono.value !="") {
		if (document.frmActivo.fono.value.length < 9 ) {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fono debe tener minimo 9 digitos <br> ";
			control = false;
		}
	}
	

	if ($(SelectEmpresas).find(':selected').text() == "--- Seleccione ---") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresas  <br> ";
		control = false;
	}
	
	if ($(SelectUen).find(':selected').text() == "--- Seleccione ---") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Unidad de Negocio  <br> ";
		control = false;
	}

	if (document.frmActivo.anexo.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Anexo <br> ";
		control = false;
	}

	if (document.frmActivo.anexo.value !="") {
		if (document.frmActivo.anexo.value.length <= 4 ) {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Anexo debe tener minimo 4 digitos o más <br> ";
			control = false;
		}
	} 
	

	if (document.frmActivo.direccion.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Dirección <br> ";
		control = false;
	}

	if (control) {

		return control;
	} else {

		$("#texto").html(mensaje);
		$("#levantarModal").click();
	}

}
</script>
<style>
input:disabled {
   
    height: 34px; 
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.form-control2 {
	display: inline;
	width: 53%;
	height: 34px; 
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 1px solid #ccc;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

</style>
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

		

		
			<s:form action="ccu" name="frmActivo" method="POST" autocomplete="off"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Búsqueda de activos</div>
					<div class="panel-body">
					
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="La serie del computador, se encuentra por lo general en la parte trasera del computador o bajo la batería del mismo. La sigla como figura esta información es: Serial, S/N o Serie">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numActivo">Número de Serie
										computador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="numActivo"
										name="numActivo" value="${numActivo}" maxlength="12"/> <a
										class="serie" href="#"> <span
										class="glyphicon glyphicon-picture" aria-hidden="true"></span>
										<img class="imagen" src="recursos/image/serial.jpg">
									</a>
								</div>
							</div>



							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Tu usuario de red, es la información con la cual tu inicias sesión dentro de la compañía. También es el mismo usuario que se encuentra en tu correo, siendo este todo lo que se encuentra a la izquierda de la @"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="nomUsuario">Nombre Completo:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nomUsuario" placeholder="Nombres y Apellidos"
										name="nomUsuario" value="${nomUsuario}"
										 maxlength="60" />
								</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Correo electrónico Corporativo Personal"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">Correo Corporativo:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="correo"
										name="correo" value="${correo}"/>	
								</div>
							</div>


							<div class="col-sm-3 col-md-3">
								<a href="#" title="Fono que se ingresará en la consulta"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="centro">Celular:&nbsp;</label>

							</div>

							<div class="col-sm-3 col-md-3">		
							<input type="text" class=form-control" id="fonos" value="+56" disabled="disabled" size="1"/>					
							<input type="text" class="form-control2" id="fono"
							placeholder="912345678" name="fono" value="${fono}"  maxlength="9" 
							onkeypress="return isNumberKey(event)"/>
							
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta es la Empresa a la cual te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectEmpresas">Empresa:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<select id="SelectEmpresas" class="form-control">
					          				<option value="0" selected>--- Seleccione ---</option>								        
									</select>
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
								<div class="form-group">
									<select id="SelectUen" class="form-control">
					          				<option value="0" selected>--- Seleccione ---</option>								        
									</select>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Este es el Anexo el cual te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">Anexo:&nbsp;</label>
								</div>							
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="anexo"
										name="anexo" value="${anexo}"  maxlength="9" onkeypress="return isNumberKey(event)"/>
								</div>
							</div>
							
						
					
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta es la Direccion donde te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="direccion">Dirección:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="direccion" placeholder="Calle, N° y Comuna"
										name="direccion" value="${direccion}" maxlength="100"/>
								</div>
							</div>
                      </div>

							
							
						</div>						
						

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Consultar Renovación" style="background-color: #fc8d00"
									onclick="consultar()" class="btn btn-success">&nbsp;						
							</div>
							<br>
							<br>
							<br>
							<br>
						<div class="copyright">
							  <div class="container">
							    <div class="col-md-6">
							    <p>Para mayor información del procedimiento descargar manual en siguiente <a href="uploadFile">LINK</a></p>
							    </div>
							  </div>
						</div>
						
						</div>
					</div>
					
					

				</div>
			</s:form>
	
	
		</div>
	
	
	

	<div class="modal fade" id="myModalInsert" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			data-backdrop="static">
			<div class="modal-dialog modal-lg">

				<s:form action="ccu-admin" name="agregarActivo">
		
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Ingresar Activo
							</h3>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">N° de serie:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="numParteNew" size="13" id="numParteNew" value=""
												class="form-control"  />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">UEN:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-italic"></span>
											</div>
											
												
												<s:select headerKey="Todas" headerValue="Todas" name="reporteActivo.unidadNegocio" id="lstUEN" list="reporteUEN"
											listKey="unidadNegocio" listValue="unidadNegocio" theme="simple" value="%{unidadNegocio}" class="form-control" />
										
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">Nombre usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="nomUsuario" size="13" id="nomUsuario" value=""
												class="form-control"  />
										</div>

									</div>
								</div>

								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">Fono:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-usd"></span>
											</div>
										
												<input name="fono" size="13" id="fono" value=""
												class="form-control" onkeypress="return isNumberKey(event)" />
										</div>

									</div>
								</div>

							</div>

							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
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
								<div class="form-group  col-sm-6 col-md-6">
									<label for="cliente" class="col-sm-4 control-label"
										style="text-align: right;">Rol:</label>
									<div class="col-sm-6 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
									
												
												<s:select headerKey="Todas" headerValue="Todas" name="reporteActivo.nomRol" id="lstRol" list="lstRol"
											listKey="idRol" listValue="nomRol" theme="simple" value="" class="form-control" />
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="agregar()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg"
								onclick="limpiarCantidad()">
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
				<div class="modal-header-warning" style="background-color: #fc8d00">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Falta por ingresar
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