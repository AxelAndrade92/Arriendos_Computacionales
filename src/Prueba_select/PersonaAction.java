package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.business.impl.ReporteBL;
import cl.st.reporte.bussiness.interfaces.IReporteBL;
import cl.st.reporte.dao.impl.EmpresaDao;
import cl.st.reporte.dao.impl.PersonaDao;
import cl.st.reporte.model.BusquedaPersonaBean;
import cl.st.reporte.model.BusquedaSBUBean;
import cl.st.reporte.model.EmpresaBean;
import cl.st.reporte.model.PersonaBean;
import cl.st.reporte.model.ReporteBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class PersonaAction extends ActionSupport{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<PersonaBean> personas;
	private String rutPersona;
	private PersonaBean personaBean;
	private List<BusquedaPersonaBean> busquedaPersonas;
	private InputStream inputStream;

	
	@Override
	public String execute() throws Exception {
		System.out.println("Pasando por el execute() Personas");
		try {
			PersonaDao cd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println("el rut enviado es "+rutPersona);
			busquedaPersonas = cd.listar(rutPersona);			
			
		} catch (Exception e) {
			System.out.println("ERROR en PersonasActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Lógica para insertar Persona");
		try {
			PersonaDao sd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println(personaBean);
			if(sd.insertar(personaBean)){
				inputStream
				 = new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream
				 = new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
			
//			sd.insertar(personaBean);
//			System.out.println(personaBean);
		} catch (Exception e) {
			System.out.println("ERROR en PersonaActionInsertar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
   public String listar() throws Exception {//Busqueda por Rut de la Persona
	
		System.out.println("Pasando por el listar() Personas");
		try {
			PersonaDao cd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println(personaBean.getRutPer());
			busquedaPersonas = cd.listarPersonas(personaBean.getRutPer());
		} catch (Exception e) {
			System.out.println("ERROR en PersonaActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

   public String actualizar(){
	System.out.println("Lógica para actualizar Persona");
	try {
		PersonaDao sd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
		;
		if(sd.actualizar(personaBean)){
			inputStream
			 = new ByteArrayInputStream("Ocurrió un problema, intente más tarde actualizar el registro".getBytes("UTF-8"));
		}else{
			inputStream
			 = new ByteArrayInputStream("Se actualizó correctamente el registro".getBytes("UTF-8"));
		}
	} catch (Exception e) {
		System.out.println("ERROR en PersonaActionActualizar: "+e.getMessage());
		e.printStackTrace();
	}
	return Action.SUCCESS;
   }
	
	public String buscarPersonaPorRut(){
		PersonaDao pd;
		try {
			pd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
			personaBean = pd.buscarPersonaPorRut(personaBean.getRutPer());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
//	public String Buscar_Persona(){
//		System.out.println("Lógica para buscar Persona");
//		try {
//			PersonaDao sd = new PersonaDao(ConnectionPool.getInstance().getConnectionDB2());
//			sd.buscar(personaBean);
//		} catch (Exception e) {
//			System.out.println("ERROR en PersonaActionBuscar: "+e.getMessage());
//			e.printStackTrace();
//		}
//		return Action.SUCCESS;
//}
//   private void listaReportes() {
//		
//		try {
//			iReporte = new ReporteBL();
//			
//			//reporteSbu = iReporte.listaSbu();
//			
////			reporteUEN=iReporte.listaUnidadNegocio();
////			reporteEmpresa=iReporte.listaEmpresa();
////			System.out.println(reporteUEN);
//			
//
//		} catch (Exception e) {
//			System.out.println("ERROR method:: listaReportes(), "
//					+ e.getMessage());
//		}
//		
//	}
	



	public List<PersonaBean> getPersonas() {
		return personas;
	}
	public void setPersonas(List<PersonaBean> personas) {
		this.personas = personas;
	}
	public String getRutPersona() {
		return rutPersona;
	}
	public void setRutPersona(String rutPersona) {
		this.rutPersona = rutPersona;
	}
	public PersonaBean getPersonaBean() {
		return personaBean;
	}
	public void setPersonaBean(PersonaBean personaBean) {
		this.personaBean = personaBean;
	}

	public List<BusquedaPersonaBean> getBusquedaPersonas() {
		return busquedaPersonas;
	}

	public void setBusquedaPersonas(List<BusquedaPersonaBean> busquedaPersonas) {
		this.busquedaPersonas = busquedaPersonas;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	

//	public List<BusquedaSBUBean> getReporteSbu2() {
//		return reporteSbu2;
//	}

//	public void setReporteSbu2(List<BusquedaSBUBean> reporteSbu2) {
//		this.reporteSbu2 = reporteSbu2;
//	}
//
//	public List<BusquedaSBUBean> getReporteSbuBuscar() {
//		return reporteSbuBuscar;
//	}
//
//	public void setReporteSbuBuscar(List<BusquedaSBUBean> reporteSbuBuscar) {
//		this.reporteSbuBuscar = reporteSbuBuscar;
//	}
//
//	public List<ReporteBean> getReporte() {
//		return reporte;
//	}
//
//	public void setReporte(List<ReporteBean> reporte) {
//		this.reporte = reporte;
//	}
//
//	public List<ReporteBean> getReporteUEN() {
//		return reporteUEN;
//	}
//
//	public void setReporteUEN(List<ReporteBean> reporteUEN) {
//		this.reporteUEN = reporteUEN;
//	}
//
//	public List<EmpresaBean> getReporteEmpresa() {
//		return reporteEmpresa;
//	}
//
//	public void setReporteEmpresa(List<EmpresaBean> reporteEmpresa) {
//		this.reporteEmpresa = reporteEmpresa;
//	}
//	

}
