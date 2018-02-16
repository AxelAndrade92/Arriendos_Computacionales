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

<script type="text/javascript">

function consultar(){

	if (validar()) {
	
	console.log("Pasando por consultar");
	console.log($('#numActivo').val());
	
var miTabla = $('#miTabla').DataTable();

var data = {};
var consulta = {};

consulta['serie'] = document.consulta_activo.numActivo.value;
data['cb'] =  consulta;

$.ajax({
	url : 'Json/Consulta_serie_activo', // url where to submit the request
	type : "POST", // type of action POST || GET
	dataType : 'json', // data type
	contentType : 'application/json',
	data : JSON.stringify(data),
	success : function(result) {
		if (result.consulta.length != 0) {			
			for (var i = 0; i < result.consulta.length; i++) {
				miTabla.row
						.add(
								[											
								result.consulta[i].nombre,
								result.consulta[i].apellido,
								result.consulta[i].rol,
								result.consulta[i].serie,
								result.consulta[i].modelo,
								result.consulta[i].fechainicio,
								result.consulta[i].fono
								])
								.draw(false);
				}
		}else {	
						
			var mensaje = "El número de serie no encuentra resultado, será contactado por el equipo de renovación para evaluar su caso en las próximas 48 horas<br><br>";
			$("#texto").html(mensaje);
			$("#levantarModal").click();	
			miTabla.clear().draw();
		}		
	},
	error : function(xhr, resp, text) {
		
	}	
  })
 }
}

function validar() {
	
	var mensaje = "";
	var verificar = 0;
	var control = true;

	var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
	var verificar = 0;
	var control = true;
	
	if (document.consulta_activo.numActivo.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie <br> ";
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
<body  background="recursos/image/fondo2.jpg">


	<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje" 
					value="<s:property value="%{mensaje}" />" /> <h1 style="color: #fc8d00">Portal de Renovaciones </h1>

			</div>
		</div>

		

		
			<s:form action="consulta" name="consulta_activo" method="POST" autocomplete="off"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Búsqueda de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="La serie del computador, se encuentra por lo general en la parte trasera del computador o bajo la batería del mismo. La sigla como figura esta información es: Serial, S/N o Serie">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numActivo">Número de serie
										computador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="numActivo"
										name="numActivo" value="${numActivo}" maxlength="12"/> 
								</div>
							</div>

						</div>
					
						<br>
						<br>
						

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Consultar Serie" style="background-color: #fc8d00" 
									onclick="consultar()" class="btn btn-success">&nbsp;
								
								
							
							</div>
						</div>
					</div>
				</div>
			</s:form>
		<%-- <button type="button" value="" data-toggle="modal"
								data-target="#myModalInsert" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Ingresar Activo
								</button> --%>

							<br>
							<br>
		
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			<!-- usr_nomb1, apellpat, rol_descr, act_serie, modelo_descr , fechainicio, usr_fono -->

			<div class="table-responsive">
					<table id="miTabla" class="table table-hover table-bordered table-condensed" style="text-align:center">
						<thead>
							<tr>
								<th>Nombres</th>
								<th>Apellidos</th>
								<th>Rol</th>
								<th>Serie PC/NB</th>
								<th>Modelo PC/NB</th>
								<th>Fecha Instalación</th>	
								<th>Fono</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				
				
			<form action="ccu-admin1" name="excel" method="POST">
				<input type="hidden" name="numSerieExcel" id="numSerieExcel" value="<s:property value="%{numActivo}" />" />
				<input type="hidden" name="unidadNegocioExcel" id="unidadNegocioExcel" value="<s:property value="%{unidadNegocio}" />" />
				<input type="hidden" name="param" id="param" value="" />
					<button type="button" href="javascript:void(0)" onclick="crearExcel()" value=" Ingresar Reporte " class="btn btn-default btn-sm " style="outline: none;">
						<img alt="" src="recursos/image/excel.png" width="45"
									height="35">&nbsp; Exportar Excel
					</button>
				
			</form>
			

			</div>
		</div>
		</div>
		</div>
		
	
		</div>
		
		
		
			
		
		
		
		
	
	









		
	








	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog" style="color: #fc8d00">
			<div class="modal-content">
				<div class="modal-header-warning" >

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