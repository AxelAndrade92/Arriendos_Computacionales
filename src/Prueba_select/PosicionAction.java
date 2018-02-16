package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.PosicionDao;
import cl.st.reporte.model.PosicionBean;

public class PosicionAction {
	
	private int id;
	private PosicionBean pos;
	private List<PosicionBean> lista_posiciones;
	
	
	public String listar() throws Exception{	
		
		System.out.println("Pasando por listar Posiciones");
		
		try {
			PosicionDao po = new PosicionDao(ConnectionPool.getInstance().getConnectionDB2());
			lista_posiciones = po.listar(pos.getRack());
			System.out.println("lista : "+lista_posiciones);
		} catch (Exception e) {
			System.out.println("Error en listar Posiciones :"+e.getMessage());
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
	public PosicionBean getPos() {
		return pos;
	}
	public void setPos(PosicionBean pos) {
		this.pos = pos;
	}
	public List<PosicionBean> getLista_posiciones() {
		return lista_posiciones;
	}
	public void setLista_posiciones(List<PosicionBean> lista_posiciones) {
		this.lista_posiciones = lista_posiciones;
	}
	
	
	

}
