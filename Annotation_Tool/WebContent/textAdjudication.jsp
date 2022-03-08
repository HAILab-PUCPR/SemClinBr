<%@page import="helper.TextAdjudicationHelper"%>
<%@page import="helper.TextAnnotationHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Usuario" %>
<%@ page import="model.Texto" %>
<%@ page import="model.TextoStatus" %>
<%@ page import="model.Tag" %>
<%@ page import="model.Sentenca" %>
<%@ page import="model.Token" %>
<%@ page import="model.Anotacao" %>
<%@ page import="model.TokenStats" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="util.Tokenizer" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%@ page import="model.Tiporelacionamento" %>
<%@ page import="model.Relacionamento" %>
<%@ page import="model.TermoCompostoStats" %>
<%@ page import="model.AnotacaoCompleta" %>
<%@ page import="model.RelacionamentoCompleto" %>
<%
  
	//Obtém ID do projeto
 	Integer project_id = (Integer) session.getAttribute("projectid");
	//Obtém ID do texto
 	int texto_id = Integer.parseInt(request.getParameter("id"));
 	//Busca usuário logado
	Usuario u = (Usuario) session.getAttribute("usuario");
 	//Busca TEXTO a ser adjudicado
 	Texto texto = Texto.findById(texto_id);
 	//Caso os adjudicadores também fossem relacionados aos textos
 	//Texto texto = Texto.findByIdAndUser(texto_id, u.id);
 	
 	//Obtém parâmetro para verificar se adjudicação será apenas dos relacionamentos
 	//OBS: Função temporária pois os primeiros textos adjudicados não tinham a funcionalidade dos relacionamentos
 	boolean relationOnly = (request.getParameter("relationOnly") != null) ? true : false;
 	
 	ArrayList<Anotacao> adjudicacoes = new ArrayList<Anotacao>();
 	//Se é abertura para adjudicação dos relacionamentos apenas
 	if(relationOnly){
 		//Busca adjudicações feitas
 		adjudicacoes = Anotacao.findAdjudicacoesFinalizadasByTextoId(texto_id);
 	}
 	
 	//Busca SENTENCAS do texto
 	ArrayList<Sentenca> sentencas = Sentenca.findSentencasByTextoId(texto_id);
 	//Busca TOKENS do texto
 	ArrayList<Token> tokens = Token.findTokensByTextoId(texto_id);
 	//Busca TAGS
 	ArrayList<Tag> tags = Tag.findByProjectId(project_id);
 	//Busca TIPOS DE RELACIONAMENTOS
 	ArrayList<Tiporelacionamento> tps = Tiporelacionamento.findByProjectId(project_id);
 	
 	//TODO: Possibilitar abertura de adjudicações finalizadas apenas para visualização (falta apenas buscar relacionamentos adjudicados e desabilitar funcionalidades de envio)
 	//TODO: Verificar status para todos anotadores
 	if(!texto.status.equals(TextoStatus.ADJUDICACAO) && !relationOnly){
 		out.print("<script>alert('O texto atual não está aberto para adjudicação. Status atual: "+texto.status+".');location.href='textList.jsp?id="+project_id+"';</script>");
 	}
 	System.out.println("1");
 	//Busca quais anotadores foram atribuídos ao texto
 	ArrayList<Usuario> relatedAnnotators = Anotacao.findTextRelatedAnnotators(texto_id);
 	System.out.println("2");
 	//Busca quais anotadores participaram da anotação deste texto
 	ArrayList<Usuario> performedAnnotators = Anotacao.findTextPerformedAnnotators(texto_id);
 	System.out.println("3");
 	//Se o texto ainda não foi anotado por todos anotadores relacionados
 	if(relatedAnnotators.size() > performedAnnotators.size()){
 		out.print("<script>alert('O texto atual ainda não foi finalizado por todos anotadores relacionados.');location.href='textList.jsp?id="+session.getAttribute("projectid")+"';</script>");
 	}
 	System.out.println("4");
 	//Busca ANOTACOES PARA O ANOTADOR 1
 	ArrayList<Anotacao> anotacoes1 = Anotacao.findAnotacoesByTextoIdAndAnotadorId(texto_id, performedAnnotators.get(0).id);
 	//Busca ANOTACOES PARA O ANOTADOR 2
 	ArrayList<Anotacao> anotacoes2 = Anotacao.findAnotacoesByTextoIdAndAnotadorId(texto_id, performedAnnotators.get(1).id);
 			
 	//TODO: Adjudicação está funcional para apenas DOIS ANOTADORES por texto!
 	//TODO: Não seria necessário um Map, apenas um arraylist estaria de bom tamanho, assim como os termos discordantes foi feito
 	//Busca anotações concordantes entre os anotadores
 	Map<Anotacao, Anotacao> anotacoesConcordantes = Anotacao.findAnotacoesConcordantesByTextoIdAndAnnotators(texto_id, performedAnnotators);
 	System.out.println("5");
 	//Busca anotações SIMPLES discordantes entre os anotadores
 	List<AnotacaoCompleta> anotacoesSimplesDiscordantes = Anotacao.findAnotacoesSimplesDiscordantesByTextoIdAndAnnotators(texto_id, performedAnnotators);
 	//Map<AnotacaoCompleta, AnotacaoCompleta> anotacoesSimplesDiscordantes = Anotacao.findAnotacoesSimplesDiscordantesByTextoIdAndAnnotators(texto_id, performedAnnotators);
 	System.out.println("6");
 	//Busca anotações COMPOSTAS discordantes entre os anotadores
 	List<AnotacaoCompleta> anotacoesCompostasDiscordantes = Anotacao.findAnotacoesCompostasDiscordantesByTextoIdAndAnnotators(texto_id, performedAnnotators);
 	//Map<AnotacaoCompleta, AnotacaoCompleta> anotacoesCompostasDiscordantes = Anotacao.findAnotacoesCompostasDiscordantesByTextoIdAndAnnotators(texto_id, performedAnnotators);
 	System.out.println("7");
 	//Busca RELACIONAMENTOS PARA ANOTADOR 1
 	//ArrayList<Relacionamento> relacionamentos1 = Relacionamento.findRelacionamentosByTextoIdAndAnotadorId(texto_id, performedAnnotators.get(0).id);
 	//Busca RELACIONAMENTOS PARA ANOTADOR 2
 	//ArrayList<Relacionamento> relacionamentos2 = Relacionamento.findRelacionamentosByTextoIdAndAnotadorId(texto_id, performedAnnotators.get(1).id);
 	System.out.println("8");
 	//Busca RELACIONAMENTOS CONCORDANTES entre os anotadores
 	List<RelacionamentoCompleto> relacionamentosConcordantes = Relacionamento.findRelacionamentosConcordantesByTextoIdAndAnnotators(texto_id, performedAnnotators, tokens);
 	//Busca RELACIONAMENTOS DISCORDANTES entre os anotadores
 	List<RelacionamentoCompleto> relacionamentosDiscordantes = Relacionamento.findRelacionamentosDiscordantesByTextoIdAndAnnotators(texto_id, performedAnnotators, tokens);
 	System.out.println("9");
 	
 	
 	System.out.println("10");
 	//Monta TOPO da página
 	out.print(GeneralLayoutHelper.getTop("Adjudicação de textos"));
 	
%>   
    
	<div id="adjudicationContainer" class="container">
		<form action="servlets/TextAdjudication" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" id="id" value="<%=texto.id %>"/>
			<h3>Use o assistente para resolver as divergências entre os anotadores.</h3>
			<div id="textbox" class="well">
        		<p>
				<%
					//Se for aberto apenas para adjudicações de relacionamentos (Neste caso anotações de conceitos já foram adjudicadas e finalizadas)
					if(relationOnly)
						out.print(TextAdjudicationHelper.showAdjudications(sentencas, tokens, tags, adjudicacoes));
					else
						out.print(TextAdjudicationHelper.showFinalAnnotations(sentencas, tokens, tags, anotacoesConcordantes));
				
				%>	
				</p>
				</div>
				 <div id="alertbox" class="alert alert-dismissable fade in" style="display:none">
				    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				    <strong>Successo!</strong> <span>This alert box could indicate a successful or positive action.</span>
				  </div>
				  <div id="alertbox-selection" class="alert alert-warning alert-dismissable fade in" style="display:none">
				    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				    <strong>Aviso!</strong> <span>Não é possível marcar termos compostos que já contenham token marcados.</span>
				  </div>
				<div class="form-group">
					<button id="voltar" class="btn btn-default"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span> Voltar</button>
					<button id="mostrarAnotacao" class="btn"><span class="glyphicon glyphicon-tags" aria-hidden="true"></span> Anotações</button>
					<!-- <button id="mostrarRelacionamentos" class="btn"><span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span> Relacionamentos</button> -->
					<button id="mostrarMetricas" class="btn"><span class="glyphicon glyphicon-indent-right" aria-hidden="true"></span> Métricas</button>
					<!-- <button id="enviar" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> Salvar adjudicação</button> --> 
					<button id="finalizar" class="btn btn-success"><span class="glyphicon glyphicon-saved" aria-hidden="true"></span> Salvar e finalizar adjudicação</button>	
					
				</div>
			</form>
	</div>
	
	
	
	<!-- RETIRADO do adjudicationContainer - Acompanhar erros  -->
	<!-- SIDEBAR DE RELACIONAMENTOS -->
	<div id="relation-panel" class="panel panel-default">
	  <!-- Default panel contents -->
	  <div class="panel-heading">
  			<a data-toggle="collapse" data-parent="#relation-panel" href="#collapsePanel" style="text-decoration:none">
  				<span class="glyphicon glyphicon-link"></span>&nbsp;Painel de Relacionamentos
  			</a>
	  </div>
		<div id="collapsePanel" class="panel-body panel-collapse collapse">
		  <!-- List group -->
		  <ul id="relation-list" class="list-group">
		  <%
		  
		  String str = "";
		  
		  //Adicionar relacionamentos concordantes ao painel
		  for(RelacionamentoCompleto r : relacionamentosConcordantes){
			  
			  //Separa TOKEN_IDS dos termos
			  String[] t1_ids = r.tokens1.split(",");
			  String[] t2_ids = r.tokens2.split(",");
			  
			  str += "<li class=\"list-group-item\" style=\"text-align:center\">";
			  
			  //TODO: Inserir tags associadas - tag128="128" hastags="128" data-original-title="Tags: <span tag128='128'>Negation</span> "
			  str += "<span style=\"font-size: 12px;\">";
			  //Percorre token(s) do TERMO 1
			  for(Token t : r.tokens1List){

		  			//TODO:  compoundid="a3dfb762-ddcc-4f04-9b9b-e6e7fe20c5c2" title="Tags: <span tag30='30'>Laboratory or Test Result</span> "
		  			str += "<span class=\"token\" tokenid=\""+t.id+"\" data-toggle=\"tooltip\" data-html=\"true\" >"+t.token+"</span>";
		  			str += "<span class=\"space\"> </span>";	  
				  
			  }
			  str += "</span>";
			  
			  //Adiciona ícone de relacionamento
			  str += "<br><span class=\"glyphicon glyphicon-link isRelation\" hasRelations=\""+r.tiporelacionamento_id+"\" data-toggle=\"tooltip\" title=\""+r.relacionamento_name+"\"></span><br>";
			  
			  //TODO: Inserir tags associadas - tag128="128" hastags="128" data-original-title="Tags: <span tag128='128'>Negation</span> "
			  str += "<span style=\"font-size: 12px;\">";
			  //Percorre token(s) do TERMO 2
			  for(Token t : r.tokens2List){

		  			//TODO:  compoundid="a3dfb762-ddcc-4f04-9b9b-e6e7fe20c5c2" title="Tags: <span tag30='30'>Laboratory or Test Result</span> "
		  			str += "<span class=\"token\" tokenid=\""+t.id+"\" data-toggle=\"tooltip\" data-html=\"true\" >"+t.token+"</span>";
		  			str += "<span class=\"space\"> </span>";	  
				  
			  }
			  str += "</span>";
			  str += "	<span class=\"icon edit-relation glyphicon glyphicon-edit\" style=\"font-size:24px\"></span><span class=\"icon delete-relation glyphicon glyphicon-remove-sign\" style=\"font-size:24px\"></span>";
			  str += "</li>";
			  
		  }
		  
		  //Imprime relacionamentos
		  out.print(str); 
		  
		  
		  %>
		  </ul>
		</div>
	</div>
	
	<div id="metricasContainer" class="container" style="display:none">
		<div class="panel panel-default"> 
		  <div class="panel-heading">
		    <h3 class="panel-title">Medidas de adjudicação</h3>
		  </div>
		  <% out.print(TextAdjudicationHelper.showAdjudicationMetrics(texto_id, performedAnnotators)); %>
		</div>
	</div>
	
	<div id="annotatorsContainer" class="container" style="display:none">
		<div id="annotator1Container" class="container">
			<h3>Anotador 1</h3>
			<div id="textbox1" class="well">
				<p><% out.print(TextAdjudicationHelper.showAnnotations(sentencas, tokens, tags, anotacoes1)); %></p>
			</div>
		</div>
		
		<div id="annotator2Container" class="container">
			<h3>Anotador 2</h3>
			<div id="textbox2" class="well">
				<p><% out.print(TextAdjudicationHelper.showAnnotations(sentencas, tokens, tags, anotacoes2)); %></p>
			</div>
		</div>
		<div style="clear:both">&nbsp;</div>	
	</div>
	
	
	<div id="spacer"></div>
	 
	<!-- Modal TAGS -->
  <div class="modal fade" id="modal-annotation" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Adjudicando: <span id="annotated-token"></span></h4>
        </div>
        <div class="modal-body">
        	<div class="form-group">
	          <%
	          
	          	out.print(TextAnnotationHelper.getTagAutocompleteSelectBox(tags));
	          
	          %>
	          </div>
	          
	          <div id="info-abbreviation" class="form-group" style="display:none">
    				<label for="expanded-abbreviation">Abreviatura expandida</label>
          			<input type="text" class="form-control" id="expanded-abbreviation" placeholder="Informe a forma expandida da abreviatura">
          	   </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="cancelTag">Cancelar</button>
          <button type="button" class="btn btn-success" data-dismiss="modal" id="addTag">OK</button>
        </div>
      </div>
    </div>
  </div>
  
  
  <!-- Modal RELAACIONAMENTOS -->
  <div class="modal fade" id="modal-relation" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Relacionando: <span id="relation-concept-1"></span> <span class="glyphicon glyphicon-link"></span> <span id="relation-concept-2"></span></h4>
        </div>
        <div class="modal-body">
        	<div class="form-group">
	          <%
	          
	          	out.print(TextAnnotationHelper.getRelationAutocompleteSelectBox(tps));
	          
	          %>
	          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-success" data-dismiss="modal" id="addRelation">OK</button>
        </div>
      </div>
    </div>
  </div>


<%

	out.print(GeneralLayoutHelper.getFooter());

	out.print(GeneralLayoutHelper.getBootstrap());

	//INÍCIO DA MONTAGEM DAS SUGESTÕES DE ADJUDICAÇÃO
	String html = "";
	int cont = 0;
	
	//SE NÃO FOI ABERTO APENAS PARA ADJUDICAÇÃO DE RELACIONAMENTOS
	//MOSTRA OPÇÕES DE ADJUDICAÇÃO DE CONCEITOS
	if(!relationOnly){
	
		//TODO: Fazer funcionar para mais de 2 anotadores
		//Percorre anotações discordantes de TERMOS SIMPLES
		//for (Map.Entry<AnotacaoCompleta, AnotacaoCompleta> entry : anotacoesSimplesDiscordantes.entrySet()){
		for(AnotacaoCompleta a : anotacoesSimplesDiscordantes){
			
			String comp = (a.abreviatura != null) ? " ["+a.abreviatura+"]" : "";
		    
			//Montar DIVs de sugestões de adjudicação
	  		html += "<div class=\"well well-sm assistantItem notdecided\" id=\""+a.token_id+"\">";
			html += "     <div class=\"description\">";
			html += "          Deseja anotar o termo <span class=\"term\">"+a.token_name+"</span> como <span class=\"semanticType\" tag_id=\""+a.tag_id+"\" tag"+a.tag_id+"=\"tag"+a.tag_id+"\">"+a.tag_name + comp + "</span>?<br>"; 
			html += "          Anotador: <u>" + a.anotador_name + "</u><br>";
			html += "     </div>";
			html += "     <div class=\"yesNoButtons\">";
			html += "           <button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
			html += "        	<button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
			html += "     </div>";
			html += "     <div style=\"clear:both\"></div>";
			html += "</div>"; 
			
			cont++;
			
			
		}
		
		String token_ids = "";
		String token_names = "";
		int tag_id = 0;
		String termocomposto_id = "";
		//Percorre anotações discordantes de TERMOS COMPOSTOS
		for(int i = 0; i < anotacoesCompostasDiscordantes.size(); i++){
			
			AnotacaoCompleta a = anotacoesCompostasDiscordantes.get(i);
			
			//Se é ultimo token
			if(i == anotacoesCompostasDiscordantes.size() - 1 && tag_id == a.tag_id){
				//Concatena token_id
				token_ids += a.token_id + ",";
				//Concatena nome do token
				token_names += a.token_name + " ";
				//Força mudança
				tag_id = 0;
				termocomposto_id = "";
			}
			
			//Se foi para token do próximo termo ou é ultimo token
			if(i != 0 && (!termocomposto_id.equals(a.termocomposto_id) || tag_id != a.tag_id)){
				
				token_ids = token_ids.substring(0, token_ids.length() - 1);//Remove ultima virgula
			
				//Montar DIVs de sugestões de adjudicação
		  		html += "<div class=\"well well-sm assistantItem isMultiple notdecided\" id=\""+token_ids+"\">";
				html += "     <div class=\"description\">";
				html += "         Deseja anotar o termo <span class=\"term\">"+token_names.trim()+"</span> como <span class=\"semanticType\" tag_id=\""+anotacoesCompostasDiscordantes.get(i-1).tag_id+"\" tag"+anotacoesCompostasDiscordantes.get(i-1).tag_id+"=\"tag"+anotacoesCompostasDiscordantes.get(i-1).tag_id+"\">"+anotacoesCompostasDiscordantes.get(i-1).tag_name + "</span>?<br>"; 
				html += "         Anotador: <u>" + anotacoesCompostasDiscordantes.get(i-1).anotador_name + "</u><br>";
				html += "     </div>";
				html += "     <div class=\"yesNoButtons\">";
				html += "          <button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
				html += "          <button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
				html += "     </div>";
				html += "     <div style=\"clear:both\"></div>";
				html += "</div>"; 
				
				token_ids = "";
				token_names = "";
				
				cont++;
				
			}
			
			//Armazena tag_id atual
			tag_id = a.tag_id;
			termocomposto_id = a.termocomposto_id;
			//Concatena token_id
			token_ids += a.token_id + ",";
			//Concatena nome do token
			token_names += a.token_name + " ";
			
		}
		
	}
	
	//Percorre RELACIONAMENTOS DISCORDANTES
	for(RelacionamentoCompleto r : relacionamentosDiscordantes){
	    
		//Montar DIVs de sugestões de adjudicação
  		html += "<div class=\"well well-sm assistantItem notdecided isRelation\" id=\""+r.tokens1+"-"+r.tokens2+"\">";
		html += "     <div class=\"description\">";
		html += "          Deseja relacionar como <span class=\"semanticType\" tag_id=\""+r.tiporelacionamento_id+"\">"+r.relacionamento_name+"</span> os termos <span class=\"term\">"+r.termo1+"</span> e <span class=\"term\">"+r.termo2+"</span>?<br>"; 
		html += "          Anotador: <u>"+r.anotador_name+"</u><br>";
		html += "     </div>";
		html += "     <div class=\"yesNoButtons\">";
		html += "          <button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
		html += "          <button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
		html += "     </div>";
		html += "     <div style=\"clear:both\"></div>";
		html += "</div>"; 
		
		cont++;
		
		
	}
	

%>

	<!-- ASSISTENTE DE ADJUDICAÇÃO -->
	<div class="panel-group" id="accordion">
	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h4 class="panel-title">
	                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                    <span id="assistantIcon" class="glyphicon glyphicon-arrow-up"></span> 
	                    Assistente de adjudicação <span id="assistantNumber" class="badge"><%=cont %></span>
	                </a>
	            </h4>
	        </div>
	        <div id="collapseOne" class="panel-collapse collapse">
	            <div class="panel-body">
	            	<%	out.print(html); 	%>
	            </div>
	        </div>
	    </div>
	</div>

	
	<script type="text/javascript">
	//TODO: Inserir dinamicamente caso funcionalidade seja ampliada para mais de 2 anotadores
	//Define os containers que contém anotações - deixar sempre o principal primeiro!
	var containers = ["adjudicationContainer", "annotator1Container", "annotator2Container"];
	
	//Define se tela foi aberta apenas para adjudicação de relacionamentos
	var relationOnly = <%= (relationOnly) ? "true" : "false" %>;
	
	if(relationOnly){
		$.notify({
			title: "<strong>Aviso: </strong>",
			message: "Apenas as adjudicações de RELACIONAMENTOS serão enviadas ao finalizar a adjudicação.",
			icon: "glyphicon glyphicon-warning-sign"
		},{
			type: 'warning',
			newest_on_top: true
		});
	}
	
	//Gera UNIQUE IDs
	function guid() {
	  function s4() {
	    return Math.floor((1 + Math.random()) * 0x10000)
	      .toString(16)
	      .substring(1);
	  }
	  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
	    s4() + '-' + s4() + s4() + s4();
	}
	
	//Função para habilitar DragNDrop
	var doDragDrop = function(selector){
		
		//Se não foi informado elemento específico, adiciona a todos spans de tokens
		selector = (selector === null) ? "span.token[hasTags],span.compoundtoken" : selector;
		
		//Define DRAG para relacionamentos
		$(selector).draggable({ 
			/*containment: "#annotationContainer" ,*///Está dando bug em termos compostos muito grandes
			helper: 'clone',
			drag: function( event, ui ) {
				//Evita BUG dos tooltips, remove-os sempre que está arrastando conceitos
				$(".tooltip[role=tooltip]").remove();
			}
		});
		//DEfine DROP para relacionamentos
		$(selector).droppable({
	    	drop: function( event, ui ) {
	        	
	    		var $from = $(ui.draggable[0]);
	    		var $to = $(this);
	    		
	    		//Abre MODAL para seleção do TIPO DE RELACIONAMENTO
	    		//modalRelation($from, $to, null);
	    		//Mostra mensagem avisando bloqueio de funcionalidade
				$.notify({
					title: "<strong>Aviso: </strong>",
					message: "Função desabilitada para adjudicação.",
					icon: "glyphicon glyphicon-warning-sign"
				},{
					type: 'warning',
					newest_on_top: true
				});
	    		
	      	}
	    });
		
	}
	
	//Função para obter TOKEN IDs dentro de um termo composto
	var getCompoundTermTokens = function($term){
		
		var tokens = "";
		//Concatena tokens
		$term.find("span.token").each(function(index, element){
			tokens = (tokens == "") ? $(element).attr("tokenid") : tokens + "," + $(element).attr("tokenid");
		});
		return tokens;
		
	}
	
	//Função que controla abertura do MODAL para definir relacionamentos
	var modalRelation = function($elSpan1, $elSpan2, $editedElement){
		
		//Obtém TOKEN IDs dos elementos (Só existirão se forem termos simples)
		var tokenid1 = $elSpan1.attr("tokenid");
		var tokenid2 = $elSpan2.attr("tokenid");
		
		//Flag para determinar se dois elementos já tem relação no painel
		var alreadyWithRelationship = false;
		//Armazena <li> que contém relacionamento já adicionado ao painel
		var liElement;
		//Flag para determinar se elementos são compostos
		var isCompound1 = true; 
		var isCompound2 = true;
		
		//Verifica se primeiro elemento é COMPOSTO
		if (typeof $elSpan1.attr("tokenid") !== typeof undefined && $elSpan1.attr("tokenid") !== false) {
			isCompound1 = false;
		}
		//Verifica se segundo elemento é COMPOSTO
		if (typeof $elSpan2.attr("tokenid") !== typeof undefined && $elSpan2.attr("tokenid") !== false) {
			isCompound2 = false;
		}
		
		//Se NÃO FOR ABERTURA PARA EDIÇÃO
		if($editedElement == null){
		
			//Verificar se relacionamento já não está no painel antes de adicionar
			//Percorre relacionamentos existentes no painel
			$("#relation-list li").each(function(index, li){
				
				//Obtém elementos relacionados no <li> atual do painel
				var $elem1 = $(li).children("span:eq(0)");
				var $elem2 = $(li).children("span:eq(2)");
				
				//Se é relacionamento entre dois termos simples
				if(!isCompound1 && !isCompound2){
					
					//Se elemento atual do painel tem os dois tokens atuais
					if($(li).has("span[tokenid="+tokenid1+"]").size() > 0 && $(li).has("span[tokenid="+tokenid2+"]").size() > 0){
						alreadyWithRelationship = true;
						liElement = li;
					}
					
				}//Se é relacionamento entre dois termos compostos
				else if(isCompound1 && isCompound2){
					
					//Se elemento1 e elemento2 estiverem presentes no relacionamento (<li> do painel) atual
					if( 
						(getCompoundTermTokens($elSpan1) == getCompoundTermTokens($elem1) || getCompoundTermTokens($elSpan1) == getCompoundTermTokens($elem2))
							&&
						(getCompoundTermTokens($elSpan2) == getCompoundTermTokens($elem1) || getCompoundTermTokens($elSpan2) == getCompoundTermTokens($elem2))
					){
						alreadyWithRelationship = true;
						liElement = li;
					}
					
					
				}//Se apenas o primeiro termo é composto
				else if(isCompound1){
						
					if(
						(getCompoundTermTokens($elSpan1) == getCompoundTermTokens($elem1) || getCompoundTermTokens($elSpan1) == getCompoundTermTokens($elem2))
						&&
						($(li).has("span[tokenid="+tokenid2+"]").size() > 0)
					){
						alreadyWithRelationship = true;
						liElement = li;
					}
					
				}//Se apenas o segundo termo é composto
				else if(isCompound2){
					
					if(
						(getCompoundTermTokens($elSpan2) == getCompoundTermTokens($elem1) || getCompoundTermTokens($elSpan2) == getCompoundTermTokens($elem2))
						&&
						($(li).has("span[tokenid="+tokenid1+"]").size() > 0)
					){
						alreadyWithRelationship = true;
						liElement = li;
					}
				
				}
				
				
			});
			
		}
		
		//TODO: Caso já tenha relacionamento, abrir painel mesmo assim com os relacionamentos já existentes
		//Se dois termos selecionados já contém relacionamento no painel E for abertura para NOVO relacionamento
		if(alreadyWithRelationship && $editedElement == null){

			//Mostra mensagem avisando
			$.notify({
				title: "<strong>Aviso: </strong>",
				message: "Os termos selecionados já contém relacionamento definido no painel",
				icon: "glyphicon glyphicon-warning-sign"
			},{
				type: 'warning',
				newest_on_top: true
			});
			
			//Faz brilhar o relacionamento no painel
    		$(liElement).switchClass( "foo", "glow", 750).delay(750).switchClass( "glow", "foo", 750);
			
		}
		else{
		
			//Define termos que estão sendo relacionados
			$("#relation-concept-1").text($elSpan1.text());
			$("#relation-concept-2").text($elSpan2.text());
			
			//Abre DIALOG e abre opções de tag ao final da animação
			$("#modal-relation").modal('show').on('shown.bs.modal', function() {
				//Foco no campo de TAG
				$("#relationtoken").select2('focus');
		    });
			
			//Define DIALOG como Dragable
			$("#modal-relation").draggable({
			    handle: ".modal-header"
			});
			
			//Limpa possíveis TAGS definidas anteriormente
			$("#relationtoken").val(null).trigger("change");
			
			//Adiciona RELAÇÕES que já tenham sido anotadas para os termos - Caso eles tenham relações associadas
			//Funciona para caso de acionamento do botão EDITAR
			if($elSpan1.siblings(".isRelation").size() > 0){
				
				var arrRelations = $elSpan1.siblings(".isRelation").attr("hasRelations").split(",");
				$("#relationtoken").val(arrRelations).trigger("change");
				
			}
			
			//Corrige BUG de layout da caixa de busca do Autocomplete
			$(".modal-body .select2-search").add(".select2-search__field").css("width", "75%");
			
			//Captura CLICK para adicionar TAG
			$("#addRelation").off().click(function(){
				
				//Gerar UNIQUE ID - Não é mais necessário
				//var UID = guid();
	    		
	    		//Relacionar dois conceitos através de ID único
	    		//$elSpan1.attr("relationid", UID);
	    		//$elSpan2.attr("relationid", UID);
				
				var rtext = "";
				//Percorre NOMES das RELAÇÕES selecionadas
				$.each($('#relationtoken').select2('data'), function(index, relation){
					//Concatena NOMES das relações selecionadas
					rtext += relation.text + " ";
				});
				
				var rids = "";
				//Percorre IDs das RELAÇÕES selecionadas
				$.each($("#relationtoken").val(), function( index, relationid ) {
					//Concatena os IDs de relacionamento selecionados (Ex.: 1,10)
					rids = (rids == "") ? relationid : rids + "," + relationid;
				});
				
				//Se for inserção de NOVO RELACIONAMENTO
				if($editedElement == null){
		    		
					//Adicionar relacionamento no PAINEL DE RELACIONAMENTO
		    		$("<li>")
		    			.css("text-align", "center")
		    			.addClass("list-group-item")
		    			.append($elSpan1.clone().removeClass().css("font-size", "12px"))
		    			.append("<br><span class=\"glyphicon glyphicon-link isRelation\" hasRelations=\""+rids+"\" data-toggle=\"tooltip\" title=\""+rtext+"\"></span><br>")
		    			.append($elSpan2.clone().removeClass().css("font-size", "12px"))
		    			.append("<span class=\"icon edit-relation glyphicon glyphicon-edit\" style=\"font-size:24px\"></span><span class=\"icon delete-relation glyphicon glyphicon-remove-sign\" style=\"font-size:24px\"></span>")
		    		.appendTo("#relation-list");
					
		    		//Faz painel de relacionamentos brilhar
		    		$("#relation-panel").switchClass( "foo", "glow", 750).delay(750).switchClass( "glow", "foo", 750); 
		    		
				}//Se for EDIÇÃO DE RELACIONAMENTO
				else{
					
					//Atualiza relacionamentos e faz relacionamento brilhar
					$editedElement
						.find("span.isRelation")
							.attr("hasRelations", rids)
							.attr("title", rtext)
						.end()
							.switchClass( "foo", "glow", 750)
							.delay(750)
							.switchClass( "glow", "foo", 750);
					
				}
	    		
	    		
					
			});
			
		}
		
	}
	
	//Função para obter texto selecionado
	var getSelectedText = function() {
  		t = (document.all) ? document.selection.createRange().text : document.getSelection();
		return t;
	}
	
	//Função que controla abertura do MODAL para tagear texto
	var modalTag = function($elSpan, isCompoundTerm){
		
		//Obtém TOKEN ID
		var tokenid = $elSpan.attr("tokenid");
		
		//Define termo que está sendo anotado
		$("#annotated-token").text($elSpan.text());
		
		//Abre DIALOG e abre opções de tag ao final da animação
		$("#modal-annotation").modal('show').on('shown.bs.modal', function() {
			//Foco no campo de TAG
			$("#tagtoken").select2('focus');
	    });
		
		//Define DIALOG como Dragable
		$("#modal-annotation").draggable({
		    handle: ".modal-header"
		});
		
		//Limpa possíveis TAGS definidas anteriormente
		$("#tagtoken").val(null).trigger("change");
		
		//Se tem abreviatura
		if (typeof $elSpan.attr("abbreviation") !== typeof undefined && $elSpan.attr("abbreviation") !== false) {
			$("#expanded-abbreviation").val($elSpan.attr("abbreviation"));
		}
		else{
			//Limpa possíveis ABREVIATURAS
			$("#expanded-abbreviation").val(null);
		}
		
		//Adiciona TAGS que já tenha sido anotadas para o termo - Caso ele tenha TAGS associadas
		if (typeof $elSpan.attr("hasTags") !== typeof undefined && $elSpan.attr("hasTags") !== false) {

			var arrTags = $elSpan.attr("hasTags").split(",");
			$("#tagtoken").val(arrTags).trigger("change");
			
		}
		
		//Corrige BUG de layout da caixa de busca do Autocomplete
		$(".modal-body .select2-search").add(".select2-search__field").css("width", "75%");
		
		//Captura CLICK para adicionar TAG
		$("#addTag").off().click(function(){
			
			//Retira possíveis TAGS adicionadas anteriormente
			$elSpan.removeAttr("hasTags");
			$.each(arrTags, function( index, tagid ) {
				
				$elSpan.removeAttr("tag" + tagid);
				
			});
			
			//Percorre TAGS selecionadas
			$.each($("#tagtoken").val(), function( index, tagid ) {
			
				//Adiciona atributo de cada TAG selecionada ao TOKEN no texto (Assim a TAG fica com a cor correta)
				$elSpan.attr("tag" + tagid, tagid);
				$elSpan.attr("hasTags", ($elSpan.attr("hasTags") == undefined) ? tagid : $elSpan.attr("hasTags") + "," + tagid);
				
			
			});
			
			//Se é abreviatura
			if($("#expanded-abbreviation").is(":visible")){
				//Adiciona abreviatura no SPAN do token
				$elSpan.attr("abbreviation", $("#expanded-abbreviation").val());
			}
			
			//Re-executa DragDrop para habilitar funcionalidade para novo Conceito adicionado
			doDragDrop($elSpan);
			
			//Se foi abertura de termo composto e nenhuma tag foi selecionada
			if(isCompoundTerm && $("#tagtoken").val() == null){
				//Remove SPAN de termo composto dos tokens circundados por ele
				$elSpan.children().unwrap();
			}
			
		});
		
		//Captura CLICK do botão CANCELAR do modal
		$("#cancelTag").off().click(function(){
			
			//Se foi abertura de termo composto
			if(isCompoundTerm){
				
				//Se ainda não foi marcada nenhuma tag para o termo composto
				if (typeof $elSpan.attr("hasTags") === typeof undefined || $elSpan.attr("hasTags") === false) {
					//Remove SPAN de termo composto dos tokens circundados por ele
					$elSpan.children().unwrap();
				}
				
			}
			
		});
		
	}
	
	/**
	* Obtém todos elementos (objetos jquery) de termos compostos
	*/
	var getAllTokensElementsById = function(token_id){
		
		var toks = token_id.split(",");
		var $itens = $("#" + containers[0] + " span[tokenid=" + toks[0] + "]");
		
		for(var i = 1; i < toks.length; i++){
			
			$itens = $itens.add($("#" + containers[0] + " span[tokenid=" + toks[i] + "]"));
			
		}
		
		return $itens;
		
	}
	
	/**
	* Obtém todos elementos (objetos jquery) de termos compostos inclusive os <span class='space'> entre eles
	*/
	var getAllTokensElementsByIdWithSpaces = function(token_id){
		
		var toks = token_id.split(",");
		var $startElement = $("#" + containers[0] + " span[tokenid=" + toks[0] + "]");//Obtém objeto jQuery do elemento inicial (primeiro token do termo composto)- variável guardará pilha de elementos selecionados também
	    var $endElement = $("#" + containers[0] + " span[tokenid=" + toks[toks.length - 1] + "]");//Obtém objeto jQuery do elemento final (ultimo token do termo composto)
	    var $actualElement = $startElement;//Define elemento atual
	    var cont = 1;
		
	    //Se houve algum erro e foi passado o mesmo token como inicio e fim - Evita loop infinito
	    if($startElement.get(0) == $endElement.get(0))
	    	return $startElement;
	    
		do{
			
			//Vai para próximo elemento
	    	$actualElement = $actualElement.next();
	    	
	    	//Guarda pilha com todos elementos selecionados
	    	$startElement = $startElement.add($actualElement);
	    	
	    	//Se encontrou algum termo composto, parar - Evita loop infinito caso alguns dos termos desejados já estejam anotados como termos 
	    	if($actualElement.hasClass("compoundtoken")){
	    		return $startElement;
	    	}
	    	
	    	//Caso ultrapasse de 20 tokens - Evitar loop infinito por causas não detectadas =/
	    	if(cont > 20){
	    		return $startElement;
	    	}
	    	
	    	cont++;
			
		}while($actualElement.get(0) != $endElement.get(0));
		
		return $startElement;
		
	}
	
	var compoundIds = new Array();
	var c = 0;
	//Busca todos IDs de termos compostos
	$("span.token[compoundId]").each(function(i, v){
		
		//Se ID ainda não foi armazenado
		if($.inArray($(v).attr("compoundId"),compoundIds) == -1){
			compoundIds[c] = $(v).attr("compoundId");
			c++;
		}
		
	});
	
	//Percorre todos compoundIds para fazer WRAP
	$.each(compoundIds, function(i, v){
		
		//Para cada termo composto, percorre os 3 containers
		$.each(containers, function(c, container){
			
			//Inicia a lista com o primeiro token do termo composto
			var $actual = $("#"+container+" span.token[compoundid="+v+"]:first");
			var $list = $actual;
			var hasTags = $actual.attr("hasTags");//Obtém tags associadas ao termo composto
			var abbr = $actual.attr("abbreviation");
			var $span = $("<span>").addClass("compoundtoken");
			
			//Se encontrou termo composto no container atual
			if($actual.size() > 0){
			
				do{
					//Se não for elemento de espaço
					if(!$actual.hasClass("space") ){
						
						//Evita BUG desconhecido =/
						if(hasTags !== undefined){
							//Percorre tags associadas
							$.each(hasTags.split(","), function(i, v){
								
								//Remove atributos de tags associadas
								$actual.removeAttr("tag" + v).removeAttr("hasTags");
								//Coloca atributo no SPAN WRAPPER de termo composto
								$span.attr("tag" + v, "tag" + v);
								
							});
						}
						else{
							console.log("O termo composto " + v + " esta com problemas!");
						}
						
					}
					
					//Obtém próximo elemento
					$actual = $actual.next();
					
					//Se element não for um espaço e não tiver o compoundId - Para a execução
					//if(!$actual.hasClass("space") && !(typeof $actual.attr("compoundid") !== typeof undefined && $actual.attr("compoundid") !== false))
					//Corrigido: Se NÃO for espaço e compoundid for diferente do termo composto atual da iteração (ou não tem compoundId) - PARA A EXECUÇÃO
					if(!$actual.hasClass("space") && $actual.attr("compoundid") != v )
						break;
					
					//Adiciona elemento a lista
					$list = $list.add($actual);
					
				}while(true);
				
				//Se tem abreviatura
				if (typeof abbr !== typeof undefined && abbr !== false) {
					$span.attr("abbreviation", abbr);
				}
				
				$list.wrapAll($span.attr("hasTags", hasTags));
				
			}
		
		});
		
	});
	
	//Define autocomplete
	$("#tagtoken").select2({
		placeholder: "Digite a(s) tag(s) desejada(s)...",
		allowClear: true
	});
	
	//Captura evento de CHANGE no autocomplete
	$('#tagtoken').on('change', function(evt) {
		
		var hasAbbr = false;
		
		//Percorre valores definidos
		$.each($("#tagtoken").val(), function( index, tagid ) {
			
			//TODO: Usar campo tipo da tabela de tags para verificar se é abreviatura
			//Se for abreviatura
			if(tagid == "131"){
				//Mostra campo de abreviatura
				$("#info-abbreviation").show(200);
				
				hasAbbr = true;
			}
			
		});
		
		//Se não tiver encontrado abreviatura
		if(!hasAbbr){
			//Oculta campo de abreviatura
			$("#info-abbreviation").hide();
		}
		
	});
	
	//Evento de DOUBLE CLICK nos TOKENS do texto
	$('#adjudicationContainer span.token').dblclick(function(event){
		
		//event.stopPropagation();

		//Se elemento clicado já está definido em um termo composto - Não permite marcação
		if($(this).parent().hasClass("compoundtoken")){
			//Abre DIALOG para termo composto
			//modalTag($(this).parent(), true);
		}
		else{
			//Abre DIALOG para SPAN atual
			//modalTag($(this), false);
		}
		
		//Mostra mensagem avisando bloqueio de funcionalidade
		$.notify({
			title: "<strong>Aviso: </strong>",
			message: "Função desabilitada para adjudicação.",
			icon: "glyphicon glyphicon-warning-sign"
		},{
			type: 'warning',
			newest_on_top: true
		});
		
	});
	

	
	//Evento para lidar com seleção de termos compostos
	$("#adjudicationContainer #textbox").mouseup(function(event) {
		
		try{
		    var selection =  getSelectedText();//Obtém seleção de texto
		    var selection_text = selection.toString();//Obtém o texto selecionado
		    var range = selection.getRangeAt(0);//Obtém o RANGE da seleção
		    var $startElement = $(range.startContainer.parentElement);//Obtém objeto jQuery do elemento inicial da seleção - variável guardará pilha de elementos selecionados também
		    var $endElement = $(range.endContainer.parentElement);//Obtém objeto jQuery do elemento final da seleção
		    var $actualElement = $startElement;//Define elemento atual
		    var selectionAlreadyHasTaggedTokens = false;
		    var count = 1;
		 
		    //Se foi selecionado apenas um elemento OU um elemento + espaço OU já é um termo composto - IGNORA
		    if($startElement.get(0) == $endElement.get(0) || ($endElement.get(0) == $startElement.next().get(0) && ($endElement.hasClass("space") || $startElement.hasClass("space"))) || $startElement.hasClass("compoundtoken") || $endElement.hasClass("compoundtoken") || $startElement.parent().hasClass("compoundtoken") || $endElement.parent().hasClass("compoundtoken")){
	
		    	return;
			}
		}
		catch(Exception){
			return;
		}

	    do{
	    	
	    	//Verifica se elemento atual já tem marcação
	    	if (typeof $actualElement.attr("hasTags") !== typeof undefined && $actualElement.attr("hasTags") !== false){
	    		selectionAlreadyHasTaggedTokens = true;
			}
	    	
	    	//Vai para próximo elemento
	    	$actualElement = $actualElement.next();
	    	
	    	//Guarda pilha com todos elementos selecionados
	    	$startElement = $startElement.add($actualElement);
	    	
	    	count++;
	    	
	    	//Para evitar travamentos em casos desconhecidos... =/
	    	if(count > 20){
	    		selectionAlreadyHasTaggedTokens = true;
	    		break;
	    	}
	    	
	    }while($actualElement.get(0) != $endElement.get(0));
	    
	 
	    //Somente cria SPAN de palavra composta se não existe marcação dentro da seleção
	    if(!selectionAlreadyHasTaggedTokens){
		    
	    	//TODO: Retirar SPAN caso nenhuma tag esteja associada ao final
	    	//Coloca <SPAN> em torno de todos tokens selecionados
	    	var $span = $startElement.wrapAll("<span class='compoundtoken'>").parent();
	    	
	    	//Abre DIALOG para SPAN atual
			//modalTag($span, true);
	    	
	    	//Mostra mensagem avisando bloqueio de funcionalidade
			$.notify({
				title: "<strong>Aviso: </strong>",
				message: "Função desabilitada para adjudicação.",
				icon: "glyphicon glyphicon-warning-sign"
			},{
				type: 'warning',
				newest_on_top: true
			});
	    	
	    }
	    else{
	    	$.notify({
				title: "<strong>Aviso: </strong>",
				message: "Não é possível anotar termos compostos que já contenham tokens definidos",
				icon: "glyphicon glyphicon-warning-sign"
			},{
				type: 'warning',
				newest_on_top: true
			});
	    	
	    }
		
	});
	
	//CLICK para SALVAR ADJUDICAÇÕES
	$("#enviar,#finalizar").click(function(event){
		
		event.preventDefault();
		
		//Se ainda houver itens a serem decididos/votados/adjudicados no painel de adjudicação
		if($("#accordion .notdecided").size() > 0){
			$.notify({
				title: "<strong>ATENÇÃO: </strong>",
				message: "Ainda existem itens a serem adjudicados no Assistente.",
				icon: 'glyphicon glyphicon-warning-sign',
			},{
				type: 'danger',
				newest_on_top: true
			});
			
			return;
			
		}
		
		//Bloqueia interface
		$.LoadingOverlay("show");

		//Define se finalizará anotação
		var finalizeAnnotation = (this.id == "finalizar") ? true : false;
		
		//Define arrays que serão enviados na requisição
		var arrTokens = new Array();
		var arrCompound = new Array();
		var arrRelations = new Array();
		var arrAux;
		
		//Percorre tokens para obter TAGS associadas
		$("#adjudicationContainer span.sentence > span.token[hasTags]").each(function(index, token){
			
			//Adiciona TOKEN_ID e TAGS associadas
			arrTokens[index] = $(token).attr("tokenid")+":"+ $(token).attr("hastags");
			
			//Se tem abreviatura
			if (typeof $(token).attr("abbreviation") !== typeof undefined && $(token).attr("abbreviation") !== false) {
				//Concatena a abreviatura
				arrTokens[index] = arrTokens[index] + ":abbreviation," + $(token).attr("abbreviation");
			}
			
			//Se tem UMLS CUI
			if (typeof $(token).attr("umlscui") !== typeof undefined && $(token).attr("umlscui") !== false) {
				//Concatena a UMLS
				arrTokens[index] = arrTokens[index] + ":umlscui," + $(token).attr("umlscui");
			}
			
			//Se tem SNOMED-CT ID
			if (typeof $(token).attr("snomedctid") !== typeof undefined && $(token).attr("snomedctid") !== false) {
				//Concatena a SNOMED
				arrTokens[index] = arrTokens[index] + ":snomedctid," + $(token).attr("snomedctid");
			}
			
		});
		
		//Percorre termos compostos
		$("#adjudicationContainer span.compoundtoken").each(function(index, compound){
			
			arrAux = new Array();
			
			//Percorre tokens do termo composto
			$(compound).find("span.token").each(function(i, token){
				arrAux[i] = $(token).attr("tokenid");
			});
			
			//Adiciona TOKEN_IDs e TAGS associadas
			arrCompound[index] = arrAux.join(",") + ":" + $(compound).attr("hastags");
			
			//Se tem abreviatura
			if (typeof $(compound).attr("abbreviation") !== typeof undefined && $(compound).attr("abbreviation") !== false) {
				//Concatena a abreviatura
				arrCompound[index] = arrCompound[index] + ":abbreviation," + $(compound).attr("abbreviation");
			}
			
			//Se tem UMLS CUI
			if (typeof $(compound).attr("umlscui") !== typeof undefined && $(compound).attr("umlscui") !== false) {
				//Concatena UMLS
				arrCompound[index] = arrCompound[index] + ":umlscui," + $(compound).attr("umlscui");
			}
			
			//Se tem SNOMED-CT ID
			if (typeof $(compound).attr("snomedctid") !== typeof undefined && $(compound).attr("snomedctid") !== false) {
				//Concatena SNOMED
				arrCompound[index] = arrCompound[index] + ":snomedctid," + $(compound).attr("snomedctid");
			}
			
		});
		
		
		//Percorre relacionamentos existentes no painel
		$("#relation-list li").each(function(index, li){
			
			//Obtém elementos relacionados no <li> atual do painel
			var $term1 = $(li).children("span:eq(0)");
			var $rel = $(li).children("span:eq(1)");
			var $term2 = $(li).children("span:eq(2)");
			//Define variáveis para armazenar token_ids de cada termo e relacionamentos associados
			var tokens1, tokens2, rels;
			
			//Se TERMO 1 é COMPOSTO
			if($term1.find("span").size() > 0){
				
				arrAux = new Array();
				
				//Percorre tokens do termo composto
				$term1.find("span.token").each(function(i, token){
					arrAux[i] = $(token).attr("tokenid");
				});
				
				//Armazena TOKEN_IDs separados por vírgula
				tokens1 = arrAux.join(",");
				
			}
			else{
				//Armazena TOKEN_ID
				tokens1 = $term1.attr("tokenid");
			}
			
			//Se TERMO 2 é COMPOSTO
			if($term2.find("span").size() > 0){
				
				arrAux = new Array();
				
				//Percorre tokens do termo composto
				$term2.find("span.token").each(function(i, token){
					arrAux[i] = $(token).attr("tokenid");
				});
				
				//Armazena TOKEN_IDs separados por vírgula
				tokens2 = arrAux.join(",");
				
			}
			else{
				//Armazena TOKEN_ID
				tokens2 = $term2.attr("tokenid");
			}
			
			//Armazena relacionamentos separados por vírgula
			rels = $rel.attr("hasrelations");
			
			//Adiciona RELACIONAMENTO e TOKEN_IDS aos array
			arrRelations[index] = tokens1 + ":" + rels + ":" + tokens2;
			
	
			
		});
		
		//Envia dados ao servidor
		var jqxhr = $.post( "servlets/TextAdjudication?id=" + $("#id").val(), {tokens:arrTokens, compoundtokens:arrCompound, relations:arrRelations, finalize: finalizeAnnotation, "relationOnly": relationOnly}, function(res) {

			//Desbloqueia interface
			$.LoadingOverlay("hide");
			
			if(res.status == true){
				
				$.notify({
					title: "<strong>Sucesso: </strong>",
					message: "Adjudicação salva",
					icon: "glyphicon glyphicon-ok-circle"
				},{
					type: 'success',
					newest_on_top: true
				});
				
				//Se for para finalizar, ir para listagem
				if(finalizeAnnotation){
					location.href = "textList.jsp?id=<%= project_id.toString() %>"; 
				}
			}
			else{
				$.notify({
					title: "<strong>Erro: </strong>",
					message: "Houve um erro ao salvar as adjudicações",
					icon: 'glyphicon glyphicon-warning-sign',
				},{
					type: 'danger',
					newest_on_top: true
				});
			
			}

		})
		.done(function() {
		  //	alert( "second success" );
		})
		.fail(function() {
		  	alert( "Erro ao enviar anotação ao servidor." );
		})
		.always(function() {
			$.LoadingOverlay("hide");
		});
		
	});
	
	
	$("#voltar").click(function(event){
		event.preventDefault();
		location.href = "textList.jsp?id=<%= project_id.toString() %>"; 
	});
	
	//Retira position:fixed da barra inferior para deixar o assistente de anotação fixo
	$(".footer").hide();
	//Configura ACCORDION do assistente de adjudicação
	$('#collapseOne').on('show.bs.collapse', function () {    
	    $('#accordion .panel-heading').animate({
	        backgroundColor: "#31708f",
	        color: "#ffffff"
	    }, 500);   
	    $("#assistantIcon").removeClass("glyphicon-arrow-up").addClass("glyphicon-arrow-down");
	});
	
	$('#collapseOne').on('hide.bs.collapse', function () {    
	    $('#accordion .panel-heading').animate({
	        backgroundColor: "#d9edf7",
	        color: "#31708f"
	    }, 500);
	    $("#assistantIcon").removeClass("glyphicon-arrow-down").addClass("glyphicon-arrow-up");
	});
	
	//Ao passar MOUSE sobre o termo, mostrar onde ele está no texto
	$("#accordion").on("mouseenter", ".assistantItem", function(){
		
		var token_id = $(this).attr("id");
		
		//Se é item de relacionamento
		if($(this).hasClass("isRelation")){
			
			//Separa o TERMO1 do TERMO2
			var terms = token_id.split("-");
			var $item1 = getAllTokensElementsById(terms[0]);
			var $item2 = getAllTokensElementsById(terms[1]);
			//Enfatiza termo com uma borda
			$item1.css("border", "3px solid green");
			$item2.css("border", "3px solid blue");
			//Rolagem da tela vai até o elemento
			$('html, body').animate({
		        scrollTop: $item1.offset().top
		    }, 250);
			
		}
		else{
			var $item;
			//Se é sugestão de termo composto
			if($(this).hasClass("isMultiple")){
				$item = getAllTokensElementsById(token_id);
			}
			else{
				$item = $("#"+containers[0]+" span[tokenid=" + token_id + "]");
				
				//Se houver o token correspondente como TERMO COMPOSTO já marcado
				if($("#" + containers[0] + " .compoundtoken > span[tokenid=" + token_id + "]").size() > 0){
					$item = $("#"+containers[0]+" span[tokenid=" + token_id + "]").parent();	
				}
			}
			
			//Enfatiza termo com uma borda vermelha
			$item.css("border", "3px solid red");
			//Rolagem da tela vai até o elemento
			$('html, body').animate({
		        scrollTop: $item.offset().top
		    }, 250);
		}
	
	});
	
	$("#accordion").on("mouseleave", ".assistantItem", function(){
		var token_id = $(this)/*.parents(".assistantItem")*/.attr("id");
		var $item;
		//Se é item de relacionamento
		if($(this).hasClass("isRelation")){
			$item = getAllTokensElementsById(token_id.replace("-",","));
		}
		else{
			//Se é sugestão de termo composto
			if($(this).hasClass("isMultiple")){
				$item = getAllTokensElementsById(token_id);
			}
			else{
				$item = $("#"+containers[0]+" span[tokenid=" + token_id + "]");
				$("#" + containers[0] + " .compoundtoken > span[tokenid=" + token_id + "]").parent().removeAttr("style");
			}
		}
		
		//Remove a borda colocada
		$item.removeAttr("style");
		
		
	});
	
	//CLICK dos botões SIM e NÃO do assistente
	$("#accordion").on("click", ".btn-danger", function(){
		//Esconde proposta de pré-anotação
		$(this).parents(".assistantItem").slideUp(300);
		//Reduz quantidade exibida
		$("#assistantNumber").text(parseInt($("#assistantNumber").text())-1);
		//Marca como decidido/votado/adjudicado
		$(this).parents(".assistantItem").removeClass("notdecided");
		
	});
	
	//TODO: Verificar se o que tem no hasTags é a mesma tag_id que está tentado aplicar. (Ex.: hasTags="41,41")
	//Botão para aceitar pré-anotação do assistente
	$("#accordion").on("click", ".btn-success", function(){
		var $assistantItem = $(this).parents(".assistantItem");
		//Obtém token_id
		var token_id = $assistantItem.attr("id");
		//Obtém tag_id
		var tag_id = $assistantItem.find(".semanticType").attr("tag_id");
		//Obtém tag_name
		var tag_name = $assistantItem.find(".semanticType").text();
		
		var $item;
		var $span;
	 
	 	//Se é sugestão de relacionamento
		if($assistantItem.hasClass("isRelation")){
			
			//Se é filho de compoundtoken ou tem hastags
			var aux = token_id.split("-");
			var term1_id = aux[0];//ID(s) termo 1
			var term1_arr = term1_id.split(",");
			var term1_labeled = false;
			var $term1;
			var term2_id = aux[1];//ID(s) termo 2
			var term2_arr = term2_id.split(",");
			var term2_labeled = false;
			var $term2;
			var terms_already_relationed = false;
	
			//Se termo 1 é simples e já foi rotulado
			if(term1_arr.length == 1 && !(typeof $("#textbox .token[tokenid="+term1_id+"]").attr("hasTags") === typeof undefined || $("#textbox .token[tokenid="+term1_id+"]").attr("hasTags") === false) ){
			
				term1_labeled = true;
				$term1 = $(".token[tokenid="+term1_id+"]");
			
			}//Se termo 1 é composto e já foi rotulado
			else if(term1_arr.length > 1 && $("#textbox .token[tokenid="+term1_arr[0]+"]").parent('.compoundtoken').length > 0){
				
				//Obtém IDs dos elementos(tokens) pertencentes ao termo composto
				var ids = $("#textbox .token[tokenid="+term1_arr[0]+"]").parent('.compoundtoken').find(".token").map(function() {
				    return $(this).attr("tokenid");
				}).get().join();
				
				//Se exatamente os mesmos tokens foram rotulados
				if(ids == term1_id){
					term1_labeled = true;
					$term1 = $("#textbox .token[tokenid="+term1_arr[0]+"]").parent('.compoundtoken');
				}
				else{
				
					$.notify({
						title: "<strong>Aviso: </strong>",
						message: "Não é possível aceitar este relacionamento. O termo composto 1 não contém os mesmos tokens do relacionamento original.",
						icon: "glyphicon glyphicon-warning-sign"
					},{
						type: 'warning',
						newest_on_top: true
					});
					
					return;
					
				}
				
			}
			
			//Se termo 2 é simples e já foi rotulado
			if(term2_arr.length == 1 && !(typeof $("#textbox .token[tokenid="+term2_id+"]").attr("hasTags") === typeof undefined || $("#textbox .token[tokenid="+term2_id+"]").attr("hasTags") === false) ){
			
				term2_labeled = true;
				$term2 = $("#textbox .token[tokenid="+term2_id+"]");
			
			}//Se termo 2 é composto e já foi rotulado
			else if(term2_arr.length > 1 && $("#textbox .token[tokenid="+term2_arr[0]+"]").parent('.compoundtoken').length > 0){
				
				//Obtém IDs dos elementos(tokens) pertencentes ao termo composto
				var ids = $("#textbox .token[tokenid="+term2_arr[0]+"]").parent('.compoundtoken').find(".token").map(function() {
				    return $(this).attr("tokenid");
				}).get().join();
				
				//Se exatamente os mesmos tokens foram rotulados
				if(ids == term2_id){
					term2_labeled = true;
					$term2 = $("#textbox .token[tokenid="+term2_arr[0]+"]").parent('.compoundtoken');
				}
				else{
					$.notify({
						title: "<strong>Aviso: </strong>",
						message: "Não é possível aceitar este relacionamento. O termo composto 2 não contém os mesmos tokens do relacionamento original.",
						icon: "glyphicon glyphicon-warning-sign"
					},{
						type: 'warning',
						newest_on_top: true
					});
					
					return;
				}
				
			}
			
			//console.log($term1);
			//console.log($term2);
			//Se $item1 ou $item2 forem undefined, quer dizer que eles não estão como anotações definitivas, portanto não podem estar no painel de relacionamentos taopouco.
			
			//Percorre os itens já adicionados ao painel
			//Para verificar se os termos atuais já contém um relacionamento adicionado ao painel
			$("#relation-list li").each(function(index, li){
				
				//Se termo 1 é simples
				if(term1_arr.length == 1 && $term1 !== undefined){
					
					//Se encontrou o termo 1 no painel de relacionamentos
					if($(li).find("[tokenid="+$term1.attr("tokenid")+"]").size() > 0){
						
						//Se termo 2 é simples
						if(term2_arr.length == 1  && $term2 !== undefined){
							
							//Se encontrou o termo 2 no painel de relacionamentos
							if($(li).find("[tokenid="+$term2.attr("tokenid")+"]").size() > 0){
								terms_already_relationed = true;//TERMO1 SIMPLES + TERMO2 SIMPLES
								//console.log("TERMO1 SIMPLES + TERMO2 SIMPLES");
							}
							
						}
						//Se termo 2 é composto
						else if(term2_arr.length > 1  && $term2 !== undefined){
							
							//Obtém IDs dos elementos(tokens) pertencentes ao termo composto
							var ids = $(li).find("[tokenid="+term2_arr[0]+"]").parent('span').find("span").map(function() {
							    return $(this).attr("tokenid");
							}).get().join();
							
							//Se TOKEN_IDS já relacionados são os mesmos do TERMO 2
							if(ids == term2_id){
								terms_already_relationed = true;//TERMO1 SIMPLES + TERMO2 COMPOSTO
								//console.log("TERMO1 SIMPLES + TERMO2 COMPOSTO");
							}
							
						}
						
						
					}
					
				}//Se termo 1 é composto
				else if(term1_arr.length > 1 && $term1 !== undefined){
					
					//Obtém IDs dos elementos(tokens) pertencentes ao termo composto
					var ids = $(li).find(".token[tokenid="+term1_arr[0]+"]").parent('span').find("span").map(function() {
					    return $(this).attr("tokenid");
					}).get().join();
					
					//Se TOKEN_IDS já relacionados são os mesmos do TERMO 1
					//Se encontrou TERMO 1 no painel de relacionamentos
					if(ids == term1_id){
						
						//Se termo 2 é simples
						if(term2_arr.length == 1  && $term2 !== undefined){
							
							//Se encontrou o termo 2 no painel de relacionamentos
							if($(li).find(".token[tokenid="+$term2.attr("tokenid")+"]").size() > 0){
								terms_already_relationed = true;//TERMO1 COMPOSTO + TERMO2 SIMPLES
								//console.log("TERMO1 COMPOSTO + TERMO2 SIMPLES");
							}
							
						}
						//Se termo 2 é composto
						else if(term2_arr.length > 1  && $term2 !== undefined){
							
							//Obtém IDs dos elementos(tokens) pertencentes ao termo composto
							var ids = $(li).find(".token[tokenid="+term2_arr[0]+"]").parent('span').find("span").map(function() {
							    return $(this).attr("tokenid");
							}).get().join();
							
							//Se TOKEN_IDS já relacionados são os mesmos do TERMO 2
							if(ids == term2_id){
								terms_already_relationed = true;//TERMO1 COMPOSTO + TERMO2 COMPOSTO
								//console.log("TERMO1 COMPOSTO + TERMO2 COMPOSTO");
							}
							
						}	
					
						
					}
					
				}
				
				
			});
			
			//Se os termos já foram relacionados e estão no painel
			if(terms_already_relationed){
				$.notify({
					title: "<strong>Aviso: </strong>",
					message: "Não é possível aceitar este relacionamento. Os dois termos já foram relacionados no Painel de relacionamentos.",
					icon: "glyphicon glyphicon-warning-sign"
				},{
					type: 'warning',
					newest_on_top: true
				});
				
				return;
			}
			
			//Se os dois termos foram rotulados, pode aceitar o relacionamento
			if(term1_labeled && term2_labeled){
				
				//TODO: Verificar se não precisa tirar atributos de tag e class="token"
				//Obtém todos tokens envolvidos na operação
				var $itens = getAllTokensElementsById(token_id.replace("-",","));
				//Retira formatações de mouseover
				$itens.removeAttr("style");	
			
				//Adicionar relacionamento no PAINEL DE RELACIONAMENTO
	    		$("<li>")
	    			.css("text-align", "center")
	    			.addClass("list-group-item")
	    			.append($term1.clone().removeClass().css("font-size", "12px"))
	    			.append("<br><span class=\"glyphicon glyphicon-link isRelation\" hasRelations=\""+tag_id+"\" data-toggle=\"tooltip\" title=\""+tag_name+"\"></span><br>")
	    			.append($term2.clone().removeClass().css("font-size", "12px"))
	    			.append("<span class=\"icon edit-relation glyphicon glyphicon-edit\" style=\"font-size:24px\"></span><span class=\"icon delete-relation glyphicon glyphicon-remove-sign\" style=\"font-size:24px\"></span>")
	    		.appendTo("#relation-list");
				
	    		//Faz painel de relacionamentos brilhar
	    		$("#relation-panel").switchClass( "foo", "glow", 750).delay(750).switchClass( "glow", "foo", 750); 
			}
			else{
				$.notify({
					title: "<strong>Aviso: </strong>",
					message: "Não é possível aceitar este relacionamento. Um dos termos originais não foi anotado.",
					icon: "glyphicon glyphicon-warning-sign"
				},{
					type: 'warning',
					newest_on_top: true
				});
				
				return;
			}
			
		}
		else{
			//Se é sugestão de termo composto
			if($assistantItem.hasClass("isMultiple")){
				$item = getAllTokensElementsByIdWithSpaces(token_id);
				
				//Se já está marcado como termo composto
				if($item.first().parent('.compoundtoken').length > 0){
					//Recebe SPAN do termo composto
					$span = $item.first().parent('.compoundtoken');
				}
				else{
					
					//Se algum dos tokens já está marcado como termo simples
					if($item.filter("span[hasTags]").size() > 0 || $item.filter("span.compoundtoken").size() > 0){
						
						$.notify({
							title: "<strong>Aviso: </strong>",
							message: "Não é possível marcar este termo composto. Algum dos tokens já foi anotado.",
							icon: "glyphicon glyphicon-warning-sign"
						},{
							type: 'warning',
							newest_on_top: true
						});
						
						return;
						
					}
					else{
						//Coloca <SPAN> em torno de todos tokens do termo composto
			    		$span = $item.wrapAll("<span class='compoundtoken'>").parent();
					}
					
				}
		    	//Define atributo para definir coloração da TAG
				$span.attr("tag" + tag_id, tag_id);
				//Se elemento já foi tageado, mantém tags anteriores
				tag_id = ($span.attr("hasTags") == undefined) ? tag_id : $span.attr("hasTags") + "," + tag_id;
				//Define a TAG(s) atual para o elemento
				$span.attr("hasTags", tag_id);
				//Define CUI da UMLS
				$span.attr("umlscui", $assistantItem.find(".umlscui").text());
				//Define SNOMED-CT ID
				$span.attr("snomedctid", $assistantItem.find(".snomedctid").text());
				//Se encontrou definição de abreviatura
				if($assistantItem.find(".expandedAbbreviation").size() > 0)
					$span.attr("abbreviation", $assistantItem.find(".expandedAbbreviation").text());
			}
			else{
			 	$item = $("#" + containers[0] + " span[tokenid=" + token_id + "]");
			 	
			 	//Se houver o token correspondente como TERMO COMPOSTO
				if($("#" + containers[0] + " .compoundtoken > span[tokenid=" + token_id + "]").size() > 0){
					
					$.notify({
						title: "<strong>Aviso: </strong>",
						message: "Não é possível marcar um termo simples dentro de um composto",
						icon: "glyphicon glyphicon-warning-sign"
					},{
						type: 'warning',
						newest_on_top: true
					});
					
					return;
				}
			 	
				//Define atributo para definir coloração da TAG
				$item.attr("tag" + tag_id, tag_id);
				//Se elemento já foi tageado, mantém tags anteriores
				tag_id = ($item.attr("hasTags") == undefined) ? tag_id : $item.attr("hasTags") + "," + tag_id;
				//Define a TAG(s) atual para o elemento
				$item.attr("hasTags", tag_id);
				//Define CUI da UMLS
				$item.attr("umlscui", $assistantItem.find(".umlscui").text());
				//Define SNOMED-CT ID
				$item.attr("snomedctid", $assistantItem.find(".snomedctid").text());
				//Se encontrou definição de abreviatura
				if($assistantItem.find(".expandedAbbreviation").size() > 0)
					$item.attr("abbreviation", $assistantItem.find(".expandedAbbreviation").text());
			}
		}
		
		//Marca como decidido/votado/adjudicado
		$assistantItem.removeClass("notdecided");
		
		//Esconde sugestão
		$assistantItem.slideUp(300);
		
		//Reduz quantidade exibida
		$("#assistantNumber").text(parseInt($("#assistantNumber").text())-1);
		
		
	});
	
	//Habilita Drag Drop em todos conceitos marcados
	doDragDrop(null);
	
	//Inicia TOOLTIPS
	$('body').tooltip({
	    selector: 'span[data-toggle]'
	});

	//Configura ACCORDION do PAINEL DE RELACIONAMENTOS
	$('#collapsePanel').on('show.bs.collapse', function () {    
	    $('#relation-panel .panel-heading').animate({
	        backgroundColor: "#31708f",
	        color: "#ffffff"
	    }, 500); 
	    $('#relation-panel .panel-heading a').animate({
	        color: "#ffffff"
	    }, 500);
	});
	
	$('#collapsePanel').on('hide.bs.collapse', function () {    
	    $('#relation-panel .panel-heading').animate({
	        backgroundColor: "#d9edf7",
	        color: "#31708f"
	    }, 500);
	    $('#relation-panel .panel-heading a').animate({
	        color: "#31708f"
	    }, 500);
	});
	
	//Deixa PAINEL DE RELATIONAMENTOS Draggable (Corrige posicionamento e evita que bibilioteca tire a posição fixed)
	$("#relation-panel").draggable().css({'top': 60, 'right' : 6, 'position': 'fixed'});
	
	//Define autocomplete de relacionamento
	$("#relationtoken").select2({
		placeholder: "Digite o(s) relacionamento(s) desejado(s)...",
		allowClear: true
	});
	
	/* //Faz aparecer menu no hover dos relacionamentos
	$("#relation-panel").on("mouseenter", "li", function(){
		$(this).find("span.icon").show();
	});
	
	$("#relation-panel").on("mouseleave", "li", function(){
		$(this).find("span.icon").hide();
	});
	
	//Apagar relacionamento
	$("#relation-panel").on("click", ".delete-relation", function(){
		
		//Remove relacionamento do painel
		$(this).parent().remove();
	});
	
	//Editar relacionamento
	$("#relation-panel").on("click", ".edit-relation", function(){
		
		modalRelation($(this).siblings("span:first"), $(this).siblings("span:eq(2)"), $(this).parent());
		
	}); */
	
	$("#mostrarAnotacao").click(function(event){
		
		event.preventDefault();
		$("#annotatorsContainer").slideToggle(250);	
	
	});
	
	/* $("#mostrarRelacionamentos").click(function(event){
		
		event.preventDefault();
			
	
	}); */
	
	$("#mostrarMetricas").click(function(event){
		
		event.preventDefault();
		$("#metricasContainer").slideToggle(250);	
	
	});
	
	</script>
	<style type="text/css">
	#adjudicationContainer{margin-bottom:40px}
	#annotatorsContainer{margin-bottom:380px; /*Necessario para rolagem automatica do assistente*/}
	#annotator1Container{width:50%;float:left;}
	#annotator2Container{width:50%;float:left}
	#annotated-token{font-weight: bold;}
	#spacer{height:800px}
	.modal-header{cursor:move;}
	span.token{border-radius: 4px;}
	span.compoundtoken{border-radius: 4px;}
	<%
		out.print(TextAnnotationHelper.getTagsCssColorRules(tags));
	%>
	/*Configura assistente de anotação*/
	#accordion {
	    position: fixed;
	    bottom: 0;
	    width: 100%; 
	    margin-bottom: 0px;  
	    max-height: 380px; 
	    overflow: overlay;
	}
	
	#accordion .panel-default > .panel-heading{
	    /*background: #00B4FF;*/
	    background-color: #d9edf7;
    	border-color: #bce8f1;
	}
	
	#accordion .panel-heading {
	    padding: 0;
	    border-top-left-radius: 0px;
	    border-top-right-radius: 0px;
	    color: #31708f;
	}
	
	#accordion .panel-group .panel {
	    border-radius: 0;
	}
	
	#accordion .panel-title a {
	    text-align: center;
	    width: 100%;
	    display: block;
	    padding: 10px 15px;
	    font-size: 16px;
	    font-family: Helvetica,Arial,sans-serif;
	    outline: none;
	}
	
	#accordion .panel-title a:hover, .panel-title a:focus, .panel-title a:active {
	    text-decoration: none;
	    outline: none;
	} 
	.semanticType{
		font-weight: bold;
	}
	.assistantItem .term{
		font-weight: bold;
		text-decoration:underline;
		cursor: alias;
		font-size: 1.25em;
	}
	.assistantItem .yesNoButtons{
		float:right;
		padding-top: 14px;
		padding-right: 20px;
	}
	.assistantItem .description{
		float:left;
	}
	.assistantItem .percent{
		font-weight: bold;
	}
	#relation-panel{
		top: 60px;
		right: 6px;
		position: fixed;
		overflow-y: auto;
		z-index: 1000;
		width: 320px;
	}
	#relation-panel .panel-heading{
		padding: 10px 15px;
	    border-bottom: 1px solid transparent;
	    border-top-left-radius: 3px;
	    border-top-right-radius: 3px;
	    text-align:center;
	}
	#relation-list li { position: relative; }
	#relation-list li:hover { background: #F8F8FF; }
	#relation-list li span.edit-relation {
	    position: absolute;
	    top: 0px;
	    right: 0px;
	    z-index: 100;
	    cursor:pointer;
	    display:none;
	}
	#relation-list li span.delete-relation {
	    position: absolute;
	    top: 54px;
	    right: 0px;
	    z-index: 101;
	    cursor:pointer;
	    display:none;
	}
	#relation-list li span[hastags]{border-radius: 4px;}
	#relation-panel.glow{
		border-color: gold;
	    -webkit-box-shadow: 0 0 6px gold;
	       -moz-box-shadow: 0 0 6px gold;
	            box-shadow: 0 0 6px gold;
	}
	#relation-panel li.glow{
		border-color: gold;
	    -webkit-box-shadow: 0 0 6px gold;
	       -moz-box-shadow: 0 0 6px gold;
	            box-shadow: 0 0 6px gold;
	}
	</style>
	<%
		out.print(TextAnnotationHelper.getTagsJsArray(tags));
	%>
  </body>
</html>