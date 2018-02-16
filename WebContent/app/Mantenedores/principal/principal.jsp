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
<title>Home</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>


</script>
</head>
<!-- <body onload="levantar()" background="recursos/image/fondo.jpg"> -->
<body  background="recursos/image/fondost.jpg">
<div class="container">

		<s:include value="/ambiente/menu/menuMantenedorPrincipal.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				 
			</div>
		</div>
		
		<form action="PaginaPrincipal" name="PaginaPrinncipal" method="POST" autocomplete="off" id="Retornos"
				class="form-inline">
				<%-- <div class="panel panel-success">
					<div class="panel-heading" align="center">Página principal</div>
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
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="serie">Marca:&nbsp;</label>
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
						 <button type="button" value="" class="btn btn-success btn-sm " >
								<span class="glyphicon glyphicon-plus" onclick="insertar()"></span>&nbsp;Asignar Equipo
								</button>
								<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Asignar Activo" id="asignarBoton"
									onclick="insertar()" class="btn btn-success">&nbsp;
							</div>
						</div>	
					</div>
				</div> --%>
			</form>
			
		<!-- ****************************************************************************************** --> 
		<%-- <s:if test="%{busquedaAgendado!=null}">
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
		</s:if>	 --%>
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
