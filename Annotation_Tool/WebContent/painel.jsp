<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%


	Usuario u = (Usuario) session.getAttribute("usuario"); 
	
	out.print(GeneralLayoutHelper.getTop("Painel"));
	
%>



    <div class="container">

      <div class="jumbotron">
        <h1>Bem-vindo</h1>
        <p>Olá <%= u.nome %>. Para acessar as funcionalidades da ferramenta verifique as opções no menu superior.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="projectSelection.jsp?redirect=textList" role="button">Listar textos &raquo;</a>
        </p>
      </div>

    </div> <!-- /container -->


<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

%>
  </body>
</html>
