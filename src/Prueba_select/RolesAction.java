package Prueba_select;

import java.util.List;

import com.opensymphony.xwork2.Action;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.RolesDao;
import cl.st.reporte.model.RolesBean;

public class RolesAction {
	
	private List<RolesBean> roles;
	private int idRol;
	
	public String execute() throws Exception{
		
		System.out.println("Pasando por el execute() RolesAction");
		try {
			RolesDao cd = new RolesDao(ConnectionPool.getInstance().getConnectionDB2());
			roles = cd.listar(idRol);
		} catch (Exception e) {
			System.out.println("ERROR en RolesAction: "+e.getMessage());
			e.printStackTrace();
		}
		
		
		return Action.SUCCESS;
		
	}
	
	public List<RolesBean> getRoles() {
		return roles;
	}
	public void setRoles(List<RolesBean> roles) {
		this.roles = roles;
	}
	public int getIdRol() {
		return idRol;
	}
	public void setIdRol(int idRol) {
		this.idRol = idRol;
	}

}
