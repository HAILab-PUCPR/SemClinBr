<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="model.Usuario" %>

    <%
    	Usuario u = (Usuario) session.getAttribute("usuario");
    %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Annotation Tool - New Project</title>
</head>
<body>
	<h1>Annotation Tool</h1>
	<div id="boasvindas">
		Ol�, <% 
		
		try{
		 	out.print(u.nome);
		 }
		 catch(NullPointerException e ){
			 //TODO: Resolver problema da sess�o expirando rapidamente
			 out.print("A sess�o expirou!");
		 }%>
	</div>

	<br>
	
	<form action="servlets/NewProject" method="post">
	<fieldset>
		<legend>Novo Projeto</legend>
		<div>
			Nome: <input type="text" name="nome" id="nome">
		</div>
		<div>
		<input type="submit" value="Enviar" />
		</div>
	</fieldset>
	</form>
	
</body>
</html>