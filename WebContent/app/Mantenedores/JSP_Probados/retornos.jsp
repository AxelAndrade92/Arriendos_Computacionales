<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<style type="text/css">

.dataTable td.hidden {

     display: none;

}

.dataTable th.hidden {

     display: none;

}
</style>
<title>Retornos</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var array;
function callback(data){
	array = data;
}

$(document).ready(function() {


	$("#serieInsert").keypress(function(e){

		if(e.which == 13) {
		
			var data = {};
			var activoBean = {};
			activoBean['serie'] = $('#serieInsert').val();
			data['activoBean'] = activoBean;
			
			$.ajax({
		    url: 'Json/RetornosPersonaPorRutActivoPorSerie', // url where to submit the request
		    type : "POST", // type of action POST || GET
		    dataType : 'json',//'json', // data type
		    contentType: 'application/json',
		    data : JSON.stringify(data), // post data || get data
		    success : function(result) {
		    if(result.personaBean != null & result.activoBean != null){
			    	$('#nombreapellido').val(result.personaBean.nombre+' '+result.personaBean.apellidoP);
					$("#idpersonaInsert").val(result.personaBean.id);
					$('#rut').val(result.personaBean.rutPer);
					$('#serieInsert').val(result.activoBean.serie);
					$('#idactivoInsert').val(result.activoBean.id);
 					$("#modelo").val(result.modelo[1]);
 					$("#marca").val(result.modelo[2]);
			    }else{
				    alert(result.mensaje);
				    $('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
					$('#serieInsert').val('');
					$('#idactivoInsert').val('');
 					$("#modelo").val('');
 					$("#marca").val('');
				    }
		    },
		    error: function(xhr, resp, text) {
		        console.log(xhr, resp, text);
		    }
		})  
		}else{
			return soloLetrasNumeros(event);
		}
	});     
	var SelectCausa = $('#SelectCausa'); 
	/*
	  * Se carga el primer SelectRegion a través de una petición Ajax
	  */
	  $.ajax({
         url: 'Json/CausasRetornosJson', // url where to submit the request
         type : "GET", // type of action POST || GET
         success : function(result) {
       	  var option = '';
       	  console.log(result.causas.length);
       	  for (var i=0;i<result.causas.length;i++){
       	     option = '<option value="'+ result.causas[i].id + '">' + result.causas[i].causa + '</option>';
       	     SelectCausa.append(option);
       	  }
       	 
         },
         error: function(xhr, resp, text) {
             console.log(xhr, resp, text);
         }
     })
	
    $('a.distribuir').click(function(){

    	var id = $(this).parents("tr").find("td").eq(0).html(); 
        var nombre = $(this).parents("tr").find("td").eq(1).html();
		var direccion = $(this).parents("tr").find("td").eq(6).html();

		$("#sucursalId").val(id);
        $("#sucursalNombre").val(nombre);
		$("#direccionSucursal").val(direccion);
		
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
				 var SelectCausa = $('#SelectCausa');
				var data = {};
				var retornoBean = {};
				var activoBean = {};
				
				retornoBean['id'] = '0';
				retornoBean['usuario'] = $('#idpersonaInsert').val();
				retornoBean['activo'] = $('#idactivoInsert').val();
				retornoBean['causa'] = $(SelectCausa).find(':selected').val();
				retornoBean['observacion'] = $('#observacionInsert').val();
				data['retornoBean'] = retornoBean;

				activoBean['serie'] = $('#serieInsert').val();
				data['activoBean'] = activoBean;
				
				$.ajax({
                url: 'RetornoInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html',//'json', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
				    $('#nombreapellido').val('');
					$("#idpersonaInsert").val('');
					$('#rut').val('');
					$('#serieInsert').val('');
					$('#idactivoInsert').val('');
 					$("#modelo").val('');
 					$("#marca").val('');
 					$("#observacionInsert").val('');
 					$("#SelectCausa").prop('selectedIndex',0);
                },
                error: function(xhr, resp, text) {
                    console.log(xhr, resp, text);
                }
            }) 
			}
		});
		}
	
		}
	function limpiarInsert(){
		document.Marca.nombre.value == "";
		document.Marca.sucursalEmpresa.value == "";
		$("#direccionSucursal").val("");
		
	}
	
	
	function buscar() {
			document.Marca.param.value = "buscar";
			document.Marca.submit();
	}
	
	
	
	
	function validar() {

		var SelectCausa = $('#SelectCausa');
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if ($('#serieInsert').val() == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie  <br> ";
			control = false;
		}

		if ($(SelectCausa).find(':selected').text() == "--- Seleccione ---" || $(SelectCausa).find(':selected').val() == "0") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Causa  <br> ";
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

		/* if (document.Marca.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		} */
	}



</script>
</head>
<body onload="levantar()" background="recursos/image/fondo2.jpg">

<div class="container">

		 <s:include value="/ambiente/menu/menuMantenedor.jsp" /> 

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<h1 style="color: #fc8d00">
					Portal de Renovaciones </h1>

			</div>
		</div>
		
		<form action="Retornos" name="Retornos" method="POST" autocomplete="off" id="Retornos"
				class="form-inline">
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Retornos</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="serie">Serie:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								<input type="hidden" name="mensaje" id="idactivoInsert"
										value="" />
									<input type="text" class="form-control" id="serieInsert"
										name="serie" value="" maxlength="30"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">Modelo:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="modelo"
										name="modelo" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<%-- <a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --%> <label for="serie">Marca:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="marca"
										name="marca" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">Nombre/Apellido:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreapellido"
										name="nombreapellido" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group"><!-- 
									<a href="#"
										title="Aqui debes ingresar la serie del equipo">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> --> <label for="modelo">RUT:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
								<input type="hidden" name="mensaje" id="idpersonaInsert"
										value="" />
									<input type="text" class="form-control" id="rut"
										name="rut" value="" maxlength="30" readonly="readonly"/> 
								</div>
							</div>
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes seleccionar la causa de retorno"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectCausa">Causa:&nbsp;</label>
								</div>

							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								        <select id="SelectCausa" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>
								          <!-- <option value="1">Daños de fabrica</option>
								          <option value="2">Daños hecho por el usuario</option>
								          <option value="3">Desconocido</option> -->
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar algunas observaciones si existen">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="observaciones">Observaciones:&nbsp;</label>
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<textarea id="observacionInsert" maxlength="140" rows="5" cols="30" placeholder="Escribe tus Observaciones"></textarea>
							</div>
							</div>
							
							
						</div>
						<div class="row" align="center">
						 <%-- <button type="button" value="" data-toggle="modal"
								data-target="#myModalMarca" class="btn btn-success btn-sm ">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;Asignar nuevo equipo
								</button> --%>
								<input type="button" value="Registrar retorno" style="background-color: #fc8d00"
									onclick="insertar()" class="btn btn-success" id="retorno">&nbsp;
						</div>	
					</div>
				</div>
			</form>
			
		<!-- ****************************************************************************************** --> 
		<!-- <div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row" id="ResultadoHorario">
		</div>
		<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Agendar"
									onclick="insertar()" class="btn btn-success" id="agendar">&nbsp;
							</div>
								
						</div>
						
		</div>
		</div> -->
		
		</div> 
			<button type="button" id="levantarModal" class="btn btn-primary btn-lg"
			data-toggle="modal" data-target="#myModal" style="display: none;"></button>
			
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
</body>
</html>
