<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<s:include value="/ambiente/library/base.jsp"></s:include>
<title>Módulo de Despacho</title>
<script type="text/javascript">

var miTabla = $('#miTabla').DataTable();
var filaTabla;
var solicitudes=[];

function eliminarFila(item){
	var miTabla = $('#miTabla').DataTable();
	var filaTabla;
	var solicitudes=[];
	filaTabla = miTabla.row($(item).parents('tr')).index();
	miTabla.row($(item).parents('tr')).remove().draw();
	solicitudes.splice(filaTabla,1);
}

$(document).ready(function(){

	var SelectEmpresas = $('#SelectEmpresas');
	var SelectCourier = $('#SelectCourier');
	
	 $.ajax({
	        url: 'Json/CourierJson', // url where to submit the request
	        type : "POST", // type of action POST || GET
	        success : function(result) { 	                  
	      	  var option = '';	      	  
	      	console.log(result.courier.length);
			for (var i = 0; i < result.courier.length; i++) {
				option = '<option value="' + result.courier[i].id + '">' + result.courier[i].nombreCourier +'</option>';				
				SelectCourier.append(option);
			}	      	
	        },
	        error: function(xhr, resp, text) {
	            console.log(xhr, resp, text);
	        }
	    })
	    
	    
	    $.ajax({
	        url: 'Json/EmpresaJson', // url where to submit the request
	        type : "POST", // type of action POST || GET
	        success : function(result) { 	                  
	      	  var option = '';	      	  
	      	console.log(result.empresas.length);
			for (var i = 0; i < result.empresas.length; i++) {
				option = '<option value="' + result.empresas[i].id + '">' + result.empresas[i].nombre +'</option>';				
				SelectEmpresas.append(option);
			}	      	
	        },
	        error: function(xhr, resp, text) {
	            console.log(xhr, resp, text);
	        }
	    })	
		var SelectRegion = $('#SelectRegion');
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

	
});//fin document



/* $(document).on('click', '.borrar', function (event) {
    event.preventDefault();
    $(this).closest('tr').remove();
}); */


$( "#btn1" ).click(function() {
	
	

});


function cargaActivo(){
	
	var campo1;
	var campo2;

	campo1 = $('#numero_despacho').val();
	campo2 = $('#numero_ot').val();
	

var miTabla = $('#miTabla').DataTable();
//miTabla.clear().draw();

var data = {};
var activos = {};

activos['num_producto'] = document.Despacho.numero_producto.value;
data['actbean'] = activos;

$.ajax({
	url : 'Json/busqueda_activos', // url where to submit the request
	type : "POST", // type of action POST || GET
	dataType : 'json', // data type
	contentType : 'application/json',
	data : JSON.stringify(data),
	success : function(result) {
		if (result.activos.length != 0) {
			for (var i = 0; i < result.activos.length; i++) {
				miTabla.row
						.add(
								[
								'<center>'+campo1+'</center>',
								'<center>'+campo2+'</center>',
								result.activos[i].id,
								result.activos[i].serie,
								result.activos[i].marca,
								result.activos[i].descr_modelo,
								result.activos[i].descripcion,
								result.activos[i].caracteristicas,
								result.activos[i].num_producto,
								result.activos[i].estadoOperacion,								
								'<center><input type="text" style="text-align:center" size=4 maxlength=3></input></center> ',
								'<center><a onClick="eliminarFila(this);" "><span class="glyphicon glyphicon-remove" style="color:green;"></span></a></center> '])
				.draw(false);
				}
		}else {
			miTabla.clear().draw();
		}		
	},
	error : function(xhr, resp, text) {
		
	}	
})
	
}

function insertar(){

	if (validar()) {

		//var array = [];
	    /* Obtenemos todos los tr del Body*/
	    //var rowsBody= $("#miTabla").find('tbody > tr');
	    /* Obtenemos todos los th del Thead */
	    //var rowsHead= $("#miTabla").find('thead > tr > th');
	    
	    /* Iteramos sobre as filas del tbody*/
	    //for (var i = 0; i < rowsBody.length; i++) {
	        //var obj={};/* auxiliar*/
	        //for (var j = 0;j < rowsHead.length;j++) /*  Iteramos sobre los th de THead*/
	            /*Asignamos como clave el text del th del thead*/
	             /*Asignamos como Valor el text del tr del tbody*/
	            //obj[rowsHead[j].innerText] =  rowsBody[i].getElementsByTagName('td')[j].innerText;
	        
	        //array.push(obj);/* Añadimos al Array Principal*/
	    //}
	    //console.log(array);

	    $('#miTabla tr').each(function(){
	    	var array = [];
	    	var rowsBody= $("#miTabla").find('tbody > tr');
			var celdas = $(this).find('td');
			var obj={};
			
			for (var i = 0 ; i < rowsBody.length; i++){

				obj[rowsBody[i].getElementsByTagName('td')[i].innerText];
				array.push(obj);
				
			}
			console.log(array);
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
	
	if (document.Despacho.numero_despacho.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero de Despacho  <br> ";
		control = false;
	}
	
	if (document.Despacho.numero_ot.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero de Orden de Trabajo  <br> ";
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
	
	if (document.Despacho.direccion.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Dirección  <br> ";
		control = false;
	}

	if ($(SelectEmpresas).find(':selected').text() == "--- Seleccione ---") {
		
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresa  <br> ";
		control = false;
	}
	
	if (document.Despacho.numero_producto.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero de Producto  <br> ";
		control = false;
	}

	if (document.Despacho.solicita.value == "") {

		mensaje += "<span class='glyphicon glyphicon-edit'></span> Solicitante  <br> ";
		control = false;
	}

	if (document.Despacho.recibe.value == "") {

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

function valida_factura(){
	
	var data = {};
	var activos = {};
	
	activos['factura'] = document.Despacho.numero_despacho.value;
	data['actbean'] = activos;
	
}

</script>
</head>
<body background="recursos/image/fondo2.jpg">
<s:include value="/ambiente/menu/menuMantenedor.jsp" />
<div class="container">

<div class="row centro" style="text-align: center; font-size: 35px">
	<div class="col-sm-4 col-md-12">
	<input type="hidden" name="mensaje" id="mensaje"
		value="<s:property value="%{mensaje}" />" /> <h1 style="background-color: #fc8d00">Modulo de Despacho</h1>
	</div>
</div>


<form action="ingreso_despacho" name="Despacho" method="post" class="form-inline">
<input type="hidden" name="param" id="param" value="" />
<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
<div class="panel panel-success">
<div class="panel-heading" style="background-color: #fc8d00" align="center">Ingreso de Despacho</div>
<div class="panel-body">
<div class="row">

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="numero_despacho">Número de Despacho:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="numero_despacho" 
	      					name="numero_despacho" value="${numero_despacho}" maxlength="20"/> 
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="numero_ot">Orden de Trabajo:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="numero_ot" 
	      					name="numero_ot" value="${numero_ot}" maxlength="20"/> 
		</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="region">Región:&nbsp;</label>
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group" >
		<select id="SelectRegion" class="form-control">
					          <option value="0" selected>--- Seleccione ---</option>								        
		</select>									
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="comuna">Comuna:&nbsp;</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group" >
		<select id="SelectComuna" class="form-control">
					          <option value="0" selected>--- Seleccione ---</option>								        
		</select>									
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="direccion">Dirección:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="direccion" 
	      					name="direccion" value="${direccion}" maxlength="60"/> 
		</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="empresa">Empresa:&nbsp;</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group" >
		<select id="SelectEmpresas" class="form-control">
					          <option value="0" selected>--- Seleccione ---</option>								        
		</select>									
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="courier">Courier:&nbsp;</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group" >
		<select id="SelectCourier" class="form-control">
					          <option value="0" selected>--- Seleccione ---</option>								        
		</select>									
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="solicita">Solicita:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="solicita" 
	      					name=solicita value="${solicita}" maxlength="20" style="text-transform:uppercase"/> 
		</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="recibe">Recibe:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="recibe" 
	      					name=recibe value="${recibe}" maxlength="20" style="text-transform:uppercase"/> 
		</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#"	title="">
					<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
					</a> <label for="numero_producto">Numero de Producto:</label>
	</div>
</div>
<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<input type="text" class="form-control" id="numero_producto" 
	      					name="numero_producto" value="${numero_producto}" maxlength="20" style="text-transform:uppercase"/> 
		</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<a href="#" title="Aqui debes ingresar algunas observaciones">
			<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
		</a> <label for="observaciones">Observaciones:&nbsp;</label>
	</div>
</div>

<div class="col-sm-3 col-md-3">
	<div class="form-group">
		<textarea id="comentarios" maxlength="140" rows="5" cols="26" placeholder="Escribe tus Comentarios"></textarea>
	</div>
</div>

<div class="row">
	<div class="col-sm-12 col.md-6" align="center">
		<input type="button" value="Ingresar Despacho"  style="background-color: #fc8d00" onclick="insertar();" class="btn btn-success">&nbsp;
		<input type="button" value="Buscar Activo" id="btn1" style="background-color: #fc8d00" onclick="cargaActivo();"	class="btn btn-success">&nbsp;		
	</div>
</div>


</div>
</div>
</div>
</form>
<div class="panel panel-success">

<div class="panel-body" style="margin: 6px;">
<div class="row">

<div class="table-responsive">
	<table id="miTabla" class="table table-hover table-bordered table-condensed" style="text-align:center">
		<thead>
			<tr>
				<th>Nº Despacho</th>
				<th>Nº O.T.</th>
				<th>Nº ID</th>
				<th>Serie PC/NB</th>
				<th>Marca</th>
				<th>Modelo</th>	
				<th>Tipo</th>
				<th>Caracteristicas</th>
				<th>Part Number</th>
				<th>Estado Equipo</th>
				<th>Cantidad</th>
				<th>Eliminar</th>
			</tr>
		</thead>
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
		
		
		
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
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
				<button type="button" class="btn btn-default btn-lg" data-dismiss="modal">
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