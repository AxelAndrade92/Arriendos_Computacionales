<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="recursos/css/detallecontrato.css">

<title>Reporte Activo</title>
<script>
	$(document).ready(function() {

		$('#tabla').DataTable();

	

	});


	function verDetalle(idActivo){
		

		PopupCenter('reporteActivoDetalle?param=detalle&numActivo='+idActivo, 'Detalle Activo', 1007, 500);
		return false;
		

		}


	function PopupCenter(pageURL, title,w,h){

		

		var left = (screen.width/2)-(w-2);
		var top = (screen.height/2)-(h-2);
		if(top > 100)top = top-100;
		if(top<=0) top = 15;
		window.open(pageURL, title,'toolbar=no,location=no,directories=no, status=no, menubar=no, scrollbars=no,resizable=no,copyhistory=no,width='+w+',height='+h+',top='+top+',left='+left);	


		
	}

	function crearExcel(unidad,activo,usuario,centro){

		document.unidadNegocio.param.value = "excel";
		document.unidadNegocio.unidadNegocio.value = unidad;
		document.unidadNegocio.numActivo.value = activo;
		document.unidadNegocio.nomUsuario.value = usuario;
		document.unidadNegocio.centro.value = centro;
		document.unidadNegocio.submit();

		
	}

	
</script>
</head>
<body>

	<div class="container">

				<s:include value="/ambiente/menu/menuAdmin.jsp" />

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
			
			
				<display:table id="tabla" class="table table-striped table-hover" name="listaTraza" list="listaTraza" export="false" requestURI="reporteActivo">
				
			
				
				<display:column property="serieEquipo" title="Serie Equipo" style="width:180px; text-align:center;" media="excel" />
				<display:column property="descripcion" title="Descripcion" style="width:180px; text-align:center;" />
				<display:column property="usuarioActivo" title="Usuario" style="width:180px; text-align:center;" />
				<display:column property="nomUbicacion" title="Ubicacion" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="tipoEquipo" title="Tipo Equipo" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="serieMonitor" title="Serie Monitor" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="nombrePc" title="Nombre PC" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="centroCosto" title="Centro de Costo" style="width:180px; text-align:center;" />
				<display:column property="unidadNegocio" title="Unidad de Negocio" style="width:180px; text-align:center;" />
				<display:column property="tipoFinanciamiento" title="Tipo de Financiamiento" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="anexo" title="Anexo" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="fechaInicio" title="Fecha Inicio" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="fechaTermino" title="Fecha Termino" style="width:180px; text-align:center;" media="excel"/>
				<display:column property="fechaMod" title="Fecha Modificacion" style="width:180px; text-align:center;"/>
				<display:column property="usuarioMod" title="Usuario" style="width:180px; text-align:center;"/>
				<display:column property="ip" title="IP" style="width:180px; text-align:center;"/>
				<display:column property="accion" title="Acción" style="width:180px; text-align:center;"/>
				
				
				
			
			</display:table>		
			
		

				

				
			</div>
		</div>

</div>

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input value="Atrás" onclick="window.history.back();" type="button" class="btn btn-success">
							</div>
						</div>

	</div>

</body>
</html>