package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.UenDao;
import cl.st.reporte.model.UenBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class UenAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<UenBean> uenes;
	private int idEmpresa;
	
	@Override
	public String execute() throws Exception {
		
		System.out.println("Pasando por el execute() UenAction");
		try {
			UenDao cd = new UenDao(ConnectionPool.getInstance().getConnectionDB2());
			uenes = cd.listar(idEmpresa);
		} catch (Exception e) {
			System.out.println("ERROR en UenAction: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

	public List<UenBean> getUenes() {
		return uenes;
	}

	public void setUenes(List<UenBean> uenes) {
		this.uenes = uenes;
	}

	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}
}
