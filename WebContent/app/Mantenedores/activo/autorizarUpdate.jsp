<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="recursos/css/detallecontrato.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reporte Activo</title>
<script>
		
function autorizar(id){

	jConfirm('Seguro que desea continuar?', 'Confirmación', function (r) {
        if (r) {
        	$.getJSON("autorizarModificacion?param=autorizar&numActivo=" + id, function(j) {
        		$.each(j.json, function(i, item) {
        			jAlert(item.mensaje, 'Informaci\u00F3n ');
        			i++;
        		});
        	});

        }
    });

	

	
}

function rechazar(id){

	jConfirm('Seguro que desea continuar?', 'Confirmación', function (r) {
        if (r) {
        
        	$.getJSON("autorizarModificacion?param=rechazar&numActivo=" + id, function(j) {
        		$.each(j.json, function(i, item) {
        			jAlert(item.mensaje, 'Informaci\u00F3n ');
        			i++;
        		});
        	});

    		
        }
    });

	

	
}



</script>
</head>
<body>

	<div class="container">
				<c:if test="${menu==1}">
				<s:include value="/ambiente/menu/menuMantenedor.jsp" />
				</c:if>
				<c:if test="${menu!=1}">
				<s:include value="/ambiente/menu/menuAdmin.jsp" />
				</c:if>
		<div class="row centro" style="color: #008000; text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" /> Reporte de Activos en Arriendo
				
			</div>
		</div>

		<div class="row centro" style="color: #008000; text-align: center; font-size: 12px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" /> 
				Este sistema te permitirá visualizar el costo de arriendo de tu computador, valor e información de su renovación
				
			</div>
		</div>


		<div class="row centro">
			<div class="col-md-12">
			<div class="frmInsertar">
							
								<div class="panel panel-success">
					<div class="panel-heading" align="center">Autorización Modififación Activo N° <s:property value="%{reporteActivo.serieEquipo}"/></div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="numActivo">Descripción Activo:&nbsp;</label> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
									<input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.descripcion}" size="35px" disabled="disabled"> 
								</div>
							</div>
							
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="nomUsuario">Estado:&nbsp;</label> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
										<input type="text" class="form-control" id="exampleInputName2"
										value="${reporteActivo.estado}" disabled="disabled"> 
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Usuario del Activo:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.usuarioActivo}" disabled="disabled"> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3" >
							<div class="form-group" align="right">
							<label for="centro">Ubicación:&nbsp;</label>
							</div>
								
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								<s:textfield name="user" type="text" class="form-control" value="%{reporteActivo.codUbicacion}/%{reporteActivo.nomUbicacion}"  disabled="true" theme="simple" />
								</div>
							</div>
						</div>
						
						
							<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Tipo de Equipo:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.tipoEquipo}" disabled="disabled"> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
							<div class="form-group" align="right">
							<label for="centro">Centro de Costos:&nbsp;</label>
							</div>	
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								<input type="text" class="form-control" id="exampleInputName2" value="${reporteActivo.centroCosto}" disabled="disabled"> 
								</div>
							</div>
						</div>
						
						
					
						
						
							<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Nº de serie:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.serieEquipo}" disabled="disabled"> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
							<div class="form-group" align="right">
							<label for="centro">Unidad de Negocio:&nbsp;</label>
							</div>
								
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								<input type="text" class="form-control" id="exampleInputName2" value="${reporteActivo.unidadNegocio}" size="23px" disabled="disabled"> 
								</div>
							</div>
						</div>
						
					
						
								<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Tipo de Financiamiento:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.tipoFinanciamiento}" disabled="disabled"> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
							<div class="form-group" align="right">
							<label for="centro">Marca PC:&nbsp;</label>
							</div>
								
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								<input type="text" class="form-control" id="exampleInputName2"  value="${reporteActivo.marcaPc}" disabled="disabled"> 
								</div>
							</div>
						</div>
						
						
						
						
									<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Valor Cuota UF:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.valorCuota}" disabled="disabled"> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Anexo:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										  value="${reporteActivo.anexo}" disabled="disabled"> 
								</div>
							</div>
						</div>
						
						
						
						<div class="row">
							<div class="col-sm-3 col-md-3">
							<div class="form-group" align="right">
									<label for="unidadNegocio">Inicio Contrato:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.fechaInicio}" disabled="disabled"> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Termino Contrato:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${reporteActivo.fechaTermino}" disabled="disabled">
								</div>
							</div>
						
						</div>
						
						
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Cantidad de Cuotas:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										  value="${cuotas}" disabled="disabled"> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label for="unidadNegocio">Cuotas Pendientes:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
								    <input type="text" class="form-control" id="exampleInputName2"
										 value="${cuotaRest}"  disabled="disabled">
								</div>
							</div>
						
						</div>
						
						<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Correo solicitante:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.correo" id="correo"  value="${reporteActivo.correo}" readonly="readonly"/>
									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group">
								
									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group">
									</div>
								</div>

							</div>
							
						
					
						
						
						
						
						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input value="Autorizar" onclick="autorizar(${reporteActivo.id});" type="button" class="btn btn-success">
								<input value="Rechazar" onclick="rechazar(${reporteActivo.id});" type="button" class="btn btn-success">
								<input value="Atrás" onclick="window.history.back();" type="button" class="btn btn-success">
							</div>
						</div>
					</div>
				</div>
					
					
					
			</div>
		</div>

</div>



	</div>

</body>
</html>