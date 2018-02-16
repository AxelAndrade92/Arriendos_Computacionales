package Prueba_select;
import java.util.List;

import cl.st.common.ConstantResult;
import cl.st.reporte.business.impl.ReporteBL;
import cl.st.reporte.bussiness.interfaces.IReporteBL;
import cl.st.reporte.model.BusquedaSBUBean;
import cl.st.reporte.model.EmpresaBean;
import cl.st.reporte.model.ReporteBean;

import com.opensymphony.xwork2.ActionSupport;

import BussinessObjects.Sbu;

public class SbuAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String param = ""; //param que recibiremos desde el jsp
	private Sbu sbu;
	private String mensaje = ""; //mensaje mostrando exito o error
	private IReporteBL iReporte;//reporte 
	boolean estado = false; //estado inicial 
	private int ver;
	//private List<Sbu> reporteSbu;//lista que desplegamos en la grilla
	private List<BusquedaSBUBean> reporteSbu2;
	private List<BusquedaSBUBean> reporteSbuBuscar;
	private List<ReporteBean> reporte;
	private List<ReporteBean> reporteUEN;
	private List<EmpresaBean> reporteEmpresa;
	//atributos a insertar
	private String idsbu;
	private String nombreSbu;
//	private String centroCosto;
	private int Empresas; //variable de la uen
	//private int lstReporte; //variable id del combobox ...creo
	/*public int getLstReporte() {
		return lstReporte;
	}
	public void setLstReporte(int lstReporte) {
		this.lstReporte = lstReporte;
	}*/
	//atributos para actualizar
	private String idsbuu; //mismos nombres como estan en el jsp
	private String nombreSbuu;
//	private String centroCostoUpdate;
	
	
	public String insertar() throws Exception{
		
		iReporte =  new ReporteBL();	
		
		//int num = iReporte.verificarUEN(Empresas);
		
		//System.out.println(num);
		
		try {
			
	   if(param == null)
			param = "";
		if (param.equalsIgnoreCase("")) {
			
			System.out.println("*********** PARAM SIN PARAMETRO: " + param);
			
			listaReportes();
			
			iReporte = new ReporteBL();		
			
			//reporteSbu =  iReporte.ConsultaIdentificadorSBU("");
			reporteSbu2= iReporte.ConsultaIdSBU("");
			
	    if (reporte.size() > 0 || reporte != null) {
			ver = 1;
			}
			return SUCCESS;
	    }else if(param.equalsIgnoreCase("insert")){
	    	
	    	System.out.println("***************PARAM RECIBIDO : "+param);
	    	
			iReporte = new ReporteBL();
			
		if(iReporte.verificarSbu(sbu)!= null){
				mensaje = "<span class='glyphicon glyphicon-exclamation-sign'> </span> Número identificador ya existe en los registros";
		}else{
				
				sbu = new Sbu();
				sbu.setId(idsbu);
				sbu.setDescripcion(nombreSbu.toUpperCase());
//				sbu.setSbu_cc(centroCosto);
				sbu.setEmpresa(Empresas);
				
				
		/*if (unidadNegocioNew != "") {
				sbu.setUen(unidadNegocioNew);
		}*/
				
				estado = iReporte.insertarSbu(sbu);
				
		if (estado) {

				mensaje = "<span class='glyphicon glyphicon-thumbs-up'> </span> Sbu ingresado correctamente";
				listaReportes();
				return SUCCESS;
		} else {
				mensaje = " <span class='glyphicon glyphicon-thumbs-down'> </span> Error : Numero identificador ya esta registrado";
				listaReportes();
				//return ConstantResult.UPDATE;
		}
		}
		}else if(param.equalsIgnoreCase("buscar")){
				
				System.out.println("***************PARAM RECIBIDO : "+param);
				
				mensaje = "";
				
				iReporte =  new ReporteBL();
				
				//reporteSbu = iReporte.ConsultaIdentificadorSBU(idsbu);
				
				reporteSbu2 = iReporte.ConsultaIdSBU(idsbu);
				
		if (reporteSbu2.size() > 0 || reporteSbu2 != null) {
				ver = 1;
		}
		listaReportes();
		return ConstantResult.LISTAR;
		}
		}catch(Exception e) {
			System.out.println("error en Metodo Insertar " + e.getMessage());
			
		}
		return SUCCESS;
		
}
	
	public String update() throws Exception{
		iReporte = new ReporteBL();
		
		estado = iReporte.updateSbu(idsbuu,nombreSbuu/*,centroCostoUpdate*/);
		
		if (estado) {

			mensaje = "<span class='glyphicon glyphicon-thumbs-up'> </span> Sbu actualizado correctamente";
			listaReportes();
			//return SUCCESS;
		} else {
			mensaje = " <span class='glyphicon glyphicon-thumbs-down'> </span> Error al Actualizar";
			listaReportes();
			//return ConstantResult.UPDATE; PAgina de error
		}
		
		return SUCCESS;
		
	}
	
	
	
	
	
	/*public String buscar(){
		try{
			System.out.println("PARAM DETALLE : "+param);
			mensaje = "";
			
			iReporte =  new ReporteBL();
			
			reporteSbu = iReporte.ConsultaIdentificadorSBU(idsbu);
			
			 if (reporteSbu.size() > 0 || reporteSbu != null) {
					ver = 1;
				}
			
		}catch(Exception e) {
			System.out.println("error en Metodo Insertar " + e.getMessage());
	}
		return SUCCESS;
	}*/
	
	
	
   private void listaReportes() {
		
		try {
			iReporte = new ReporteBL();
			
			//reporteSbu = iReporte.listaSbu();
			reporteSbu2 = iReporte.listaSbu2();
			reporteUEN = iReporte.listaUnidadNegocio();
			reporteEmpresa = iReporte.listaEmpresa();
			

		} catch (Exception e) {
			System.out.println("ERROR method:: listaReportes(), "
					+ e.getMessage());
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public Sbu getSbu() {
		return sbu;
	}
	public void setSbu(Sbu sbu) {
		this.sbu = sbu;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public int getVer() {
		return ver;
	}
	public void setVer(int ver) {
		this.ver = ver;
	}
	public IReporteBL getiReporte() {
		return iReporte;
	}
	public void setiReporte(IReporteBL iReporte) {
		this.iReporte = iReporte;
	}

	public String getNombreSbu() {
		return nombreSbu;
	}


	public void setNombreSbu(String nombreSbu) {
		this.nombreSbu = nombreSbu;
	}


//	public String getCentroCosto() {
//		return centroCosto;
//	}
//
//
//	public void setCentroCosto(String centroCosto) {
//		this.centroCosto = centroCosto;
//	}


	/*public List<Sbu> getReporteSbu() {
		return reporteSbu;
	}


	public void setReporteSbu(List<Sbu> reporteSbu) {
		this.reporteSbu = reporteSbu;
	}*/
	public List<BusquedaSBUBean> getReporteSbu() {
		return reporteSbu2;
	}


	public void setReporteSbu(List<BusquedaSBUBean> reporteSbu2) {
		this.reporteSbu2 = reporteSbu2;
	}


	public String getIdsbuu() {
		return idsbuu;
	}


	public void setIdsbuu(String idsbuu) {
		this.idsbuu = idsbuu;
	}


	public String getNombreSbuu() {
		return nombreSbuu;
	}


	public void setNombreSbuu(String nombreSbuu) {
		this.nombreSbuu = nombreSbuu;
	}


//	public String getCentroCostoUpdate() {
//		return centroCostoUpdate;
//	}
//
//
//	public void setCentroCostoUpdate(String centroCostoUpdate) {
//		this.centroCostoUpdate = centroCostoUpdate;
//	}

	public String getIdsbu() {
		return idsbu;
	}

	public void setIdsbu(String idsbu) {
		this.idsbu = idsbu;
	}
	public List<ReporteBean> getReporteUEN() {
		return reporteUEN;
	}
	public void setReporteUEN(List<ReporteBean> reporteUEN) {
		this.reporteUEN = reporteUEN;
	}
	/*public String getUnidadNegocioNew() {
		return unidadNegocioNew;
	}
	public void setUnidadNegocioNew(String unidadNegocioNew) {
		this.unidadNegocioNew = unidadNegocioNew;
	}*/


	public List<EmpresaBean> getReporteEmpresa() {
		return reporteEmpresa;
	}

	public void setReporteEmpresa(List<EmpresaBean> reporteEmpresa) {
		this.reporteEmpresa = reporteEmpresa;
	}

	public int getEmpresas() {
		return Empresas;
	}

	public void setEmpresas(int empresas) {
		Empresas = empresas;
	}

	public List<BusquedaSBUBean> getReporteSbu2() {
		return reporteSbu2;
	}

	public void setReporteSbu2(List<BusquedaSBUBean> reporteSbu2) {
		this.reporteSbu2 = reporteSbu2;
	}

	public List<BusquedaSBUBean> getReporteSbuBuscar() {
		return reporteSbuBuscar;
	}

	public void setReporteSbuBuscar(List<BusquedaSBUBean> reporteSbuBuscar) {
		this.reporteSbuBuscar = reporteSbuBuscar;
	}

	
	
	

}
