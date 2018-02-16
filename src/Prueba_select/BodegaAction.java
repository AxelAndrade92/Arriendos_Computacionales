package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.BodegaDao;
import cl.st.reporte.model.BodegaBean;

public class BodegaAction {
	
	public List<BodegaBean> bodegabean;
	private int idbodega;
	
	

	public String execute() throws Exception {
		System.out.println("Pasando por el execute() bodegas");
		try {
			BodegaDao bd = new BodegaDao(ConnectionPool.getInstance().getConnectionDB2());
			bodegabean = bd.listar(idbodega);
			
		} catch (Exception e) {
			System.out.println("ERROR en BodegasActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	
	public List<BodegaBean> getBodegabean() {
		return bodegabean;
	}

	public void setBodegabean(List<BodegaBean> bodegabean) {
		this.bodegabean = bodegabean;
	}

	public int getIdbodega() {
		return idbodega;
	}

	public void setIdbodega(int idbodega) {
		this.idbodega = idbodega;
	}

}
