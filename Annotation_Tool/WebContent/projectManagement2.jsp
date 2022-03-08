<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="model.Usuario" %>
<%@ page import="model.Projeto" %>
<%@ page import="java.util.ArrayList" %>

    <%
    	Usuario u = (Usuario) session.getAttribute("usuario");
    	ArrayList<Projeto> projetos = Projeto.findAll();
    
    %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Annotation Tool - Project Management</title>
<script type="text/javascript" src="js/jquery/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.12.0.custom/jquery-ui.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.12.0.custom/jquery-ui.theme.min.css">
<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.12.0.custom/jquery-ui.structure.min.css">

<script>
$(function(){
	
	$("#tab").tabs();
	
	$("#projetos").change(function(){
		
		alert($(this).val());
		
	});
	
	
	
})
</script>

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
		<table width="90%">
			<tr style="vertical-align:top" >
				<td width="20%" style="vertical-align:top">
					<form>
	 				<fieldset>
	 					<legend>Projetos</legend>
 						<select id="projetos" size="10">
							<% for(Projeto p : projetos){ %>
								<option value="<%= p.id %>"><%= p.nome %></option>
							<% } %>
						</select>
						<div>
						<a href="newProject.jsp">
							<button type="button">Novo</button>
						</a>
						<button type="button" onclick="alert('Hello world!')">Excluir</button>
						</div>
					</fieldset>
					</form>
				</td> 
				<td style="vertical-align:top" width="80%">
					<div id="tab" style="visibility: hidden">
						<ul>
							<li><a href="#Aba1">Aba</a></li>
							<li><a href="#Aba2">Aba2</a></li>
							<li><a href="#Aba3">Aba3</a></li>
						</ul>
						<div id="Aba1" style="vertical-align:top">
							Teste
						</div>
						<div id="Aba2">Teste2</div>
						<div id="Aba3">Teste3</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<br>

	
	
</body>
</html>