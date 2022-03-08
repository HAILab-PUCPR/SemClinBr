<%@page import="model.Texto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="helper.StatisticsHelper" %>    
    <%
	//Pega usuário da seção
    Usuario u = (Usuario) session.getAttribute("usuario");
    //Recupera o ID do projeto
    int projeto_id = Integer.parseInt(request.getParameter("id"));
	  //Lista de usuários anotadores do projeto para comparação
    ArrayList<Usuario> anotadores = Usuario.findByPerfilIdAndProject(2, projeto_id); //TODO: Remover valor hardcodded
    //Lista de usuários do projeto
    ArrayList<Usuario> usuarios = Usuario.findByProject(projeto_id);
   	//Lista de Textos
   	ArrayList<Texto> textos = Texto.findByProjeto_id(projeto_id);
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Annotation Tool - Statistics</title>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #000000;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
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
		<h4>Último Acesso</h4>
		<table>
			<tr>
				<th>Usuario</th>
				<th>Último Acesso</th>
			</tr>
				<% for(Usuario user : usuarios){ %>
						<tr>
							<td><%= user.nome %></td>
							<td><%= (user.ultimo_acesso != null) ? user.ultimo_acesso : "----"%></td>
						</tr>
				<% } %>
		</table>
	
	</div>

	<div>
		<h4>Status do Projeto</h4>
	</div>
	
	<div>
		<h4>Status do Texto</h4>
		<table>
			<tr>
				<th>Texto</th>
				<% for(Usuario user : usuarios){ %>
						<th><%= user.nome %></th>
				<% } %>
			</tr>
			<% for(Texto t : textos){ %>
					<tr>
						<th><%= t.id %></th>
						<% for(Usuario user : usuarios){ %>
							<td><!-- Pegar bit de informação por cada usuario -->a</td>
						<%; } %>
					</tr>
				<% } %>
		</table>
	</div>
	

	<div>
		<h4>Coeficiente de Concordância entre Anotadores</h4>
		<table>
		<tr>
			<th>Usuário</th>
			<% for(Usuario user : anotadores){ %>
				<th><%=user.nome%></th>
			<% } %>
		</tr>
		<% for(Usuario user : anotadores){ %>
			<tr>
				<th><%=user.nome%></th>
				<%out.print(StatisticsHelper.projectAgreement(anotadores, projeto_id)); %>
			</tr>
		<% } %>
		</table>
	
	</div>

</body>
</html>