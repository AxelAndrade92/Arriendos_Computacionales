package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.CentroCostoDao;
import cl.st.reporte.model.CCBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class CentroCostoAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private List<CCBean> ccs;
	private int idUen;
	private CCBean ccBean;
	private InputStream inputStream;
	
	@Override
	public String execute() {
		try {
			CentroCostoDao ccd = new CentroCostoDao(ConnectionPool.getInstance().getConnectionDB2());
			ccs = ccd.listar(idUen);
		} catch (Exception e) {
			System.out.println("ERROR en CentroCostoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String pagina(){
		System.out.println("En el página() CentroCostoAction");
		try {
			CentroCostoDao ccd = new CentroCostoDao(ConnectionPool.getInstance().getConnectionDB2());
			ccs = ccd.listar(idUen);
		} catch (Exception e) {
			System.out.println("ERROR en CentroCostoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("En el insertar() CentroCostoAction");
		try {
			CentroCostoDao ccd = new CentroCostoDao(ConnectionPool.getInstance().getConnectionDB2());
			if(ccd.insertar(ccBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en CentroCostoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String actualizar(){
		System.out.println("En el actualizar() CentroCostoAction");
		try {
			CentroCostoDao ccd = new CentroCostoDao(ConnectionPool.getInstance().getConnectionDB2());
			if(ccd.actualizar(ccBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue actualizado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro actualizado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en CentroCostoAction:: "+e.getMessage());
			e.printStackTrace();
		}
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

	public CCBean getCcBean() {
		return ccBean;
	}

	public void setCcBean(CCBean ccBean) {
		this.ccBean = ccBean;
	}
	
	public InputStream getInputStream() {
        return inputStream;
    }
}
