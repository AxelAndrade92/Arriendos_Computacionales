<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">

.dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

}
</style>
<title>Ingreso Sucursales</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var filaTabla;
$("#nombreSucursal").hide();
var miTabla;

function funcionTabla() {
    $("#levantarModalUpdate").click();             
	}

function llenarTabla(){
	miTabla.clear().draw();
	var data = {};
	var fechaSeleccionada = $('#desde').val()+';'+$('#hasta').val();
	data['fechaSeleccionada'] = fechaSeleccionada;  
	$.ajax({
          url: 'Json/ListarSucursales', // url where to submit the request
          type : "POST", // type of action POST || GET
        dataType : 'json', // data type
        contentType: 'application/json',
          data : JSON.stringify(data),
          success : function(result) {
        	  if(result.busquedaSucursales.length != 0){
	        	  for (var i=0;i<result.busquedaSucursales.length;i++){
		        	  miTabla.row.add([
		        			  result.busquedaSucursales[i].id,	
		        			  result.busquedaSucursales[i].nombre,
		        			  result.busquedaSucursales[i].nombreEmpresa,
		        			  result.busquedaSucursales[i].nombreUen,
		        			  result.busquedaSucursales[i].nombreRegion,
		        			  result.busquedaSucursales[i].nombreComuna,		
		        			  result.busquedaSucursales[i].direccion,
		        			  //'<center><a onClick="" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center>'
		        			  '<center><a onClick="funcionTabla()" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center>'
				      ]).draw(false);
	        	     }
		        }else{
					miTabla.clear().draw();
			    }
          },
          error: function(xhr, resp, text) {
              console.log(xhr, resp, text);
          }
      })
	

}

$(document).ready(function() {
	var filaTabla;
	miTabla = $('#sucursales').DataTable({
	    "columnDefs": [
	                   {"className": "dt-center", "targets": "_all"}
	                 ]
	             });

	$('#sucursales tbody').on( 'click', 'tr', function () {
	    filaTabla = miTabla.row( this ).data();
	    console.log(filaTabla);
		$("#sucursalId").val(filaTabla[0]);
	    $("#sucursalNombre").val(filaTabla[1]);
		$("#sucursalDireccion").val(filaTabla[6]);
	} );
	
	  var SucursalInsertar = $("#SucursalInsertar");
	  var SelectRegion = $('#SelectRegion');
	  var SelectComuna = $('#SelectComuna');
	  var SelectEmpresa = $('#SelectEmpresa');
	  var SelectUen = $('#SelectUen');
	  var Regiones;
	  var Empresas;
	  var Comunas;
	  var Uenes;
	  /*
	  * Se carga el primer SelectRegion a través de una petición Ajax
	  */
	  $.ajax({
          url: 'Json/RegionJson', // url where to submit the request
          type : "GET", // type of action POST || GET
          success : function(result) {
        	  var option = '';
        	  console.log(result.regiones.length);
        	  for (var i=0;i<result.regiones.length;i++){
        	     option = '<option value="'+ result.regiones[i].id + '">' + result.regiones[i].descripcion + '</option>';
        	     SelectRegion.append(option);
        	  }
        	  SelectRegion = $('#SelectRegion');
        	  SelectComuna = $('#SelectComuna');
        	  SelectUen = $('#SelectUen');
        	  SelectEmpresa = $('#SelectEmpresa');	
          },
          error: function(xhr, resp, text) {
              console.log(xhr, resp, text);
          }
      })
      
	  /*
	  * Se carga el primer SelectEmpresa a través de una petición Ajax
	  */
	  $.ajax({
          url: 'Json/EmpresaJson', // url where to submit the request
          type : "GET", // type of action POST || GET
          success : function(result) {
        	  var option = '';
        	  console.log(result.empresas.length);
        	  for (var i=0;i<result.empresas.length;i++){
        	     option = '<option value="'+ result.empresas[i].id + '">' + result.empresas[i].nombre + '</option>';
        	     SelectEmpresa.append(option);
        	  }
        	  SelectRegion = $('#SelectRegion');
        	  SelectComuna = $('#SelectComuna');
        	  SelectUen = $('#SelectUen');	
        	  SelectEmpresa = $('#SelectEmpresa');
          },
          error: function(xhr, resp, text) {
              console.log(xhr, resp, text);
          }
      })	  
	  /*
	  * Se genera una función de escucha a los cambios en el select
	  * SelectRegion
	  */
	  SelectRegion.change(function(){
		  var data = {};
		  var idRegion = SelectRegion.find(':selected').val();
		  data['idRegion'] = idRegion;
		  $.ajax({
	          url: 'Json/ComunaJson', // url where to submit the request
	          type : "POST", // type of action POST || GET
              dataType : 'json', // data type
              contentType: 'application/json',
	          data : JSON.stringify(data),
	          success : function(result) {
		          SelectComuna.empty();
		          SelectComuna.append('<option value=0 selected>--- Selecciona ---</option>');
	        	  var option = '';
	        	  for (var i=0;i<result.comunas.length;i++){
	        	     option = '<option value="'+ result.comunas[i].id + '">' + result.comunas[i].nombre + '</option>';
	        	     SelectComuna.append(option);
	        	  }
	        	  SelectRegion = $('#SelectRegion');
	        	  SelectComuna = $('#SelectComuna');
	        	  SelectUen = $('#SelectUen');	
	        	  SelectEmpresa = $('#SelectEmpresa');
	          },
	          error: function(xhr, resp, text) {
	              console.log(xhr, resp, text);
	          }
	      })
		  
    });

	  	  /*
		  * Se genera una función de escucha a los cambios en el select
		  * SelectEmpresa
		  */
		  SelectEmpresa.change(function(){
			  var data = {};
			  var idEmpresa = SelectEmpresa.find(':selected').val();
			  data['idEmpresa'] = idEmpresa;
			  $.ajax({
		          url: 'Json/UenJson', // url where to submit the request
		          type : "POST", // type of action POST || GET
	              dataType : 'json', // data type
	              contentType: 'application/json',
		          data : JSON.stringify(data),
		          success : function(result) {
			          SelectUen.empty();
			          SelectUen.append('<option value=0 selected>--- Selecciona ---</option>');
		        	  var option = '';
		        	  for (var i=0;i<result.uenes.length;i++){
		        	     option = '<option value="'+ result.uenes[i].id + '">' + result.uenes[i].nombre + '</option>';
		        	     SelectUen.append(option);
		        	  }
		        	  SelectRegion = $('#SelectRegion');
		        	  SelectComuna = $('#SelectComuna');
		        	  SelectUen = $('#SelectUen');	
		          },
		          error: function(xhr, resp, text) {
		              console.log(xhr, resp, text);
		          }
		      })
			  
	    });    

		    llenarTabla();
    $('a.distribuir').click(function(){

    	var id = $(this).parents("tr").find("td").eq(0).html(); 
        var nombre = $(this).parents("tr").find("td").eq(1).html(); /* 
        var nombreEmpresa = $(this).parents("tr").find("td").eq(1).html();
        var nombreUen = $(this).parents("tr").find("td").eq(2).html();
        var nombreRegion = $(this).parents("tr").find("td").eq(3).html();
        var nombreComuna = $(this).parents("tr").find("td").eq(4).html();*/
		var direccion = $(this).parents("tr").find("td").eq(6).html();

		$("#sucursalId").val(id);
        $("#sucursalNombre").val(nombre);
		$("#sucursalDireccion").val(direccion);
		
        $("#levantarModalUpdate").click();
     
    });

	$('#tabla').DataTable();
	
});

	function aMays(e, elemento) {
		tecla=(document.all) ? e.keyCode : e.which; 
		 elemento.value = elemento.value.toUpperCase();
		}
	
	
	function insertar(){
	
		if (validar()) {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {
				var data = {};
				var sucursal = {};
				sucursal['id'] = '0';
				sucursal['nombre'] = document.SucursalInsertar.nombreSucursal.value;
				sucursal['region'] = $(SelectRegion).find(':selected').val();
				sucursal['comuna'] = $(SelectComuna).find(':selected').val();
				sucursal['uen'] = $(SelectUen).find(':selected').val();
				sucursal['idEmpresa'] = $(SelectEmpresa).find(':selected').val();
				sucursal['direccion'] = document.SucursalInsertar.direccionSucursal.value;
				data['sucursalBean'] = sucursal;
				
				
				$.ajax({
                url: 'SucursalInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result){
                    alert(result);
					$('#nombreSucursalInsert').val('');
					$('#direccionSucursalInsert').val('');
					$('#SelectComuna').empty();
					$('#SelectUen').empty();
					llenarTabla();
                    // you can see the result from the console
                    // tab of the developer tools
                    //console.log(result);
                },
                error: function(xhr, resp, text) {
                    //console.log(xhr, resp, text);
                }
            })
			}
		});
		}
	
		}
	function limpiarInsert(){
		document.Marca.nombreSucursal.value == "";
		document.Marca.sucursalEmpresa.value == "";
		document.Marca.direccionSucursal.value == "";
		
	}
	
	
	function buscar() {
			document.Marca.param.value = "buscar";
			document.Marca.submit();
	}
	
	
	
	
	function validar() {
		
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if (document.SucursalInsertar.nombreSucursal.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de la sucursal  <br> ";
			control = false;
		}

		if ($(SelectRegion).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Región  <br> ";
			control = false;
		}

		if ($(SelectComuna).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Comuna  <br> ";
			control = false;
		}

		if ($(SelectUen).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> UEN  <br> ";
			control = false;
		}

		if ($(SelectEmpresa).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresa  <br> ";
			control = false;
		}
		if (document.SucursalInsertar.direccionSucursal.value == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Dirección de la sucursal  <br> ";
			control = false;
		}
	
		if (control) {
	
			return control;
		} else {
	
			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}
	
	}
	function validarUpdate() {

		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;

	
		if (document.SucursalActualizar.sucursalNombre.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre  <br> ";
			control = false;
		}
		
		
		if (document.SucursalActualizar.sucursalDireccion.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Dirección  <br> ";
			control = false;
		}
		
		
		if (control) {

			return control;
		} else {

			$("#texto").html(mensaje);
			$("#levantarModal").click();
		}

	}
	
	function update(){

		if (validarUpdate()) {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {

				//document.SucursalActualizar.param.value = "update";
				//document.SucursalActualizar.submit();
				var data = {};
				var sucursal = {};
				sucursal['id'] = document.SucursalActualizar.sucursalId.value;
				sucursal['nombre'] = document.SucursalActualizar.sucursalNombre.value;
				sucursal['region'] = 0;
				sucursal['comuna'] = 0;
				sucursal['uen'] = 0;
				sucursal['idEmpresa'] = 0;
				sucursal['direccion'] = document.SucursalActualizar.sucursalDireccion.value;
				data['sucursalBean'] = sucursal;
				
				$.ajax({
                url: 'SucursalActualizar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                    alert(result);
                    llenarTabla();
                    // you can see the result from the console
                    // tab of the developer tools
                    //console.log(result);
                },
                error: function(xhr, resp, text) {
                    //console.log(xhr, resp, text);
                }
            })
			}
		});
		}

		}

	
	
	function soloLetras(e) {
	  key = e.keyCode || e.which;
	  tecla = String.fromCharCode(key).toString();
	  letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ";//Se define todo el abecedario que se quiere que se muestre.
	  especiales = [8, 37, 39, 46, 6]; //Es la validación del KeyCodes, que teclas recibe el campo de texto.
	
	  tecla_especial = false
	  for(var i in especiales) {
	      if(key == especiales[i]) {
	          tecla_especial = true;
	          break;
	      }
	  }
	
	  if(letras.indexOf(tecla) == -1 && !tecla_especial){
	
	      return false;
	    }
	}

	function soloLetrasNumeros(e) {
		  key = e.keyCode || e.which;
		  tecla = String.fromCharCode(key).toString();
		  letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ1234567890";//Se define todo el abecedario que se quiere que se muestre.
		  especiales = [8, 37, 39, 46, 6]; //Es la validación del KeyCodes, que teclas recibe el campo de texto.
		
		  tecla_especial = false
		  for(var i in especiales) {
		      if(key == especiales[i]) {
		          tecla_especial = true;
		          break;
		      }
		  }
		
		  if(letras.indexOf(tecla) == -1 && !tecla_especial){
		
		      return false;
		    }
		}
	
	function levantar() {

		if (document.Marca.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

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
		
		<s:form action="SucursalInsertar" name="SucursalInsertar" method="POST" autocomplete="off" id="SucursalInsertar"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Mantenedor de Sucursales</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aquí debes ingresar el nombre de la sucursal">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="nombreSucursal">Nombre:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreSucursalInsert"
										name="nombreSucursal" value="${nombreSucursal}" maxlength="50" onkeypress="return soloLetrasNumeros(event)"/> 
								</div>
							</div>
							
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes seleccionar la región"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectRegion">Región:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								        <select id="SelectRegion" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>
								        <!--    <option value="1">Región 1</option>
								          <option value="2">Región 2</option>
								          <option value="3">Región 3</option>-->
								        </select> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aquí debes seleccionar la comuna"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectComuna">Comuna:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
										<select id="SelectComuna" class="form-control">
									<!--  	  <option value="0" selected>--- Seleccione ---</option>
								          <option value="1">Comuna 1</option>
								          <option value="2">Comuna 2</option>
								          <option value="3">Comuna 3</option>-->
								        </select> 
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la unidad estratégica de negocio"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectEmpresa">Empresa:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
										<select id="SelectEmpresa" class="form-control">
										  <option value="0" selected>--- Seleccione ---</option>
								        </select> 
								</div>
							</div>
								
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la unidad estratégica de negocio"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectUen">UEN:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
										<select id="SelectUen" class="form-control">
										<!--    <option value="0" selected>--- Seleccione ---</option>
								          <option value="1">UEN 1</option>
								          <option value="2">UEN 2</option>
								          <option value="3">UEN 3</option>-->
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la dirección de la sucursal"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="direccionSucursal">Dirección:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="direccionSucursalInsert"
										name="direccionSucursal" value="${modelo}" maxlength="50" onkeypress="return soloLetrasNumeros(event)"/> 
								</div>
							</div>
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Sucursal"
									onclick="insertar()" class="btn btn-success">&nbsp;
									
								<!--  	<input type="button" value="Buscar"
									onclick="buscar()" class="btn btn-success">&nbsp;-->
							</div>
								
						</div>
						
						
							
						
						
						
					</div>
				</div>
			</s:form>
			
		<!-- ****************************************************************************************** --> 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">
               <table class="table table-hover table-bordered table-condensed" id="sucursales">
				<thead><tr><th>ID</th><th>Nombre</th><th>Empresa</th><th>UEN</th><th>Región</th><th>Comuna</th><th>Dirección</th><th>Actualizar</th></tr></thead>
				<tbody>
				</tbody>
				
				</table>
				<!--<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="BusquedaSucursales" list="busquedaSucursales"
					export="false" requestURI="">
					
					<display:column property="id" title="id" style="text-align:center;" />
					<display:column property="nombre" title="Nombre" style="text-align:center;" />
					<display:column property="nombreEmpresa" title="Empresa" style="text-align:center;" />
					<display:column property="nombreUen" title="Uen" style="text-align:center;" />
					<display:column property="nombreRegion" title="Región" style="text-align:center;" />
					<display:column property="nombreComuna" title="Numero identificador" style="text-align:center;" />
					<display:column property="direccion" title="Dirección" style="text-align:center;" />
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
				-->
			</div>
		</div>
		</div>
		</div>
		
		</div> 
		
	<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>
		
		<button type="button" id="levantarModalInsert" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal2" style="display: none;"></button>
		
		
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
	
	
	<!--  Modal informacion -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
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
						<label id="texto2"></label>
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
	
	<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			data-backdrop="static">
			<div class="modal-dialog modal-lg">

				<s:form action="SucursalActualizar" name="SucursalActualizar">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Sucursal 
							</h3>
						</div>
						<div class="modal-body">
						
						
								<div class="row">
									<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Id :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="sucursalId" maxlength="10"
													value="" id="sucursalId" size="10" class="form-control" readonly="readonly"/>



											</div>

										</div>
									</div>
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Nombre:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="sucursalNombre" size="13" id="sucursalNombre" value="" maxlength="50"
												class="form-control" onkeypress="return soloLetrasNumeros(event)"/>
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Dirección :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="sucursalDireccion" maxlength="50"
													value="" id="sucursalDireccion" size="40" class="form-control" onkeypress="return soloLetrasNumeros(event)"/>



											</div>

										</div>
									</div>
								</div>								
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg" data-dismiss="modal"
								onclick="update()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Actualizar
							</button>
							&nbsp;
							<!-- <button type="button" class="btn btn-default btn-lg"
								onclick="limpiarUpdate()">
								<span class="glyphicon glyphicon-erase"></span>&nbsp;Limpiar
							</button>
							&nbsp; -->
							<button type="button" class="btn btn-default btn-lg" id="cerrarModalUpdate"
								data-dismiss="modal">
								<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
							</button>
						</div>
						</div>
				</s:form>

			</div>
			<!-- /.modal-content -->
		</div>
	
				
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	


</body>
</html>
