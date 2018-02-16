<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>

<%

//response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
response.setHeader("Content-type","application/vnd.ms-excel");
response.setHeader("Content-disposition","inline; filename=listado_activos.xls");


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Reporte Activo</title>

</head>
<body>

				
				
				<display:table   name="reporteUEN" list="reporteUEN" >
				<display:column property="serieEquipo" title="Serie Equipo" style="width:180px; text-align:center;" />
				<display:column property="descripcion" title="Descripcion" style="width:180px; text-align:center;" media="html"/>
				<display:column property="usuarioActivo" title="Usuario" style="width:180px; text-align:center;" />
				<display:column property="nomUbicacion" title="Ubicacion" style="width:180px; text-align:center;" />
				<display:column property="tipoEquipo" title="Tipo Equipo" style="width:180px; text-align:center;" />
				<display:column property="serieMonitor" title="Serie Monitor" style="width:180px; text-align:center;" />
				<display:column property="nombrePc" title="Nombre PC" style="width:180px; text-align:center;" />
				<display:column property="centroCosto" title="Centro de Costo" style="width:180px; text-align:center;" />
				<display:column property="unidadNegocio" title="Unidad de Negocio" style="width:180px; text-align:center;" />
				<display:column property="tipoFinanciamiento" title="Tipo de Financiamiento" style="width:180px; text-align:center;" />
				<display:column property="anexo" title="Anexo" style="width:180px; text-align:center;" />
				<display:column property="fechaInicio" title="Fecha Inicio" style="width:180px; text-align:center;" />
				<display:column property="fechaTermino" title="Fecha Termino" style="width:180px; text-align:center;" />
				<display:column property="estado" title="Estado" style="width:180px; text-align:center;" />
				<display:column property="valorCuota" title="Valor Cuota"  style="width:180px; text-align:center;" />
				
		
				
			
			</display:table>
				
		

</body>
</html>