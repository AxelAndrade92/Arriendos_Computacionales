<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="BussinessLogic.*" %>
<%@ page import="BussinessObjects.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="Prueba_select.*" %>
<%@ taglib prefix = "s" uri = "/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SBU</title>
</head>
<body>

         <s:form action = "Seleccion">
         	<s:select headerKey="0" headerValue="Seleccione.." listKey="codigo" listValue="nombre" list ="Ciudades" />
         	<s:submit label ="Enviar" />		
		</s:form>










<%
		try{out.print("<h3>Lista de SBU</h3>");
		
		
			
		Consultas_BD cb = new Consultas_BD();
		
		List<Sbu> lc = cb.Consulta_uen();
		
		out.println("<table>");
		
		for(Sbu s : lc)
		{
			out.print("</br>");
			out.println("ID: ");
			out.print(s.getId());
			out.print("</br>");
			out.println("Descripcion: ");
			out.println(s.getDescripcion());
			out.print("</br>");
			out.println("Codigo C.C: ");
			out.print(s.getSbu_cc());
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