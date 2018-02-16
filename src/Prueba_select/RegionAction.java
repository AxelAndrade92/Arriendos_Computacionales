package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.RegionDao;
import cl.st.reporte.model.RegionesBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class RegionAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<RegionesBean> regiones;
	
	public String execute(){
		
		System.out.println("Pasando por el execute() regiones");
		try {
			RegionDao rg = new RegionDao(ConnectionPool.getInstance().getConnectionDB2());
			regiones = rg.listar(0);
		} catch (Exception e) {
			System.out.println("ERROR en RegionAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public List<RegionesBean> getRegiones() {
		return regiones;
	}

	public void setRegiones(List<RegionesBean> regiones) {
		this.regiones = regiones;
	}
	
}