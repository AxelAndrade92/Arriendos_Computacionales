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

.dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

}
</style>
<title>Instalaciones</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var array;
function callback(data){
	array = data;
}

$(document).ready(function() {

	$("#fechainicioInsert").datepicker({
		  firstDay: 1
		  });

	$("#serieInsert").keypress(function(e){

		if(e.which == 13) {
		
			var data = {};
			var activoBean = {};
			activoBean['serie'] = $('#serieInsert').val();
			data['activoBean'] = activoBean;
			
			$.ajax({
		    url: 'Json/InstalacionesBuscarAsignacionPorSerial', // url where to submit the request
		    type : "POST", // type of action POST || GET
		    dataType : 'json',//'json', // data type
		    contentType: 'application/json',
		    data : JSON.stringify(data), // post data || get data
		    success : function(result) {
			
		    if(result.mensaje == null){
			    	$('#nombreapellido').val(result.personaBean.nombre+' '+result.personaBean.apellidoP);
					$("#idpersonaInsert").val(result.personaBean.id);
					$('#rut').val(result.personaBean.rutPer);
					$('#serieInsert').val(result.activoBean.serie);
					$('#idactivoInsert').val(result.activoBean.id);
					$('#idasignacionInsert').val(result.asignacionBean.id);
 					$("#modelo").val(result.modelo[1]);
 					$("#marca").val(result.modelo[2]);
			    }else{
				    alert(result.mensaje);
				    $('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
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
	
	$("#ruttecnico").keypress(function(e){

		if(e.which == 13) {
		
			var data = {};
			var tecnicoBean = {};
			tecnicoBean['rut'] = $('#ruttecnico').val();
			data['tecnicoBean'] = tecnicoBean;
			
			$.ajax({
		    url: 'Json/TecnicosBuscarPorRut', // url where to submit the request
		    type : "POST", // type of action POST || GET
		    dataType : 'json',//'json', // data type
		    contentType: 'application/json',
		    data : JSON.stringify(data), // post data || get data
		    success : function(result) {
		    if(result.tecnicoBean != null){
			    	$('#nombreapellidotecnico').val(result.tecnicoBean.nombre);
					$("#idtecnicoInsert").val(result.tecnicoBean.id);
					$('#ruttecnico').val(result.tecnicoBean.rut);
			    }else{
				    alert(result.mensaje);
				    $('#nombreapellidotecnico').val('');
					$("#idtecnicoInsert").val('');
					$('#ruttecnico').val('');
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
    $('a.distribuir').click(function(){

    	var id = $(this).parents("tr").find("td").eq(0).html(); 
        var nombre = $(this).parents("tr").find("td").eq(1).html();
		var direccion = $(this).parents("tr").find("td").eq(6).html();

		$("#sucursalId").val(id);
        $("#sucursalNombre").val(nombre);
		$("#direccionSucursal").val(direccion);
		
        $("#levantarModalUpdate").click();
     
    });

	$('#tabla').DataTable();
	
});

	function aMays(e, elemento) {
		tecla=(document.all) ? e.keyCode : e.which; 
		 elemento.value = elemento.value.toUpperCase();
		}
	
	
	function insertar(){
	
		if (validar()) {
		jConfirm('¿Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {

				var fechaOriginal = $('#fechainicioInsert').val();
				var f = fechaOriginal.split('/');
				
				var data = {};
				var instalacionBean = {};
				var asignacionBean = {};
				var idAgendado = {};
				var activoBean = {};
				
				instalacionBean['id'] = '0';
				instalacionBean['asignacion'] = $('#idasignacionInsert').val();
				instalacionBean['tecnico'] = $('#idtecnicoInsert').val();
				instalacionBean['observacion'] = $('#observacionInsert').val();
				data['instalacionBean'] = instalacionBean;

				asignacionBean['id'] = $('#idasignacionInsert').val();
				asignacionBean['fechaInicio'] = fechaOriginal;//new Date(f[2]+'/'+f[1]+'/'+f[0]);
				data['asignacionBean'] = asignacionBean;

				data['idAgendado'] = $('#idAgendado').val();

				activoBean['serie'] = $('#serieInsert').val();
				data['activoBean'] = activoBean;
				
				$.ajax({
                url: 'InstalacionInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html',//'json', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
				    $('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
					$('#serieInsert').val('');
					$('#idactivoInsert').val('');
 					$("#modelo").val('');
 					$("#marca").val('');
 					$("#observacionInsert").val('');
 					$("#fechainicioInsert").val('');
 					$('#nombreapellidotecnico').val('');
 					$('#ruttecnico').val('');
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

		var SelectCausa = $('#SelectCausa');
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if ($('#serieInsert').val() == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie  <br> ";
			control = false;
		}

		if ($('#ruttecnico').val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> RUT del técnicos  <br> ";
			control = false;
		}
		
		if ($('#fechainicioInsert').val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fecha de instalación  <br> ";
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
	
	function levantar() {

		/* if (document.Marca.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		} */
	}



</script>
</head>
<body onload="levantar()" background="recursos/image/fondo2.jpg">

<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<h1 style="color: #fc8d00">
					Portal de Renovaciones </h1>

			</div>
		</div>
		
		<form action="Instalaciones" name="Instalaciones" method="POST" autocomplete="off" id="Instalaciones"
				class="form-inline">
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Instalaciones</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la serie del equipo que se instaló">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="serie">Serie:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="hidden" name="mensaje" id="idasignacionInsert"
										value="" />
										<input type="hidden" name="mensaje" id="idtecnicoInsert"
										value="" />
									<input type="text" class="form-control" id="serieInsert"
										name="serie" value="" maxlength="30"/> 
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
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">RUT:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								<input type="hidden" name="mensaje" id="idpersonaInsert"
										value="" />
									<input type="text" class="form-control" id="rut"
										name="rut" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar el RUT del técnico instalador">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a>  <label for="tecnico">RUT Técnico:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="ruttecnico"
										name="ruttecnico" value="" maxlength="30" /> 
								</div>
							</div>
								<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">Nombre/Apellido Técnico:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreapellidotecnico"
										name="nombreapellidotecnico" value="" maxlength="30" readonly="readonly" id="nombreapellidotecnico"/> 
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
								<textarea id="observacionInsert" maxlength="140" rows="5" cols="30" placeholder="Escribe tus Observaciones"></textarea>
							</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la fecha en la cual se realizó la instalación">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="fechainicioInsert">Fecha de Instalación:&nbsp;</label>
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<input id="fechainicioInsert" type="text" class="form-control" maxlength="10" readonly="readonly"></input>
							</div>
							</div>
							
							
						</div>
						<div class="row" align="center">
						 <%-- <button type="button" value="" data-toggle="modal"
								data-target="#myModalMarca" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Asignar nuevo equipo
								</button> --%>
								<input type="button" value="Registrar instalación" style="background-color: #fc8d00"
									onclick="insertar()" class="btn btn-success" id="retorno">&nbsp;
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
				<caption style="color: black;">Registro del agendamiento</caption>
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
</body>
</html>
