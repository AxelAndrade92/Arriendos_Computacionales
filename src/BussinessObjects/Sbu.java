package BussinessObjects;

public class Sbu {
	private String id;
	private String descripcion;
	private String Sbu_cc;
	private int empresa;

	
	public Sbu(){
		setId("");
		setDescripcion("");
		setSbu_cc("");
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getDescripcion() {
		return descripcion;
	}


	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}


	public String getSbu_cc() {
		return Sbu_cc;
	}


	public void setSbu_cc(String sbu_cc) {
		Sbu_cc = sbu_cc;
	}
	
	public String print()
	{
		return "<tr><td>"+ id + "<\td><td>" + descripcion + "<\td><\tr>" + Sbu_cc + "<\td><\tr>";
		
	}

	public int getEmpresa() {
		return empresa;
	}


	public void setEmpresa(int empresa) {
		this.empresa = empresa;
	}
	
	

}
