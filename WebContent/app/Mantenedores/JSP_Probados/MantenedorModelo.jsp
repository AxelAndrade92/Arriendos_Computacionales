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
<title>Ingreso Marca/Modelos</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var miTabla;
var SelectMarca;
var SelectTipo;

function llenarTabla(){
	var data = {};
	  //$('tbody').empty();
	  miTabla.clear();
	  /* console.log('Pasando por el change');
	  var Empresa = $('#SelectEmpresa').find(':selected').text();
	  var Uen = $('#SelectUen').find(':selected').text();
	  var idUen = $('#SelectUen').find(':selected').val();
	  data['idUen'] = idUen; */
		 $("#tabla").show();
		var tabla;
			  $.ajax({
		          url: 'Json/ModelosJson', // url where to submit the request
		          type : "POST", // type of action POST || GET
	              dataType : 'json', // data type
	              contentType: 'application/json',
		          data : JSON.stringify(data),
		          success : function(result) {
			        if(result.busquedaModelos.length != 0){
		        	  for (var i=0;i<result.busquedaModelos.length;i++){
			        	  miTabla.row.add([
			        			  result.busquedaModelos[i][0],	
			        			  result.busquedaModelos[i][1],
			        			  result.busquedaModelos[i][2],
			        			  result.busquedaModelos[i][3],
			        			  result.busquedaModelos[i][4]
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

function marcasDisponibles(){
	  /*
	  * Se carga el primer SelectMarca a través de una petición Ajax
	  */
	  $.ajax({
         url: 'Json/MarcasDisponibles', // url where to submit the request
         type : "GET", // type of action POST || GET
         success : function(result) {
       	  var option = '';
       	  
       	  for (var i=0;i<result.marcas.length;i++){
       	     option = '<option value="'+ result.marcas[i].idMarca + '">' + result.marcas[i].nombreMarca + '</option>';
       	     SelectMarca.append(option);
       	  }
       	  SelectMarca = $('#SelectMarca');
       	  SelectTipo = $('#SelectTipo');
         },
         error: function(xhr, resp, text) {
             console.log(xhr, resp, text);
         }
     })
}

$(document).ready(function() {
	//miTabla = $('#tabla').DataTable();
	miTabla = $('#tabla').DataTable({
	    "columnDefs": [
	                   {"className": "dt-center", "targets": "_all"}
	                 ]
	             });
	SelectMarca = $('#SelectMarca');
	SelectTipo = $('#SelectTipo');
	marcasDisponibles();
    llenarTabla();  
	  /*
	  * Se carga el primer SelectEmpresa a través de una petición Ajax
	  */
	  $.ajax({
          url: 'Json/TipoActivosDisponibles', // url where to submit the request
          type : "GET", // type of action POST || GET
          success : function(result) {
        	  var option = '';
        	  
        	  for (var i=0;i<result.tipos.length;i++){
        	     option = '<option value="'+ result.tipos[i].id + '">' + result.tipos[i].tipoActivo + '</option>';
        	     SelectTipo.append(option);
        	  }
        	  SelectMarca = $('#SelectMarca');
        	  SelectTipo = $('#SelectTipo');
          },
          error: function(xhr, resp, text) {
              console.log(xhr, resp, text);
          }
      })	  
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
				var modeloBean = {};
				modeloBean['id'] = '0';
				modeloBean['descripcion'] = $('#nombreModelo').val();
				modeloBean['idMarca'] = $(SelectMarca).find(':selected').val();
				modeloBean['idTipo'] = $(SelectTipo).find(':selected').val();
				modeloBean['numeroProducto'] = $('#numeroProductoModelo').val();
				data['modeloBean'] = modeloBean;
				
				$.ajax({
                url: 'ModeloInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
    				$('#nombreModelo').val('');
    				$('#SelectMarca').empty();
    				marcasDisponibles();
                },
                error: function(xhr, resp, text) {
                    console.log(xhr, resp, text);
                }
            })
			}
		});
		}
	
		}


	function insertarMarca(){
		
		if ($('#nombreMarca').val() != '') {
		jConfirm('Seguro que desea continuar?', 'Confirmación', function(r) {
			if (r) {
				var data = {};
				var marcaBean = {};
				marcaBean['id'] = '0';
				marcaBean['nombreMarca'] = $('#nombreMarca').val();
				data['marcaBean'] = marcaBean;
				data['marcaBean'] = marcaBean;
				
				$.ajax({
                url: 'MarcaInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
    				$('#nombreMarca').val('');
                },
                error: function(xhr, resp, text) {
                    console.log(xhr, resp, text);
                }
            })
			}
		});
		}
	
		}	
	
	function validar() {
		
		var mensaje = "";
		var verificar = 0;
		var control = true;
		
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if ($('#nombreModelo').val() == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre del Modelo  <br> ";
			control = false;
		}

		if ($('#numeroProductoModelo').val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Número de Producto  <br> ";
			control = false;
		}

		if ($(SelectMarca).find(':selected').text() == "--- Seleccione ---" || $(SelectMarca).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Marca  <br> ";
			control = false;
		}

		if ($(SelectTipo).find(':selected').text() == "--- Seleccione ---" || $(SelectTipo).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Tipo  <br> ";
			control = false;
		}
	
		if (control) {
	
			return control;
		} else {
	
			$("#texto").html(mensaje);
			$("#levantarModal").click();
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
		  letras = " áéíóúabcdefghijklmnñopqrstuvwxyzÁÉÍÓÚABCDEFGHIJKLMNÑOPQRSTUVWXYZ0123456789";//Se define todo el abecedario que se quiere que se muestre.
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

	function funcionModalMarca() {
	    $("#levantarModalMarca").click();             
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
		
		<s:form action="" name="Insertar" method="POST" autocomplete="off" id="SucursalInsertar"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Mantenedor de Marcas/Modelos</div>
					<div class="panel-body">
						<div class="row">
						<div class="row">
							<div class="col-sm-3 col-md-3">
									<div class="form-group">
										<a href="#"	title="Aqui debes seleccionar la marca"><span
											class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
										<label for="SelectMarca">Marca:&nbsp;</label>
									</div>
								</div>
									<div class="col-sm-3 col-md-3">
									<div class="form-group" >
											<select id="SelectMarca" class="form-control">
											  <option value="0" selected>--- Seleccione ---</option>
									        </select> 
									</div>
								</div>
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes seleccionar el tipo"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectTipo">Tipo:&nbsp;</label>
								</div>
							</div>
								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
										<select id="SelectTipo" class="form-control">
										  <option value="0" selected>--- Seleccione ---</option>
								        </select> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aquí debes ingresar el nombre del Modelo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="nombreModelo">Modelo:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreModelo"
										name="nombreModelo" value="" maxlength="40" onkeypress="return soloLetrasNumeros(event)"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aquí debes ingresar el número de producto">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="numeroProductoModelo">Número de Producto:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="numeroProductoModelo"
										name="numeroProductoModelo" value="" maxlength="40" onkeypress="return soloLetrasNumeros(event)"/> 
								</div>
							</div>
						</div>
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Modelo"
									onclick="insertar()" class="btn btn-success">&nbsp;
							</div>
								
						</div>
						
						
							
						
						
						
					</div>
				</div>
			</s:form>
			
			<button type="button" value="" data-toggle="modal"
								data-target="#myModalMarca" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Ingresar Marca
								</button>
			
			
		<!-- ****************************************************************************************** --> 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
		
				<table class="table table-hover table-bordered table-condensed" id="tabla">
				<thead><tr><th>ID</th><th>Modelo</th><th>Número de producto</th><th>Marca</th><th>Tipo</th></tr></thead>
				<tbody>
				</tbody>
				
				</table>
			</div>
		</div>
		</div>
		</div>		
	<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal" style="display: none;"></button>
		
		<button type="button" id="levantarModalInsert" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal2" style="display: none;"></button>
		
		<button type="button" id="levantarModalMarca" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalMarca" style="display: none;"></button>
		
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
	
	<div class="modal fade" id="myModalMarca" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header-warning">

					<h3>
						<i class="glyphicon glyphicon-exclamation-sign"></i>&nbsp;Ingresa una nueva marca
					</h3>
				</div>
				<div class="modal-body">
					<div class="row">
									
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Marca:</label>
									<%-- <div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="nombreMarca"  id="nombreMarca" value=""
												class="form-control" onkeypress="return soloLetrasNumeros(event)"/>
										</div>

									</div> --%>
									<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="nombreMarca" maxlength="40"
													value="" id="nombreMarca" size="10" class="form-control" onkeypress="return soloLetrasNumeros(event)"/>



											</div>

										</div>
								</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-lg" data-dismiss="modal"
								onclick="insertarMarca()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Guardar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg" id="cerrarModalMarca"
								data-dismiss="modal">
								<span class="glyphicons glyphicons-remove"></span>&nbsp;Cerrar
							</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
	</div> 
</body>
</html>
