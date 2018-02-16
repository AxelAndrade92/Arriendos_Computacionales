<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
td ,a{
text-align:center;
}
</style>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script>
	var miTabla;
	
$(document).ready(function() {
	var filaTabla;
	
	miTabla = $('#miTabla').DataTable({
	    "columnDefs": [
	                   {"className": "dt-center", "targets": "_all"}
	                 ]
	             });
	$('#miTabla tbody').on( 'click', 'tr', function () {
	    filaTabla = miTabla.row( this ).data();
	    console.log(filaTabla);
	    $("#idsbuu").val(filaTabla[0]);
	    $("#nombreSbuu").val(filaTabla[1]);
	 	$("#SelectEmpresas").val(filaTabla[2]);

	 	
	 	
	} );
	
	

    
	var SelectEmpresas = $('#SelectEmpresas');
	
	 $.ajax({
         url: 'Json/"EmpresaJson"', // url where to submit the request
         type : "POST", // type of action POST || GET
         success : function(result) {
        
       	  var option = '';
       	  console.log(result.empresas.length);
       	  for (var i=0;i<result.empresas.length;i++){
       	     option = '<option value="'+ result.empresas[i].id + '">' + result.empresas[i].nombre + '</option>';
       	     
       	  SelectEmpresas.append(option);
       	  }
       	SelectEmpresas = $('#SelectEmpresas');
         },
         error: function(xhr, resp, text) {
             console.log(xhr, resp, text);
         }
     })
	  
    $('a.distribuir').click(function(){

        var idsb = $(this).parents("tr").find("td").eq(0).html();  
        var nombreSbu = $(this).parents("tr").find("td").eq(1).html();
        var empresaSbu = $(this).parents("tr").find("td").eq(2).html();
        
    
		
        $("#idsbuu").val(idsb);
		$("#nombreSbuu").val(nombreSbu);
		/* $("#SelectEmpresas").val(empresaSbu); */
		
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
				var uen = {};
				uen['id'] = document.Sbu.idsbu.value;
				uen['nombre'] = document.Sbu.nombreSbu.value;
				uen['empresa'] = $(SelectEmpresas).find(':selected').val();
				data['sbu'] = uen;

				$.ajax({
	                url: 'insercion_sbu', // url where to submit the request
	                type : "POST", // type of action POST || GET
	                dataType : 'html', // data type
	                contentType: 'application/json',
	                data : JSON.stringify(data), // post data || get data
	                success : function(result){
		                alert(result);
	                	cargaSbu();
	                    // you can see the result from the console
	                    // tab of the developer tools
	                    //console.log(result);
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
		document.Sbu.idsbu.value == "";
		document.Sbu.nombreSbu.value == "";
		/* document.Sbu.centroCosto.value == ""; */
		
	}
	
	
	function buscar() {
		console.log("Ingresa a Funcion Buscar");
		
		cargaSbu();
		
	}
	
	function cargaSbu(){
		var miTabla = $('#miTabla').DataTable();
		miTabla.clear().draw();
		
		var data =  {};
		var uen = {};
		

		uen['id'] = document.Sbu.idsbu.value;
		
		if (document.Sbu.idsbu.value == "") {
			uen['id'] = 0
		} 

		data['sbu'] = uen;
		$.ajax({
            url: 'BuscarSbu', // url where to submit the request
            type : "POST", // type of action POST || GET
            dataType : 'json', // data type
            contentType: 'application/json',
            data : JSON.stringify(data), // post data || get data
            success : function(result){
                /* alert("Sbu insertado con exito!"); */
            	if(result.listasbubean.length != 0){
		        	  for (var i=0;i<result.listasbubean.length;i++){
			        	  miTabla.row.add([
			        			  result.listasbubean[i].id,	
			        			  result.listasbubean[i].nombre,
			        			  result.listasbubean[i].empresa,
			        			  '<center><a onClick="funcionTabla();" class="distribuir"> <span class="glyphicon glyphicon-pencil" style="color:green;"></span></a></center>'
					      ]).draw(false);
		        	     }
			        }else{
						miTabla.clear().draw();
						alert("Registro de Sbu fallido");
				    }
            },
            error: function(xhr, resp, text) {
                console.log(xhr, resp, text);
            }
        })
		}
	
	
	function validar() {
		
		var mensaje = "";
		var verificar = 0;
		var control = true;
	
		var mensaje = "Favor ingresar los siguientes parametros:  <br><br>";
		var verificar = 0;
		var control = true;
	
		if (document.Sbu.idsbu.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Numero identificador de SBU <br> ";
			control = false;
		}
	
		if (document.Sbu.nombreSbu.value == "") {
	
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre SBU <br> ";
			control = false;
		}
	
	
		if ($(SelectEmpresas).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresas  <br> ";
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

	
		if (document.Update_sbu.nombreSbuu.value == "") {

			mensaje += "<span class='glyphicon glyphicon-edit'></span> Nombre de SBU  <br> ";
			control = false;
		}

		if ($(SelectEmpresas).find(':selected').text() == "--- Seleccione ---") {
			
			mensaje += "<span class='glyphicon glyphicon-edit'></span> Empresas  <br> ";
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

				/* var data = {};
				var empresa = {};
				empresa['id'] = document.Update_Empresa.numero_empresaUP.value;
				empresa['nombre'] = document.Update_Empresa.nombre_empresaUP.value;
				empresa['rut'] = document.Update_Empresa.rut_EmpresaUP.value;
				empresa['direccion'] = document.Update_Empresa.dir_EmpresaUP.value;
				empresa['representanteLegal'] = document.Update_Empresa.rep_LegalUP.value;
				empresa['email'] = document.Update_Empresa.email_ContactoUP.value;
				empresa['fono'] = document.Update_Empresa.fono_ContactoUP.value;
				data['empresaBean'] = empresa;
				console.log(data); */

				var data = {};
				var uen = {};

				uen['id'] = $('#idsbuu').val();
				uen['nombre'] = $('#nombreSbuu').val();
				console.log(data);
				data['sbu'] = uen;

				$.ajax({
	                url: 'Update_sbu', // url where to submit the request
	                type : "POST", // type of action POST || GET
	                dataType : 'html', // data type
	                contentType: 'application/json',
	                data : JSON.stringify(data), // post data || get data
	                success : function(result) {
		                alert(result);
		                cargaSbu();
	                    // you can see the result from the console
	                    // tab of the developer tools
	                    //console.log(result);
	                },
	                error: function(xhr, resp, text) {
	                    console.log(xhr, resp, text);
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

		if (document.Sbu.mensaje.value != "") {
			$("#texto2").html($("#mensaje").val());
			$("#levantarModalInsert").click();

		}
	}

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

	function miTabla(){
		$('a.distribuir').click(function(){
				
		        var nomsbu = $(this).parents("tr").find("td").eq(0).html();  
		        var numerosbu = $(this).parents("tr").find("td").eq(1).html();
		        var empresasbu = $(this).parents("tr").find("td").eq(2).html();
		         
		        
		    	$("#nombreSbuu").val(nomsbu);
		    	$("#idsbuu").val(numerosbu);
		    	
		    	
		    	
				 //console.log(idMa);

				/*if(modeloEquipo == ""){
					$("#lstModeloEquipoUpdate").val("0");
					}else{
						$("#lstModeloEquipoUpdate").val(modeloEquipo);
						}
				 */
		        $("#levantarModalUpdate").click();
		     
		    });
		}
</script>
<title>Ingreso de SBU</title>

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
		
		<s:form action="insercion_sbu" name="Sbu" method="POST" autocomplete="off"
				class="form-inline">                                 
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
				 value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" align="center">Mantenedor de SBU</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Aqui debes ingresar Numero identificador del SBU">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="idsbu">Nº identificador:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2" onkeypress="return valida(event)"
										name="idsbu" value="${idsbu}" maxlength="12"/> 
								</div>
							</div>
							
							
								<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar el Nombre del SBU"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="nombreSbu">Nombre de Sbu:&nbsp;</label>
								</div>
								
								
								
							</div>

								<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="exampleInputName2"
										name="nombreSbu" value="${nombreSbu}" maxlength="40"  onkeypress="return soloLetras(event)"/> 
								</div>
							</div>
							
							
							<%-- <div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"	title="Aqui debes ingresar el Centro de Costo"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="centroCosto">Centro de Costo:&nbsp;</label>
								</div>
								
								
								
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<input type="text" class="form-control" id="exampleInputName2"
										name="centroCosto" value="${centroCosto}" maxlength="12"/> 
								</div>
							</div> --%>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="Esta son las Empresas las cuales debes indicar a la cual se encuentra relacionada la SBU"><span
										class="glyphicon glyphicon-info-sign" aria-hidden="true"></span></a>
									<label for="empresas">Empresas:&nbsp;</label>

								</div>
							</div>
						
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
								
								<select id="SelectEmpresas" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
								</select> 
									  
								</div>
							</div>
                           
                             
						</div>
						<br>
						

						

						<div class="row">
							<div class="col-sm-12 col.md-6" align="center">
								<input type="button" value="Ingresar Registro"
									onclick="insertar()" class="btn btn-success">&nbsp;
									
									<input type="button" value="Buscar SBU"
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
	 
		<div class="panel panel-success">
					
		<div class="panel-body" style="margin: 6px;">
		<div class="row">
			
			<div class="table-responsive">
               
					<table class="table table-hover table-bordered table-condensed" id="miTabla">
				<thead><tr><th>ID</th><th>Nombre Sbu</th><th>Id Empresa</th><th>Actualizar</th></tr></thead>
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

				<s:form action="Update_sbu" name="Update_sbu">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje"
					value="<s:property value="%{mensaje}" />" />
					<div class="modal-content">
						<div class="modal-header modal-header-warning">

							<h3>
								<i class="glyphicon glyphicon-plus"></i>&nbsp;Actualizar SBU
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
																						
												<input name="idsbuu" size="13" id="idsbuu" value=""
												class="form-control"  readonly="readonly" />
										</div>

									</div>
								</div>
								<div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Nombre de Sbu :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-asterisk"></span>
												</div>
											<input type="text" name="nombreSbuu" maxlength="10"
													value="" id="nombreSbuu" size="40" class="form-control"/>
											</div>

										</div>
									</div>
									
									
							
							<%-- <div class="form-group col-sm-6 col-md-6">
										<label class="col-sm-4 control-label"
											style="text-align: right;">Empresas :</label>
										<div class="col-sm-8 col-md-8">
											<div class="input-group input-append date">
												<div class="input-group-addon">
													<span class="glyphicon glyphicon-asterisk"></span>
												</div>
											<select id="SelectEmpresas" class="form-control">
									          <option value="0" selected>--- Seleccione ---</option>								        
											</select> 
											</div>

										</div>
									</div> --%>
							
							
						
							</div>
										
							
								
							</div>
							

						
						<div class="modal-footer">
							<button type="button" class="btn btn-default btn-lg" data-dismiss="modal"
								onclick="update()">
								<span class="glyphicon glyphicon-floppy-disk"></span>&nbsp;Agregar
							</button>
							&nbsp;
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