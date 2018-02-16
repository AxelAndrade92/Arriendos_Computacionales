<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
td ,a{
text-align:center;
}
</style>
<script>
$(document).ready(function() {
	
	  
   /*  $("#mitabla").hide(); */
		$('#miTabla tbody').on( 'click', 'tr', function () {
				    filaTabla = miTabla.row( this ).data();
				    console.log(filaTabla);
				    $$("#numero_PiezaUP").val(filaTabla[0]);
				    $("#nombre_PiezaUP").val(filaTabla[1]);
				    
				} );

});
function insertar(){
if (validar()){
	jConfirm('Seguro que desea continuar?','Confirmación', function(r){
		if(r){
			var data ={};
			var piezas ={};

			piezas['PartesPiezas'] = document.Piezas.nombre_pieza.value;
			data['partesBean'] = piezas;

			$.ajax({
				url: 'insercion_piezas',
				type: "POST",
				dataType: 'json',
				contentType: 'application/json',
				data: JSON.stringify(data),
				success: function(result){
					alert(result);

					},
					error: function(xhr,resp,text){

					}
				})

			}
	})
}
	
}

function buscar(){
	var miTabla = $('#miTabla').DataTable({
	    "columnDefs": [
	                   {"className": "dt-center", "targets": "_all"}
	                 ]
	             });
	miTabla.clear().draw();
	var data = {};
	var piezas = {};
	/* piezas['id'] = 0; */
	piezas['partesPiezas'] = document.Piezas.nombre_pieza.value;
	data['partesBean'] = piezas;
	console.log(data);
	$.ajax({
		url:'Json/busqueda_piezas',
		type: "POST",
		dataType:'json',
		contentType: 'application/json',
		data:JSON.stringify(data),
		success: function(result){
			
			if(result.partes.length !=0){
				for(var i=0;i<result.partes.length;i++){
					miTabla.row.add([   
                                        result.partes[i].id,
										result.partes[i].partesPiezas,
										'<center><a onclick="funcionTabla();" class="distribuir"> <span class="glyphicon glyphicon-refresh" style="color:green;"></span></a></center>'
										]).draw(false);
					console.log(result);
					}
				}else{
					miTabla.clear().draw();
					}
				 // you can see the result from the console
	             // tab of the developer tools
	            //console.log(result);
			},
			error: function(xhr,resp,text){
				//console.log(xhr, resp, text);
				}

		})
	
	
	
	
}

function validar(){
	var mensaje = "";
	var verificar = 0;
	var control = true;

	var mensaje = "Favor ingresar los siguientes parametros : <br><br>";
	var verificar = 0;
	var control = true;


	if(document.Piezas.nombre_pieza.value == ""){
		mensaje +="<span class='glyphicon glyphicon-edit'></span>Nombre de Pieza <br>";
		control = false;
		}
	
	if (control) {
		
		return control;
	} else {

		$("#texto").html(mensaje);
		$("#levantarModal").click();
	}
}

function validarUpdate(){
	var mensaje = "Favor ingresar los siguientes parametros : <br><br>";
	var verificar = 0;
	var control = true;

	if(document.update_pieza.nombre_piezaup.value == ""){
		mensaje +="<span class='glyphicon glyphicon-edit'></span> Nombre de Pieza  <br> ";
		control =false;
		}

	if (control) {

		return control;
	} else {

		$("#texto").html(mensaje);
		$("#levantarModal").click();
	}
}

function update(){
	
	if(validarUpdate()){
		
		jConfirm('Seguro que desea continuar?','Confirmación', function(r){
			
				if(r){
					var data = {};
					var piezas = {};
					piezas['PartesPiezas'] = document.update_piezas.nombre_piezaup.value;
					data['PartesPiezasBean'] = piezas;

					$.ajax({
						url: 'update_piezas',
						type: "POST",
						dataType: 'json',
						contentType: 'application/json',
						data:JSON.stringify(data),
						success:function(result){
							 // you can see the result from the console
		                    // tab of the developer tools
		                    //console.log(result);
							},
							error:function(xhr,resp,text){
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

	if (document.Piezas.mensaje.value != "") {
		$("#texto2").html($("#mensaje").val());
		$("#levantarModalInsert").click();

	}
}

function miTabla(){
	$('a.distribuir').click(function(){
		
		var nomPza = $(this).parents("tr").find("td").eq(0).html();  
		$("#nombre_piezaup").val(nomPza);
		
		$("#levantarModalUpdate").click();
		});
}

</script>
<title>Mantenedor de Partes y Piezas</title>
</head>
<body onload="levantar();" background="recursos/image/fondo.jpg">

<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" /> Portal de Renovaciones

			</div>
		</div>
		
		<s:form action="insercion_piezas" name="Piezas" method="POST" autocomplete="off"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Mantenedor de Partes y Piezas</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar Nombre de la Pieza">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="nombre_pieza">Nombre de Parte o Pieza:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2"
										name="nombre_pieza" value="${nombre_pieza}" maxlength="30"/> 
								</div>
							</div>
							
							
						</div>
						<br>
						
						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Registro"
									onclick="insertar();" class="btn btn-success">&nbsp;
									
									<input type="button" value="Buscar Activo"
									onclick="buscar();" class="btn btn-success">&nbsp;
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
			
		
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive" >
			<table id="miTabla"  class="table table-hover table-bordered table-condensed">
			<thead><tr><th>Nº ID</th><th>Nombre de Pieza</th><th>Actualizar</th></tr></thead>
				<tbody>
				</tbody>
			</table>	
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

				<s:form action="update_piezas" name="update_piezas">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar Empresa
							</h3>
						</div>
						<div class="modal-body">
						
						
							<div class="row">
							<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">ID Pieza:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="numero_PiezaUP" size="13" id="numero_PiezaUP" value=""
												class="form-control"  readonly="readonly" />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
									<label  class="col-sm-4 control-label"
										style="text-align: right;">Nombre de Pieza:</label>
									<div class="col-sm-8 col-md-8">
										<div class="input-group">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-barcode"></span>
											</div>
																						
												<input name="nombre_piezaup" size="13" id="nombre_piezaup" value=""
												class="form-control"  readonly="readonly" />
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
		
<script type="text/javascript">
function funcionTabla() {
    $("#levantarModalUpdate").click();             // The function returns the product of p1 and p2
	}
</script>

</body>
</html>