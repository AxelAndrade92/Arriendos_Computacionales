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

.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid green;
  border-bottom: 16px solid green;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
  position: absolute;
  left: 50%;
  top: 50%;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>

<title>Solicitud de Equipos</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script type="text/javascript">

var solicitudes=[];

var miTabla;

var filaTabla;

function eliminarFila(item){
	filaTabla = miTabla.row(  $(item).parents('tr') ).index();
	miTabla.row(  $(item).parents('tr') ).remove().draw();
    console.log(filaTabla);
	//delete solicitudes[filaTabla];
	solicitudes.splice(filatabla,1);
    console.log(solicitudes);
}

function extraerSolicitud(){
	var solicitud = {};	
	solicitud['idEmpresa'] = document.EquiposSolicitar.idEmpresas.value;
	solicitud['modelo'] = $(SelectModelo).find(':selected').val();
	solicitud['cantidad_equipos'] = $('#cantidadEquipos').val();
	
	if (document.getElementById("accesorio1").checked == true) {
		solicitud['accesorio1'] = 10; 
	}
	
	if (document.getElementById("accesorio2").checked == true) {
		solicitud['accesorio2'] = 20;
	} 
	solicitud['estado'] = false;
	solicitud['observaciones'] = document.EquiposSolicitar.comentarios.value;
	solicitudes.push(solicitud);
	console.log(solicitudes);
}

function agregar(){
	
	var ac1;
	var ac2;
	
	if (document.getElementById("accesorio1").checked == true) {
		ac1 = 'CANDADO';
	}else{
		ac1 = 'S/A';
	}
	
	if (document.getElementById("accesorio2").checked == true) {
		ac2 = 'DOCKING';
	}else{
		ac2 = 'S/A';
	}
	
	miTabla.row.add([
	         		  $('#empresas').val(), 
                      $(SelectMarcas).find(':selected').text(), 
                      $(SelectModelo).find(':selected').text(),
                      ac1,
                      ac2,
                      document.EquiposSolicitar.cantidadEquipos.value,
                      document.EquiposSolicitar.comentarios.value,
                      '<center><a onClick="eliminarFila(this);" class="distribuir"> <span class="glyphicon glyphicon-erase" style="color:green;"></span></a></center>'
        			  
		      ]).draw(false);
	}

$(document).ready(function() {
	$('.loader').hide();
	miTabla = $('#tabla').DataTable({
    "columnDefs": [
                   {"className": "dt-center", "targets": "_all"}
                 ]
             });

	$('#Boton_guardar').click(function(){
		if(validar()){
		extraerSolicitud();
		agregar();
		}
	});

	$('#Boton_limpiar').click(function(){

		
	});
	
	var SelectAccesorios = $('#SelectAccesorios');
	
	$("#Token").change(function(){

		var inputToken = $('#Token').val();
		var data = {};
		var token = {};
		token['token'] = inputToken;
		 data['token'] = token;
		 var SelectModelo = $('#SelectModelo');
		 var SelectMarcas = $('#SelectMarcas');
		 var SelectTipo = $('#SelectTipo');
		 
//validacion token
	 $.ajax({
         url: 'Json/ValidacionTokenJson', // url where to submit the request
         type : "POST", // type of action POST || GET
         dataType : 'json', // data type
         contentType: 'application/json',
         data : JSON.stringify(data),
         success : function(result) {
	
          $('#idEmpresas').val(result.empresaBean.id);
          $('#empresas').val(result.empresaBean.nombre);
          
          var option = '';
    	  for (var i=0;i<result.marcas.length;i++){
    	     option = '<option value="'+ result.marcas[i].idMarca + '">' + result.marcas[i].nombreMarca + '</option>';
    	     SelectMarcas.append(option);
    	  }
    	  
    	  var option = '';
    	  for (var i=0;i<result.tipos.length;i++){
     	     option = '<option value="'+ result.tipos[i].id + '">' + result.tipos[i].tipoActivo + '</option>';
     	    SelectTipo.append(option);
     	  }
			
         },
         error: function(xhr, resp, text) {
             console.log(xhr, resp, text);
         }
     })
	});
	
     $("#SelectMarcas").change(function(){
    	 var SelectMarcas = $('#SelectMarcas');
    	 var SelectTipo = $('#SelectTipo');
    	 var SelectModelo = $('#SelectModelo');
    	 SelectModelo.empty();
    	 var data = {};

    	 var marca = {};
    	 var tipo = {};
    		data['idtipo'] = SelectTipo.find(':selected').val();
    		data['idmarca'] = SelectMarcas.find(':selected').val();
    		data['idEmpresa'] = document.EquiposSolicitar.idEmpresas.value;
    	 
         if ((SelectMarcas.find(':selected').text() != "--- Seleccione ---") && (SelectTipo.find(':selected').text() != "--- Seleccione ---")) {
             
        	 $.ajax({
                 url: 'Json/CargarSelectModelosJson', // url where to submit the request
                 type : "POST", // type of action POST || GET
                 dataType : 'json', // data type
                 contentType: 'application/json',
                 data : JSON.stringify(data),
                 success : function(result) {
                     
            	  var option = '<option value="0">--- Seleccione ---</option>';
            	  SelectModelo.append(option);
            	  for (var i=0;i<result.modelos.length;i++){
             	     option = '<option value="'+ result.modelos[i].id + '">' + result.modelos[i].modelos + '</option>';
             	    SelectModelo.append(option);
             	  }
               	 
                 },
                 error: function(xhr, resp, text) {
                     console.log(xhr, resp, text);
                 }
             })
			
		} 
    
	});
	 $("#SelectTipo").change(function(){
    	 var SelectMarcas = $('#SelectMarcas');
    	 var SelectTipo = $('#SelectTipo');
    	 var SelectModelo = $('#SelectModelo');
    	 SelectModelo.empty();
    	 var data = {};

    	 var marca = {};
    	 var tipo = {};
    		data['idtipo'] = SelectTipo.find(':selected').val();
    		data['idmarca'] = SelectMarcas.find(':selected').val();
    		data['idEmpresa'] = document.EquiposSolicitar.idEmpresas.value;
    	 
         if ((SelectMarcas.find(':selected').text() != "--- Seleccione ---") && (SelectTipo.find(':selected').text() != "--- Seleccione ---")) {
             
        	 $.ajax({
                 url: 'Json/CargarSelectModelosJson', // url where to submit the request
                 type : "POST", // type of action POST || GET
                 dataType : 'json', // data type
                 contentType: 'application/json',
                 data : JSON.stringify(data),
                 success : function(result) {
                SelectModelo.empty();
                var option = '<option value="0">--- Seleccione ---</option>';
          	  	SelectModelo.append(option);
            	  for (var i=0;i<result.modelos.length;i++){
             	     option = '<option value="'+ result.modelos[i].id + '">' + result.modelos[i].modelos + '</option>';
             	    SelectModelo.append(option);
             	  }
               	 
                 },
                 error: function(xhr, resp, text) {
                     console.log(xhr, resp, text);
                 }
             })
			
		} 
    
	});
	
	var cont = 0;
/* 	function agregar(){
		
		var ac1;
		var ac2;
		
		if (document.getElementById("accesorio1").checked == true) {
			ac1 = 'CANDADO';
		}else{
			ac1 = 'S/A';
		}
		
		if (document.getElementById("accesorio2").checked == true) {
			ac2 = 'DOCKING';
		}else{
			ac2 = 'S/A';
		}
		
		miTabla.row.add([
		         		  $('#empresas').val(), 
                          $(SelectMarcas).find(':selected').text(), 
                          $(SelectModelo).find(':selected').text(),
                          ac1,
                          ac2,
                          document.EquiposSolicitar.cantidadEquipos.value,
                          document.EquiposSolicitar.comentarios.value,
                          '<center><a onClick="eliminarFila(this);" class="distribuir"> <span class="glyphicon glyphicon-erase" style="color:green;"></span></a></center>'
	        			  
			      ]).draw(false);
		} */

});

	
	
	function insertar(){
			extraerSolicitud();
			agregar();
			if (validar()) {
				jConfirm('¿Seguro que desea continuar o desea continuar agregando equipos?', 'Confirmación', function(r) {
					if (r) {
						if(solicitudes.length != 0){
								var data = {};
								data['solicitudes'] = solicitudes;
								$('.container').hide();
								$('.loader').show();
							$.ajax({
				                url: 'SolicitudGuardar', // url where to submit the request
				                type : "POST", // type of action POST || GET
				                dataType : 'html', // data type
				                contentType: 'application/json',
				                data : JSON.stringify(data), // post data || get data
				                success : function(result){
				                    alert(result);
				                    $('#idEmpresas').val('');
				                    $('#empresas').val('');
				                    $('#comentarios').val('');
				                    $('#cantidadEquipos').val('');
				                    $('#SelectMarcas').empty();
				                    $('#SelectTipo').empty();
				                    document.getElementById("accesorio1").checked = false;
				                    document.getElementById("accesorio2").checked = false;
				                    $('#SelectModelo').empty();
				                    miTabla.clear().draw();
				                    $('#Token').val('');
				                    $('.container').show();
									$('.loader').hide();
				                },
				                error: function(xhr, resp, text) {
				                    console.log(xhr, resp, text);
				                }
				            })
						}else{alert('Debes tener al menos un registro agregado antes de realizar la solicitud');}
					}
				});
				}		
}

function validar() {
	
	var mensaje = "";
	var verificar = 0;
	var control = true;

	var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
	var verificar = 0;
	var control = true;
	
	if (document.EquiposSolicitar.Token.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Token Personal  <br> ";
		control = false;
	}
	
	/* if (document.EquiposSolicitar.empresas.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresas  <br> ";
		control = false;
	} */

	if ($(SelectMarcas).find(':selected').text() == "--- Seleccione ---") {
		
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Marcas  <br> ";
		control = false;
	}

	if ($(SelectTipo).find(':selected').text() == "--- Seleccione ---") {
		
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Tipos de Activos  <br> ";
		control = false;
	}

	if ($(SelectModelo).find(':selected').text() == "--- Seleccione ---") {
		
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelos  <br> ";
		control = false;
	}
	
	if ($('#cantidadEquipos').val() == "") {
		
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Cantidad de Equipos  <br> ";
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

<s:include value="/ambiente/library/base.jsp"></s:include>
</head>
<body background="recursos/image/fondo.jpg">
<div class="loader" id="loader"></div>
<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> Renovaciones Tecnológicas

			</div>
		</div>
		
		<s:form action="EquiposSolicitar" name="EquiposSolicitar" method="POST" autocomplete="off" id="EquiposSolicitar"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Solicitud de Equipos</div>
					<div class="panel-body">
						<div class="row">							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar el Token Personal">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="">Token:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="Token" 
										name="Token" value="" maxlength="12"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui se despliega el nombre de la empresa solicitante"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="empresas">Empresa:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								    <input type="hidden" class="form-control" id="idEmpresas"
										name="empresas" value="" /> 
									<input type="text" class="form-control" id="empresas" readonly="true"
										name="empresas" value="" maxlength="12"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui seleccionara todos las marcas de los modelos desplegados"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectMarca">Marcas:&nbsp;</label>
								</div>
								
								
								
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								        <select id="SelectMarcas" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>
								        
								        </select> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui se seleccionara el tipo de equipo"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectTipo">Tipo:&nbsp;</label>
								</div>
								
								
								
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								        <select id="SelectTipo" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>
								        
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui se seleccionara todos los modelos disponibles para tu Empresa"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectModelo">Modelos:&nbsp;</label>
								</div>
								
								
								
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								        <select id="SelectModelo" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>
								        
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui seleccionara los accesorios que desea seleccionar"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectAccesorios">Accesorios:&nbsp;</label>
								</div>
								
								
								
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									        <input type="checkbox" name="accesorio1" id="accesorio1" value="10"> Candado<br>
									        <input type="checkbox" name="accesorio2" id="accesorio2" value="20"> Docking<br>
								</div>
						    </div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la cantidad de Accesorios que necesitas solicitar">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="cantidadAccesorios">Cantidad de Equipos:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="cantidadEquipos"
										name="cantidadAccesorios" value="${cantidadAccesorios}" maxlength="12"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar algunas observaciones para tu solicitud">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="observaciones">Observaciones:&nbsp;</label>
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<textarea id="comentarios" maxlength="140" rows="5" cols="30" placeholder="Escribe tus Comentarios"></textarea>
							</div>
							</div>
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
									<input type="button" value="Enviar solicitud"
									onclick="insertar()" class="btn btn-success">&nbsp;
									<input type="button" value="Agregar Equipo"
									id="Boton_guardar" class="btn btn-success">&nbsp;
									<!-- <input type="button" value="Limpiar"
									id="Boton_limpiar" class="btn btn-success">&nbsp; -->
							</div>
						</div>
						
						
					</div>
				</div>
			</s:form>
			
			
			
			<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">
			
			
			
			
               		<table class="table table-hover table-bordered table-condensed" id="tabla">
				<thead><tr><th>Empresa</th><th>Marca</th><th>Modelo</th><th>Accesorio 1</th><th>Accesorio 2</th><th>Cantidad Equipos</th><th>Observaciones</th><th>Eliminar</th></tr></thead>
				<tbody>
				</tbody>
				
				</table>
				
				
			</div>
		</div>
		</div>
		</div>
			
		
		
		
		</div> 
		
	
		<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>
		
		
		
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

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
	
	
	
				
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	

	

</body>
</html>