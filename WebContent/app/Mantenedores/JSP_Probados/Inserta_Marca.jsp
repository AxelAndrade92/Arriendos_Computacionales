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
<title>Ingreso Marca / Modelo</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
$(document).ready(function() {
	  $("#idMarca").hide();


	  $('#lstUEN').on('change', function() {

		  if(this.value == 'OTRO'){

			  document.getElementById('oculto').style.display = 'block';

				
			  }else{

				  document.getElementById('oculto').style.display = 'none';

				  $("#UENnew").empty();
					
				  }
		 
		});


	  $('#lstModeloEquipo').on('change', function() {

		  if(this.value == 'ESPECIAL'){

			  document.getElementById('EspecialOculto').style.display = 'block';

				
			  }else{

				  document.getElementById('EspecialOculto').style.display = 'none';

				  $("#especialInsert").val("");	
					
				  }
		 
		});



	  $('#lstModeloEquipoUpdate').on('change', function() {

		  if(this.value == 'ESPECIAL'){

			  document.getElementById('EspecialOcultoUpdate').style.display = 'block';

				
			  }else{

				  document.getElementById('EspecialOcultoUpdate').style.display = 'none';

				  $("#especialUpdate").val("");	
					
				  }
		 
		});


	  $('#lstUENUpdate').on('change', function() {

		  if(this.value == 'OTRO'){

			  document.getElementById('oculto2').style.display = 'block';

				
			  }else{

				  document.getElementById('oculto2').style.display = 'none';

				  $("#UENupdate").val("");
					
				  }
		 
		});


		

	  
    $('a.distribuir').click(function(){

        var idm = $(this).parents("tr").find("td").eq(0).html();  
        var marcaActivo = $(this).parents("tr").find("td").eq(1).html();
        var modeloMarcaAct = $(this).parents("tr").find("td").eq(2).html();  
        
    
		
        $("#idMar").val(idm);
		  $("#marcaActivo").val(marcaActivo);
		  $("#modeloMarcaUpdate").val(modeloMarcaAct);
		 //console.log(idMa);

		/*if(modeloEquipo == ""){
			$("#lstModeloEquipoUpdate").val("0");
			}else{
				$("#lstModeloEquipoUpdate").val(modeloEquipo);
				}
		 */
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
	
				document.Marca.param.value = "insert";
				document.Marca.submit();
			}
		});
		}
	
		}
	function limpiarInsert(){
		document.Marca.idMarca.value == "";
		document.Marca.marcaActivo.value == "";
		document.Marca.modeloMarcaActivo.value == "";
		
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
	
		if (document.Marca.idMarca.value == "0") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero identificador  <br> ";
			control = false;
		}
	
		if (document.Marca.marcaActivo.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Marca  <br> ";
			control = false;
		}
	
	
		if (document.Marca.modeloMarcaActivo.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo Equipo  <br> ";
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

	
		if (document.Update_marca.marcaActivo.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Marca  <br> ";
			control = false;
		}
		
		
		if (document.Update_marca.modeloMarcaUpdate.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo  <br> ";
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

				//document.Update_marca.param.value = "update";
				document.Update_marca.submit();
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
		
		<s:form action="Insercion_marca" name="Marca" method="POST" autocomplete="off"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Mantenedor de Marca y Modelo</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar Numero identificador de la Marca">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="idMarca">Nº identificador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="idMarca" value="${idMarca}" maxlength="12"/> 
								</div>
							</div>
							
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar el Nombre de la Marca"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="marcaActivo">Marca:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="exampleInputName2"
										name="marcaActivo" value="${marca}" maxlength="12"/> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar el Modelo de la Marca"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="modeloMarcaActivo">Modelo:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="exampleInputName2"
										name="modeloMarcaActivo" value="${modelo}" maxlength="12"/> 
								</div>
							</div>


								
							
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Registro"
									onclick="insertar()" class="btn btn-success">&nbsp;
									
									<input type="button" value="Buscar Activo"
									onclick="buscar()" class="btn btn-success">&nbsp;
							</div>
							
				<!--		<div class="col-sm-12 col.md-12" display ="inline">
								
								
							</div>
						
						
						 <div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Limpiar"
									onclick="limpiarInsert()" class="btn btn-success">&nbsp;
							</div>
							 
							  -->	
						</div>
						
						
							
						
						
						
					</div>
				</div>
			</s:form>
			
		<!-- ****************************************************************************************** -->
	 <c:if test="${ver==1}"> 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">
               
				<display:table class="table table-hover table-bordered table-condensed" id="tabla" name="reporte" list="reporte"
					export="false" requestURI="">
					
					
					<display:column property="idmarca" title="Numero identificador" style="text-align:center;" />
					
					<display:column property="descrmarca" title="Nombre de Marca" style="text-align:center;" />
					
					<display:column property="modmarca" title="Modelo de Activo" style="text-align:center;" />
					
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
				
			</div>
		</div>
		</div>
		</div>
		</c:if>
		
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

				<s:form action="Update_marca" name="Update_marca">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Activo
							</h3>
						</div>
						<div class="modal-body">
						
						
									<div class="row">
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">N° identificador:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="idMar" size="13" id="idMar" value=""
												class="form-control"  readonly="readonly" />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Marca :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="marcaActivo" maxlength="10"
													value="" id="marcaActivo" size="10" class="form-control"/>



											</div>

										</div>
									</div>
									
									<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Modelo :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicons glyphicons-calendar"></span>
												</div>
												<input type="text" name="modeloMarcaUpdate" maxlength="20"
													value="" id="modeloMarcaUpdate" size="10" class="form-control"/>



											</div>

										</div>
									</div>
							</div>
													
						
							
							
							
									
							
							
							
							
							
							
							
								
							</div>
							

						
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg"
								onclick="update()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
							</button>
							&nbsp;
							<button type="button" class="btn btn-default btn-lg"
								onclick="limpiarUpdate()">
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
	
				
		<button type="button" id="levantarModalUpdate" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModalUpdate" style="display: none;"></button>	


</body>
</html>
