package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.ProveedorDao;
import cl.st.reporte.model.ProveedorBean;

import com.opensymphony.xwork2.Action;

public class ProveedorAction {
	
	private List<ProveedorBean> proveedorbean;
	private int idProveedor;
	
	public String execute() throws Exception {
		System.out.println("Pasando por el execute() bodegas");
		try {
			ProveedorDao pd = new ProveedorDao(ConnectionPool.getInstance().getConnectionDB2());
			proveedorbean = pd.listar(idProveedor);
			
		} catch (Exception e) {
			System.out.println("ERROR en BodegasActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

	public List<ProveedorBean> getProveedorbean() {
		return proveedorbean;
	}

	public void setProveedorbean(List<ProveedorBean> proveedorbean) {
		this.proveedorbean = proveedorbean;
	}

	public int getIdProveedor() {
		return idProveedor;
	}

	public void setIdProveedor(int idProveedor) {
		this.idProveedor = idProveedor;
	}
	
	

}
