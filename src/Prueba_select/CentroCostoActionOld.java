package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.CentroCostoDao;
import cl.st.reporte.model.CCBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class CentroCostoActionOld extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private List<CCBean> ccs;
	private int idUen;
	
	@Override
	public String execute() throws Exception {
		/*ccs = new ArrayList<CCBean>();
		ccs.add(new CCBean(1, "Gerencia X", "123124155", 1));
		ccs.add(new CCBean(1, "Gerencia Y", "123153465", 2));
		ccs.add(new CCBean(1, "Gerencia Z", "123153675", 1));*/
		CentroCostoDao ccd = new CentroCostoDao(ConnectionPool.getInstance().getConnectionDB2());
		ccs = ccd.listar(idUen);
		return Action.SUCCESS;
	}

	public List<CCBean> getCcs() {
		return ccs;
	}

	public void setCcs(List<CCBean> ccs) {
		this.ccs = ccs;
	}

	public int getIdUen() {
		return idUen;
	}

	public void setIdUen(int idUen) {
		this.idUen = idUen;
	}
}
