<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="model.Usuario" %>
<%@ page import="java.util.ArrayList" %>

    <%
    	Usuario u = (Usuario) session.getAttribute("usuario");
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Annotation Tool - Project Management</title>
</head>
<body>
	<h1>Annotation Tool</h1>
	<div id="boasvindas">
		Olá, <% 
		
		try{
		 	out.print(u.nome);
		 }
		 catch(NullPointerException e ){
			 //TODO: Resolver problema da sessão expirando rapidamente
			 out.print("A sessão expirou!");
		 }%>
	</div>

	<br>

	<div>
		Usuários :
		<br>
		<ul>
		<%
			ArrayList<Usuario> usuarios = Usuario.findAll();
			for(Usuario user : usuarios){
			%>
			<li>
				<a href="userProprieties.jsp?id=<%=user.id%>"><%=user.id%> - <%=user.nome%></a>
			</li>
			<% 	
		} %>
		</ul>
	</div>
	
	<div>
		<a href="newUser.jsp">
			<button type="button">Novo</button>
		</a>
		<button type="button" onclick="alert('Hello world!')">Excluir</button>
	</div>
	
	
</body>
</html>