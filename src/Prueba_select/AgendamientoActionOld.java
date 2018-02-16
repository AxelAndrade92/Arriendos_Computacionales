package Prueba_select;

import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.AgendamientoDao;
import cl.st.reporte.model.AgendamientoBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class AgendamientoActionOld extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String fechaSeleccionada;
	private List<AgendamientoBean> agendamientos;
	private boolean AM;
	private boolean PM;
	private AgendamientoBean agendamientoBean;
	
	@Override
	public String execute() throws Exception {
		System.out.println("En el execute() de agendamiento");
		return Action.SUCCESS;
	}
	
	public String insertar() {
		System.out.println("En el insertar() de agendamiento");
		try {
			AgendamientoDao ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			ad.insertar(agendamientoBean);
		} catch (Exception e) {
			System.out.println("ERROR en AgendamientoAction:: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String buscar() throws Exception {
		System.out.println("En el buscar() de agendamiento");
		agendamientoBean.setHorario(1);
		int parametroTopeAm = 2;
		int parametroTopePm = 2;
		AM = false;
		PM = false;
		try {
			AgendamientoDao ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			if(ad.contar(agendamientoBean) < parametroTopeAm){
	        	AM = true;
	        }
			ad = new AgendamientoDao(ConnectionPool.getInstance().getConnectionDB2());
			agendamientoBean.setHorario(2);
			if(ad.contar(agendamientoBean) < parametroTopePm){
	        	PM = true;
	        }
		} catch (Exception e) {
			System.out.println("ERROR en AgendamientoAction:: "+e.getMessage());
			e.printStackTrace();
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
}
