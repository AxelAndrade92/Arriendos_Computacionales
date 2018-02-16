<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mantenedor Activos</title>

<!-- CSS -->

<link rel="stylesheet" href="recursos/css/bootstrap.min.css">
<link rel="stylesheet" href="recursos/css/font-awesome.min.css">
<link rel="stylesheet" href="recursos/css/form-elements.css">
<link rel="stylesheet" href="recursos/css/style_login.css">
<link rel="stylesheet" type="text/css" href="recursos/css/jquery.alerts.css">

<script type="text/javascript" lang="javascript" src="recursos/js/jquery.js"></script>
<script type="text/javascript" lang="javascript" src="recursos/js/jquery.ui.draggable.js"></script>
<script type="text/javascript" lang="javascript" src="recursos/js/jquery.alerts.js"></script>



<script type="text/javascript" lang="javascript" src="recursos/js/jquery-1.10.2.js"></script>




<script src="recursos/js/scripts.js"></script>


<script type="text/javascript">
$(function() {

	control();





});


	function acceso() {
		if (validacion()) {
			var URLactual = window.location;
			document.login.urlPath.value = URLactual;
			document.login.submit();
		}
	}

	function validacion() {

		var mensaje = "Favor ingresar datos faltantes: \n ";
		var verificar = 0;
		var control = true;

		if (document.login.usuario.value == 0) {

			mensaje += "- Campo Usuario vac&iacute;o \n ";
			control = false;
		}

		if (document.login.password.value == 0) {

			mensaje += "- Campo Password vac&iacute;o \n ";
			control = false;
		}
		if (control) {

			return control;
		} else {
			jAlert(mensaje, 'Validaci\u00F3n De Campos');
		}
	}

	function control() {

		if (($("#mensaje").val() == null) == false) {

			if ($("#mensaje").val() != "") {
				jAlert($("#mensaje").val(), 'Informacion');
			}

		}

	}
</script>
<style type="text/css">
span {
	cursor: pointer;
}
</style>
</head>

<body background="recursos/image/fondo.jpg">

	<!-- Top content -->
	<div class="top-content">
		<s:form action="Mantenedor?param=login" name="login" method="POST">
			<input type="hidden" name="urlPath" value="" id="urlPath">
			<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
			<div class="inner-bg">
				<div class="container">
					<div class="row">
						<div class="col-sm-8 col-sm-offset-2 text"></div>
					</div>
					<div class="row centro">

					<div class="col-md-12" align="center">
					
							<div id="wrapper">
					

							<div class="inner col-md-4" align="center">
									<div class="panel panel-default">
										<div class="panel-heading">
											<img src="recursos/image/icono.png" width="100" height="96" />

										</div>
										<div class="panel-body">

											<div class="col-md-8 col-md-offset-2">
												<div class="form-group">
													<div class="input-group">
														<div class="input-group-addon success">
															<span class="glyphicon glyphicon-user"></span>
														</div>
														<input class="form-control" type="text" name="usuario" id="username" placeholder="Usuario" />
													</div>
												</div>
												<div class="form-group">
													<div class="input-group">
														<div class="input-group-addon success">
															<span class="glyphicon glyphicon-lock"></span>
														</div>
														<input class="form-control" type="password" name="password" id="password" placeholder="Contraseña" />
													</div>
												</div>
												
											
											</div>
										</div>
										<div class="panel-footer">
											<input type="submit" name="Entrar" class="btn btn-success" value="Entrar" id="Entrar" />
										</div>
									</div>
								
							</div>

						</div>


					</div>
			</div>

				</div>
			</div>
		</s:form>
	</div>








</body>

</html>