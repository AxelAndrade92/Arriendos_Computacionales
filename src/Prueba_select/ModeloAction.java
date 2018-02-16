package Prueba_select;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;

import cl.st.common.ConnectionPool;
import cl.st.reporte.dao.impl.ModeloDao;
import cl.st.reporte.model.ModeloBean;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class ModeloAction extends ActionSupport {
	
//	private List<ModeloActivoBean> modeloBean;
	private ModeloBean modeloBean;
	private List<ModeloBean> modelos;
	private InputStream inputStream;
	private List<String[]> busquedaModelos;
	
	public String listar() throws Exception {
			
			System.out.println("Pasando por el listar() empresas");
			try {
				ModeloDao cd = new ModeloDao(ConnectionPool.getInstance().getConnectionDB2());
				
				busquedaModelos = cd.listarModelosMarcaTipo();
			} catch (Exception e) {
				System.out.println("ERROR en EmpresaActionListar: "+e.getMessage());
				e.printStackTrace();
			}
			
			return Action.SUCCESS;
		}
	
	public String pagina(){
		System.out.println("Pasando por el pagina() de ModeloAction");
		return Action.SUCCESS;
	}
	
	public String insertar(){
		System.out.println("Pasando por el insertar de ModeloAction");
		try {
			ModeloDao md = new ModeloDao(ConnectionPool.getInstance().getConnectionDB2());
			if(md.insertar(modeloBean)){
				inputStream = 
						new ByteArrayInputStream("El registro no fue ingresado, por favor intente de nuevo".getBytes("UTF-8"));
			}else{
				inputStream = 
						new ByteArrayInputStream("Registro ingresado exitosamente".getBytes("UTF-8"));
			}
		} catch (Exception e) {
			System.out.println("ERROR en ModeloAction: "+e.getMessage());
			e.printStackTrace();
		}
		return Action.SUCCESS;
	}

	public ModeloBean getModeloBean() {
		return modeloBean;
	}

	public void setModeloBean(ModeloBean modeloBean) {
		this.modeloBean = modeloBean;
	}

	public List<ModeloBean> getModelos() {
		return modelos;
	}

	public void setModelos(List<ModeloBean> modelos) {
		this.modelos = modelos;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public List<String[]> getBusquedaModelos() {
		return busquedaModelos;
	}

	public void setBusquedaModelos(List<String[]> busquedaModelos) {
		this.busquedaModelos = busquedaModelos;
	}	
	}
