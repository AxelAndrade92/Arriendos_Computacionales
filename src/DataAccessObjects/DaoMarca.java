package DataAccessObjects;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import BussinessObjects.DaoRet;

public class DaoMarca {

	public DaoRet InsertarMarca(int idMarca, String marcaActivo,	String modeloMarcaActivo) {
		// ResultSet rs = new ResultSet;
		DaoRet res = new DaoRet(); 
		try {
			Connection db = DriverManager.getConnection("jdbc:postgresql:BDProduccionn","postgres", "admin");
			db.setAutoCommit(false);
		    CallableStatement proc = db.prepareCall("{ ? = call InsertaMarca(?,?,?) }");
		    		
		    
		    proc.setLong(1,Types.INTEGER);
		    proc.setLong(2,Types.VARCHAR);
		    proc.setLong(3, Types.VARCHAR);
		    if(proc.execute()){
		    res.setSqlcode(0);
		    //return rs;
		    }
		}
		catch(SQLException e)
		{
			res.setSqlcode(1);
			res.setMensaje(e.getMessage());
			System.out.println(e.getMessage());
		}
		
	    return null;
	}

}
