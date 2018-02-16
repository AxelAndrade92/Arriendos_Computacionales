package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.PartesDao;
import cl.st.reporte.model.PartesPiezasBean;



public class PartesPiezasAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<PartesPiezasBean> partes;
	private int idPartes;
	private PartesPiezasBean partesBean;
	
	
	@Override
	public String execute() throws Exception {
		System.out.println("Pasando por el execute() Partes y Piezas");
		try {
			PartesDao cd = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
			partes = cd.listar(idPartes);
		} catch (Exception e) {
			System.out.println("ERROR en PartesActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Lógica para insertar Piezas");
		try {
			PartesDao sd = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
			sd.insertar(partesBean);
		} catch (Exception e) {
			System.out.println("ERROR en PartesActionInsertar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String listarPiezas() throws Exception {
		
		System.out.println("Pasando por el listar() piezas");
		try {
			PartesDao cd = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
//			System.out.println(partesBean.getPartesPiezas().toUpperCase());
			partes = cd.listarPiezas(idPartes);
		} catch (Exception e) {
			System.out.println("ERROR en PiezasActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String actualizar(){
		System.out.println("Lógica para actualizar Piezas");
		try {
			PartesDao sd = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
			sd.actualizar(partesBean);
		} catch (Exception e) {
			System.out.println("ERROR en PiezasActionActualizar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	
	
	
	
	
	
	
	
	
	public List<PartesPiezasBean> getPartes() {
		return partes;
	}
	public void setPartes(List<PartesPiezasBean> partes) {
		this.partes = partes;
	}
	public int getIdPartes() {
		return idPartes;
	}
	public void setIdPartes(int idPartes) {
		this.idPartes = idPartes;
	}
	public PartesPiezasBean getPartesBean() {
		return partesBean;
	}
	public void setPartesBean(PartesPiezasBean partesBean) {
		this.partesBean = partesBean;
	}

}
