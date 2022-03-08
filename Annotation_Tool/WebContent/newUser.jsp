<%@page import="java.util.ArrayList"%>
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
	
	<form action="servlets/NewUser" method="post" id="user">
	<fieldset>
		<legend>Novo Usuário</legend>
		<div>
			Nome: <input type="text" name="nome" id="nome">
		</div>
		<div>	
			Senha: <input type="password" name="senha" id="senha">
		</div>
		<div>
			E-mail: <input type="text" name="email" id="email">
		</div>
		<div>
			Perfil:  <div>
					<input type="checkbox" name="permissao_grp" value="8">Administrador
					<input type="checkbox" name="permissao_grp" value="1">Revisor
					<input type="checkbox" name="permissao_grp" value="2">Anotador
					<input type="checkbox" name="permissao_grp" value="4">Adjudicador
					</div>
		</div>
		<div>
		<input type="submit" value="Enviar" />
		</div>
	</fieldset>
	</form>
	
</body>
</html>