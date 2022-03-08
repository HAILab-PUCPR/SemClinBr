<%@page import="model.Permissao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Usuario" %>
<%@ page import="model.Texto" %>
<%@ page import="model.TextoStatus" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.Tokenizer" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%
 
 	//Busca usuário logado
	Usuario u = (Usuario) session.getAttribute("usuario");
 	//Busca texto a ser revisado
 	Texto t = Texto.findById(Integer.parseInt(request.getParameter("id")));
 	//Obtém ID do projeto
 	Integer project_id = (Integer) session.getAttribute("projectid");
 	
 	//TODO: Melhoria = DEFINIR PREVIEW DO TEXTO TOKENIZADO AQUI PARA REVISOR CORRIGIR POSSÍVEIS PONTUAÇÕES ERRADAS TAMBÉM
 			
 			
 	out.print(GeneralLayoutHelper.getTop("Revisão de textos"));

	
%>
	<div class="container">
		<form action="servlets/TextReview" method="post">
			<input type="hidden" name="id" id="id" value="<%= t.id %>"/>
			<h3>Revisar o texto em busca de erros ortográficos e de-identificação do texto.</h3>
			<div class="form-group">
				<textarea name="texto" id="text" class="form-control" rows="22"><%= t.texto %></textarea>
			</div>
			<div class="form-group">
				<select name="status" id="status" class="form-control">
					<option value="<%= TextoStatus.REVISAO %>">Importação inicial / Em processo de revisão</option>
					<option value="<%= TextoStatus.ANOTACAO %>" selected="selected">Aprovado / Em processo de anotação</option>
					<!--  
					<option value="<%= TextoStatus.ADJUDICACAO %>">Anotado / Em processo de adjudicação</option>
					<option value="<%= TextoStatus.FINALIZADO %>">Adjudicado / Finalizado</option>
					-->
				</select>
			</div>
			<div class="form-group">
				<h4>Selecione os usuários habilitados a anotar este texto</h4>
				<%
					ArrayList<Usuario> usuarios = Usuario.findByPerfilAndProject(Permissao.ANOTADOR, project_id);
					for(Usuario user : usuarios)
						out.print("<input type=\"checkbox\" name=\"selectedUser\" value=\"" + user.id + "\"> "+ user.nome + "<br>");
				%>
			</div>
			<div class="form-group">
				<input type="button" id="voltar" value="Voltar" class="btn btn-default"/>
				<input type="submit" value="Enviar" class="btn btn-primary"/>
			</div>
			<br><Br><br><br>
		</form>
	</div>
	
<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

%>
<script type="text/javascript">
$("#voltar").click(function(){
	location.href = "textList.jsp?id=<%= project_id.toString() %>"; 
});

//TODO: Validar campos. Não deixar enviar sem definição dos anotadores

</script>
  </body>
</html>
	