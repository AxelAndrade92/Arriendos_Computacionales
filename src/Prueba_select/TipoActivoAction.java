package Prueba_select;



import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.TipoActivoDao;
import cl.st.reporte.model.TipoActivoBean;

public class TipoActivoAction {
	
	private List<TipoActivoBean> tipos;
	private int idmarca;
	private TipoActivoBean tipoactivobean;
	private String factura;
	private int bodega;
	private int empresa;
	


public String listar() throws Exception {
		
		System.out.println("Pasando por el listar() tipos");
		try {
			TipoActivoDao cd = new TipoActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println(tipoactivobean.getTipoActivo().toUpperCase());
			tipos = cd.listarTipos(tipoactivobean.getId());
		} catch (Exception e) {
			System.out.println("ERROR en TiposActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String listarGeneral() throws Exception {
		
		System.out.println("Pasando por el listarGeneral() tipos");
		try {
			TipoActivoDao cd = new TipoActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			tipos = cd.listar(0);
		} catch (Exception e) {
			System.out.println("ERROR en TiposActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}

	public List<TipoActivoBean> getTipos() {
		return tipos;
	}
	public void setTipos(List<TipoActivoBean> tipos) {
		this.tipos = tipos;
	}
	public int getIdmarca() {
		return idmarca;
	}
	public void setIdmarca(int idmarca) {
		this.idmarca = idmarca;
	}
	public TipoActivoBean getTipoactivobean() {
		return tipoactivobean;
	}
	public void setTipoactivobean(TipoActivoBean tipoactivobean) {
		this.tipoactivobean = tipoactivobean;
	}

	public String getFactura() {
		return factura;
	}

	public void setFactura(String factura) {
		this.factura = factura;
	}
	public int getBodega() {
		return bodega;
	}

	public void setBodega(int bodega) {
		this.bodega = bodega;
	}

	public int getEmpresa() {
		return empresa;
	}

	public void setEmpresa(int empresa) {
		this.empresa = empresa;
	}
}
