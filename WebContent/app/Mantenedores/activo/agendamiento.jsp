<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">

.dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

}

</style>




<title>Mantenedor de Activo</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
	$(document).ready(function() {
		$('#tabla').DataTable();

		$("#datepicker").datepicker();
		
		$("#lstRegion").on("change", function(e) {
			id = $(this).val();
			
			
			$("#lstComuna").empty();
			$("#puntoInstalacion").empty();
			$("#solicitud").empty();
			
			e.preventDefault();
			$.getJSON("llamaLstComuna?region=" + id, function(j) {
				$.each(j.json, function(i, item) {

					$("#lstComuna").append("<option value=\""+item.idComuna+"\">" + item.nombreComuna + "</option>");

					i++;
				});
			});

		});



		$("#lstRegion").on("change", function(e) {
			id = $(this).val();
		
			e.preventDefault();
			$.getJSON("llamaPuntoInstalacion?region=" + id, function(j) {
				$.each(j.json, function(i, item) {

					$("#puntoInstalacion").val(item.punto);

					i++;
				});
			});

		});


		

	});


	function levantar(){
		
		if(document.frmActivo.mensaje.value !=""){
		$("#texto2").html($("#mensaje").val());
		$("#levantarModalInsert").click();

		}
	}

	function limpiar(){

		$("#lstRegion").val("0");
		$("#lstComuna").empty();
		$("#lstComuna").append("<option value='0'>Seleccione..</option>");
		$("#puntoInstalacion").val("");
		$("#listaHorario").val("0");
		$("#lstModeloEquipo").val("0");
		$("#listaUEN").val("0");
		$("#solicitud").val("");
		}

	function agendar(){

		if (validar()) {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {

				document.frmActivo.param.value = "agendar";
				document.frmActivo.submit();
				
			}
		});
		}

		}


	function validar() {

		var mensaje = "Validación de campos:  <br><br>";
		var verificar = 0;
		var control = true;

		if (document.frmActivo.region.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Región  <br> ";
			control = false;
		}

		if (document.frmActivo.comuna.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Comuna  <br> ";
			control = false;
		}


		if (document.frmActivo.horario.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Horario  <br> ";
			control = false;
		}


		if (document.frmActivo.unidadNegocio.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> UEN (Unidad de negocio)  <br> ";
			control = false;
		}

		if (document.frmActivo.modeloEquipo.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo de Equipo  <br> ";
			control = false;
		}


// 		if (document.frmActivo.solicitud.value == "0" || document.frmActivo.solicitud.value == "") {

// 			mensaje += "<span class='glyphicon glyphicon-edit'></span> Solicitudes  <br> ";
// 			control = false;
// 		}
		


		if (document.frmActivo.fechaAgenda.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Fecha Solicitud  <br> ";
			control = false;
		}


		if (document.frmActivo.punto.value == "0") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> No es posible realizar agendamiento ya que no existen puntos de instalación disponibles  <br> ";
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
</head>
<body onload="levantar()" background="recursos/image/fondo.jpg">


	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> Portal de Renovaciones

			</div>
		</div>

		

		
			<s:form action="agendar" name="frmActivo" method="POST"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Agendamiento</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								
								 <label for="numActivo">Región:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<s:select headerKey="0" headerValue="Seleccione.."
										name="region" id="lstRegion" list="lstRegion"
										listKey="idRegion" listValue="nomRegion"
										theme="simple" class="form-control" />
								</div>
							</div>



								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									
									<label for="unidadNegocio">Comuna:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<select name="comuna" id="lstComuna"  class="form-control">
									<option value="0">Seleccione...</option>
										</select>

								</div>
							</div>
						</div>
					
					
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								
								 <label for="numActivo">Puntos Instalación:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="puntoInstalacion"
										name="punto" value="" maxlength="12" readonly="readonly"/> 
								</div>
							</div>



								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									
									<label for="unidadNegocio">Horario:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								
													
								<s:select headerKey="0" headerValue="Seleccione.."
										name="horario" id="listaHorario" list="listaHorario"
										listKey="codigo" listValue="nombre"
										theme="simple" class="form-control" />

								</div>
							</div>
						</div>
						
						
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								
								 <label for="numActivo">UEN:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<s:select headerKey="0" headerValue="Seleccione.."
										name="unidadNegocio" id="listaUEN" list="reporteUEN"
										listKey="unidadNegocio" listValue="unidadNegocio"
										theme="simple" class="form-control" />
								</div>
							</div>



								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									
									<label for="unidadNegocio">Modelo Equipo:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<s:select headerKey="0" headerValue="Seleccione.."
										name="modeloEquipo" id="lstModeloEquipo" list="lstModeloEquipo"
										listKey="modeloEquipo" listValue="modeloEquipo"
										theme="simple" class="form-control" />

								</div>
							</div>
						</div>
						
						
										<div class="row">
					


<!-- 								<div class="col-sm-3 col-md-3"> -->
<!-- 								<div class="form-group"> -->
									
<!-- 									<label for="unidadNegocio">Solicitudes:&nbsp;</label> -->

<!-- 								</div> -->
<!-- 							</div> -->

<!-- 							<div class="col-sm-3 col-md-3"> -->
<!-- 								<div class="form-group" > -->
<!-- 									<input type="text" class="form-control" id="solicitud" -->
<!-- 										name="solicitud" value="" maxlength="12" onkeypress="return isNumberKey(event)"/>  -->

<!-- 								</div> -->
<!-- 							</div> -->
							
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									
									<label for="unidadNegocio">Fecha Solicitud:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" name="fechaAgenda" maxlength="10"
													value="" id="datepicker" size="10" class="form-control"/>


								</div>
							</div>
							
							
							
							
						</div>

						

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<button type="button" 
									onclick="agendar()" class="btn btn-success">
									<span class="glyphicon glyphicon-inbox"></span>
									&nbsp;Agendar
									</button>&nbsp;
								
								<button type="button" value="Limpiar"
									onclick="limpiar()" class="btn btn-success">
									<span class="glyphicon glyphicon-erase"></span>
									&nbsp;Limpiar
								</button>
							
							</div>
						</div>
					</div>
				</div>
			</s:form>
					
		<c:if test="${ver==1}">					
			<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">

				<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="reporte" list="reporte"
					export="true" requestURI="">
					
					<display:column property="modeloEquipo" title="Modelo Equipo" style="text-align:center;" />
					<display:column property="nomRegion" title="Región" style="text-align:center;" />
					<display:column property="nomComuna" title="Comuna" style="text-align:center;" />
					<display:column property="UEN" title="Unidad de Negocio" style="text-align:center;" />
					<display:column property="fechaAgenda" title="Fecha Agendamiento" style="text-align:center;" />
					
				
					<display:setProperty name="export.csv" value="false"></display:setProperty>
					<display:setProperty name="export.pdf" value="false"></display:setProperty>
					<display:setProperty name="export.excel.filename" value="Listado_Agenda.xls" />
					<display:setProperty name="export.xml" value="false" />
					<display:setProperty name="export.pdf.filename" value="false" />

				</display:table>
				
		
			

			</div>
		</div>
		</div>
		</div>					
							
	</c:if>
	
		</div>
		
		
		
			
		
		
		
		
	
	









	
	








	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
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
	<!-- /.modal -->


	<!-- Modal insertar datos -->
	<div class="modal fade" id="myModal3" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-info-sign"></i>&nbsp;Información
					</h3>
				</div>
				<div class="modal-body">
					<h4>
						<label id="texto2"></label>
					</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger btn-lg"
						data-dismiss="modal">
						<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
					</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->




		




	<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>
		
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	
		
		
	<button type="button" id="levantarModalInsert"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal3" style="display: none;"></button>


	<!-- Modal alerta datos -->

<div class="copyright">
  <div class="container">
    <div class="col-md-6">
      <p>© 2016 - Desing by ST-Computación</p>
    </div>

  </div>
</div>
</body>
</html>