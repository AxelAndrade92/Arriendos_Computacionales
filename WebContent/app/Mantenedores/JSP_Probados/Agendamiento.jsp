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
<title>Agendamiento</title>

<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
var array;
function callback(data){
	array = data;
}

$(document).ready(function() {
	
	
	/*  
	** Se agrega la búsqueda de días feriados al cargar el documento
	*/

		$.ajax({
	        url: 'Json/FeriadosJson', // url where to submit the request
	        type : "GET", // type of action POST || GET
	        success : function(result) {
				console.log(result.feriados);
	        	$.datepicker.setDefaults($.datepicker.regional["es"]);
				  $("#AgendamientoFecha").datepicker({
			      minDate : 0,
				  firstDay: 1,
				  beforeShowDay: function(date){
					  	var noWeekend = $.datepicker.noWeekends(date);
				        var string = $.datepicker.formatDate('yy/mm/dd', date);
				        return noWeekend[0] ? [ result.feriados.indexOf(string) == -1 ]: noWeekend;
				    },
				  autoclose: true,
				  todayHighlight: true
				  });
				  
	        },
	        error: function(xhr, resp, text) {
	            console.log(xhr, resp, text);
	        }
	    })

	  $("#nombre").hide();
	  $('#agendar').hide();
	
	  var Agendamiento = $("#Agendamiento");
	  var SelectRegion = $('#SelectRegion');
	  var SelectComuna = $('#SelectComuna');
	  var SelectEmpresa = $('#SelectEmpresa');
	  var SelectUen = $('#SelectUen');
	  var SelectCC = $('#SelectCC');
	  var Regiones;
	  var Empresas;
	  var Comunas;
	  var Uenes;
	  var Cc;
	  /*
	  * Se carga el primer SelectRegion a través de una petición Ajax
	  */
	  $.ajax({
          url: 'Json/RegionJson', // url where to submit the request
          type : "GET", // type of action POST || GET
          success : function(result) {
        	  var option = '';
        	  //console.log(result.regiones.length);
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
        	  //console.log(result.empresas.length);
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
		          SelectComuna.append('<option value=0 selected>--- Seleccione ---</option>');
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
			          SelectUen.append('<option value=0 selected>--- Seleccione ---</option>');
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
				  var idUen = SelectUen.find(':selected').val();
				  data['idUen'] = idUen;
				  $.ajax({
			          url: 'Json/CCJson', // url where to submit the request
			          type : "POST", // type of action POST || GET
		              dataType : 'json', // data type
		              contentType: 'application/json',
			          data : JSON.stringify(data),
			          success : function(result) {
				          SelectCC.empty();
				          SelectCC.append('<option value=0 selected>--- Seleccione ---</option>');
			        	  var option = '';
			        	  for (var i=0;i<result.ccs.length;i++){
			        	     option = '<option value="'+ result.ccs[i].id + '">' + result.ccs[i].nombre + '</option>';
			        	     SelectCC.append(option);
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
				  * Se genera una función de escucha a los cambios en AgendamientoFecha
				  */
				  $("#AgendamientoFecha").change(function(){
					  var data = {};
					  var agendamientoBean = {};
					  agendamientoBean['fecha'] = $("#AgendamientoFecha").val();
					  agendamientoBean['region'] = $(SelectRegion).find(':selected').val();
					  agendamientoBean['region'] = $(SelectRegion).find(':selected').val();
					  //agendamientoBean['horario'] = $(SelectHorario).find(':selected').val();
					  data['agendamientoBean'] = agendamientoBean;
					  if(agendamientoBean.region != 0 ){
						     
								  $.ajax({
							          url: 'Json/FechasAgendaJson', // url where to submit the request
							          type : "POST", // type of action POST || GET
						              dataType : 'json', // data type
						              contentType: 'application/json',
							          data : JSON.stringify(data),
							          success : function(result) {
							        	  //console.log(result);
							        	  $('#ResultadoHorario').empty();
											var input = '<div class="alert alert-warning"><strong>Sin disponibilidad</strong> No hay horarios disponibles para la fecha seleccionada</div>';
							        	  	  var SelectHorario = '<select id="SelectHorario" class="form-control"> <option value="0" selected>--- Seleccione ---</option>';
												if(result.AM == true){
													SelectHorario += '<option value="1">09:00 a 13:00</option>';
												}
												if(result.PM == true){
													SelectHorario += '<option value="2">13:00 a 16:00</option>'; 
												}  
											    SelectHorario += '</select>';
											    $('#agendar').show();
											    if((result.AM == false) && (result.PM == false)){
												    SelectHorario = input;
												    $('#agendar').hide();
												}
												var html = $.parseHTML(SelectHorario);
												$('#ResultadoHorario').append(html);
							        	  SelectRegion = $('#SelectRegion');
							        	  SelectComuna = $('#SelectComuna');
							        	  SelectUen = $('#SelectUen');	
							          },
							          error: function(xhr, resp, text) {
							              console.log(xhr, resp, text);
							          }
					      })
				  }else{alert("Por favor ingrese una región");
				  $("#AgendamientoFecha").val('');
				  }  
			    });     
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
				var SelectEmpresa = $('#SelectHorario');
				var data = {};
				var agendamientoBean = {};
				agendamientoBean['id'] = '0';
				agendamientoBean['nombrePersona'] = document.Agendamiento.nombre.value;
				agendamientoBean['region'] = $(SelectRegion).find(':selected').val();
				agendamientoBean['comuna'] = $(SelectComuna).find(':selected').val();
				agendamientoBean['centroCosto'] = $(SelectCC).find(':selected').val();
				agendamientoBean['idEmpresa'] = $(SelectEmpresa).find(':selected').val();
				agendamientoBean['direccion'] = $("#AgendamientoUbicacion").val();
				agendamientoBean['fecha'] = document.Agendamiento.AgendamientoFecha.value;
				agendamientoBean['horario'] = $(SelectHorario).find(':selected').val();
				data['agendamientoBean'] = agendamientoBean;
				
				$.ajax({
                url: 'AgendamientoInsertar', // url where to submit the request
                type : "POST", // type of action POST || GET
                dataType : 'html',//'json', // data type
                contentType: 'application/json',
                data : JSON.stringify(data), // post data || get data
                success : function(result) {
                	alert(result);
    				$('#nombreInsert').val('');
    				$("#AgendamientoUbicacion").val('');
    				$('#AgendamientoFecha').val('');
    				$('#agendar').hide();
    				$('#ResultadoHorario').empty();
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
		
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
		
		if (document.Agendamiento.nombre.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de la persona  <br> ";
			control = false;
		}

		if ($(SelectRegion).find(':selected').text() == "--- Seleccione ---" || $(SelectRegion).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Región  <br> ";
			control = false;
		}

		if ($(SelectComuna).find(':selected').text() == "--- Seleccione ---" || $(SelectComuna).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Comuna  <br> ";
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
	    if ($(SelectCC).find(':selected').text() == "--- Seleccione ---" || $(SelectCC).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Centro de Costos <br> ";
			control = false;
		}
		if ($("#AgendamientoUbicacion").val() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Ubicación  <br> ";
			control = false;
		}
		if ($(SelectHorario).find(':selected').val() == "0" ||  $(SelectHorario).find(':selected').text() == "") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Horario válido  <br> ";
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



</script>
</head>
<body onload="levantar()" background="recursos/image/fondo2.jpg">

<div class="container">

		<s:include value="/ambiente/menu/menuMantenedor.jsp" />

		<div class="row centro" style="text-align: center; font-size: 35px">
			<div class="col-sm-4 col-md-12">
				<input type="hidden" name="mensaje" id="mensaje"
					value="" /><h1 style="color: #fc8d00">
					Portal de Renovaciones </h1>

			</div>
		</div>
		
		<s:form action="Agendamiento" name="Agendamiento" method="POST" autocomplete="off" id="Agendamiento"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">
					Agendamiento</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar el nombre y apellido del usuario">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="nombre">Nombre:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="nombreInsert"
										name="nombre" value="${nombre}" maxlength="30" onkeypress="return soloLetras(event)"/> 
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
									<a href="#"	title="Aqui debes seleccionar la comuna"><span
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
									<a href="#"	title="Aqui debes ingresar el centro de costos"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="SelectCC">Centro de Costos:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
										<select id="SelectCC" class="form-control">
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la ubicación para el reemplazo"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="AgendamientoUbicacion">Ubicación:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="AgendamientoUbicacion"
										name="AgendamientoUbicacion" value="" maxlength="40" onkeypress="return soloLetrasNumeros(event)"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar la fecha"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="AgendamientoFecha">Fecha:&nbsp;</label>
								</div>
							</div>	
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="AgendamientoFecha" 
										name="AgendamientoFecha" value="" maxlength="12" readonly="readonly"/> 
								</div>
							</div>
							
						</div>
						
					</div>
				</div>
			</s:form>
			
		<!-- ****************************************************************************************** --> 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row" id="ResultadoHorario">
		</div>
		<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Agendar" style="background-color: #fc8d00"
									onclick="insertar()" class="btn btn-success" id="agendar">&nbsp;
							</div>
								
						</div>
						
		</div>
		</div>
		
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
