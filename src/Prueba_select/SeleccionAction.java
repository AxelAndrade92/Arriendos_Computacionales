package Prueba_select;

import java.util.ArrayList;
import java.util.List;

import cl.st.reporte.business.impl.GenericBL;
import cl.st.reporte.bussiness.interfaces.IGenericBL;
import cl.st.reporte.model.BaseBean;

public class SeleccionAction {

	private String NombreCiudad;
	private List<BaseBean> Ciudades;

	public String execute() {
		if (NombreCiudad == null || NombreCiudad.trim().length() == 0) {
			
			
			IGenericBL iGneric = new GenericBL();
			try {
				Ciudades = iGneric.listaCiudades();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "INDEX";
			
		}
		return "SUCCESS";
		
	}

	public String getNombreCiudad() {
		return NombreCiudad;
	}

	public void setNombreCiudad(String NombreCiudad) {
		this.NombreCiudad = NombreCiudad;
	}

	public List<BaseBean> getCiudades() {
		return Ciudades;
	}

	public void setCiudades(List<BaseBean> ciudades) {
		Ciudades = ciudades;
	}

}
