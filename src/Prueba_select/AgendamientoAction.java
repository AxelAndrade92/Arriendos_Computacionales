package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.AgendamientoDao;
import cl.st.reporte.dao.impl.TopesDao;
import cl.st.reporte.model.AgendamientoBean;
import cl.st.reporte.model.BusquedaAgendamientoBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class AgendamientoAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fechaSeleccionada;
	private List<AgendamientoBean> agendamientos;
	private List<BusquedaAgendamientoBean> busquedaAgendamientosBean;
	private boolean AM;
	private boolean PM;
	private AgendamientoBean agendamientoBean;
	private InputStream inputStream;
    
	
	@Override
	public String execute() throws Exception {
		System.out.println("En el execute() de agendamiento");
		return Action.SUCCESS;
	}
	
	public String insertar() {
		System.out.println("En el insertar() de agendamiento");
		try {
			AgendamientoDao ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			if(ad.insertar(agendamientoBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en AgendamientoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String buscar() throws Exception {
		System.out.println("En el buscar() de agendamiento");
		int parametroTopes= 0;
		agendamientoBean.setHorario(1);
		AM = false;
		PM = false;
		
		try {
			TopesDao td = new TopesDao(ConnectionPool.getInstance().getConnectionDB2());
			parametroTopes = td.buscar(agendamientoBean.getRegion());
			AgendamientoDao ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			System.out.println("parametro: "+parametroTopes);
			if(ad.contar(agendamientoBean) < (parametroTopes/2)){
	        	AM = true;
	        }
			ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			agendamientoBean.setHorario(2);
			if(ad.contar(agendamientoBean) < (parametroTopes/2)){
	        	PM = true;
	        }
		} catch (Exception e) {
			System.out.println("ERROR en AgendamientoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String agendado(){
		System.out.println("Pasando por agendado() en AgendamientoAction");
		return Action.SUCCESS;
	}
	
	public String buscarAgendado(){
		System.out.println("Pasando por buscarAgendado() en AgendamientoAction");
		String[] fechas = fechaSeleccionada.split(";");
		if(fechas.length != 0 ){
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			long[] fechasParseadas = new long[2];
			try {
				fechasParseadas[0] = (df.parse(fechas[0]).getTime());
				fechasParseadas[1] = (df.parse(fechas[1]).getTime());
				AgendamientoDao ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
				busquedaAgendamientosBean = ad.buscarAgendado(fechasParseadas);
			} catch (Exception e) {
				System.out.println("ERROR en AgendamientoAction:: "+e.getMessage());
				e.printStackTrace();
			}
		}
		return Action.SUCCESS;
	}

	public String getFechaSeleccionada() {
		return fechaSeleccionada;
	}

	public void setFechaSeleccionada(String fechaSeleccionada) {
		this.fechaSeleccionada = fechaSeleccionada;
	}

	public List<AgendamientoBean> getAgendamientos() {
		return agendamientos;
	}

	public void setAgendamientos(List<AgendamientoBean> agendamientos) {
		this.agendamientos = agendamientos;
	}

	public boolean isAM() {
		return AM;
	}

	public void setAM(boolean aM) {
		AM = aM;
	}

	public boolean isPM() {
		return PM;
	}

	public void setPM(boolean pM) {
		PM = pM;
	}

	public AgendamientoBean getAgendamientoBean() {
		return agendamientoBean;
	}

	public void setAgendamientoBean(AgendamientoBean agendamientoBean) {
		this.agendamientoBean = agendamientoBean;
	}
	public InputStream getInputStream() {
        return inputStream;
    }

	public List<BusquedaAgendamientoBean> getBusquedaAgendamientosBean() {
		return busquedaAgendamientosBean;
	}

	public void setBusquedaAgendamientosBean(
			List<BusquedaAgendamientoBean> busquedaAgendamientosBean) {
		this.busquedaAgendamientosBean = busquedaAgendamientosBean;
	}
}
