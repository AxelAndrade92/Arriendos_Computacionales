package Prueba_select;

public class ModeloActivoBean {
	
	private int id;
	private String modelos;
	
	public ModeloActivoBean(){}
	
	
	public ModeloActivoBean(int id, String modelos) {
		super();
		this.id = id;
		this.modelos = modelos;
	}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getModelos() {
		return modelos;
	}
	public void setModelos(String modelos) {
		this.modelos = modelos;
	}
	
	

}
