package BussinessObjects;

public class Marca {
	private int idmarca;
	private String marca;
	private String modelo;
	
	public Marca(){
		setIdmarca(0);
		setMarca("");
		setModelo("");
		
	}

	public int getIdmarca() {
		return idmarca;
	}

	public void setIdmarca(int idmarca) {
		this.idmarca = idmarca;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	

	
	
	
}
