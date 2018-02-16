<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>



<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ingreso Activo</title>
<script>
	$(document).ready(function() {

		$('#datePicker').datepicker();
		$('#datePicker2').datepicker();
	});



	function ingresar(){

		if(validarDatos()){


			jConfirm('Seguro que desea continuar?', 'Confirmación', function (r) {
                if (r) {
                	document.frmActivo.param.value= "insert";
        			document.frmActivo.submit();

                }
            });

			
			
			}


		}
	

	function validarDatos(){

		var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
		var verificar = 0;
		var control = true;

		if (document.getElementById('descripcion').value == 0 ) {

			mensaje += "- Campo Descripci&oacute;n vac&iacute;o \n ";
			control = false;
		}


		if (document.getElementById('estado').value == 0 ) {

			mensaje += "- Campo Estado vac&iacute;o \n ";
			control = false;
		}

		if (document.getElementById('usuario').value == 0 ) {

			mensaje += "- Campo Usuario vac&iacute;o \n ";
			control = false;
		}


		if (document.getElementById('nomUsuario').value == 0 ) {

			mensaje += "- Campo Nombre de Usuario vac&iacute;o \n ";
			control = false;
		}
		
		
		if (document.getElementById('nomUbicacion').value == 0 ) {

			mensaje += "- Campo Nombre Ubicaci&oacute;n vac&iacute;o \n ";
			control = false;
		}


		if (document.getElementById('tipoEquipo').value == 0 ) {

			mensaje += "- Campo Tipo Equipo vac&iacute;o \n ";
			control = false;
		}


		if ($("#lstCC option:selected").val() == 0) {

			mensaje += "- Debe Seleccionar Centro de Costo \n ";
			control = false;
		}

		if (document.getElementById('serieEquipo').value == 0 ) {

			mensaje += "- Campo Serie Equipo vac&iacute;o \n ";
			control = false;
		}


		if ($("#lstUEN option:selected").val() == "Todas") {

			mensaje += "- Debe Seleccionar Unidad de Negocio \n ";
			control = false;
		}


		if (document.getElementById('tipoFinanciamiento').value == 0 ) {

			mensaje += "- Campo Tipo Financiamiento vac&iacute;o \n ";
			control = false;
		}	


		if (document.getElementById('marcaPc').value == 0 ) {

			mensaje += "- Campo Marca PC vac&iacute;o \n ";
			control = false;
		}	

		if (document.getElementById('valorCuota').value == 0 ) {

			mensaje += "- Campo Valor Cuota vac&iacute;o \n ";
			control = false;
		}	



		if (document.getElementById('anexo').value == 0 ) {

			mensaje += "- Campo Anexo vac&iacute;o \n ";
			control = false;
		}

		if (document.getElementById('datePicker').value == 0 ) {

			mensaje += "- Campo Inicio Contrato vac&iacute;o \n ";
			control = false;
		}	


		if (document.getElementById('datePicker2').value == 0 ) {

			mensaje += "- Campo Termino Contrato vac&iacute;o \n ";
			control = false;
		}	


		if (document.getElementById('cantCuota').value == 0 ) {

			mensaje += "- Campo Cantidad de Cuotas vac&iacute;o \n ";
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

			<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="color: #008000; text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" /> Reporte de Activos en Arriendo
				
			</div>
		</div>

		<div class="row centro" style="color: #008000; text-align: center; font-size: 12px">
			<div class="col-sm-4 col-md-12">
				
				Este sistema te permitirá visualizar el costo de arriendo de tu computador, valor e información de su renovación
				
			</div>
		</div>
   

		<div class="row centro">
			<div class="col-md-12">
				<div class="frmInsertar">
					<s:form action="insertActivo" name="frmActivo" method="POST">
					<input type="hidden" name="param" id="param" value="" />
					<div class="panel panel-success">
						<div class="panel-heading" align="center">Ingresar de Activo</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Descripción Activo:&nbsp;</label>
									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" id="descripcion" name="reporteActivo.descripcion" value="" size="35px">
									</div>
								</div>



								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Estado:&nbsp;</label>
									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" id="estado" name="reporteActivo.estado" value="">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Usuario del Activo:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" id="usuario" name="reporteActivo.usuario" value="">
									</div>
								</div>


								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label>Ubicación:&nbsp;</label>
									</div>

								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
									<input type="text" class="form-control" name="reporteActivo.codUbicacion" value="" id="nomUbicacion"> 
									</div>
								</div>
							</div>


							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Nombre de Usuario:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.nomUsuario" id="nomUsuario" value="">
									</div>
								</div>


								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label>Centro de Costos:&nbsp;</label>
									</div>

								</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
									<s:select headerKey="0" headerValue="Todas" name="reporteActivo.centroCosto" id="lstCC" list="reporteCentroCosto"
										listKey="centroCosto" listValue="centroCosto" theme="simple" value="%{centro}" class="form-control" />
								</div>
								</div>
							</div>





							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Nº de serie:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.serieEquipo" id="serieEquipo" value="">
									</div>
								</div>


								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label>Unidad de Negocio:&nbsp;</label>
									</div>

								</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
									<s:select headerKey="Todas" headerValue="Todas" name="reporteActivo.unidadNegocio" id="lstUEN" list="reporteUEN"
										listKey="unidadNegocio" listValue="unidadNegocio" theme="simple" value="%{unidadNegocio}" class="form-control" />
									</div>
								</div>
							</div>



							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Tipo de Financiamiento:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.tipoFinanciamiento" id="tipoFinanciamiento" value="">
									</div>
								</div>


								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="right">
									<label>Marca PC:&nbsp;</label>
								</div>
								</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" align="left">
									<input type="text" class="form-control" name="reporteActivo.marcaPc" id="marcaPc" value="">
								</div>
								</div>
							</div>




							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Valor Cuota UF:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.valorCuota" id="valorCuota" value="">
									</div>
								</div>


								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Tipo de Equipo:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.tipoEquipo" id="tipoEquipo" value="">
									</div>
								</div>
							</div>



							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Inicio Contrato:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">


										<div class="input-group input-append date" >
											<input type="text" class="form-control" name="reporteActivo.fechaInicio" id="datePicker"/> 
										</div>




									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Termino Contrato:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<div class="input-group input-append date" >
											<input type="text" class="form-control" name="reporteActivo.fechaTermino" id="datePicker2"/> 
										</div>
									</div>
								</div>

							</div>


							<div class="row">
								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Cantidad de Cuotas:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.cantCuota" id="cantCuota" value="">
									</div>
								</div>

								<div class="col-sm-3 col-md-3">
									<div class="form-group" align="right">
										<label>Anexo:&nbsp;</label>

									</div>
								</div>

								<div class="col-sm-3 col-md-3">
										<div class="form-group" align="left">
										<input type="text" class="form-control" name="reporteActivo.anexo" id="anexo" value="">
									</div>
								</div>

							</div>








							<div class="row">
								<div class="col-sm-12 col.md-12" align="center">
									<input value="Ingresar" onclick="ingresar();" type="button" class="btn btn-success">&nbsp; 
									<input value="Atrás" onclick="window.history.back();" type="button" class="btn btn-success">
								</div>
							</div>
						</div>
					</div>

					</s:form>

				</div>
			</div>

		</div>



	</div>

</body>
</html>