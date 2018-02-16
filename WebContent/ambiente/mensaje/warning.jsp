<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<s:include value="/ambiente/library/base.jsp"></s:include>
<title>Insert title here</title>
</head>
<body>
	<div id="content">
		<div id="home">
			<s:include value="/ambiente/page/header.jsp"></s:include>
		</div>
		<div id="center">
			<div class="menus">
				<s:include value="/ambiente/menu/menuOperador.jsp"></s:include>
			</div>
			<div class="page">
				<div class="mensaje">
					<small class="icon-warning"></small>
					<span><s:property value="mensaje" /></span>
				</div>
			</div>
			<div id="footer">
				<s:include value="/ambiente/page/footer.jsp"></s:include>
			</div>
		</div>
	</div>
</body>
</html>