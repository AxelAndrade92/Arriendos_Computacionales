<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel=stylesheet type=text/css href="recursos/css/dataTable.css">


<title>Reporte Activo</title>
<script>
	$(document).ready(function() {

		$('#tabla').DataTable();

	
	});


	function verDetalle(idActivo){
		
		document.unidadNegocio.numActivo.value = idActivo;
		document.unidadNegocio.param.value = "detalle";
		document.unidadNegocio.submit();
		//PopupCenter('reporteActivoDetalle?param=detalle&numActivo='+idActivo, 'Detalle Activo', 1007, 550);
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

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" /> Reporte de Activos en Arriendo
				
			</div>
		</div>

		<div class="row centro" style=" text-align: center; font-size: 12px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" /> 
				Este sistema te permitirá visualizar el costo de arriendo de tu computador, valor e información de su renovación
				
			</div>
		</div>

		<div class="row-center">
			<s:form action="%{session.empresa}?param=listar" name="frmActivo" method="POST" class="form-inline">
				<div class="panel panel-success">
					
					<div class="panel-heading" align="center">Búsqueda de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="La serie del computador, se encuentra por lo general en la parte trasera del computador o bajo la batería del mismo. La sigla como figura esta información es: Serial, S/N o Serie"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="numActivo">Numero de serie computador:&nbsp;</label> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								
									<input type="text" class="form-control" id="exampleInputName2"
										placeholder="N° de serie " name="numActivo" value="${numActivo}"> 
								</div>
							</div>
							
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Tu usuario de red, es la información con la cual tu inicias sesión dentro de la compañía. También es el mismo usuario que se encuentra en tu correo, siendo este todo lo que se encuentra a la izquierda de la @"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="nomUsuario">Usuario de red:&nbsp;</label> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
										<input type="text" class="form-control" id="exampleInputName2"
										placeholder="Usuario" name="nomUsuario" value="${nomUsuario}"> 
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#" title="Esta es la Unidad de Negocios a la cual te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">UEN:&nbsp;</label>
									
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
								    <s:select headerKey="0" headerValue="Todas" name="unidadNegocio" id="lstReporte" list="reporteUEN" listKey="unidadNegocio"
										listValue="unidadNegocio" theme="simple" value="%{unidadNegocio}" class="form-control" />
									
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
							<a href="#" title="Esta es la división interna de tu Unidad de Negocios"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
							<label for="centro">Centro de Costo:&nbsp;</label>
								
							</div>
							
								<div class="col-sm-3 col-md-3">
								<s:select headerKey="0" headerValue="Todas" name="centro" id="lstReporte" list="reporteCentroCosto" listKey="centroCosto"
									listValue="centroCosto" theme="simple" value="%{centro}" class="form-control" />
									
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="submit" value="Consultar activos" class="btn btn-success">
							</div>
						</div>
					</div>
				</div>
			</s:form>
		</div>


		<div class="well">
			<div>
				<div class="col-sm-4 col-md-4">
					<div class="form-group">
						<label> <b>Gasto total seleccionado (UF):</b>&nbsp;
						</label>
					</div>
				</div>
				<div class="col-sm-4 col-md-4">
					<div class="form-group">
						<input type="text" value="${total}" name="total" readonly="readonly" class="form-control" placeholder="Disabled input" />
					</div>
				</div>
				<div class="col-sm-4 col-md-4">
					<div class="form-group" align="right">
						<label><b>Mes Facturación: Septiembre 2016</b></label>
					</div>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="col-md-12">
				<div class="frmInsertar">

<!-- 					<div class="panel panel-success"> -->
<!-- 						<div class="panel-body"> -->
<!-- 							<div class="row"> -->
<!-- 								<div class="col-sm-4 col-md-4"> -->
<!-- 									<div class="form-group"> -->
<!-- 										<label for="numActivo"> <b>Gasto total seleccionado (UF):</b>&nbsp; -->
<!-- 										</label> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-4 col-md-4"> -->
<!-- 									<div class="form-group"> -->
<%-- 										<input type="text" value="${total}" name="total" readonly="readonly" class="form-control" placeholder="Disabled input" /> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-4 col-md-4"> -->
<!-- 									<div class="form-group" align="right"> -->
<!-- 										<label for="numActivo"><b>Mes Facturación: Septiembre 2016</b></label> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->





					<c:if test="${ver==1}">
						<s:form action="reporteActivoDetalle" name="unidadNegocio" enctype="multipart/form-data">


							<s:hidden name="unidadNegocio" value="" />
							<s:hidden name="param" value="" />
							<s:hidden name="numActivo" value="" />
							<s:hidden name="nomUsuario" value="" />
							<s:hidden name="centro" value="" />
							<display:table id="tabla" class="table table-striped table-hover" name="reporte" list="reporte" export="false"
								requestURI="reporteActivo">

								<display:column title="Serie Equipo" style="width:95px;" media="html">
									<center>
										<a href="javascript:void(0)" onclick="verDetalle('${tabla.id}')">${tabla.numeroActivo} </a>
									</center>
								</display:column>

								<display:column property="serieEquipo" title="Serie Equipo" style="width:180px; text-align:center;" media="excel" />
								<display:column property="descripcion" title="Descripción" style="width:180px; text-align:center;" />
								<display:column property="usuarioActivo" title="Usuario" style="width:180px; text-align:center;" />
								<display:column property="nomUbicacion" title="Ubicación" style="width:180px; text-align:center;" media="excel" />
								<display:column property="tipoEquipo" title="Tipo Equipo" style="width:180px; text-align:center;" media="excel" />
								<display:column property="serieMonitor" title="Serie Monitor" style="width:180px; text-align:center;" media="excel" />
								<display:column property="nombrePc" title="Nombre PC" style="width:180px; text-align:center;" media="excel" />
								<display:column property="centroCosto" title="Centro de Costo" style="width:180px; text-align:center;" />
								<display:column property="unidadNegocio" title="Unidad de Negocio" style="width:180px; text-align:center;" />
								<display:column property="tipoFinanciamiento" title="Tipo de Financiamiento" style="width:180px; text-align:center;" media="excel" />
								<display:column property="anexo" title="Anexo" style="width:180px; text-align:center;" media="excel" />
								<display:column property="fechaInicio" title="Fecha Inicio" style="width:180px; text-align:center;" media="excel" />
								<display:column property="fechaTermino" title="Fecha Término" style="width:180px; text-align:center;" media="excel" />

								<display:column property="estado" title="Estado" style="width:180px; text-align:center;" media="excel" />
								<display:column property="valorCuota" title="Valor Cuota UF" style="width:180px; text-align:center;" />
								<display:column title="Ver Trazabilidad" media="html">
									<center>
										<a href="verTraza?param=${tabla.id}">Trazabilidad</a>
									</center>
								</display:column>
									<display:column title="Acción" media="html">
									<center>
										<a href="Actualizar?param=update&numActivo=${tabla.id}">Editar</a>
									</center>
								</display:column>

								<display:setProperty name="export.csv" value="false"></display:setProperty>
								<display:setProperty name="export.pdf" value="false"></display:setProperty>
								<display:setProperty name="export.excel.filename" value="Listado_Activos.xls" />
								<display:setProperty name="export.xml" value="false" />
								<display:setProperty name="export.pdf.filename" value="false" />



							</display:table>
						</s:form>


					</c:if>



				</div>
			</div>

		</div>



	</div></body>
</html>