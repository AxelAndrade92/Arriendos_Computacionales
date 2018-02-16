<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ingreso Detalle</title>
<s:include value="/ambiente/library/base.jsp"></s:include>
<script type="text/javascript">
$(document).ready(function(){
	
	    var SelectTipo = $('#SelectTipo');
		var siPath = $('#siPath');
		var SelectMarcas = $('#SelectMarcas');
		var SelectRack = $('#SelectRack');
		var SelectPosicion = $('#SelectPosicion');
		
		data = {};
		
		data['idbodega'] = document.Detalle.bodega.value;			
		 
		    $.ajax({			    
		        url: 'Json/Cargaselectrack', // url where to submit the request
		        type : "POST", // type of action POST || GET
		        dataType : 'json', // data type
                contentType: 'application/json',
                data : JSON.stringify(data),
		        success : function(result) {
		       
		      	  var option = '';
		      	  console.log(result.rckbean.length);
		      	  
		      	  for (var i=0;i<result.rckbean.length;i++){
		      	     option = '<option value="'+ result.rckbean[i].id + '">' + result.rckbean[i].nombre + '</option>';
		      	     
		      	   SelectRack.append(option);
		      	  }
		      	
		        },
		        error: function(xhr, resp, text) {
		            console.log(xhr, resp, text);
		        }
		    })
			
			$('#SelectRack').change(function(){
				
				var SelectRack = $('#SelectRack');
				var SelectPosicion = $('#SelectPosicion');

				SelectPosicion.empty();
				
				var data = {};  
				var posicion = {};
				posicion['rack'] = SelectRack.find(':selected').val();
				var a;
				a = SelectRack.find(':selected').val();
				console.log("id pasando "+a);
				data['pos'] = posicion;				

					$.ajax({
		                 url: 'Json/CargarSelectPosicionesJson', // url where to submit the request
		                 type : "POST", // type of action POST || GET
		                 dataType : 'json', // data type
		                 contentType: 'application/json',
		                 data : JSON.stringify(data),
		                 success : function(result) {
		                     
		            	  var option = '';
		            	  for (var i=0;i<result.lista_posiciones.length;i++){
		             	     option = '<option value="'+ result.lista_posiciones[i].posicion + '">' + result.lista_posiciones[i].nombre + '</option>';
		             	    SelectPosicion.append(option);
		             	  }
		               	 
		                 },
		                 error: function(xhr, resp, text) {
		                     console.log(xhr, resp, text);
		                 }
		             })


					

				

				});

		$.ajax({
	        url: 'Json/TipoActivosDisponibles', // url where to submit the request
	        type : "POST", // type of action POST || GET
	        success : function(result) {
	       
	      	  var option = '';
	      	  console.log(result.tipos.length);
	      	  for (var i=0;i<result.tipos.length;i++){
	      	     option = '<option value="'+ result.tipos[i].id + '">' + result.tipos[i].tipoActivo + '</option>';
	      	     
	      	   SelectTipo.append(option);
	      	  }
	      	
	        },
	        error: function(xhr, resp, text) {
	            console.log(xhr, resp, text);
	        }
	    })
	    
	   


	    $.ajax({
         url: 'Json/MarcasDisponibles', // url where to submit the request
         type : "GET", // type of action POST || GET
         success : function(result) {
       	  var option = '';
       	  
       	  for (var i=0;i<result.marcas.length;i++){
       	     option = '<option value="'+ result.marcas[i].idMarca + '">' + result.marcas[i].nombreMarca + '</option>';
       	  SelectMarcas.append(option);
       	  }
         },
         error: function(xhr, resp, text) {
             console.log(xhr, resp, text);
         }
     })

     $("#SelectMarcas").change(function(){
    	 var SelectMarcas = $('#SelectMarcas');
    	 var SelectTipo = $('#SelectTipo');
    	 var SelectModelo = $('#SelectModelo');
    	 SelectModelo.empty();
    	 var data = {};

    	 var marca = {};
    	 var tipo = {};
    		data['idtipo'] = SelectTipo.find(':selected').val();
    		data['idmarca'] = SelectMarcas.find(':selected').val();
    		data['idEmpresa'] = document.Detalle.empresa.value;
    	 
         if ((SelectMarcas.find(':selected').text() != "--- Seleccione ---") && (SelectTipo.find(':selected').text() != "--- Seleccione ---")) {
             
        	 $.ajax({
                 url: 'Json/CargarSelectModelosJson', // url where to submit the request
                 type : "POST", // type of action POST || GET
                 dataType : 'json', // data type
                 contentType: 'application/json',
                 data : JSON.stringify(data),
                 success : function(result) {
                     
            	  var option = '';
            	  for (var i=0;i<result.modelos.length;i++){
             	     option = '<option value="'+ result.modelos[i].id + '">' + result.modelos[i].modelos + '</option>';
             	    SelectModelo.append(option);
             	  }
               	 
                 },
                 error: function(xhr, resp, text) {
                     console.log(xhr, resp, text);
                 }
             })
			
		} 
    
	});
		 $("#SelectTipo").change(function(){
	    	 var SelectMarcas = $('#SelectMarcas');
	    	 var SelectTipo = $('#SelectTipo');
	    	 var SelectModelo = $('#SelectModelo');
	    	 SelectModelo.empty();
	    	 var data = {};

	    	 var marca = {};
	    	 var tipo = {};
	    		data['idtipo'] = SelectTipo.find(':selected').val();
	    		data['idmarca'] = SelectMarcas.find(':selected').val();
	    		data['idEmpresa'] = document.Detalle.empresa.value;
	    	 
	         if ((SelectMarcas.find(':selected').text() != "--- Seleccione ---") && (SelectTipo.find(':selected').text() != "--- Seleccione ---")) {
	             
	        	 $.ajax({
	                 url: 'Json/CargarSelectModelosJson', // url where to submit the request
	                 type : "POST", // type of action POST || GET
	                 dataType : 'json', // data type
	                 contentType: 'application/json',
	                 data : JSON.stringify(data),
	                 success : function(result) {
	                SelectModelo.empty();
	            	  var option = '';
	            	  for (var i=0;i<result.modelos.length;i++){
	             	     option = '<option value="'+ result.modelos[i].id + '">' + result.modelos[i].modelos + '</option>';
	             	    SelectModelo.append(option);
	             	  }
	               	 
	                 },
	                 error: function(xhr, resp, text) {
	                     console.log(xhr, resp, text);
	                 }
	             })
				
			} 
	    
		});
		 var SelectModelo = $('#SelectModelo');
		 
		/*  $('#SelectModelo').change(function(){
			 
			 var SelectModelo = $('#SelectModelo');
			 var product = $('#product');
			 
			 var data = {};
			 
	    	 data['id'] = SelectModelo.find(':selected').val();
	    	 console.log(SelectModelo.find(':selected').val());

	    	 $
				.ajax({
					url : 'Json/NumeroProducto', // url where to submit the request
					type : "POST", // type of action POST || GET
					dataType : 'json', // data type
					contentType : 'application/json',
					data : JSON.stringify(data),
					success : function(result) {
						
						product.val(result.modelos[0].numero_producto);	
						console.log(result.modelos[0].numero_producto);				
						
					},
					error : function(xhr, resp,	text) {
						console.log(xhr, resp, text);
					}
				})
			 
		 });
			 */
	 
});


	function Validar_serie(val){
		var SelectMarcas = $('#SelectMarcas');
		var caracter = val.substr(0,3);//EXTRAER LAS 3 PRIMERAS LETRAS DE LA CADENA INGRESADA

		if (SelectMarcas.find(':selected').text() == "HP") {
	        if (caracter != 'mxl') {
	        	$('#caracteres').slideDown("slow");
	        	$('#caracteres').text('la serie para HP no es valida');
	        	$('#caracteres').css('color','red');
			} else {
				$('#caracteres').slideDown("slow");
				$('#caracteres').text('la serie para HP es valida');
				$('#caracteres').css('color','green');
			}
		} /* else {

		} */
	
	
	
	
	/* $('#caracteres').text(caracter); */
	
}

	function Mostrar_input(){
		
		var SelectTipo = $('#SelectTipo');
		
		if (SelectTipo.find(':selected').text() == "MONITOR") {
			$('#pulgada').show(2000);
			$('#pulgada2').show(2000);
			$('#txtbox').hide(2000);
			$('#txtbox2').hide(2000);
			$('#accesorio1').hide(2000);
			$('#accesorio2').hide(2000);
		}

		if (SelectTipo.find(':selected').text() == "THIN CLIENT") {			
			$('#txtbox').hide(2000);
			$('#txtbox2').hide(2000);
			$('#accesorio1').hide(2000);
			$('#accesorio2').hide(2000);
			$('#pulgada').hide(2000);
			$('#pulgada2').hide(2000);
			
		}

		if (SelectTipo.find(':selected').text() == "AIO") {
			$('#txtbox').show(2000);
			$('#txtbox2').show(2000);
			$('#accesorio1').show(2000);
			$('#accesorio2').show(2000);
			$('#accesorio3').hide(2000);
		}

		if (SelectTipo.find(':selected').text() == "DESKTOP") {
			$('#txtbox').show(2000);
			$('#txtbox2').show(2000);
			$('#accesorio1').show(2000);
			$('#accesorio2').show(2000);
			$('#accesorio3').hide(2000);
			$('#pulgada').hide(2000);
			$('#pulgada2').hide(2000);
		}

		if (SelectTipo.find(':selected').text() == "NOTEBOOK") {
			$('#txtbox').show(2000);
			$('#txtbox2').show(2000);
			$('#accesorio1').show(2000);
			$('#accesorio2').show(2000);
			$('#accesorio3').show(2000);
			$('#pulgada').hide(2000);
			$('#pulgada2').hide(2000);
		}

		

		

		};

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

	if ($(SelectTipo).find(':selected').text() == "--- Seleccione ---") {
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Tipo de Activo  <br> ";
		control = false;
	} 

	if($(SelectModelo).find(':selected').text() == "--- Seleccione ---"){
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Modelo  <br> ";
		control = false;
	}

	if(document.Detalle.serie.value == ""){
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie  <br> ";
		control = false;
	}

	if(document.Detalle.serie.value == ""){
		mensaje += "<span class='glyphicon glyphicon-edit'></span> Serie  <br> ";
		control = false;
	}
	
	if (control) {

		return control;
	} else {

		$("#texto").html(mensaje);
		$("#levantarModal").click();
	}

}

		
		function insertar(){
			
			if (validar()) {
				jConfirm(
			
						'Seguro que desea continuar?',
						'Confirmación',
						function(r) {
							if (r) {
								var data = {};
								var activos = {};
								var pulgadas = document.Detalle.pulgadas.value;
								var simbolo = "``";
								
								var ac1;
								var ac2;
								var ac3;
								
								if (document.getElementById("accesorio1").checked ==true) {
									ac1 = ' TECLADO ';
								} else {
									ac1 = ' S/A ';
								}

								if (document.getElementById("accesorio2").checked == true) {
									ac2 = 'MOUSE';
								}else{
									ac2 = ' S/A ';
								}

								if (document.getElementById("accesorio3").checked == true) {
									ac3 = ' DOCKING ';
								}else{
									ac3 = 'S/A';
								}
								
								var accesorios = ac1+' ; '+ac2+' ; '+ac3+' ; '+pulgadas+simbolo;
								/* private int id;
								private String serie;
								private int tipo;
								private int idBodega;
								private String caracteristicas;
								private int modelo;
								private int orden_compra;
								private int factura;
								private String num_producto;
								private int estadoOperacion;
								private int estadoTecnico;
								private int posicion;
								private int rack;
								private String descripcion;
								private String marca;
								private String descr_modelo; */

								activos['tipo'] = $(SelectTipo).find(':selected').val();
								activos['num_producto'] = document.Detalle.product.value;
								activos['modelo'] = $(SelectModelo).find(':selected').val();
								activos['serie'] = document.Detalle.serie.value;
								activos['caracteristicas'] = accesorios;
								activos['idBodega'] = document.Detalle.bodega.value;
								activos['factura'] = document.Detalle.factura.value;
								activos['estadoOperacion'] = 1;
								activos['estadoTecnico'] = 1;
								activos['rack'] = $(SelectRack).find(':selected').val();
								activos['posicion'] = $(SelectPosicion).find(':selected').val();;
								
								data['actbean'] = activos;
								$.ajax({
									url : 'Json/ingreso_activos', // url where to submit the request //Struts 
									type : "POST", // type of action POST || GET
									dataType : 'html', // data type
									contentType : 'application/json',
									data : JSON.stringify(data), // post data || get data
									success : function(result) {
										alert(result);		
										 	var SelectTipo = $('#SelectTipo');
											var SelectMarcas = $('#SelectMarcas');
											var SelectModelo = $('#SelectModelo');
											var SelectRack = $('#SelectRack');	
											var SelectPosicion = $('#SelectPosicion');																
											$(SelectTipo).prop('selectedIndex',0);
											$(SelectModelo).prop('selectedIndex',0);
											$(SelectRack).prop('selectedIndex',0);
											$(SelectMarcas).prop('selectedIndex',0);
											SelectPosicion.empty();	
											SelectModelo.empty();									
											$('#product').val('');
											$('#serie').val('');
											$('#pulgadas').val('');
											$('input:checkbox').removeAttr('checked');
											
															

										
									},
									error : function(xhr, resp, text) {
										console.log(xhr, resp, text);
									}
								})
							}
						});
		




			}




	}

</script>
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

		

		
			<s:form action="ingreso_detalle" name="Detalle" method="POST"
				class="form-inline">
				<input type="hidden" name="param" id="param" value="" />
				<input type="hidden" name="mensaje" id="mensaje" value="<s:property value="%{mensaje}" />" />
				<div class="panel panel-success">
					<div class="panel-heading" style="background-color: #fc8d00" align="center">Ingreso de activos</div>
					<div class="panel-body">
						<div class="row">
					
						<div class="col-sm-3 col-md-3" hidden="hidden">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="bodega">bodega:&nbsp;</label>
								</div>
							</div>
							
						<div class="col-sm-3 col-md-3" hidden="hidden">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2" 
										name="bodega" value="<s:property value="bodega" />" maxlength="12" readonly="readonly"/> 
								</div>
						</div>
						<div class="col-sm-3 col-md-3" hidden="hidden">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="empresa">empresa:&nbsp;</label>
								</div>
							</div>
						<div class="col-sm-3 col-md-3" hidden="hidden">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2" 
										name="empresa" value="<s:property value="empresa" />" maxlength="12" readonly="readonly"/> 
								</div>
						</div>
						
						
							
						<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="factura">Factura:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="exampleInputName2" " 
										name="factura" value="<s:property value="factura" />" maxlength="12" readonly="readonly"/> 
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="tipo_activo">Tipo de Activo :&nbsp;</label>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group" >
									<select id="SelectTipo" class="form-control" onchange="Mostrar_input()">
								          <option value="0" selected>--- Seleccione ---</option>								        
										</select>									
								</div>
							</div>
							
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="product">Numero Producto:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="product" 
										name="product" value="${product}" maxlength="20" readonly="readonly"/> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="marca">Marca:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<select id="SelectMarcas" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="modelo">Modelo:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<select id="SelectModelo" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
								        </select> 
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="serie">Serie:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<input type="text" class="form-control" id="serie"  
										name="serie" value="${serie}" maxlength="12"/> <!--oninput="Validar_serie(this.value)"  -->
										<div id="caracteres"></div>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3" hidden="hidden" id="pulgada">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="pulgadas">Pulgadas:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3" hidden="hidden" id="pulgada2">
								<div class="form-group">
									<input type="text" class="form-control" id="pulgadas" id="pulgada2" hidden="hidden"
										name="pulgadas" value="${pulgadas}" maxlength="2"/>
								</div>
							</div>			
												
							<div class="col-sm-3 col-md-3" id="txtbox" hidden="hidden">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="accesorios">Accesorios:&nbsp;</label>
								</div>
							</div>

							<div class="col-sm-3 col-md-3" id="txtbox2" hidden="hidden">
								<div class="form-group">
									<input type="checkbox" name="accesorio1" id="accesorio1" value="10" hidden="hidden"> Teclado<br>
									<input type="checkbox" name="accesorio2" id="accesorio2" value="20" hidden="hidden"> Mouse<br>
									<input type="checkbox" name="accesorio3" id="accesorio3" value="30" hidden="hidden"> Docking<br>
								</div>
							</div>
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="Rack">Estante:&nbsp;</label>
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<select id="SelectRack" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
								       </select> 
								</div>
							</div>
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<a href="#"
										title="">
										<span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
									</a> <label for="posicion">Posición:&nbsp;</label>
								</div>
							</div>
							
							
							<div class="col-sm-3 col-md-3">
								<div class="form-group">
									<select id="SelectPosicion" class="form-control">
								          <option value="0" selected>--- Seleccione ---</option>								        
								        </select> 
								</div>
							</div>
							
							
							
							
							
							
							
						</div>
					

						

						<div class="row">
						
							<div class="col-sm-12 col.md-12" align="center">
								<input type="button" value="Ingresar Activo" style="background-color: #fc8d00"
									onclick="insertar()" class="btn btn-success">&nbsp;							
							
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

</body>
</html>