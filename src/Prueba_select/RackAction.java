package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.RackDao;
import cl.st.reporte.model.RackBean;

public class RackAction {
	
	private int id;
	private List<RackBean> rckbean;
	private RackBean rack;


	public String listar() throws Exception {
		System.out.println("Pasando por el listar Rack");
		try {
			RackDao rd = new RackDao(ConnectionPool.getInstance().getConnectionDB2());
			rckbean = rd.listar(122);
			System.out.println(rckbean.size());
			System.out.println(rckbean);
		} catch (Exception e) {
			System.out.println("ERROR en RackActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		
		return Action.SUCCESS;
	}
	
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}




	public List<RackBean> getRckbean() {
		return rckbean;
	}




	public void setRckbean(List<RackBean> rckbean) {
		this.rckbean = rckbean;
	}




	public RackBean getRack() {
		return rack;
	}




	public void setRack(RackBean rack) {
		this.rack = rack;
	}
	
	
	
	

}
