package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

import cl.st.common.ConnectionPool;
import cl.st.common.ConstantResult;
import cl.st.reporte.business.impl.ReporteBL;
import cl.st.reporte.bussiness.interfaces.IReporteBL;
import cl.st.reporte.dao.impl.MarcaDao;
import cl.st.reporte.model.MarcaBean;
import cl.st.reporte.model.ReporteBean;

public class MarcaAction extends ActionSupport{

	private static final long serialVersionUID = 1L;
	private String param = ""; //parametro que recibiremos desde el jsp
	private IReporteBL iReporte;//reporte 
	private ReporteBean Marca;
	private String mensaje = "";//mensaje que entregaremos
	private List<ReporteBean> reporteMarca;//instanciamos nuestra variable que tendra nuestra lista de marcas
	boolean estado = false;
	private List<ReporteBean> reporte;
	private List<MarcaBean> marcas;
	private InputStream inputStream;
	private MarcaBean marcaBean;
	public List<ReporteBean> getReporte() {
		return reporte;
	}

	public void setReporte(List<ReporteBean> reporte) {
		this.reporte = reporte;
	}

	private int ver;
	
	//atributos a insertar
	private String idMarca;
	private String marcaActivo;
	private String modeloMarcaActivo;
	
	//atributos para actualizar
	private String idMar;
	private String modeloMarcaUpdate;
	
	
	//Marca marca = new Marca();
	
	/*public String execute(){
		
		if(param.equalsIgnoreCase("insert")){
			BussinessLogic.MarcaLogic bl = new BussinessLogic.MarcaLogic(); 
			DaoRet ret = bl.InsertaMarca(idMarca,marcaActivo,modeloMarcaActivo);
			if (ret.getSqlcode() == 0){
				return SUCCESS;
			}
			else
			{
				return ERROR;
			}
		}
		return SUCCESS;
		
	}*/
	
	

	public String execute(){
		
		
	try{
		if(param == null)
			param = "";
		if (param.equalsIgnoreCase("")) {
			System.out.println("*********** PARAM SIN PARAMETRO: " + param);
			listaReportes();
			//llenando reportes
			 iReporte = new ReporteBL();
			
			 reporte =  iReporte.consultaIdentificadorMarca("");
			 
			 if (reporte.size() > 0 || reporte != null) {
					ver = 1;
				}
			return SUCCESS;

		}else if(param.equalsIgnoreCase("insert")){//insercion de nueva marca
			System.out.println("*********** PARAM CON PARAMETRO: " + param);
					iReporte = new ReporteBL();
					
					 if(iReporte.verificarMarca(Marca) != null){//si numero es distinto a nulo
						mensaje = "<span class='glyphicon glyphicon-exclamation-sign'> </span> Número identificador ya existe en los registros";
						
						
					 }else{
						Marca = new ReporteBean();
						Marca.setIdmarca(idMarca);
						Marca.setDescrmarca(marcaActivo.toUpperCase());
						Marca.setModmarca(modeloMarcaActivo.toUpperCase());
						
					    estado = iReporte.insertarMarca(Marca);
						
						if (estado) {

							mensaje = "<span class='glyphicon glyphicon-thumbs-up'> </span> Activo ingresado correctamente";
							listaReportes();
							return SUCCESS;
						} else {
							mensaje = " <span class='glyphicon glyphicon-thumbs-down'> </span> Error : Numero identificador ya esta registrado";
							listaReportes();
							return ConstantResult.UPDATE;
						}
						
					}	
		 }else if(param.equalsIgnoreCase("buscar")){
			 System.out.println("PARAM DETALLE : "+param);
			 mensaje = "";
			 
			 iReporte = new ReporteBL();
			 
			 reporte =  iReporte.consultaIdentificadorMarca(idMarca);
			 
			 if (reporte.size() > 0 || reporte != null) {
					ver = 1;
				}
			listaReportes();
			return ConstantResult.LISTAR;
			 
		 }
	}
	catch (Exception e) {
		System.out.println("error en Execute " + e.getMessage());

	}
	return SUCCESS;
	

}
	
	public String unidadNegocio() {
		try {
			if (param == null)
				param = "";

			if (param.equalsIgnoreCase("")) {
				iReporte = new ReporteBL();
				reporteMarca = iReporte.listaMarcas();
				return SUCCESS;

			}else  if (param.equalsIgnoreCase("listar")) {
				iReporte = new ReporteBL();
				reporteMarca = iReporte.listaMarcas();
				ver = 1 ;
				return ConstantResult.LISTAR;

			} 

		} catch (Exception e) {
			System.out.println("ERROR " + e.getMessage());

		}
		return SUCCESS;
	}

	private void listaReportes() {
		
		try {
			iReporte = new ReporteBL();
			
			reporteMarca = iReporte.listaMarcas();
			

		} catch (Exception e) {
			System.out.println("ERROR method:: listaReportes(), "
					+ e.getMessage());

		}
		
	}
	
	public String update() throws Exception{
		
		iReporte = new ReporteBL();
		
		estado = iReporte.updateMarca(idMar,marcaActivo,modeloMarcaUpdate);
		
		if (estado) {

			mensaje = "<span class='glyphicon glyphicon-thumbs-up'> </span> Activo actualizado correctamente";
			listaReportes();
			//return SUCCESS;
		} else {
			mensaje = " <span class='glyphicon glyphicon-thumbs-down'> </span> Error al Actualizar";
			listaReportes();
			//return ConstantResult.UPDATE; PAgina de error
		}
		
		return SUCCESS;
		
		
	}

	public String buscarMarcasDisponibles(){
		System.out.println("Pasando por el buscarMarcasDisponibles");
		try {
			MarcaDao md = new MarcaDao(ConnectionPool.getInstance().getConnectionDB2());
			marcas = md.listarSimple(0);
		} catch (Exception e) {
			System.out.println("Error MarcaAction buscarMarcasDisponibles:: "
				+e.getLocalizedMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Pasando por el insertar en MarcaAction");
		try {
			MarcaDao md = new MarcaDao(ConnectionPool.getInstance().getConnectionDB2());
			if(md.insertar(marcaBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en MarcaAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public List<ReporteBean> getReporteMarca() {
		return reporteMarca;
	}

	public void setReporteMarca(List<ReporteBean> reporteMarca) {
		this.reporteMarca = reporteMarca;
	}

	
	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getIdMarca() {
		return idMarca;
	}

	public void setIdMarca(String idMarca) {
		this.idMarca = idMarca;
	}

	public String getMarcaActivo() {
		return marcaActivo;
	}

	public void setMarcaActivo(String marcaActivo) {
		this.marcaActivo = marcaActivo;
	}

	public String getModeloMarcaActivo() {
		return modeloMarcaActivo;
	}

	public void setModeloMarcaActivo(String modeloMarcaActivo) {
		this.modeloMarcaActivo = modeloMarcaActivo;
	}

	public int getVer() {
		return ver;
	}

	public void setVer(int ver) {
		this.ver = ver;
	}

	public String getIdMar() {
		return idMar;
	}

	public void setIdMar(String idMar) {
		this.idMar = idMar;
	}
	
	public String getModeloMarcaUpdate() {
		return modeloMarcaUpdate;
	}

	public void setModeloMarcaUpdate(String modeloMarcaUpdate) {
		this.modeloMarcaUpdate = modeloMarcaUpdate;
	}

	public List<MarcaBean> getMarcas() {
		return marcas;
	}

	public void setMarcas(List<MarcaBean> marcas) {
		this.marcas = marcas;
	}

	public MarcaBean getMarcaBean() {
		return marcaBean;
	}

	public void setMarcaBean(MarcaBean marcaBean) {
		this.marcaBean = marcaBean;
	}

	public InputStream getInputStream() {
		return inputStream;
	}
}
