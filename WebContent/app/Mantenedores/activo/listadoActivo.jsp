<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />





<title>Mantenedor de Activo</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
	
</script>
</head>
<body onload="levantar()" background="recursos/image/fondo2.jpg">


	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> <h1 style="background-color: #fc8d00">Portal de Renovaciones</h1>

			</div>
		</div>

		

		
			<s:form action="ccu" name="frmActivo" method="POST"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Búsqueda de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="La serie del computador, se encuentra por lo general en la parte trasera del computador o bajo la batería del mismo. La sigla como figura esta información es: Serial, S/N o Serie">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numActivo">Número de Serie
										computador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="numActivo" value="${numActivo}" maxlength="12"/> <a
										class="serie" href="#"> <span
										class="glyphicon glyphicon-picture" aria-hidden="true"></span>
										<img class="imagen" src="recursos/image/serial.jpg">
									</a>
								</div>
							</div>



							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Tu usuario de red, es la información con la cual tu inicias sesión dentro de la compañía. También es el mismo usuario que se encuentra en tu correo, siendo este todo lo que se encuentra a la izquierda de la @"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="nomUsuario">Nombre de Usuario:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="nomUsuario" value="${nomUsuario}"
										onkeypress="return soloLetras(event);" maxlength="25" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Correo electrónico que se ingresará a la consulta"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">Correo Electrónico:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="correo" value="${correo}"/>

								</div>
							</div>


							<div class="col-sm-3 col-md-3">
								<a href="#" title="Fono que se ingresará en la consulta"><span
									class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
								<label for="centro">Fono:&nbsp;</label>

							</div>

							<div class="col-sm-3 col-md-3">
								<input type="text" class="form-control" id="exampleInputName2"
									name="fono" value="${fono}"  maxlength="9" onkeypress="return isNumberKey(event)"/>

							</div>
						</div>

						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta es la Unidad de Negocios a la cual te encuentras trabajando"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="unidadNegocio">UEN:&nbsp;</label>

								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<s:select headerKey="0" headerValue="Todas"
										name="unidadNegocio" id="lstReporte" list="reporteUEN"
										listKey="unidadNegocio" listValue="unidadNegocio"
										theme="simple" class="form-control" />

								</div>
							</div>


							<div class="col-sm-3 col-md-3"></div>

							<div class="col-sm-3 col-md-3"></div>
						</div>


						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Consultar Renovación"
									onclick="buscar()" class="btn btn-success">&nbsp;
							
								
							
							</div>
						</div>
					</div>
				</div>
			</s:form>
	
	
		</div>
	
	<div class="modal fade" id="myModalInsert" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			data-backdrop="static">
			<div class="modal-dialog modal-lg">

				<s:form action="ccu-admin" name="agregarActivo">
		
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Ingresar Activo
							</h3>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">N° de serie:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="numParteNew" size="13" id="numParteNew" value=""
												class="form-control"  />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">UEN:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-italic"></span>
											</div>
											
												
												<s:select headerKey="Todas" headerValue="Todas" name="reporteActivo.unidadNegocio" id="lstUEN" list="reporteUEN"
											listKey="unidadNegocio" listValue="unidadNegocio" theme="simple" value="%{unidadNegocio}" class="form-control" />
										
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">Nombre usuario:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-sound-5-1"></span>
											</div>
											
												<input name="nomUsuario" size="13" id="nomUsuario" value=""
												class="form-control"  />
										</div>

									</div>
								</div>

								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">Fono:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-usd"></span>
											</div>
										
												<input name="fono" size="13" id="fono" value=""
												class="form-control" onkeypress="return isNumberKey(event)" />
										</div>

									</div>
								</div>

							</div>

							<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label for="listaEstados" class="col-sm-4 control-label"
										style="text-align: right;">Correo:</label>
									<div class="col-sm-8 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
											<input name="correo" size="13" id="correo" value=""
												class="form-control"  />
										</div>
									</div>
								</div>
								<div class="form-group  col-sm-6 col-md-6">
									<label for="cliente" class="col-sm-4 control-label"
										style="text-align: right;">Rol:</label>
									<div class="col-sm-6 col-md-8">

										<div class="input-group">
											<span class="input-group-addon"><span
												class="glyphicons glyphicons-filter"></span></span>
									
												
												<s:select headerKey="Todas" headerValue="Todas" name="reporteActivo.nomRol" id="lstRol" list="lstRol"
											listKey="idRol" listValue="nomRol" theme="simple" value="" class="form-control" />
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="agregar()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg"
								onclick="limpiarCantidad()">
								<span class="glyphicon glyphicon-erase"></span>&nbsp;Limpiar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg"
								data-dismiss="modal">
								<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
							</button>
						</div>
						</div>
				</s:form>

			</div>
			<!-- /.modal-content -->
		</div>
	




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
	<button type="button" id="levantarModalInsert"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal3" style="display: none;"></button>


	<!-- Modal alerta datos -->

<div class="copyright">
  <div class="container">
    <div class="col-md-6">
    <p>Para mayor información del procedimiento descargar manual en siguiente <a href="uploadFile">LINK</a></p> 
    <p>© 2016 - Desing by ST-Computación</p> 
    </div>

  </div>
</div>
</body>
</html>