<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="BussinessLogic.*" %>
<%@ page import="BussinessObjects.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
		<%
		try{
			
		Consultas_BD cc = new Consultas_BD();
		
		List<Lista_Centro_Costo> lc = cc.Consulta_cc();
		out.println("<table>");
		
		for( Lista_Centro_Costo e : lc)
		{
			out.print("</br>");
			out.println("ID: ");
			out.println(e.getId());
			out.print("</br>");
			out.println("Codigo C.C.: ");
			out.println(e.getDescripcion());
			out.print("</br>");
			out.println("Pertenece a: ");
			out.println(e.getSbu());
			out.print("</br>");
			out.println("-------------------------------");
		}
		out.println("</table>");
		}
		catch(Exception e){
			e.printStackTrace();
			out.println(e.getMessage());
		}
		
		
		
		
		
		%>


</body>
</html>