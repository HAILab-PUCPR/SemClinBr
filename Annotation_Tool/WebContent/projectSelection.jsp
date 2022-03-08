<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="model.Projeto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%


	Usuario u = (Usuario) session.getAttribute("usuario"); 

	String redirect = request.getParameter("redirect");
	
	out.print(GeneralLayoutHelper.getTop("Seleção de Projeto"));
	
%>



    <div class="container">

      <div class="starter-template">
        <h1>Seleção de projetos</h1>
        <p class="lead">Selecione o projeto de anotação desejado.<br> 
      	<%
			ArrayList<Projeto> projetos = Projeto.findAll();
			for(Projeto p : projetos){
			%>
			
			<a href="<%=redirect %>.jsp?id=<%=p.id%>"><%=p.id%> - <%=p.nome%></a><br/>
			
			<% 	
		} %>
		</p>
      </div>

    </div><!-- /.container -->


<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

%>
  </body>
</html>
