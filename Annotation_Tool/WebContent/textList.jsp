<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="model.Texto" %>
<%@ page import="model.TextoStatus" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.Tokenizer" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.Permissao" %>
<%@ page import="model.Alocacaotexto" %>
 <%
 
	Usuario u = (Usuario) session.getAttribute("usuario");

	//Recupera o ID do projeto
	int projeto_id = Integer.parseInt(request.getParameter("id"));
	//int projeto_id = (Integer) session.getAttribute("projectid");
	
	String filter = request.getParameter("filter");
	ArrayList<Texto> textos;
	HashMap<String, Integer> map;
	
	//Busca anotadores alocados para cada um dos textos
	//Textoid, Usuarios(nomes)
	HashMap<Integer, ArrayList<String>> textosUsuarios = Alocacaotexto.findAllTextUsersAlocationByProject(projeto_id);
	ArrayList<String> listAux;
	
	//Busca textos que contenham adjudicação de relacionamentos associada
	ArrayList<Integer> listAdjRel = Texto.findAllTextsWithRelationAdjudicationByProject(projeto_id);
	
	//Se é ADMIN ou REVISOR
	if(Permissao.isAdmin(u) || Permissao.isRevisor(u) || Permissao.isAdjudicador(u)){
		//Obtém textos do projeto
		textos = Texto.findByProjeto_id(projeto_id);
		//Obtém estatísticas do projeto
		map = Texto.findByStatisticsByProject(projeto_id);
	}
	else{
		if(filter == null)
			textos = Texto.findByProjeto_idAndUser_id(projeto_id, u.id);
		else
			textos = Texto.findByProjeto_idAndUser_id(projeto_id, u.id, filter);
		
		//Obtém estatísticas do projeto para usuário atual
		map = Texto.findByStatisticsByProjectAndUser(projeto_id, u.id);
	}
	
	//Store PROJECT ID on SESSION
	//TODO: Put in a servlet
	session.setAttribute("projectid", projeto_id);
	
	out.print(GeneralLayoutHelper.getTop("Listagem de textos"));
%>      

 <div class="container">
 
 <form action="servlets/TextList" method="POST" name="f">
 	<div class="page-header">
        <h1>Listagem de textos do Projeto atual</h1>

       	<ul id="tab-status" class="nav nav-pills" role="tablist">
	       <li role="presentation" class="active" status="ALL"><a href="textList.jsp?id=<%=projeto_id%>"  >TODOS <span class="badge"><%= (map.get("TODOS") == null) ? 0 :  map.get("TODOS") %></span></a></li>
	       <li role="presentation" status="<%=TextoStatus.REVISAO%>"><a href="#">Revisão <span class="badge"><%= (map.get(TextoStatus.REVISAO) == null) ? 0 :  map.get(TextoStatus.REVISAO) %></span></a></li>
	       <li role="presentation" status="<%=TextoStatus.ANOTACAO%>"><a href="#">Anotação <span class="badge"> <%= (map.get(TextoStatus.ANOTACAO) == null) ? 0 :  map.get(TextoStatus.ANOTACAO) %></span></a></li>
	       <li role="presentation" status="<%=TextoStatus.ADJUDICACAO%>"><a href="#">Adjudicação <span class="badge"> <%= (map.get(TextoStatus.ADJUDICACAO) == null) ? 0 :  map.get(TextoStatus.ADJUDICACAO) %></span></a></li>
	       <li role="presentation" status="<%=TextoStatus.FINALIZADO%>"><a href="#">Finalizado <span class="badge"> <%= (map.get(TextoStatus.FINALIZADO) == null) ? 0 :  map.get(TextoStatus.FINALIZADO) %></span></a></li>
	     </ul>
      </div>
  </form>

	<table id="table-texts" class="table table-striped">
	  <thead>
	    <tr>
	      <th>#</th>
	      <th>Texto</th>
	      <th style="text-align:center">Responsáveis</th>
	      <th style="text-align:center">Data</th>
	      <th style="text-align:center">Tarefa</th>
	      <th style="text-align:center">Status</th>
	      <%--<th></th>--%>
	    </tr>
	  </thead>
	  <tbody>
	  <% 
	  try{
	  	for(Texto t:textos){  %>
		    <tr class="status-<%=t.status%> status-ALL">
				<td>
					<%= t.id %>
				</td>
				<td>
					<%= t.texto %>
				</td>
				<td align="center">
					<% 
						//Obtém lista de usuários(anotadores) associados ao texto atual
						listAux = textosUsuarios.get(t.id);
						if(listAux != null){
							if(listAux.size() > 0)
								for(String nome : listAux)
									out.print(nome + " ");
						}
						else{
							out.print("N/A");
						}
					
					%>
				</td>
				<td align="center">
					<%
					
					String timeStamp = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(t.dataatualizacao); 
					
					out.print(timeStamp);
					%>
				</td>
				<td align="center">
					<div id='link_<%= t.id %>'>
					<%
						if(t.status.equals(TextoStatus.REVISAO))
							out.print("<a href=\"textReview.jsp?id=" + t.id + "\">Revisar</a>");
						else if(t.status.equals(TextoStatus.ANOTACAO))
							out.print("<a href=\"textAnnotation.jsp?id=" + t.id + "\">Anotar</a>");
						else if(t.status.equals(TextoStatus.ADJUDICACAO))
							out.print("<a href=\"textAdjudication.jsp?id=" + t.id + "\">Adjudicar</a>");
						else if(t.status.equals(TextoStatus.FINALIZADO))
							out.print("Finalizado");
					%>
					</div>
					<%
						//Se for adjudicador - Permitir adjudicação apenas dos relacionamentos
						//Funcionalidade feita apenas para solucionar textos que foram adjudicados antes da funcionalidade de adjudicação de relacionamentos ficar pronto
						if(Permissao.isAdjudicador(u))
							//Se texto já foi finalizado
							if(t.status.equals(TextoStatus.FINALIZADO))
								//Se texto atual não contém adjudicação de relacionamentos armazenada
								if(!listAdjRel.contains(t.id))
									out.print("<div><a style=\"color:red\" href=\"textAdjudication.jsp?id=" + t.id + "&relationOnly=1\">Adjudicar relacionamentos</a></div>");
							
						
					
					%>
				</td>
				<td align="center">
					<select class="text-status" id="<%=t.id%>" <% if(!Permissao.isOnlyAdmin(u)) out.print("disabled='disabled'"); %>>
  						<option value="<%= TextoStatus.REVISAO %>" <% if(t.status.equals(TextoStatus.REVISAO)) out.print("selected"); %>>Revisão</option>
  						<option value="<%= TextoStatus.ANOTACAO %>" <% if(t.status.equals(TextoStatus.ANOTACAO)) out.print("selected"); %>>Anotação</option>
  						<option value="<%= TextoStatus.ADJUDICACAO %>" <% if(t.status.equals(TextoStatus.ADJUDICACAO)) out.print("selected"); %>>Adjudicação</option>
  						<option value="<%= TextoStatus.FINALIZADO %>" <% if(t.status.equals(TextoStatus.FINALIZADO)) out.print("selected"); %>>Finalizado</option>
					</select><br>
					
				</td>
			</tr>
		<% 
		
	  	}
	  }
	catch(NullPointerException e){
	
		out.print("<tr><td colspan='6'>No texts!</td></tr>");
	}
		%>
	   </tbody>
	</table>
</div>

<!-- Modal CONFIRM CHANGE STATUS -->
 <div class="modal fade" id="modal-change-status" role="dialog">
   <div class="modal-dialog modal-lg">
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h4 class="modal-title"><b>Confirmação</b></h4>
       </div>
       <div class="modal-body">
       	<div class="form-group" style="font-size:18px">
          <%
          
          if(Permissao.isOnlyAdmin(u)){
        	  out.print("Deseja alterar o status para TODOS usuários relacionados ao texto? ");
          }
          else{
        	  out.print("Deseja alterar o status apenas para o usuário atual? ");
          }
          
          %>
        </div>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
         <button type="button" class="btn btn-success" data-dismiss="modal" id="confirm-change-status">OK</button>
       </div>
     </div>
   </div>
 </div>
<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

	
%>
	<script type="text/javascript">
	$(".text-status").change(function store(s) {
		var selected_value =  this.value;
		var text_id =  this.id;
		
		//Abre DIALOG e abre opções de tag ao final da animação
		$("#modal-change-status").modal('show');
		
		//Define DIALOG como Dragable
		$("#modal-change-status").draggable({
		    handle: ".modal-header"
		});
		
		$("#confirm-change-status").off().click(function(){
		
			//Envia REQUEST para atualição do status
			var jqxhr = $.post( "servlets/TextList?text_id=" + text_id + "&selected_value=" + selected_value,{}, function(res) {
				
				//$("#modal-change-status").modal('hide');
				
				//Se deu certo atualização
				if(res.result == true){
					//Atualiza link de ação
					if(selected_value == 'I'){
			        	$('#link_' + text_id).html("<a href=\"textReview.jsp?id=" + text_id + "\">Revisar</a>");
					}
			        else if(selected_value == 'R'){
			        	$('#link_' + text_id).html("<a href=\"textAnnotation.jsp?id=" + text_id + "\">Anotar</a>");
			        }
			        else if(selected_value == 'A'){
			        	$('#link_' + text_id).html("<a href=\"textAdjudication.jsp?id=" + text_id + "\">Adjudicar</a>");
			        }
			        else if(selected_value == 'F'){
			        	$('#link_' + text_id).html("Finalizado");
			        }
					
					
			        $.notify({
						title: "<strong>Sucesso: </strong>",
						message: "Status alterado",
						icon: "glyphicon glyphicon-ok-circle"
					},{
						type: 'success',
						newest_on_top: true
					});
				}
				else{
					$.notify({
						title: "<strong>Erro: </strong>",
						message: "Houve um erro ao salvar o novo status",
						icon: 'glyphicon glyphicon-warning-sign',
					},{
						type: 'danger',
						newest_on_top: true
					});
				}
			});
		
		});
	});
	
	
	$("#tab-status li").click(function(){
	
		//Retira status de ativo das abas
		$("#tab-status li").removeClass("active");
		
		//Coloca status de ativo nas abas
		$(this).addClass("active");
		
		//Obtém status selecionado
		var status = $(this).attr("status");
		
		//Filtra apenas as linhas selecionadas
		$("#table-texts")
			.find("tr.status-ALL")
				.hide()
			.end()
			.find("tr.status-"+status)
				.show();
		
	});
	
	</script>
  </body>
  <style type="text/css">
	.modal-header{cursor:move;}
</style>
</html>