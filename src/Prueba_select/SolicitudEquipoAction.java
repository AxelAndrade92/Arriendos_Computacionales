package Prueba_select;

import java.util.ArrayList;
import java.util.List;

import DataAccessObjects.Conector;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.EmpresaDao;
import cl.st.reporte.dao.impl.MarcaDao;
import cl.st.reporte.dao.impl.ModeloDao;
import cl.st.reporte.dao.impl.PartesDao;
import cl.st.reporte.dao.impl.SolicitudDao;
import cl.st.reporte.dao.impl.TipoActivoDao;
import cl.st.reporte.model.EmpresaBean;
import cl.st.reporte.model.MarcaBean;
import cl.st.reporte.model.PartesPiezasBean;
import cl.st.reporte.model.SolicitudEquiposBean;
import cl.st.reporte.model.TipoActivoBean;

public class SolicitudEquipoAction extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<EmpresaBean> empresas;
	private int idEmpresa;
	private EmpresaBean empresaBean;
	private SolicitudEquiposBean token;
	private List<MarcaBean> marcas;
	private List<PartesPiezasBean> partes;
	private List<TipoActivoBean> tipos;
	private List<ModeloActivoBean> modelos;
	private int idtipo;
	private int idmarca;
	
	

	
	
	
	
	
	

	public List<PartesPiezasBean> getPartes() {
		return partes;
	}

	public void setPartes(List<PartesPiezasBean> partes) {
		this.partes = partes;
	}

	public String execute() throws Exception {
		System.out.println("Pasando por el execute() empresasSolicitud");
		try {
			EmpresaDao cd = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
			empresas = cd.listar(idEmpresa);
		} catch (Exception e) {
			System.out.println("ERROR en EmpresaActionListarSolicitud: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	public String validar() throws Exception{
		System.out.println("Pasando por el validar Token");
		try {
		
			System.out.println("Token ingresado :"+token);
			SolicitudDao so = new SolicitudDao(ConnectionPool.getInstance().getConnectionDB2());
//			token.setIdEmpresa(
//					List<SolicitudEquiposBean> lista =  so.validar(token.getToken());//new ArrayList<SolicitudEquiposBean>();
	     	//so.validar(token.getToken());
	     	token  = so.validar(token.getToken()).stream()                        // Convert to steam
	                .filter(x -> token.getToken().equals(x.getToken()))        // we want "jack" only
	                .findAny()                                      // If 'findAny' then return found
	                .orElse(null);
			EmpresaDao eo = new EmpresaDao(ConnectionPool.getInstance().getConnectionDB2());
//			eo.listar(token.getIdEmpresa());
			empresaBean = eo.listar(token.getIdEmpresa()).stream()                        // Convert to steam
	                .filter(x -> token.getIdEmpresa() == x.getId())        // we want "jack" only
	                .findAny()                                      // If 'findAny' then return found
	                .orElse(null);
//			eo.nombreEmpresa();
			MarcaDao mo = new MarcaDao(ConnectionPool.getInstance().getConnectionDB2());
			marcas = mo.listar(empresaBean.getId());
			
			TipoActivoDao tp = new TipoActivoDao(ConnectionPool.getInstance().getConnectionDB2());
			tipos = tp.listarTipos(empresaBean.getId());
			
//			ModeloDao md = new ModeloDao(ConnectionPool.getInstance().getConnectionDB2());
//			modelos = md.listarModelos(idtipo,idmarca);
			
			

//			PartesDao pt = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
//			partes = pt.listar();
			
//			PartesDao p = new PartesDao(ConnectionPool.getInstance().getConnectionDB2());
//			partes = p.listar(parametro);
					
			
			
		} catch (Exception e) {
			System.out.println("Error validarToken_::"+e.getMessage());
		}
		return Action.SUCCESS;
	}
	
	public String listarModelos() throws Exception {
		
		System.out.println("Pasando por el listar() modelos");
		try {
			ModeloDao cd = new ModeloDao(ConnectionPool.getInstance().getConnectionDB2());			
			modelos = cd.listarModelos(idtipo,idmarca,idEmpresa);
			
		} catch (Exception e) {
			System.out.println("ERROR en ModelosActionListar: "+e.getMessage());
			e.printStackTrace();
		}
		
		return Action.SUCCESS;
	}
	
	
	public List<EmpresaBean> getEmpresas() {
		return empresas;
	}


	public void setEmpresas(List<EmpresaBean> empresas) {
		this.empresas = empresas;
	}


	public EmpresaBean getEmpresaBean() {
		return empresaBean;
	}


	public void setEmpresaBean(EmpresaBean empresaBean) {
		this.empresaBean = empresaBean;
	}

	
	
	public int getIdEmpresa() {
		return idEmpresa;
	}

	public void setIdEmpresa(int idEmpresa) {
		this.idEmpresa = idEmpresa;
	}

	public SolicitudEquiposBean getToken() {
		return token;
	}

	public void setToken(SolicitudEquiposBean token) {
		this.token = token;
	}

	public List<MarcaBean> getMarcas() {
		return marcas;
	}

	public void setMarcas(List<MarcaBean> marcas) {
		this.marcas = marcas;
	}

	public List<TipoActivoBean> getTipos() {
		return tipos;
	}

	public void setTipos(List<TipoActivoBean> tipos) {
		this.tipos = tipos;
	}

	public List<ModeloActivoBean> getModelos() {
		return modelos;
	}

	public void setModelos(List<ModeloActivoBean> modelos) {
		this.modelos = modelos;
	}

//	public ModeloActivoBean getMod() {
//		return mod;
//	}
//
//	public void setMod(ModeloActivoBean mod) {
//		this.mod = mod;
//	}

	public int getIdtipo() {
		return idtipo;
	}

	public void setIdtipo(int idtipo) {
		this.idtipo = idtipo;
	}

	public int getIdmarca() {
		return idmarca;
	}

	public void setIdmarca(int idmarca) {
		this.idmarca = idmarca;
	}

	

	

}
