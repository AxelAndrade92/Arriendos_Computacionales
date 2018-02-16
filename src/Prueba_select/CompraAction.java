package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.CompraDao;
import cl.st.reporte.model.CompraBean;

public class CompraAction {
	
	private int id;
	private List<CompraBean> comprabean;
	private CompraBean compra;
	
	


	public String insertar(){
		System.out.println("Pasando por el Action Insertar Compra");
		System.out.println(compra);
		try {
			CompraDao cd = new CompraDao(ConnectionPool.getInstance().getConnectionDB2());
			cd.insertar(compra);
			
		} catch (Exception e) {
			System.out.println("Error al insertar Factura error :"+e.getMessage());
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
	public List<CompraBean> getComprabean() {
		return comprabean;
	}
	public void setComprabean(List<CompraBean> comprabean) {
		this.comprabean = comprabean;
	}
	
	public CompraBean getCompra() {
		return compra;
	}

	public void setCompra(CompraBean compra) {
		this.compra = compra;
	}

}
