package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.ReceptorDao;
import cl.st.reporte.model.ReceptorBean;

public class ReceptorAction {
	
	private List<ReceptorBean> receptorbean;
	private int idReceptor;
	
	
	public String execute() throws Exception {
		System.out.println("Pasando por el execute() Receptores");
		try {
			ReceptorDao rd = new ReceptorDao(ConnectionPool.getInstance().getConnectionDB2());
			receptorbean = rd.listar(idReceptor);
			
		} catch (Exception e) {
			System.out.println("ERROR en BodegasActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public List<ReceptorBean> getReceptorbean() {
		return receptorbean;
	}
	public void setReceptorbean(List<ReceptorBean> receptorbean) {
		this.receptorbean = receptorbean;
	}
	public int getIdReceptor() {
		return idReceptor;
	}
	public void setIdReceptor(int idReceptor) {
		this.idReceptor = idReceptor;
	}
	
	

}
