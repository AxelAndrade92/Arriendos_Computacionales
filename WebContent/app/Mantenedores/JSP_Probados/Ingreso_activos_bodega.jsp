<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bodega</title>

<style type="text/css">

</style>

<script>
function insertar() {
	
	var SelectBodega = $('#SelectBodegas');
	var SelectProveedores = $('#SelectProveedores');
	var SelectReceptores = $('#SelectReceptores');
	var SelectEmpresa = $('#SelectEmpresa');
	
	if (validar()) {
		jConfirm(
				'Seguro que desea continuar?',
				'Confirmación',
				function(r) {
					if (r) {
						var data = {};
						var factura = {};

						factura['factura'] =  $('#factura').val();   //document.Bodega.factura.value;
						factura['orden'] =  $('#numero_compra').val();//document.Bodega.numero_compra.value;
						factura['fecha_recepcion'] = $('#AgendamientoFecha').val(); //document.Bodega.AgendamientoFecha.value;
						factura['proveedor'] = $(SelectProveedores).find(':selected').val();
						factura['receptor'] = $(SelectReceptores).find(':selected').val();
						factura['empresa'] = $(SelectEmpresa).find(':selected').val();						
						data['compra'] = factura;							
						       
						$.ajax({
							url : 'ingreso_compra', // url where to submit the request //Struts 
							type : "POST", // type of action POST || GET
							dataType : 'html', // data type
							contentType : 'application/json',
							data : JSON.stringify(data), // post data || get data
							success : function(result) {
								window.location.href =  "ingreso_detalle?factura="+$('#factura').val()+"&bodega="+$(SelectBodega).find(':selected').val()
								+"&empresa="+$(SelectEmpresa).find(':selected').val();
								
							},
							error : function(xhr, resp, text) {
								console.log(xhr, resp, text);
							}
						})
					}
				});
	}

}
	
$(document).ready(function(){

	$.datepicker.setDefaults($.datepicker.regional["es"]);
    $("#AgendamientoFecha").datepicker({
    firstDay: 1
    });
	
	var SelectBodega = $('#SelectBodegas');
	var SelectProveedores = $('#SelectProveedores');
	var SelectReceptores = $('#SelectReceptores');
	
/* 	$.ajax({
        url: 'Json/"BodegasJson"', // url where to submit the request
        type : "POST", // type of action POST || GET
        success : function(result) {
       
      	  var option = '';
      	  console.log(result.bodegabean.length);
      	  for (var i=0;i<result.bodegabean.length;i++){
      	     option = '<option value="'+ result.bodegabean[i].id + '">' + result.bodegabean[i].nombre + '</option>';
      	     
      	   SelectBodega.append(option);
      	  }
      	
        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
        }
    }) */

    $.ajax({
        url: 'Json/ProveedoresJson', // url where to submit the request
        type : "POST", // type of action POST || GET
        success : function(result) {
       
      	  var option = '';
      	  console.log(result.proveedorbean.length);
      	  for (var i=0;i<result.proveedorbean.length;i++){
      	     option = '<option value="'+ result.proveedorbean[i].id + '">' + result.proveedorbean[i].nombre + '</option>';
      	     
      	   SelectProveedores.append(option);
      	  }
      	
        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
        }
    })

     $.ajax({
        url: 'Json/ReceptoresJson', // url where to submit the request
        type : "POST", // type of action POST || GET
        success : function(result) {       
      	  var option = '';
      	console.log(result.receptorbean.length);
    	  for (var i=0;i<result.receptorbean.length;i++){
    	     option = '<option value="'+ result.receptorbean[i].id + '">' + result.receptorbean[i].nombre + '</option>';
    	     
    	   SelectReceptores.append(option);
    	  }
	      
      	
        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
        }
    })
   var SelectEmpresa = $('#SelectEmpresa');
    $.ajax({
        url: 'Json/EmpresaJson', // url where to submit the request
        type : "POST", // type of action POST || GET
        success : function(result) { 
                  
      	  var option = '';
      	  
      	console.log(result.empresas.length);
		for (var i = 0; i < result.empresas.length; i++) {
			option = '<option value="' + result.empresas[i].id + '">' + result.empresas[i].nombre +'</option>';
			
			SelectEmpresa.append(option);
		}
      	
        },
        error: function(xhr, resp, text) {
            console.log(xhr, resp, text);
        }
    })


});
function valida(e){
    tecla = (document.all) ? e.keyCode : e.which;

    //Tecla de retroceso para borrar, siempre la permite
    if (tecla==8){
        return true;
    }
        
    // Patron de entrada, en este caso solo acepta numeros
    patron =/[0-9]/;
    tecla_final = String.fromCharCode(tecla);
    return patron.test(tecla_final);
}

function validar() {

	var mensaje = "";
	var verificar = 0;
	var control = true;

	var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
	var verificar = 0;
	var control = true;

	var SelectBodega = $('#SelectBodegas');
	var SelectProveedores = $('#SelectProveedores');
	var SelectReceptores = $('#SelectReceptores');

	if (document.Bodega.factura.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero de Factura  <br> ";
		control = false;
	}

	if (document.Bodega.numero_compra.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero de Orden de Compra  <br> ";
		control = false;
	}

	if (document.Bodega.AgendamientoFecha.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Fecha de Recepción  <br> ";
		control = false;
	}
	
	if ($(SelectBodega).find(':selected').text() == "--- Seleccione ---") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Bodega  <br> ";
		control = false;
	}

	if ($(SelectProveedores).find(':selected').text() == "--- Seleccione ---") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Proveedores  <br> ";
		control = false;
	}

	if ($(SelectReceptores).find(':selected').text() == "--- Seleccione ---") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Receptor  <br> ";
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
<s:include value="/ambiente/library/base.jsp"></s:include>
</head>
<body background="recursos/image/fondo2.jpg">

<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> <h1 style="background-color: #fc8d00">Modulo de Bodega</h1>

			</div>
		</div>

		

		
			<s:form action="ingreso_activo" name="Bodega" method="POST"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Ingreso de activos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="factura">Número de Factura:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="factura" onkeypress="return valida(event)"
										name="factura" value="" maxlength="12"/> 
								</div>
							</div>



							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numero_compra">N° Orden de Compra :&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<div class="form-group">
										<input type="text" class="form-control" id="numero_compra" onkeypress="return valida(event)"
											name="numero_compra" value="${numero_compra}" maxlength="12"/> 
									</div>						

								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="bodega">Bodega :&nbsp;</label>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<div class="form-group">
									
										<select id="SelectBodegas" class="form-control">
								          <option value="122" selected>BODEGA ST-COMPUTACIÓN</option>								        
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="Proveedores">Proveedor :&nbsp;</label>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<div class="form-group">
									
										<select id="SelectProveedores" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="Receptores">Receptor :&nbsp;</label>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<div class="form-group">
									
										<select id="SelectReceptores" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="Empresas">Cliente :&nbsp;</label>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<div class="form-group">
									
										<select id="SelectEmpresa" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
										</select>
									</div>
								</div>
							</div>
							
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la fecha"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="AgendamientoFecha">Fecha Recepción:&nbsp;</label>
								</div>
							</div>	
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="AgendamientoFecha"
										name="AgendamientoFecha" value="" maxlength="12"/> 
								</div>
							</div>
						</div>
					

						

						<div class="row">
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Ingresar Activos" onclick="insertar()" style="background-color: #fc8d00"
									 class="btn btn-success">
							</div>
						</div>
					</div>
				</div>
			</s:form>
	<%-- 	<button type="button" value="" data-toggle="modal"
								data-target="#myModalInsert" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Ingresar Activo
								</button> --%>

							<br>
							<br>
		<%-- <c:if test="${ver==1}">
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">

				<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="reporte" list="reporte"
					export="false" requestURI="">
					
					<display:column property="modeloEquipo" title="Modelo Equipo" style="text-align:center;" />
					
					<display:column property="serieEquipo" title="N° de Serie" style="text-align:center;" />
					
					<display:column property="idUsuario" title="Usuario" style="text-align:center;" />
					
					<display:column property="usuarioEquipo" title="Nombre Usuario" style="text-align:center;" />
					
					<display:column property="centroCosto" title="CC" style="text-align:center;" />
									
					<display:column property="unidadNegocio" title="UEN" style="text-align:center;" />
					<display:column property="fonoUsuario" title="Fono" style="text-align:center;" />
					<display:column property="correoUsuario" title="Correo" style="text-align:center;" />
					<display:column property="fechaTermino" title="Fecha Término" style="text-align:center;" />
					<display:column property="nomRol" title="Rol" style="text-align:center;" />
					<display:column property="especial" title="Especial" style="text-align:center;" />
					<div style="display:none;">
					<display:column property="idRol" title=" id Rol" style="text-align:center;" class="hidden" headerClass="hidden" media="html"/>
					</div>
						<display:column title="Actualizar" media="html">
							<center>

								<a href="javascript:void(0)" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a>

							</center>
						</display:column>

				


					<display:setProperty name="export.csv" value="false"></display:setProperty>
					<display:setProperty name="export.pdf" value="false"></display:setProperty>
					<display:setProperty name="export.excel.filename" value="Listado_Activos.xls" />
					<display:setProperty name="export.xml" value="false" />
					<display:setProperty name="export.pdf.filename" value="false" />

				</display:table>
				
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
		</c:if> --%>
	
		</div>
		
		<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>

	<button type="button" id="levantarModalInsert"
		class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal2" style="display: none;"></button>


	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Falta
						por ingresar
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

</body>
</html>