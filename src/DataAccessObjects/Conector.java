package DataAccessObjects;
import java.sql.*;

public class Conector {
	//private String jdbc = "jdbc:postgresql:ERP_ARRIENDOS";
	//private String user = "postgres";
	//private String passwd = "1ST-Computacion";
	// Connection db = DriverManager.getConnection("jdbc:postgresql:ERP_ARRIENDOS","postgres", "1ST-Computacion");
	public Conector()
	{
		
	}
	//Class.forName("org.postgresql.Driver");
	public ResultSet executeProcedure1()
	{
		// ResultSet rs = new ResultSet;
		try {
			Connection db = DriverManager.getConnection("jdbc:postgresql:BDProduccionn","postgres", "admin");
			db.setAutoCommit(false);
		    CallableStatement proc = db.prepareCall("{ ? = call Muestra_listaCentroCosto() }");
		    proc.registerOutParameter(1,Types.OTHER);
		    proc.execute();
		    ResultSet rs = (ResultSet) proc.getObject(1);
		    return rs;
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}
		
	    return null;
	}
	
	public ResultSet executeProcedure2(){
		try {
			Connection db = DriverManager.getConnection("jdbc:postgresql:BDProduccionn","postgres", "admin");
			db.setAutoCommit(false);
		    CallableStatement proc = db.prepareCall("{ ? = call Muestra_ListaSBU() }");
		    proc.registerOutParameter(1,Types.OTHER);
		    proc.execute();
		    ResultSet rs = (ResultSet) proc.getObject(1);
		    return rs;
		}
		catch(SQLException e)
		{
			System.out.println(e.getMessage());
		}
		
	    return null;
	}
    

}
