package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.ActivoDao;
import cl.st.reporte.dao.impl.AsignacionDao;
import cl.st.reporte.dao.impl.ConsultaDao;
import cl.st.reporte.model.ActivoBean;
import cl.st.reporte.model.AsignacionBean;
import cl.st.reporte.model.ConsultaBean;

public class ConsultaAction {
	
	private String serieConsultada;
	private List<ConsultaBean> consulta;
	private ConsultaBean cb;
	private String serie ;
	private InputStream inputStream;
	private String mensaje;
	private String nombre;
	private String fono;
	private String correo;
	private int empresa;
	private int sbu;
	private String anexo;
	private String direccion;
	private String estado;
	private String mensajeconsulta;
	
	
	
	
	public String execute(){
		System.out.println("Pasando por Execute");
		
		return Action.SUCCESS;
	}
	
	

	public String consultar_serie() throws Exception{
		System.out.println("Pasando por consultar serie ");
		
		try {
			ConsultaDao cd =  new ConsultaDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println("Serie Action "+cb.getSerie());
			consulta = cd.consultar_serie(cb.getSerie());	
			
			if (consulta.size()==0) {
				
				ActivoDao ad = new ActivoDao(ConnectionPool.getInstance().getConnectionDB2());				
				ActivoBean ab= ad.buscarActivoPorSerial(cb.getSerie());
				
				if (ab == null) {
					System.out.println("Serie NO se encuentra registrado en la Base de Datos");
					mensaje = "Serie No se encuentra registrado en la Base de Datos";
					ConsultaDao cdd = new ConsultaDao(ConnectionPool.getInstance().getConnectionDB2());
					nombre = cb.getNombre();
					correo = cb.getCorreo();
					fono = cb.getFono();
					empresa = cb.getIdEmpresa();
					sbu = cb.getIdSbu();
					anexo = cb.getAnexo();
					direccion = cb.getDireccion();
					serie = cb.getSerie();
					mensajeconsulta = "La serie consultada no existe en la Base de Datos";
					estado = "Error en Consulta : la serie ingresada no existe en la Base de Datos";
					cdd.insertar_datos_consulta(nombre, correo, fono, empresa, sbu, anexo, direccion, serie, mensajeconsulta, estado);
					System.out.println(nombre+" "+correo+" "+fono+" "+empresa+" "+sbu+" "+anexo+" "+direccion+" "+serie+" "+mensajeconsulta+" "+estado);
				}
			}else{
				Date fechaInicio = consulta.get(0).getFechainicio();
				Date fechaActual = new Date();
				Date fechaFin;
				
				Calendar cal = Calendar.getInstance();
		        cal.setTime(fechaInicio);
		        cal.add(Calendar.MONTH, 36);
		        fechaFin = cal.getTime();

		        System.out.println("Fecha fin :"+fechaFin);
		        
		        if (fechaFin.after(fechaActual)) {
		        	
		        	DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
					
					System.out.println("Todavia no te toca renovacion");
					mensaje = "<strong>Su Renovación está programada para "+formatoFecha.format(fechaFin)+"</strong>";	
					
					nombre = cb.getNombre();
					correo = cb.getCorreo();
					fono = cb.getFono();
					empresa = cb.getIdEmpresa();
					sbu = cb.getIdSbu();
					anexo = cb.getAnexo();
					direccion = cb.getDireccion();
					serie = cb.getSerie();
					ConsultaDao cdd = new ConsultaDao(ConnectionPool.getInstance().getConnectionDB2());
					mensajeconsulta = "No ingresa para Renovación de su Equipo.";
					estado = "Error en Consulta : No entra por fecha en el Proceso de Renovación";
					cdd.insertar_datos_consulta(nombre, correo, fono, empresa, sbu, anexo, direccion, serie, mensajeconsulta, estado);
					System.out.println(nombre+" "+correo+" "+fono+" "+empresa+" "+sbu+" "+anexo+" "+direccion+" "+serie+" "+mensajeconsulta+" "+estado);
				}else {
					DateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
					System.out.println("Fecha con formato :"+formatoFecha.format(fechaFin));
					
					System.out.println("Te toca renovacion para :"+formatoFecha.format(fechaFin));
					//mensaje = "<strong>Te toca renovacion en la Fecha "+fechaFin.getDay()+"-"+fechaFin.getMonth()+"-"+cal.get(Calendar.YEAR)+"</strong>";
					
					mensaje = "<strong>Te toca renovacion para la Fecha "+formatoFecha.format(fechaFin)+"</strong>";
					
					nombre = cb.getNombre();
					correo = cb.getCorreo();
					fono = cb.getFono();
					empresa = cb.getIdEmpresa();
					sbu = cb.getIdSbu();
					anexo = cb.getAnexo();
					direccion = cb.getDireccion();
					serie = cb.getSerie();
					ConsultaDao cdd = new ConsultaDao(ConnectionPool.getInstance().getConnectionDB2());
					
					mensajeconsulta = "Su Renovacion será para : "+formatoFecha.format(fechaFin);
					estado = "Exito en Consulta : Equipo ingresa al Proceso de Renovación";
					cdd.insertar_datos_consulta(nombre, correo, fono, empresa, sbu, anexo, direccion, serie, mensajeconsulta, estado);
					//System.out.println(nombre+" "+correo+" "+fono+" "+empresa+" "+sbu+" "+anexo+" "+direccion+" "+serie+" "+mensajeconsulta+" "+estado);
				}
			}
			
			
		} catch (Exception e) {
			System.out.println("Error en consultarSerieAction error:"+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	
	
	public String getMensajeconsulta() {
		return mensajeconsulta;
	}


	public void setMensajeconsulta(String mensajeconsulta) {
		this.mensajeconsulta = mensajeconsulta;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getFono() {
		return fono;
	}


	public void setFono(String fono) {
		this.fono = fono;
	}


	public String getCorreo() {
		return correo;
	}


	public void setCorreo(String correo) {
		this.correo = correo;
	}


	public int getEmpresa() {
		return empresa;
	}


	public void setEmpresa(int empresa) {
		this.empresa = empresa;
	}


	public int getSbu() {
		return sbu;
	}


	public void setSbu(int sbu) {
		this.sbu = sbu;
	}


	public String getAnexo() {
		return anexo;
	}


	public void setAnexo(String anexo) {
		this.anexo = anexo;
	}


	public String getDireccion() {
		return direccion;
	}


	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}


	public String getEstado() {
		return estado;
	}


	public void setEstado(String estado) {
		this.estado = estado;
	}


	public String getMensaje() {
		return mensaje;
	}


	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}


	public String getSerie() {
		return serie;
	}


	public void setSerie(String serie) {
		this.serie = serie;
	}


	public ConsultaBean getCb() {
		return cb;
	}
















	public void setCb(ConsultaBean cb) {
		this.cb = cb;
	}
















	public InputStream getInputStream() {
		return inputStream;
	}
















	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
















	public String getSerieConsultada() {
		return serieConsultada;
	}
	public void setSerieConsultada(String serieConsultada) {
		this.serieConsultada = serieConsultada;
	}
	public List<ConsultaBean> getConsulta() {
		return consulta;
	}
	public void setConsulta(List<ConsultaBean> consulta) {
		this.consulta = consulta;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
