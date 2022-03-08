<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="helper.GeneralLayoutHelper" %>

<%
	//Recupera o usuário
	Usuario u = (Usuario) session.getAttribute("usuario"); 
	//Recupera o ID do projeto
	Integer projeto_id = Integer.parseInt(request.getParameter("id"));
	
	//Store PROJECT ID on SESSION
	//TODO: Put in a servlet
	session.setAttribute("projectid", projeto_id);
	
	out.print(GeneralLayoutHelper.getTop("Importação de textos"));
%>

<div id="annotationContainer" class="container">
	
	<form action="servlets/TextImport" method="post" enctype="multipart/form-data">
	<fieldset>
		<legend>Informações do arquivo</legend>
		<div class="form-group">
			Selecione o arquivo: <input type="file" name="file" id="file">
			        			 <input type="hidden" name="projeto_id" value="<%=projeto_id%>">
		</div>
		
		
		<div class="form-group">
			<input type="button" id="voltar" value="Voltar" class="btn btn-default"/>
			<input type="submit" id="enviar" value="Enviar" class="btn btn-primary"/>
		</div>
		
	</fieldset>
	</form>
</div>
<script type="text/javascript">
$("#voltar").click(function(){
	location.href = "textList.jsp?id=<%= projeto_id.toString() %>"; 
});

$("#enviar").click(function(){
	$.LoadingOverlay("show");
})

</script>
<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

%>

	
</body>
</html>