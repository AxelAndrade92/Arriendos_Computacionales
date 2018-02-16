package BussinessLogic;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import com.ibm.db2.jcc.am.SqlException;

import DataAccessObjects.*;
import BussinessObjects.*;

public class Consultas_BD {
	
	
	public Consultas_BD(){
		
		
	}
	
	public List<Lista_Centro_Costo> Consulta_cc() 
	{
		List<Lista_Centro_Costo> lista_cc = new ArrayList<Lista_Centro_Costo>();
		Conector conn = new Conector();
		
		ResultSet rs =  conn.executeProcedure1();
		
		try
		{
			while(rs.next()){
				Lista_Centro_Costo lista = new Lista_Centro_Costo();
				lista.setId(rs.getInt(1));
				lista.setDescripcion(rs.getString(2));
				lista.setSbu(rs.getString(3));
				lista_cc.add(lista);
			}
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		return lista_cc;
		
	}
	
	
	
	public List<Sbu> Consulta_uen()
	{
		
		List<Sbu> lista_uen = new ArrayList<Sbu>();		
		Conector conn = new Conector();
		
		ResultSet rs =  conn.executeProcedure2();
		
		try
		{
			while(rs.next()){
				Sbu s = new Sbu();
				s.setId(rs.getString(1));
				s.setDescripcion(rs.getString(2));
				s.setSbu_cc(rs.getString(3));
				lista_uen.add(s);
			}
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
		return lista_uen;
	}

}
