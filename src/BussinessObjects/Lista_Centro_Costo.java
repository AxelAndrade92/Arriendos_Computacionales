package BussinessObjects;

public class Lista_Centro_Costo {
	
	private int id;
	private String descripcion;
	private String Sbu;
	
	public Lista_Centro_Costo(){
		setId(0);
		setDescripcion("");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	public String print(){
		return "<tr><td>" + descripcion + "<\tr><\td>";
	}

	public String getSbu() {
		return Sbu;
	}

	public void setSbu(String sbu) {
		Sbu = sbu;
	}
	

}
