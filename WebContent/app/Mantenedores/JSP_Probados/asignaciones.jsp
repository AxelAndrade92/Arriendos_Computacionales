<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<style type="text/css">
/* Popup container - can be anything you want */
.popup {
    position: relative;
    display: inline-block;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* The actual popup */
.popup .popuptext {
    visibility: hidden;
    width: 160px;
    background-color: #555;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 8px 0;
    position: absolute;
    z-index: 1;
    bottom: 125%;
    left: 50%;
    margin-left: -80px;
}

/* Popup arrow */
.popup .popuptext::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: #555 transparent transparent transparent;
}

/* Toggle this class - hide and show the popup */
.popup .show {
    visibility: visible;
    -webkit-animation: fadeIn 1s;
    animation: fadeIn 1s;
}

/* Add animation (fade in the popup) */
@-webkit-keyframes fadeIn {
    from {opacity: 0;} 
    to {opacity: 1;}
}

@keyframes fadeIn {
    from {opacity: 0;}
    to {opacity:1 ;}
}
/* .dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

} */

caption {
	color: black;
	background-color: white;
}
</style>
<title>Asignaciones</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var array;
function callback(data){
	array = data;
}

function popUp() {
    var popup = document.getElementById("myPopup");
    popup.classList.toggle("show");
}

$(document).ready(function() {

	$('#serieInsert').attr('readonly', true);
	
	$("#rut").keypress(function(e){

		if(e.which == 13) {
		
			var data = {};
			var personaBean = {};
			personaBean['rutPer'] = $('#rut').val();
			data['personaBean'] = personaBean;
			
			$.ajax({
		    url: 'Json/AsginacionPersonaPorRut', // url where to submit the request
		    type : "POST", // type of action POST || GET
		    dataType : 'json',//'json', // data type
		    contentType: 'application/json',
		    data : JSON.stringify(data), // post data || get data
		    success : function(result) {
			    if(result.personaBean != null){
					$('#nombreapellido').val(result.personaBean.nombre+' '+result.personaBean.apellidoP);
					$("#idpersonaInsert").val(result.personaBean.id);
					$('#rut').val(result.personaBean.rutPer);
					$('#idempresaInsert').val(result.personaBean.empresaPer);
					$('#serieInsert').attr('readonly', false);
					var contenido = 'Los activos recomendados para asignar son los siguientes: \n';
					for (var i=0;i<result.activos.length;i++){
						contenido += result.activos[i].serie+'\n';
					}
					alert(contenido);
					$('#myPopup').text(contenido);
			    }else{
				    alert(result.mensaje);
			    	$('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
					$('#idempresaInsert').val('');
				    }
		    },
		    error: function(xhr, resp, text) {
		        console.log(xhr, resp, text);
		    }
		})  
		}else{
			return soloNumeros(event);
		}
	});

	$("#serieInsert").keypress(function(e){

		if(e.which == 13) {
		
			var data = {};
			var personaBean = {};
			var activoBean = {};
			personaBean['empresaPer'] = $('#idempresaInsert').val();
			data['personaBean'] = personaBean;
			
			activoBean['serie'] = $('#serieInsert').val();
			data['activoBean'] = activoBean;
			
			$.ajax({
		    url: 'Json/AsginacionActivoPorSerie', // url where to submit the request
		    type : "POST", // type of action POST || GET
		    dataType : 'json',//'json', // data type
		    contentType: 'application/json',
		    data : JSON.stringify(data), // post data || get data
		    success : function(result) {
			    if(result.activoBean != null){
					$('#serieInsert').val(result.activoBean.serie);
					$('#idactivoInsert').val(result.activoBean.id);
 					$("#modelo").val(result.modelo[1]);
 					$("#marca").val(result.modelo[3]);
 					if(result.activoBean.estado == 'ASIGNADO'){
 						jConfirm('¿Desea reasignar el activo?', 'Confirmación', function(r) {
 							if (r) {
 	 							alert('Dentro del desea reasignar');
 	 							$.ajax({
 	 							    url: 'AsginacionReasignacion', // url where to submit the request
 	 							    type : "POST", // type of action POST || GET
 	 							    dataType : 'html',//'json', // data type
 	 							    contentType: 'application/json',
 	 							    data : JSON.stringify(data), // post data || get data
 	 							    success : function(result) {
 	 	 							    alert(result);
 	 							    	$("#asginarBoton").click();
 	 							    },
 	 							    error: function(xhr, resp, text) {
 	 							        console.log(xhr, resp, text);
 	 							    }
 	 							})
 							}else{
 							    $('#serieInsert').val('');
 								$('#idactivoInsert').val('');
 			 					$("#modelo").val('');
 			 					$("#marca").val('');
 	 						}
 						});
 	 				}
			    }else{
				    alert(result.mensaje);
				    $('#serieInsert').val('');
					$('#idactivoInsert').val('');
 					$("#modelo").val('');
 					$("#marca").val('');
				    }
		    },
		    error: function(xhr, resp, text) {
		        console.log(xhr, resp, text);
		    }
		})
		}else{
			return soloLetrasNumeros(event);
			}
	});
	
});

	function aMays(e, elemento) {
		tecla=(document.all) ? e.keyCode : e.which; 
		 elemento.value = elemento.value.toUpperCase();
		}
	
	
	function insertar(){
	
		if (validar()) {
		//if (true) {
		jConfirm('¿Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {
			 	
				var data = {};
				var activoBean = {};
				
				var asignacionBean = {};
				asignacionBean['id'] = '0';
				asignacionBean['usuario'] = $("#idpersonaInsert").val();
				asignacionBean['activo'] = $('#idactivoInsert').val();
				asignacionBean['fechaInicio'] = null;
				asignacionBean['observacion'] = $('#observacionesInsert').val();
				data['asignacionBean'] = asignacionBean;

				activoBean['serie'] = $('#serieInsert').val();
				data['activoBean'] = activoBean;
				
				$.ajax({
                url: 'AsignacionInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html',//'json', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
                	$('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
					$('#idempresaInsert').val('');
					$('#serieInsert').val('');
					$('#idactivoInsert').val('');
 					$("#modelo").val('');
 					$("#marca").val('');
 					$('#observacionesInsert').val('');
 					$('#serieInsert').attr('readonly', true);
 					$('#myPopup').text('');
                },
                error: function(xhr, resp, text) {
                    console.log(xhr, resp, text);
                }
            }) 
			}
		});
		}
	
		}
	function limpiarInsert(){
		document.Marca.nombre.value == "";
		document.Marca.sucursalEmpresa.value == "";
		$("#direccionSucursal").val("");
		
	}
	
	
	function buscar() {
			document.Marca.param.value = "buscar";
			document.Marca.submit();
	}
	
	
	
	
	function validar() {
		
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if ($('#rut').val() == "" & $("#idpersonaInsert").val() == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> RUT  <br> ";
			control = false;
		}

		if ($('#serieInsert').val() == "" & $('#idactivoInsert').val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie del activo  <br> ";
			control = false;
		}
	
		if (control) {
	
			return control;
		} else {
	
			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}
	
	}
	
	function soloNumeros(e) {
	  key = e.keyCode || e.which;
	  tecla = String.fromCharCode(key).toString();
	  letras = "1234567890";//Se define todo el abecedario que se quiere que se muestre.
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

	function soloLetrasNumeros(e) {
		  key = e.keyCode || e.which;
		  tecla = String.fromCharCode(key).toString();
		  letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789";//Se define todo el abecedario que se quiere que se muestre.
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
	
/* 	function levantar() {

		if (document.Marca.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		}
	} */



</script>
</head>
<!-- <body onload="levantar()" background="recursos/image/fondo.jpg"> -->
<body  background="recursos/image/fondo2.jpg">
<div class="container">

		 <s:include value="/ambiente/menu/menuMantenedor.jsp" /> 

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				 <h1 style="color: #fc8d00">
					Portal de Renovaciones </h1>
			</div>
		</div>
		
		<form action="Retornos" name="Retornos" method="POST" autocomplete="off" id="Retornos"
				class="form-inline">
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Asignación de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group"> 
									<a href="#"
										title="Aqui debes el RUT de la persona a la cual se le asignará el equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a>  <label for="rut">RUT:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="rut"
										name="rut" value="" maxlength="30" /> 
										<input type="hidden" class="form-control" id="idpersonaInsert"
										name="idpersonaInsert" value="" maxlength="30" /> 
										<input type="hidden" class="form-control" id="idempresaInsert"
										name="idempresaInsert" value="" maxlength="30" /> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">Nombre/Apellido:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreapellido"
										name="nombreapellido" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="serie">Serie:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								<div class="popup" onclick="popUp()" id="popupdiv">
									  <span class="popuptext" id="myPopup"></span>
									<input type="text" class="form-control" id="serieInsert"
										name="serie" value="" maxlength="30" /> 
										<input type="hidden" class="form-control" id="idactivoInsert"
										name="idpersonaInsert" value="" maxlength="30" />
										</div>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">Modelo:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="modelo"
										name="modelo" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<%-- <a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --%> <label for="serie">Marca:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="marca"
										name="marca" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar algunas observaciones si existen">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="observaciones">Observaciones:&nbsp;</label>
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<textarea id="observacionesInsert" maxlength="140" rows="5" cols="30" placeholder="Escribe tus Observaciones"></textarea>
							</div>
							</div>
							
							
						</div>
						<div class="row" align="center">
						 <%-- <button type="button" value="" class="btn btn-success btn-sm " >
								<span class="glyphicon glyphicon-plus" onclick="insertar()"></span>&nbsp;Asignar Equipo
								</button> --%>
								<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Asignar Activo" id="asignarBoton" style="background-color: #fc8d00"
									onclick="insertar()" class="btn btn-success">&nbsp;
							</div>
						</div>	
					</div>
				</div>
			</form>
			
		<!-- ****************************************************************************************** --> 
		<s:if test="%{busquedaAgendado!=null}">
		<div class="panel panel-success" id="resultados">
				
		<div class="panel-body" style="margin: 6px;" align="center">
		<input type="hidden" name="idAgendado" id="idAgendado"
					value="<s:property value="idAgendado" />" />
		
			<table class="table table-hover table-bordered table-condensed" id="agendados">
				<caption style="color: black;">Fecha agendada para la instalación</caption>
				<thead><tr><th>ID</th><th>Nombre/Apellido</th><th>Región</th><th>Comuna</th><th>Empresa</th><th>UEN</th><th>Centro de Costos</th><th>Dirección</th><th>Fecha</th></tr></thead>
				<tbody>
				  <tr>
				    <td align="center"><s:property value="busquedaAgendado.id" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombrePersona" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombreRegion" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombreComuna" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombreEmpresa" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombreUen" /></td>
				    <td align="center"><s:property value="busquedaAgendado.nombreCC" /></td>
				    <td align="center"><s:property value="busquedaAgendado.direccion" /></td>
				    <td align="center"><s:property value="busquedaAgendado.fecha" /></td>
				  </tr>
				</tbody>
				
				</table>
				
		
						
		</div>
		</div>
		</s:if>	
		</div> 
			<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModal" style="display: none;"></button>
			
			<button type="button" id="levantarModalActivosDisponibles" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModalActivosDisponibles" style="display: none;"></button>
			
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
	
	<div class="modal fade" id="myModalActivosDisponibles" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Activos disponibles para asignar
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
</body>
</html>
