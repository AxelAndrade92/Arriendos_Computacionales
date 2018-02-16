package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.EmpresaDao;
import cl.st.reporte.dao.impl.PersonaDao;
import cl.st.reporte.dao.impl.RegionDao;
import cl.st.reporte.dao.impl.SbuDao;
import cl.st.reporte.model.EmpresaBean;
import cl.st.reporte.model.SbuBean;

import com.opensymphony.xwork2.Action;

public class SbuuAction {
	
	private List<SbuBean> listasbubean;
	private List<EmpresaBean> empresaBean;
	private SbuBean sbu;
	private InputStream inputStream;
	
	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	private int idSbu;
	private String nombreSbu;
	private int empresa;
	
	
	

	public String getNombreSbu() {
		return nombreSbu;
	}

	public void setNombreSbu(String nombreSbu) {
		this.nombreSbu = nombreSbu;
	}

	public int getEmpresa() {
		return empresa;
	}

	public void setEmpresa(int empresa) {
		this.empresa = empresa;
	}

	public String execute () throws Exception{
		
		System.out.println("Pasando por el execute() sbu");
		try {
			SbuDao sbu = new SbuDao(ConnectionPool.getInstance().getConnectionDB2());
			listasbubean = sbu.listar(idSbu);
		} catch (Exception e) {
			System.out.println("ERROR en SbuActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

	public String listarSbu () throws Exception{
		
		System.out.println("Pasando por el listar() sbu");
		try {
			SbuDao sbu = new SbuDao(ConnectionPool.getInstance().getConnectionDB2());
				listasbubean = sbu.listar(idSbu);
			
		} catch (Exception e) {
			System.out.println("ERROR en ListardosAction: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("pasando por insertar sbu");
		try {
			SbuDao sb = new SbuDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sb.insertar(sbu)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}			
		} catch (Exception e) {
			System.out.println("Error en Insertar Sbu "+e.getMessage());
		}
		return Action.SUCCESS;
	}

	public String actualizar(){
		System.out.println("Pasando por actualizar sbu");
		try {
			SbuDao sb = new SbuDao(ConnectionPool.getInstance().getConnectionDB2());
			if (sb.actualizar(sbu)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}			
		} catch (Exception e) {
			System.out.println("Error en Actualizar Sbu "+e.getMessage());
		}
		
		return Action.SUCCESS;
	}
	
	public String listarEmpresas(){
		System.out.println("Pasando por el listar empresas Sbu");
		try {
			EmpresaDao em = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
			empresaBean = em.listar(0);
			
		} catch (Exception e) {
			System.out.println("Error en listar Empresas Sbu :"+e.getMessage());
		}
		
		return Action.SUCCESS;
	}
	
	public String actualizarSbu(){
		System.out.println("Pasando por actualizar sbu");
		try {
			SbuDao sb = new SbuDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sb.actualizar(sbu)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}			
		} catch (Exception e) {
			System.out.println("error al actualizar "+e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	
	public List<SbuBean> getListasbubean() {
		return listasbubean;
	}
	public void setListasbubean(List<SbuBean> listasbubean) {
		this.listasbubean = listasbubean;
	}
	public void setSbubean(SbuBean sbu) {
		this.sbu = sbu;
	}
	
	public List<SbuBean> getSbubean() {
		return listasbubean;
	}


	public void setSbubean(List<SbuBean> listasbubean) {
		this.listasbubean = listasbubean;
	}
	
	

	public List<EmpresaBean> getEmpresaBean() {
		return empresaBean;
	}

	public void setEmpresaBean(List<EmpresaBean> empresaBean) {
		this.empresaBean = empresaBean;
	}
	
	public int getIdSbu() {
		return idSbu;
	}

	public void setIdSbu(int idSbu) {
		this.idSbu = idSbu;
	}

	public SbuBean getSbu() {
		return sbu;
	}

	public void setSbu(SbuBean sbu) {
		this.sbu = sbu;
	}

	
	

}
