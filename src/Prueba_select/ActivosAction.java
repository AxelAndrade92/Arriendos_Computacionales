package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import com.opensymphony.xwork2.Action;

import cl.st.reporte.dao.impl.ActivoDao;
import cl.st.reporte.model.ActivoBean;

public class ActivosAction {
	
	private List<ActivoBean> activos;
	private int serieActivo;
	private ActivoBean actbean;
	private int factura;
	private String numero_producto;
	private InputStream inputStream;

	
	public String insertar_activo(){
		
		System.out.println("Metodo insertar activo");
		try {
			ActivoDao ad = new ActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println(actbean);
			if (ad.insertar(actbean)) {
				inputStream
				= new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
				
			}else {
				inputStream
				 = new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
				
			}
		} catch (Exception e) {
			System.out.println("Error al ingresar Activo");
		}
		
		
		return Action.SUCCESS;		
		
	}
	
	public String buscar_activo(){
		System.out.println("Pasando por Buscar Activos");
		try {
			ActivoDao ad = new ActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			activos = ad.buscarActivoPorNumeroProducto(actbean.getNum_producto().toUpperCase());
		} catch (Exception e) {
			System.out.println("Error en buscar Activo error: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String busca_factura_replicada(){
		
		System.out.println("Pasando por buscar Factura");
		try {
			ActivoDao ad = new ActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			activos = ad.buscarfacturareplicada(actbean.getFactura());
			if (activos.size()!=0) {
				inputStream
				= new ByteArrayInputStream("El Número de Factura Ingresado ya está registrado en la Base de Datos, intente con otro".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("Error en buscar factura error :"+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	
	
	public void setActbean(ActivoBean actbean) {
		this.actbean = actbean;
	}
	
	public List<ActivoBean> getActivos() {
		return activos;
	}
	public void setActivos(List<ActivoBean> activos) {
		this.activos = activos;
	}
	public int getSerieActivo() {
		return serieActivo;
	}
	public void setSerieActivo(int serieActivo) {
		this.serieActivo = serieActivo;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public ActivoBean getactbean() {
		return actbean;
	}
	public void setactbean(ActivoBean actbean) {
		this.actbean = actbean;
	}
	
	public ActivoBean getActbean() {
		return actbean;
	}
	public int getFactura() {
		return factura;
	}

	public void setFactura(int factura) {
		this.factura = factura;
	}

	public String getNumero_producto() {
		return numero_producto;
	}

	public void setNumero_producto(String numero_producto) {
		this.numero_producto = numero_producto;
	}
	
	
	

}
