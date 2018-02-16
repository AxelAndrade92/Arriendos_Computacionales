package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.ComunaDao;
import cl.st.reporte.model.ComunaBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class ComunaAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<ComunaBean> comunas;
	private int idRegion;
	
	@Override
	public String execute() throws Exception {
		
		System.out.println("Pasando por el execute() ComunaAction");
		try {
			ComunaDao cd = new ComunaDao(ConnectionPool.getInstance().getConnectionDB2());
			comunas = cd.listar(idRegion);
		} catch (Exception e) {
			System.out.println("ERROR en ComunaAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public List<ComunaBean> getComunas() {
		return comunas;
	}

	public void setComunas(List<ComunaBean> comunas) {
		this.comunas = comunas;
	}

	public int getIdRegion() {
		return idRegion;
	}

	public void setIdRegion(int idRegion) {
		this.idRegion = idRegion;
	}	
}
