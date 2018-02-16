<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","inline; filename=" + "Reporte_Activos.xls");

%>
<html>
<head>

<title>Reporte Activo</title>
<script>
	
</script>
</head>
<body>

				
				
					<display:table class="table table-hover table-bordered table-condensed"  name="reporte" list="reporte">
					
					<display:column property="modeloEquipo" title="Modelo Equipo" style="text-align:center;" />
					
					<display:column property="serieEquipo" title="Numero de Serie" style="text-align:center;" />
					
					<display:column property="idUsuario" title="Usuario" style="text-align:center;" />
					
					<display:column property="usuarioEquipo" title="Nombre Usuario" style="text-align:center;" />
					
					<display:column property="centroCosto" title="CC" style="text-align:center;" />
									
					<display:column property="unidadNegocio" title="UEN" style="text-align:center;" />
					<display:column property="fonoUsuario" title="Fono" style="text-align:center;" />
					<display:column property="correoUsuario" title="Correo" style="text-align:center;" />
					<display:column property="fechaTermino" title="Fecha Termino" style="text-align:center;" />
					<display:column property="nomRol" title="Rol" style="text-align:center;" />
					<display:column property="especial" title="Especial" style="text-align:center;" />
					

				


					

				</display:table>
				
		

</body>
</html>