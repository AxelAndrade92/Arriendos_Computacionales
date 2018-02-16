<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<s:include value="/ambiente/library/base.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="recursos/css/detallecontrato.css">
<title>Reporte Activo</title>
<script>
	$(document).ready(function() {

		$('#tabla').DataTable();

	

	});


function crearExcel(unidad){

	document.unidadNegocio.param.value = "excel";
	document.unidadNegocio.unidadNegocio.value = unidad;
	document.unidadNegocio.submit();

	
}

function buscar(){
	if(validar()){
	document.frmActivo.param.value = "listar";
	document.frmActivo.submit();
	}
	
}

function validar(){

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if ($("#lstReporte option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Unidad de Negocio \n ";
		control = false;
	}

	
	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

	
}

</script>
</head>
<body>

	<div class="container">

		<s:include value="/ambiente/menu/menuAdmin.jsp" />


		<div class="row centro">
			<div class="col-md-12">
			<div class="frmInsertar">
				<s:form action="unidadNegocio" name="frmActivo" method="POST">
					<input type="hidden" name="param" id="param" value="" />
					<table class="table table-condensed">
						<caption class="caption">Busqueda</caption>

						<tr>
							<td><label>Unidad de Negocio</label></td>
							<td><s:select headerKey="0" headerValue="Seleccione.." name="unidadNegocio" id="lstReporte" list="reporte" listKey="unidadNegocio"
									listValue="unidadNegocio" theme="simple" /></td>
							
					 	</tr>
						
						<tr>
						<td colspan="4" style="text-align: center">
						<input type="button" onclick="buscar()" value="consultar">
						</td>
						
						</tr>

						
						
					</table>
					
				
				</s:form>
				<s:form action="unidadNegocio" name="unidadNegocio">
				<s:hidden name="unidadNegocio" value="" />
				<s:hidden name="param" value="" />
				<display:table id="tabla" class="table table-striped table-hover" name="reporteUEN" list="reporteUEN" >
				<display:column property="numeroActivo" title="Serie Equipo" style="width:60px; text-align:center;" />
				<display:column property="descripcion" title="Descripción" style="width:60px; text-align:center;" media="html"/>
				<display:column property="descripcion" title="Descripcion" style="width:60px; text-align:center;" media="excel" />
				
				<display:column property="estado" title="Estado" style="width:80px; text-align:center;" />
				<display:column property="valorCuota" title="Valor Cuota"  style="width:95px; text-align:center;" />
				
				<display:caption>Resultado de la búsqueda</display:caption>
			
				
			
			</display:table>
			</s:form>
			<c:if test="${ver==1}">
			<a href="javascript:void(0)" onclick="crearExcel('${unidadNegocio}')" >Exportar a Excel</a>
			</c:if>
					
			</div>
		</div>

</div>



	</div>

</body>
</html>