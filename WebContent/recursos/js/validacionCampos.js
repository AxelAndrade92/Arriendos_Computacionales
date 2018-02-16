



function validarAsignacion() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if ($("#lstContrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Ejecutivo \n ";
		control = false;
	}

	if ($("#lstEmpresa option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Empresa \n ";
		control = false;
	}

	if ($('input[name="estado"]').is(':checked')) {

	} else {
		mensaje += "- Debe seleccionar Estado \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validar() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.informeVisita.trabajo.value == 0) {

		mensaje += "- Campo trabajo vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.ej.value == 0) {

		mensaje += "- Campo Ejecutivo Anexo vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.fecha.value == 0) {

		mensaje += "- Campo fecha vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.horaInicio.value == 0) {

		mensaje += "- Campo hora inicio vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.horaTermino.value == 0) {

		mensaje += "- Campo hora t&eacute;rmino vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.sitio.value == 0) {

		mensaje += "- Campo sitio vac&Iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.contacto.value == 0) {

		mensaje += "- Campo contacto vac&Iacute;o \n ";
		control = false;
	}




	if (document.informeVisita.proximaVisita.value == 0) {

		mensaje += "- Campo pr&oacute;xima visita vac&Iacute;o \n ";
		control = false;
	}

	if ($('input[name="tipoVisita"]').is(':checked')) {

	} else {
		mensaje += "- Campo tipo visita vac&iacute;o \n ";
		control = false;
	}
	
	if ($('input[name="colacion"]').is(':checked')) {

	} else {
		mensaje += "- Campo colaci&oacute;n vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="estadoVisita"]').is(':checked')) {

	} else {
		mensaje += "- Campo estado visita vac&iacute;o \n ";
		control = false;
	}

	if (document.informeVisita.correoAnexo.value == "") {

		mensaje += "- Campo correo vac&iacute;o \n ";
		control = false;
	}
	if (document.informeVisita.correoAnexo.value != "") {
		if (isEmailValido(document.informeVisita.correoAnexo.value)) {

			mensaje += "- La direcci&oacute;n de e-mail tiene un formato invalido. \n ";
			control = false;
		}

	}
	
	
	if (validatefechaMayorQue(document.informeVisita.fecha.value, document.informeVisita.proximaVisita.value))

	{

		mensaje += "- La fecha de pr&oacute;xima visita " + document.informeVisita.proximaVisita.value + "  es inferior a la fecha de registro "
				+ document.informeVisita.fecha.value;
		control = false;
	}
	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}
}

function validarCargo() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmCargo.cargos.value == 0) {

		mensaje += "- Campo cargo vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="estado"]').is(':checked')) {

	} else {
		mensaje += "- Campo Estado vac&iacute;o \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarModContrato() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;
	

	

	if (document.fextenderContrato.datepicker.value == 0) {

		mensaje += "- Campo Nueva Fecha vac&iacute;o \n ";
		control = false;
	}
	
	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarModContratoValor() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;



	if ($("#lstEmpresa option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Empresa \n ";
		control = false;
	}
	
	if ($("#Tipocontratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo de Contrato \n ";
		control = false;
	}
	
	if ($("#Descripcioncontratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Descripcion contrato \n ";
		control = false;
	}
	
	


	if ($("#contratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}

	
	if (document.fcambiarValor.nuevoValor.value == 0) {

		mensaje += "- Campo Nuevo Valor vac&iacute;o \n ";
		control = false;
	}
	
	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarInforme() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmInforme.fileUpload.value == 0) {

		mensaje += "- Debe adjuntar archivo \n ";
		control = false;
	}

	if ($("#contratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}

	if (document.frmInforme.mesInforme.value == 0) {

		mensaje += "- Campo Mes Informe vac&iacute;o \n ";
		control = false;
	}
	
	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarArchivo() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmArchivo.fileUpload.value == 0) {

		mensaje += "- Debe adjuntar archivo \n ";
		control = false;
	}

	if ($("#Tipocontratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}
	
	if ($("#Descripcioncontratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarArchivoContrato() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmArchivo.fileUpload.value == 0) {

		mensaje += "- Debe adjuntar archivo \n ";
		control = false;
	}

	if ($("#lstContrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}

	if ($("#tipoFile option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Archivo \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarArchivoContratoGeneral() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmArchivo.fileUpload.value == 0) {

		mensaje += "- Debe adjuntar archivo \n ";
		control = false;
	}

	if ($("#tipoFile option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Archivo \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarModContratoAlcance() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.fcambiarAlcance.alcance.value == 0) {

		mensaje += "- Campo Nueva Fecha vac&iacute;o \n ";
		control = false;
	}

	if ($("#lstEmpresas option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Empresa \n ";
		control = false;
	}
	
	if ($("#Tipocontrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Contrato \n ";
		control = false;
	}
	
	if ($("#Descripcioncontratos option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Descripcion Contrato \n ";
		control = false;
	}

	if ($("#contrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Contrato \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {

		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarPersonal() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.fcrearPersonal.nombrePersonal.value == 0) {

		mensaje += "- Campo Nombre vac&iacute;o \n ";
		control = false;
	}

	if (document.fcrearPersonal.apellidoPersonal.value == 0) {

		mensaje += "- Campo Apellido vac&iacute;o \n ";
		control = false;
	}

	if (document.fcrearPersonal.emailPersonal.value == 0) {

		mensaje += "- Campo correo vac&iacute;o \n ";
		control = false;
	}

	if ($("#lstTipoUsuario option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Usuario \n ";
		control = false;
	}

	if ($("#lstTipoContrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Contrato \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarUsuario() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.fcrearUsuario.user.value == 0) {

		mensaje += "- Campo Usuario vac&iacute;o \n ";
		control = false;
	}

	if (document.fcrearUsuario.nombre.value == 0) {

		mensaje += "- Campo Nombre vac&iacute;o \n ";
		control = false;
	}

	if (document.fcrearUsuario.email.value == 0) {

		mensaje += "- Campo E-mail vac&iacute;o \n ";
		control = false;
	}

	if (document.fcrearUsuario.email.value != "") {
		if (isEmailValido(document.fcrearUsuario.email.value)) {

			mensaje += "- La direcci&oacute;n de e-mail tiene un formato invalido. \n ";
			control = false;
		}

	}

	if ($('input[name="estadoUsuario"]').is(':checked')) {

	} else {
		mensaje += "- Debe seleccionar Estado \n ";
		control = false;
	}

	if ($("#lstTipoUsuario option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Usuario \n ";
		control = false;
	}
	if($("#lstTipoUsuario option:selected").val() == 1){
		
		if (document.fcrearUsuario.password.value == 0) {

			mensaje += "- Campo Password vac&iacute;o \n ";
			control = false;
		}
		
		if (document.fcrearUsuario.password.value != document.fcrearUsuario.password2.value) {

			mensaje += "- Contrase&ntilde;as no coinciden \n ";
			control = false;
		}
		
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validaContrato() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmContrato.fechaInicio.value == 0) {

		mensaje += "- Campo Fecha Inicio vac&iacute;o \n ";
		control = false;
	}

	if (document.frmContrato.valorContrato.value == 0) {

		mensaje += "- Campo Valor Contrato vac&iacute;o \n ";
		control = false;
	}
	if (document.frmContrato.alcance.value == 0) {

		mensaje += "- Campo Alcance vac&iacute;o \n ";
		control = false;
	}

	if (document.frmContrato.FechaTermino.value == 0) {

		mensaje += "- Campo Fecha de Termino vac&iacute;o \n ";
		control = false;
	}

	if (document.frmContrato.descContrato.value == 0) {

		mensaje += "- Campo Descripci&oacute;n Contrato vac&iacute;o \n ";
		control = false;
	}

	if ($("#lstTipoContrato option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Contrato \n ";
		control = false;
	}

	if ($("#lstUsuarioService option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Service Manager \n ";
		control = false;
	}

	if ($("#lstArea option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Area Contrato \n ";
		control = false;
	}

	if ($("#lstMoneda option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Moneda \n ";
		control = false;
	}

	if ($("#lstEmpresa option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Empresa \n ";
		control = false;
	}

	if ($("#lstUsuario option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Ejecutivo \n ";
		control = false;
	}

	if (validatefechaMayorQue(document.frmContrato.fechaInicio.value, document.frmContrato.FechaTermino.value))

	{

		mensaje += "- La fecha de Termino " + document.frmContrato.FechaTermino.value + "  es inferior a la fecha de Inicio "
				+ document.frmContrato.fechaInicio.value;
		control = false;
	}
	

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarInformeMensual() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.informeMensual.numeroContrato.value == 0) {

		mensaje += "- Campo N&uacute;mero Contrato vac&iacute;o \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarBoleta() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.crearBoleta.numeroContrato.value == 0) {

		mensaje += "- Campo N&uacute;mero  Contrato vac&iacute;o \n ";
		control = false;
	}

	if (document.crearBoleta.objetivo.value == 0) {

		mensaje += "- Campo Objetivo vac&iacute;o \n ";
		control = false;
	}

	if (document.crearBoleta.numeroContrato.value == 0) {

		mensaje += "- Campo N&uacute;mero Contrato vac&iacute;o \n ";
		control = false;
	}

	if ($("#lstBanco option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Banco \n ";
		control = false;
	}

	if (document.crearBoleta.fechaVigencia.value == 0) {

		mensaje += "- Campo Fecha Vigencia vac&iacute;o \n ";
		control = false;
	}

	if (document.crearBoleta.valor.value == 0) {

		mensaje += "- Campo Valor vac&iacute;o \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validarIncidencia() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.frmIncidencia.idReporte.value == 0) {

		mensaje += "- Campo Id Reporte vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.numReporte.value == 0) {

		mensaje += "- Campo N&uacute;mero de Reporte vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.fechaReporte.value == 0) {

		mensaje += "- Campo fecha de reporte vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.resposableReporte.value == 0) {

		mensaje += "- Campo hora Responsable Reporte vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.problema.value == 0) {

		mensaje += "- Campo problema vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.sistemaAfectado.value == 0) {

		mensaje += "- Campo sistema afectado vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.horaInicio.value == 0) {

		mensaje += "- Campo hora inicio vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.horaTermino.value == 0) {

		mensaje += "- Campo hora termino vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.diagnosticoInicial.value == 0) {

		mensaje += "- Campo diagnostico inicial vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.accionesRealizadas.value == 0) {

		mensaje += "- Campo acciones realizadas vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.detalleProblema.value == 0) {

		mensaje += "- Campo detalle del problema vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.causa.value == 0) {

		mensaje += "- Campo causa vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.solucionParcial.value == 0) {

		mensaje += "- Campo soluci&oacute;n parcial vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.solucionFinal.value == 0) {

		mensaje += "- Campo soluci&oacute;n final vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.tiempoEstimado.value == 0) {

		mensaje += "- Campo tiempo estimado vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.antecedentesAdicionales.value == 0) {

		mensaje += "- Campo antecedentes adicionales vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.solucionPlanteada.value == 0) {

		mensaje += "- Campo soluci&oacute;n planteada vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.responsableSolucion.value == 0) {

		mensaje += "- Campo responsable solucion vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.tiempoEstimadoSolucion.value == 0) {

		mensaje += "- Campo tiempo estimado soluci&oacute;n vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.hitos.value == 0) {

		mensaje += "- Campo hitos vac&iacute;o \n ";
		control = false;
	}

	if (document.frmIncidencia.fechaHito.value == 0) {

		mensaje += "- Campo fecha hito vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="idAlarma"]').is(':checked')) {

	} else {
		mensaje += "- Campo tipo visita vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="estadoIncidente"]').is(':checked')) {

	} else {
		mensaje += "- Campo estado incidente vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="idTipoIncidente"]').is(':checked')) {

	} else {
		mensaje += "- Campo tipo incidente vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="idImpacto"]').is(':checked')) {

	} else {
		mensaje += "- Campo impacto vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="idContexto"]').is(':checked')) {

	} else {
		mensaje += "- Campo contexto vac&iacute;o \n ";
		control = false;
	}

	if ($("#lstEmpresa option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Empresa \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}
}
function validaActivacion() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.activarContrato.gp.value == 0) {

		mensaje += "- Campo C&oacute;digo GP vac&iacute;o \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validaEdicion() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.feditarUsuario.nombre.value == 0) {

		mensaje += "- Campo Nombre vac&iacute;o \n ";
		control = false;
	}
	if (document.feditarUsuario.email.value == 0) {

		mensaje += "- Campo email vac&iacute;o \n ";
		control = false;
	}
	if ($("#lstTipoUsuario option:selected").val() == 0) {

		mensaje += "- Debe Seleccionar Tipo Usuario \n ";
		control = false;
	}

	if ($('input[name="estadoUsuario"]').is(':checked')) {

	} else {
		mensaje += "- Debe seleccionar Estado \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validaEdicionCliente() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.editarEmpresa.direccion.value == 0) {

		mensaje += "- Campo Direcci&oacute;n vac&iacute;o \n ";
		control = false;
	}
	if (document.editarEmpresa.telefono.value == 0) {

		mensaje += "- Campo Tel&eacute;fono vac&iacute;o \n ";
		control = false;
	}
	
	if (document.editarEmpresa.nombre.value == 0) {

		mensaje += "- Campo Nombre Fantasía vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="estado"]').is(':checked')) {

	} else {
		mensaje += "- Debe seleccionar Estado \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validaContacto() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.crearContacto.nombre.value == 0) {

		mensaje += "- Campo Nombre vac&iacute;o \n ";
		control = false;
	}
	if (document.crearContacto.correo.value == 0) {

		mensaje += "- Campo Correo vac&iacute;o \n ";
		control = false;
	}
	
	if (document.crearContacto.telefono.value == 0) {

		mensaje += "- Campo Tel&eacute;fono vac&iacute;o \n ";
		control = false;
	}

	if (document.crearContacto.correo.value != "") {
		if (isEmailValido(document.crearContacto.correo.value)) {

			mensaje += "- La direcci&oacute;n de e-mail tiene un formato inv&aacute;lido. \n ";
			control = false;
		}

	}


	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}

function validaCliente() {

	var mensaje = "Favor ingresar datos a las siguientes campos: \n ";
	var verificar = 0;
	var control = true;

	if (document.crearEmpresa.rutEmpresa.value == 0) {

		mensaje += "- Campo Rut Empresa vac&iacute;o \n ";
		control = false;
	}

	if (document.crearEmpresa.digitoVerificador.value == 0) {

		mensaje += "- Campo D&iacute;gito Verificador vac&iacute;o \n ";
		control = false;
	}

	if (document.crearEmpresa.razonSocial.value == 0) {

		mensaje += "- Campo Raz&oacute;n Social vac&iacute;o \n ";
		control = false;
	}

	if (document.crearEmpresa.nombre.value == 0) {

		mensaje += "- Campo Nombre Cliente vac&iacute;o \n ";
		control = false;
	}

	if (document.crearEmpresa.direccion.value == 0) {

		mensaje += "- Campo Direcci&oacute;n vac&iacute;o \n ";
		control = false;
	}
	if (document.crearEmpresa.telefono.value == 0) {

		mensaje += "- Campo Tel&eacute;fono vac&iacute;o \n ";
		control = false;
	}

	if ($('input[name="estado"]').is(':checked')) {

	} else {
		mensaje += "- Debe seleccionar Estado \n ";
		control = false;
	}

	if (control) {

		return control;
	} else {
		jAlert(mensaje, 'Validaci\u00F3n De Campos');
	}

}
