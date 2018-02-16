package BussinessLogic;

import BussinessObjects.DaoRet;

public class MarcaLogic {

	public DaoRet InsertaMarca(int idMarca, String marcaActivo,
			String modeloMarcaActivo) {
		// TODO Auto-generated method stub
		
		System.out.printf( "%i - %s - %s", idMarca, marcaActivo, modeloMarcaActivo);
		
		DataAccessObjects.DaoMarca daom = new DataAccessObjects.DaoMarca();
		
		DaoRet ret = daom.InsertarMarca(idMarca, marcaActivo, modeloMarcaActivo);
		return ret;
	}

}
