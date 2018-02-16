package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.inject.Inject;

import cl.st.common.ConnectionPool;
import cl.st.reporte.business.impl.Correo;
import cl.st.reporte.dao.impl.EnvioSolicitudDao;
import cl.st.reporte.dao.impl.SolicitudDao;
import cl.st.reporte.model.BusquedaEnvioSolicitud;
import cl.st.reporte.model.EnvioSolicitudBean;

public class EnvioSolicitudAction {
	
	private List<EnvioSolicitudBean> solicitudes;
	private EnvioSolicitudBean sol;
	private InputStream inputStream;
	
	@Inject(value = "renovaciones.email")
	private String correoInterno;
	
	@Inject(value = "correos")
	Correo correo;
	
	public String insertar(){
		System.out.println("Lógica para insertar EnvioSolicitud");
		int cantidadRegistros = solicitudes.size();
		try {
			System.out.println("Tamaño de la lista de solicitudes: "+cantidadRegistros);
			EnvioSolicitudDao sd = new EnvioSolicitudDao(ConnectionPool.getInstance().getConnectionDB2());
			if(sd.insertar(solicitudes)){
				inputStream = 
						new ByteArrayInputStream("La solicitud no pudo ser procesada, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("La solicitud fue procesada exitosamente".getBytes("UTF-8"));
				
				sd = new EnvioSolicitudDao(ConnectionPool.getInstance().getConnectionDB2());
				List<BusquedaEnvioSolicitud> lista = sd.buscar(cantidadRegistros);
				String aux = null,empresa = null, tabla = null, mensaje = null;
				tabla = "<table style=\"width:100%\"><tr>"
				    +"<th>Marca</th>"
				    +"<th>Modelo</th>" 
				    +"<th>Cantidad de equipos</th>"
				    +"<th>Accesorios</th>"
				  +"</tr>";
				  for(BusquedaEnvioSolicitud bes : lista){
					  if(empresa == null){
						  empresa = bes.getNombreEmpresa();
					  }
					  aux = "<tr>"
					    +"<td align=\"center\">"+bes.getMarca()+"</td>"
					    +"<td align=\"center\">"+bes.getNombreModelo()+"</td>"
					    +"<td align=\"center\">"+bes.getCantidadEquipos()+"</td>"
					    +"<td align=\"center\">"+bes.getAccesorios()+"</td>"
					  +"</tr align=\"center\">";
					  tabla = tabla + aux;
				  }
				tabla = tabla + "</table>";
				mensaje = "Estimado equipo de "+empresa+"<br><br> Se ha registrado "
						+ "la siguiente solicitud: <br><br>"+tabla+"<br><br>"
								+ "Atentamente se despide el equipo de renovaciones tecnológicas"
								+ "<br><img src=\"http://www.gsti.cl/wp-content/uploads/2016/08/clientes_st-1200x565.jpg\" alt=\"Smiley face\" width=\"400\" height=\"200\">";
				String subject = "Solicitud de equipos realizada por "+empresa;
				
				SolicitudDao ssd = new SolicitudDao(ConnectionPool.getInstance().getConnectionDB2());
				
				//Correo correo = new Correo();
				correo.envioCorreo(subject, mensaje, ssd.obtenerEmailporIdEmpresa(solicitudes.get(0).getIdEmpresa()));
				
				mensaje = "Estimado equipo, <br><br> Se ha registrado "
						+ "la siguiente solicitud: <br><br>"+tabla+"<br><br>"
								+ "<br><img src=\"http://www.gsti.cl/wp-content/uploads/2016/08/clientes_st-1200x565.jpg\" alt=\"Smiley face\" width=\"400\" height=\"200\">";
				
				correo.envioCorreo(subject, mensaje, correoInterno);
			}
			
			
		} catch (Exception e) {
			System.out.println("ERROR en EnvioSolicitudInsertar: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public List<EnvioSolicitudBean> getSolicitudes() {
		return solicitudes;
	}

	public void setSolicitudes(List<EnvioSolicitudBean> solicitudes) {
		this.solicitudes = solicitudes;
	}


	public EnvioSolicitudBean getSol() {
		return sol;
	}

	public void setSol(EnvioSolicitudBean sol) {
		this.sol = sol;
	}

	public InputStream getInputStream() {
		return inputStream;
	}
}
