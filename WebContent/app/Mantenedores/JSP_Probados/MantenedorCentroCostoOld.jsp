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
<title>Ingreso Centro de Costos</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
$(document).ready(function() {
	var filaTabla;
	  $("#nombreSucursal").hide();
	  var miTabla = $('#tabla').DataTable();
	  $("#tabla").hide();
	  //Prueba
	  $('#tabla tbody').on( 'click', 'tr', function () {
		    filaTabla = miTabla.row( this ).data();
		    console.log(filaTabla);
			$("#idUpdate").val(filaTabla[0]);
		    $("#nombreUpdate").val(filaTabla[1]);
			$("#valorUpdate").val(filaTabla[2]);
		} );
		//Prueba
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
		  /*
			  * Se genera una función de escucha a los cambios en el select
			  * SelectUen
			  */
			  SelectUen.change(function(){
				  var data = {};
				  //$('tbody').empty();
				  $('#tabla').DataTable().clear();
				  console.log('Pasando por el change');
				  var Empresa = SelectEmpresa.find(':selected').text();
				  var Uen = SelectUen.find(':selected').text();
				  var idUen = SelectUen.find(':selected').val();
				  data['idUen'] = idUen;
				  //var th = '<thead><tr><th>ID</th><th>Nombre</th><th>Cuenta asociada</th><th>Empresa</th><th>UEN</th><th>Actualizar</th></tr></thead>';
				  //var tabla = '<table class="table table-hover table-bordered table-condensed" id="tabla">'+
					//'<thead><tr><th>ID</th><th>Nombre</th><th>Cuenta asociada</th><th>Empresa</th><th>UEN</th><th>Actualizar</th></tr></thead>'+
					//'<tbody>'; 
					 $("#tabla").show();
					var tabla;
				  $.ajax({
			          url: 'Json/CCJson', // url where to submit the request
			          type : "POST", // type of action POST || GET
		              dataType : 'json', // data type
		              contentType: 'application/json',
			          data : JSON.stringify(data),
			          success : function(result) {
				        if(result.ccs.length != 0){
			        	  for (var i=0;i<result.ccs.length;i++){
				        	  miTabla.row.add([
				        			  result.ccs[i].id,	
				        			  result.ccs[i].nombre,
				        			  result.ccs[i].valor,
				        			  Empresa,
				        			  Uen,
				        			  '<center><a onClick="funcionTabla()" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center>'
						      ]).draw(false);
			        		  /*tabla =+   
							    '<tr>'+
							      '<td>'+result.ccs[i].id+'</td>'+
							      '<td>'+result.ccs[i].nombre+'</td>'+
							      '<td>'+result.ccs[i].valor+'</td>'+
							      '<td>'+Empresa+'</td>'+
							      '<td>'+Uen+'</td>'+
							      '<td><center><a href="#" onclick="funcionTabla();" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center></td>'+
							    '</tr>';*/	  
			        	     }
				        }else{
							miTabla.clear().draw();
					    }   
			        	  //tabla =+ '</tbody></table>';
			        	   //  $('#tabla').append(tabla);
			        	    
			        	     //$('#tabla').DataTable().draw();
			        	  /*   $('a.distribuir').click(function(){

			        	     	var id = $(this).parents("tr").find("td").eq(0).html(); 
			        	         var nombre = $(this).parents("tr").find("td").eq(1).html(); /* 
			        	         var nombreEmpresa = $(this).parents("tr").find("td").eq(1).html();
			        	         var nombreUen = $(this).parents("tr").find("td").eq(2).html();
			        	         var nombreRegion = $(this).parents("tr").find("td").eq(3).html();
			        	         var nombreComuna = $(this).parents("tr").find("td").eq(4).html();*/
			        	 	/*	var direccion = $(this).parents("tr").find("td").eq(6).html();

			        	 		$("#sucursalId").val(id);
			        	         $("#sucursalNombre").val(nombre);
			        	 		$("#sucursalDireccion").val(direccion);
			        	 		
			        	         $("#levantarModalUpdate").click();
			        	      
			        	     });*/
			        	     
			          },
			          error: function(xhr, resp, text) {
			              console.log(xhr, resp, text);
			          }
			      })
				  
		    }); 
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
				var ccBean = {};
				ccBean['id'] = '0';
				ccBean['nombre'] = $('#nombreInsert').val();
				ccBean['valor'] = $('#valorInsert').val();
				ccBean['idUen'] = $(SelectUen).find(':selected').val();
				data['ccBean'] = ccBean;
				
				$.ajax({
                url: 'CentroCostoInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                    // you can see the result from the console
                    // tab of the developer tools
                	alert(result);
    				$('#nombreInsert').val('');
    				$("#valorInsert").val('');
    				$("#direccionInsert").val('');
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
		
		if ($('#nombreInsert').val() == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre del Centro de costos  <br> ";
			control = false;
		}
		
		if ($('#valorInsert').val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Cuenta asociada al Centro de costos  <br> ";
			control = false;
		}

		if ($(SelectUen).find(':selected').text() == "--- Seleccione ---" || $(SelectUen).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> UEN  <br> ";
			control = false;
		}

		if ($(SelectEmpresa).find(':selected').text() == "--- Seleccione ---" || $(SelectEmpresa).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresa  <br> ";
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
                    // you can see the result from the console
                    // tab of the developer tools
                    //console.log(result);
                	alert(result);
    				$('#nombreInsert').val('');
    				$("#direccionInsert").val('');
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
					<div class="panel-heading" align="center">Mantenedor de Centro de Costos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar el nombre del centro de costos">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="nombre">Nombre:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreInsert"
										name="nombre" value="" maxlength="40"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la cuenta asociada">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="valor">Cuenta asociada:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="valorInsert"
										name="valor" value="" maxlength="30"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la empresa de negocio"><span
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
								        </select> 
								</div>
							</div>
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Centro de Costos"
									onclick="insertar()" class="btn btn-success">&nbsp;
							</div>
								
						</div>
						
						
							
						
						
						
					</div>
				</div>
			</s:form>
			
		<!-- ****************************************************************************************** --> 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row" id="contenedorTabla">
		
				<table class="table table-hover table-bordered table-condensed" id="tabla">
				<thead><tr><th>ID</th><th>Nombre</th><th>Cuenta asociada</th><th>Empresa</th><th>UEN</th><th>Actualizar</th></tr></thead>
				<tbody>
				</tbody>
				<!--  <thead>
				    <tr>
				      <th>Firstname</th>
				      <th>Lastname</th>
				      <th>Email</th>
				    </tr>
				  </thead> 
				  <tbody>
				    <tr>
				      <td>John</td>
				      <td>Doe</td>
				      <td>john@example.com</td>
				    </tr>
				    <tr>
				      <td>Mary</td>
				      <td>Moe</td>
				      <td>mary@mail.com</td>
				    </tr>
				    <tr>
				      <td>July</td>
				      <td>Dooley</td>
				      <td>july@greatstuff.com</td>
				    </tr>
				    <tr>
				      <td>Anja</td>
				      <td>Ravendale</td>
				      <td>a_r@test.com</td>
				    </tr>
				  </tbody>-->
				</table>
               <!-- 
				<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="BusquedaSucursales" list="busquedaSucursales"
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
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Centro de Costos 
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
												<input type="text" name="idUpdate" maxlength="10"
													value="" id="idUpdate" size="10" class="form-control" readonly="readonly"/>



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
																						
												<input name="nombreUpdate" size="13" id="nombreUpdate" value=""
												class="form-control"/>
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Cuenta asociada :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="sucursalDireccion" maxlength="30"
													value="" id="valorUpdate" size="30" class="form-control"/>



											</div>

										</div>
									</div>
								</div>								
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="update()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Actualizar
							</button>
							&nbsp;
							<!-- <button type="button" class="btn btn-default btn-lg"
								onclick="limpiarUpdate()">
								<span class="glyphicon glyphicon-erase"></span>&nbsp;Limpiar
							</button>
							&nbsp; -->
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
	
				
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	

<script type="text/javascript">
function funcionTabla() {
    $("#levantarModalUpdate").click();             // The function returns the product of p1 and p2
	}
</script>
</body>
</html>
