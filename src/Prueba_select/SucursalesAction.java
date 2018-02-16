package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.SucursalDao;
import cl.st.reporte.model.BusquedaSucursalBean;
import cl.st.reporte.model.SucursalBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class SucursalesAction extends ActionSupport {

	/**
	 * Acciones para las sucursales cargar página, insertar nueva sucursal
	 * atualizar sucursales.
	 */
	private static final long serialVersionUID = 1L;
	private SucursalBean sucursalBean;
	private List<SucursalBean> sucursales;
	private List<BusquedaSucursalBean> busquedaSucursales;
	private InputStream inputStream;
	
	@Override
	public String execute() throws Exception {
		System.out.println("Lógica para cargar página");
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Lógica para insertar sucursal");
		try {
			SucursalDao sd = new SucursalDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sd.insertar(sucursalBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en SucursalesAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String actualizar(){
		System.out.println("Lógica para actualizar sucursal");
		try {
			SucursalDao sd = new SucursalDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sd.actualizar(sucursalBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue actualizado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro actualizado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en SucursalesAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public String listar(){
		System.out.println("Listar () SucursalesAction");
		try {
			SucursalDao sd = new SucursalDao(ConnectionPool.getInstance().getConnectionDB2());
			busquedaSucursales = sd.listar(0);
		} catch (Exception e) {
			System.out.println("ERROR en SucursalesAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public SucursalBean getSucursalBean() {
		return sucursalBean;
	}

	public void setSucursalBean(SucursalBean sucursalBean) {
		this.sucursalBean = sucursalBean;
	}

	public List<SucursalBean> getSucursales() {
		return sucursales;
	}

	public void setSucursales(List<SucursalBean> sucursales) {
		this.sucursales = sucursales;
	}

	public List<BusquedaSucursalBean> getBusquedaSucursales() {
		return busquedaSucursales;
	}

	public void setBusquedaSucursales(List<BusquedaSucursalBean> busquedaSucursales) {
		this.busquedaSucursales = busquedaSucursales;
	}
	public InputStream getInputStream() {
        return inputStream;
    }
}
