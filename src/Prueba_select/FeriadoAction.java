package Prueba_select;

import java.sql.Date;
import java.util.List;

import org.apache.struts2.json.annotations.JSON;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.FeriadoDao;
import cl.st.reporte.dao.impl.RegionDao;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class FeriadoAction extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<Date> feriados;
	
	public String listar(){
		
		System.out.println("Pasando por el execute() FeriadoAction");
		try {
			FeriadoDao fd = new FeriadoDao(ConnectionPool.getInstance().getConnectionDB2());
			feriados = fd.listar();
		} catch (Exception e) {
			System.out.println("ERROR en FeriadoAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	@JSON(format="yyyy/MM/dd")
	public List<Date> getFeriados() {
		return feriados;
	}

	public void setFeriados(List<Date> feriados) {
		this.feriados = feriados;
	}
	
}
