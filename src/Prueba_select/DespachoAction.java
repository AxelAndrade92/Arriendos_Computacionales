package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.DespachoDao;
import cl.st.reporte.model.CourierBean;
import cl.st.reporte.model.DespachoBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class DespachoAction extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int idActivo;
	private List<DespachoBean> despacho;
	private List<CourierBean> courier;
	private int idcourier;
	
	
	/*public String validar_activo() throws Exception{
		System.out.println("Pasando por DespachoAction");
				
		try {
			DespachoDao dp = new DespachoDao(ConnectionPool.getInstance().getConnectionDB2());
			despacho = dp.validar_activo(idActivo);
		} catch (Exception e) {
			System.out.println("Error en validar Activo");
		}
		
		return Action.SUCCESS;
	}
*/
	
	public String listar_courier() throws Exception{
		System.out.println("Pasando por el listar courier");
		
		try {
			DespachoDao dp = new DespachoDao(ConnectionPool.getInstance().getConnectionDB2());
			courier =  dp.listar(idcourier);
		} catch (Exception e) {
			System.out.println("Error en listar Action Courier error : "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

	public int getIdActivo() {
		return idActivo;
	}


	public void setIdActivo(int idActivo) {
		this.idActivo = idActivo;
	}


	public List<DespachoBean> getDespacho() {
		return despacho;
	}


	public void setDespacho(List<DespachoBean> despacho) {
		this.despacho = despacho;
	}

	public List<CourierBean> getCourier() {
		return courier;
	}

	public void setCourier(List<CourierBean> courier) {
		this.courier = courier;
	}

	public int getIdcourier() {
		return idcourier;
	}

	public void setIdcourier(int idcourier) {
		this.idcourier = idcourier;
	}

	
	
	
	
	

}
