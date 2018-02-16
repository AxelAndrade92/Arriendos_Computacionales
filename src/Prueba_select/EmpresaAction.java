package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.business.impl.ReporteBL;
import cl.st.reporte.bussiness.interfaces.IReporteBL;
import cl.st.reporte.dao.impl.EmpresaDao;
import cl.st.reporte.dao.impl.SucursalDao;
import cl.st.reporte.model.EmpresaBean;
import cl.st.reporte.model.ReporteBean;
import cl.st.reporte.model.SucursalBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class EmpresaAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<EmpresaBean> empresas;
	private int idEmpresa;
	private EmpresaBean empresaBean;
	private InputStream inputStream;
	boolean estado = false;
	

	
	
	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	@Override
	public String execute() throws Exception {
		System.out.println("Pasando por el execute() empresas");
		try {
			EmpresaDao cd = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
			empresas = cd.listar(idEmpresa);
			
		} catch (Exception e) {
			System.out.println("ERROR en EmpresaActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Lógica para insertar Empresa");
		try {
			EmpresaDao sd = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sd.insertar(empresaBean)){
				inputStream
				 = new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream
				 = new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
			
		} catch (Exception e) {
			System.out.println("ERROR en EmpresaActionInsertar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
   public String listar() throws Exception {
		
		System.out.println("Pasando por el listar() empresas");
		try {
			EmpresaDao cd = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println(empresaBean.getNombre().toUpperCase());
			empresas = cd.listarEmpresas(empresaBean.getNombre().toUpperCase());
		} catch (Exception e) {
			System.out.println("ERROR en EmpresaActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
   
   public String actualizar(){
		System.out.println("Lógica para actualizar Empresa");
		try {
			EmpresaDao sd = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
				if(sd.actualizar(empresaBean)){
				inputStream
				 = new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream
				 = new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en EmpresaActionActualizar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
   
	
	
	

	public List<EmpresaBean> getEmpresas() {
		return empresas;
	}

	public void setEmpresas(List<EmpresaBean> empresas) {
		this.empresas = empresas;
	}

	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	public EmpresaBean getEmpresaBean() {
		return empresaBean;
	}

	public void setEmpresaBean(EmpresaBean empresaBean) {
		this.empresaBean = empresaBean;
	}

	
}
