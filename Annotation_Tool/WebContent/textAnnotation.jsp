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
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Tokenizer" %>
<%@ page import="helper.GeneralLayoutHelper" %>
<%@ page import="model.Tiporelacionamento" %>
<%@ page import="model.Relacionamento" %>
<%@ page import="model.TermoCompostoStats" %>
<%@ page import="model.Permissao" %>
<%
 
	//TODO: Deixar quebras de linha na tokenização - Assim fica mais fácil visualizar o texto
 	
 	/* MARCAR TOKEN COM COR CORRESPONDENTE (Provavelmente terei de tirar a verificar das estatisticas do helper)
  */
  
	//Obtém ID do projeto
 	Integer project_id = (Integer) session.getAttribute("projectid");
	//Obtém ID do texto
 	int texto_id = Integer.parseInt(request.getParameter("id"));
 	//Busca usuário logado
	Usuario u = (Usuario) session.getAttribute("usuario");
	Texto texto;
	
 	//Se é apenas ADMIN - Pega texto e desabilita botões de enviar anotação
 	if(Permissao.isOnlyAdmin(u)){
		//Busca texto
 		texto = Texto.findById(texto_id);
 		
 	}
 	else{
 	
	 	//Busca TEXTO a ser anotado
	 	texto = Texto.findByIdAndUser(texto_id, u.id);
	 	
	 	//If not in ANNOTATION STATUS
	 	if(!texto.status.equals(TextoStatus.ANOTACAO)){
	 		out.print("<script>alert('O texto atual não está aberto para anotação. Status atual: "+texto.status+".');location.href='textList.jsp?id="+session.getAttribute("projectid")+"';</script>");
	 	}
 	
 	}
 	
 	//Busca ANOTACOES do texto atual
 	ArrayList<Anotacao> anotacoes = Anotacao.findAnotacoesByTextoIdAndAnotadorId(texto_id, u.id);
 	for(Anotacao a : anotacoes){
 		//Se anotação já foi finalizada
 	 	if(!a.status.equals(TextoStatus.ANOTACAO)){
 	 		out.print("<script>alert('O texto atual não está aberto para anotação. Status atual: "+a.status+".');location.href='textList.jsp?id="+session.getAttribute("projectid")+"';</script>");
 	 	}
 	}
 	
 	//Busca RELACIONAMENTOS do texto pelo anotador atual
 	ArrayList<Relacionamento> relacionamentos = Relacionamento.findRelacionamentosByTextoIdAndAnotadorId(texto_id, u.id);
 	
 	//Busca SENTENCAS do texto
 	ArrayList<Sentenca> sentencas = Sentenca.findSentencasByTextoId(texto_id);
 	//Busca TOKENS do texto
 	ArrayList<Token> tokens = Token.findTokensByTextoId(texto_id);
 	//Busca TAGS
 	ArrayList<Tag> tags = Tag.findByProjectId(project_id);
 	//Lista das estatísticas de anotação dos TERMOS SIMPLES
 	ArrayList<TokenStats> tokenStats = new ArrayList<TokenStats>();
 	//Lista das estatísticas de anotação dos TERMOS SIMPLES
 	ArrayList<TermoCompostoStats> compoundTermStats = new ArrayList<TermoCompostoStats>();
 	//Busca TIPOS DE RELACIONAMENTOS
 	ArrayList<Tiporelacionamento> tps = Tiporelacionamento.findByProjectId(project_id);
	
 	//Se não houverem anotações salvas para o texto atual
 	if(anotacoes.size() <= 0){
 		
 		//Obtém estatísticas de anotação para os TERMOS SIMPLES do texto
 		tokenStats = Anotacao.findTokensStatistics(tokens, u.id);
 		
 		//Obtém estatística de anotação para os TERMO COMPOSTOS do texto
 		compoundTermStats = Anotacao.findCompoundTermsStatistics(tokens, u.id);
 		
 		
 	}
 	
 	out.print(GeneralLayoutHelper.getTop("Anotação de textos"));
 	
%>   
    
	<div id="annotationContainer" class="container">
		<form action="servlets/TextAnnotation" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" id="id" value="<%=texto.id %>"/>
			<h3>Clique duas vezes nas palavras ou selecione os termos compostos para anotá-los. <span id="resize" class="glyphicon glyphicon-resize-full" aria-hidden="true" style="cursor:pointer"></span></h3>
			<div id="textbox" class="well">
        		<p>
			<%
			
			//Hashmap com estatisticas das tags para o token atual
	 		HashMap<Integer,Double> tagStats = new HashMap<Integer,Double>(); 
			boolean isCompoundTerm = false;
			
			//Percorre senteças
			for(Sentenca s : sentencas){
				
				out.print("<span class='sentence' sentenceid='"+s.id+"'>");
				
				//Percorre tokens
				for(Token t : tokens){
					
					//Se token pertence a sentença atual
					if(t.sentenca_id == s.id){
			
						String tokenAttributes = "";
						String spanTooltips = "";
						ArrayList<Integer> tokenTags = new ArrayList<Integer>();
						int qtdeTags = 0;
						
						//Percorre anotações em busca de TAGS para o token atual
						for(Anotacao a : anotacoes){
							
							//Se encontrou anotação para o token atual
							if(a.token_id == t.id){
								
								//Adiciona atributo para dar a cor da tag respectiva ao token (seguindo as regras CSS)
								tokenAttributes += "tag" + a.tag_id + "=\""+ a.tag_id+"\"";
								spanTooltips += "<span tag" + a.tag_id + "='"+ a.tag_id+"'>"+ TextAnnotationHelper.getTagName(tags, a.tag_id) +"</span> ";
								//Armazena tag_id
								tokenTags.add(a.tag_id);
								qtdeTags++;
							
								//Se for termo composto
								if(a.termocomposto_id != null)
									tokenAttributes += " compoundId=\""+a.termocomposto_id+"\"";//Marca como composta para javascript fazer o wrap
										
								//Se tem abreviatura
								if(a.abreviatura != null)
									tokenAttributes += " abbreviation=\""+a.abreviatura+"\"";
										
								//Se tem UMLS CUI
								if(a.umlscui != null)
									tokenAttributes += " umlscui=\""+a.umlscui+"\"";
								
								//Se tem SNOMED-CT ID
								if(a.snomedctid != null)
									tokenAttributes += " snomedctid=\""+a.snomedctid+"\"";
							
							}
							
						}
						
						if(qtdeTags > 0){
							//Tomcat < 8 não suporta uso de função da JDK 8 =/
							//tokenAttributes += " hasTags=\""+StringUtils.join(tokenTags, ",") +"\"";
							tokenAttributes += " hasTags=\"";
							for(int i : tokenTags){
								tokenAttributes += i + ",";
							}
							tokenAttributes = tokenAttributes.substring(0, tokenAttributes.length()-1);
							tokenAttributes += "\"";
							//Atributos do tooltip
							tokenAttributes += " data-toggle=\"tooltip\" data-html=\"true\" title=\"Tags: "+spanTooltips+"\"";
						}
						
						//Imprime TOKEN - O <span> para os espaços é necessário para a seleção dos textos via JavaScript para a marcação de termos compostos
						//Verificar como ficará essa linha depois na impressão correta de quebras de linha e espaçamento do texto original
						out.print("<span class='token' tokenid='"+t.id+"' "+tokenAttributes+">" + t.token + "</span><span class='space'> </span>");
						
						
					}
					
					
				}
				
				//Quando for colocada a formatação original do texto retirar os <br>
				out.print("</span><br><br>");
				
			}
			
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
				<button id="enviar" class="btn btn-primary" <% if(Permissao.isOnlyAdmin(u)) out.print("disabled='disabled'"); %>><span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> Salvar anotação</button>
				<button id="finalizar" class="btn btn-success"  <% if(Permissao.isOnlyAdmin(u)) out.print("disabled='disabled'"); %>><span class="glyphicon glyphicon-saved" aria-hidden="true"></span> Salvar e finalizar anotação</button>	
				
			</div>
		</form>
		
		
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
			  
			  //TODO: Gera problema quando são marcados mais de um relacionamento para os mesmo tokens - verificar se haverá situação de multiplas anotações para corrigir
			  //Monta possíveis relacionamentos salvos
			  for(Relacionamento r : relacionamentos){
				  
				  //Separa TOKEN_IDS dos termos
				  String[] t1_ids = r.tokens1.split(",");
				  String[] t2_ids = r.tokens2.split(",");
				  
				  str += "<li class=\"list-group-item\" style=\"text-align:center\">";
				  
				  //Se TERMO 1 é COMPOSTO
				  if(t1_ids.length > 1){
					  
					  //TODO: tag30="tag30" hastags="30"
					  str += "<span style=\"font-size: 12px;\">";
					  		//Percorre os tokens do termo composto
					  		for(String tid : t1_ids){
					  			//TODO:  compoundid="a3dfb762-ddcc-4f04-9b9b-e6e7fe20c5c2" title="Tags: <span tag30='30'>Laboratory or Test Result</span> "
					  			str += "<span class=\"token\" tokenid=\""+tid+"\" data-toggle=\"tooltip\" data-html=\"true\" >"+TextAnnotationHelper.getTokenName(tokens, Integer.parseInt(tid))+"</span>";
					  			str += "<span class=\"space\"> </span>";
					  		}
					  str += "</span>";
					
					  
				  }
				  else{
					  //TODO: Inserir tags associadas - tag128="128" hastags="128" data-original-title="Tags: <span tag128='128'>Negation</span> "
					  str += "	<span tokenid=\""+ t1_ids[0] +"\"  data-toggle=\"tooltip\" data-html=\"true\" title=\"\" style=\"font-size: 12px;\">" + TextAnnotationHelper.getTokenName(tokens, Integer.parseInt(t1_ids[0]))  + "</span>";
				  }
				  
				  //Adiciona ícone de relacionamento
				  str += "<br><span class=\"glyphicon glyphicon-link isRelation\" hasRelations=\""+r.tiporelacionamento_id+"\" data-toggle=\"tooltip\" title=\""+TextAnnotationHelper.getTiporelacionamentoName(tps, r.tiporelacionamento_id)+"\"></span><br>";
				  
				  
				  //Se TERMO 2 é COMPOSTO
				  if(t2_ids.length > 1){
					  
					  //TODO: tag30="tag30" hastags="30"
					  str += "<span style=\"font-size: 12px;\">";
					  		//Percorre os tokens do termo composto
					  		for(String tid : t2_ids){
					  			//TODO:  compoundid="a3dfb762-ddcc-4f04-9b9b-e6e7fe20c5c2" title="Tags: <span tag30='30'>Laboratory or Test Result</span> "
					  			str += "<span class=\"token\" tokenid=\""+tid+"\" data-toggle=\"tooltip\" data-html=\"true\" >"+TextAnnotationHelper.getTokenName(tokens, Integer.parseInt(tid))+"</span>";
					  			str += "<span class=\"space\"> </span>";
					  		}
					  str += "</span>";
					  
				  }
				  else{
					  //TODO: Inserir tags associadas - tag128="128" hastags="128" data-original-title="Tags: <span tag128='128'>Negation</span> "
					  str += "	<span tokenid=\""+ t2_ids[0] +"\"  data-toggle=\"tooltip\" data-html=\"true\" title=\"\" style=\"font-size: 12px;\">" + TextAnnotationHelper.getTokenName(tokens, Integer.parseInt(t2_ids[0]))  + "</span>";
				  }
				  
				  str += "	<span class=\"icon edit-relation glyphicon glyphicon-edit\" style=\"font-size:24px\"></span><span class=\"icon delete-relation glyphicon glyphicon-remove-sign\" style=\"font-size:24px\"></span>";
				  
				  str += "</li>";
				  
			  }
			  
			  //Imprime relacionamentos
			  out.print(str);
			  
			  
			  %>
			  </ul>
			</div>
		</div>
		
	</div>
	 
	<!-- Modal TAGS -->
  <div class="modal fade" id="modal-annotation" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Anotando: <span id="annotated-token"></span></h4>
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

   	String html = "";
	int cont = 0;
	
	//TODO: Não permitir adicionar anotação onde já existe
	//TODO: Tentar agrupar de alguma maneira termos iguais e retirar anotações já feitas
	//Ex.: Se já clicou sim em acesso venoso central, desaparecer o acesso venoso
	
	//Percorre estatísticas de termos compostos
	for(TermoCompostoStats tcs : compoundTermStats){
		
		//PROCURAR TERMOS ENCONTRADOS NAS SEQUENCIAS DE TOKENS
		//Percorre tokens do texto
		for(int i = 0; i < tokens.size(); i++){
			
			//Obtém qtde de palavras no termo
			int numWords = tcs.termo.split(" ").length;
			//Inicia termo do texto
			String termoTexto = "";
			//Concatena token_ids
			String token_ids = "";
			//Se ultrapassar a qtde de tokens - Sai do loop
			if(i + numWords > tokens.size())
				break;
			
			//Monta termo com a mesma qtde de palavras do termo na estatística
			for(int j = i; j < i + numWords; j++){
				termoTexto += tokens.get(j).token + " ";
				//Adiciona token a lista
				token_ids += tokens.get(j).id + ",";
			}
			termoTexto = termoTexto.trim();//Retira espaços extras
			token_ids = token_ids.substring(0, token_ids.length() - 1);//Remove ultima virgula
			
			//Se sequencia de tokens é igual ao termo composto atual
			if(termoTexto.equalsIgnoreCase(tcs.termo)){
				
				//Percorre tags
				for(int h = 0; h < tcs.tags.size(); h++){
					
					//Obtém TAG - A query original só inicializa o ID da tag
		     		Tag t = Tag.findById(tcs.tags.get(h).id);
		     		//Obtém percentagem de aparecimento da tag
		     		Double percent = tcs.percents.get(h);
		     		//Inicia nome da tag
		     		String tagname = t.tag;
		     		
		     		//Se for tag correspondente aos tipos semanticos da UMLS
		     		if(t.tipo == null)
		     			tagname += " ["+t.extra_id+"]";
		     		//Se for do tipo abreviatura - TODO Fazer funcionar para termos compostos
		     		//else if(t.tipo.equals("A"))
		     		//	tagname += " [<span class=\"expandedAbbreviation\">"+Anotacao.getMostUsedAbbreviationFor(tcs.termo, u.id, project_id)+"</span>]";
					
					//Montar DIVs de pré-anotações
		      		html += "<div class=\"well well-sm assistantItem isMultiple\" id=\""+token_ids+"\">";
					html += "            	<div class=\"description\">";
					html += "            	Deseja anotar o termo <span class=\"term\">"+tcs.termo+"</span> como <span class=\"semanticType\" tag_id=\""+t.id+"\">"+tagname+"</span>?<br>"; 
					html += "            	Sugestão baseada nas estatísticas de anotação.<br>Você marcou o termo dessa maneira em <span class='percent'>"+percent+"</span>% das vezes.";
					html += "        	</div>";
					html += "        	<div class=\"yesNoButtons\">";
					html += "        		<button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
					html += "        		<button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
					html += "        	</div>";
					html += "        	<div style=\"clear:both\"></div>";
					html += "        </div>";
					
					cont++;
				
				}
				
			}
			
		}
		
	}
	
	//Percorre estatísticas de token
    for(TokenStats ts : tokenStats){
     			
     	//Obtém TOKEN
     	Token tok = ts.token;
     			
     	//Percorre as tags utilizadas para o token atual
     	for(int i = 0; i < ts.tags.size(); i++){
     			
     		//Obtém TAG
     		Tag t = ts.tags.get(i);
     		//Obtém percentagem de aparecimento da tag
     		Double percent = ts.percents.get(i);
     			
     		//TODO: Verificar para termos compostos
     		String isMultiple = "";
     		//TODO: Caso termo composto colocar todos token_ids
   			String token_ids = tok.id + "";
     		//TODO: Termo comoposto
     		String name = tok.token;
     		
     		String tagname = t.tag;
     		//Se for tag correspondente aos tipos semanticos da UMLS
     		if(t.tipo == null)
     			tagname += " ["+t.extra_id+"]";
     		//Se for do tipo abreviatura
     		else if(t.tipo.equals("A"))
     			tagname += " [<span class=\"expandedAbbreviation\">"+Anotacao.getMostUsedAbbreviationFor(name, u.id, project_id)+"</span>]";
     				
      		//Montar DIVs de pré-anotações
      		html += "<div class=\"well well-sm assistantItem"+isMultiple+"\" id=\""+token_ids+"\">";
			html += "            	<div class=\"description\">";
			html += "            	Deseja anotar o termo <span class=\"term\">"+name+"</span> como <span class=\"semanticType\" tag_id=\""+t.id+"\">"+tagname+"</span>?<br>"; 
			html += "            	Sugestão baseada nas estatísticas de anotação.<br>Você marcou o termo dessa maneira em <span class='percent'>"+percent+"</span>% das vezes.";
			html += "        	</div>";
			html += "        	<div class=\"yesNoButtons\">";
			html += "        		<button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
			html += "        		<button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
			html += "        	</div>";
			html += "        	<div style=\"clear:both\"></div>";
			html += "        </div>";
			
			cont++;
			
     	}
     			
     			
     }

%>

	<!-- ASSISTENTE DE ANOTAÇÃO -->
	<div class="panel-group" id="accordion">
	    <div class="panel panel-default">
	        <div class="panel-heading">
	            <h4 class="panel-title">
	                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                    <span id="assistantIcon" class="glyphicon glyphicon-arrow-up"></span> 
	                    Assistente de anotação <span id="assistantNumber" class="badge"><%=cont %></span>
	                </a>
	            </h4>
	        </div>
	        <div id="collapseOne" class="panel-collapse collapse">
	            <div class="panel-body">
	        		<%
	        		
	        		
	        		out.print(html);
	        		
	        		
	        		
	        		%>
	                <!--  
	                <div class="well well-sm assistantItem" id="3513">
	                	<div class="description">
		                	Deseja anotar o termo <span class="term">HIPERTROFIA</span> como <span class="semanticType" tag_id="40">Pathologic Function [T046]</span>?<br>
		                	UMLS: <a href="https://uts.nlm.nih.gov//metathesaurus.html#C0020564;0;1;CUI;2016AB;EXACT_MATCH;CUI;*;" target="_blank">[C0020564] Hypertrophy</a><br> 
		                	SNOMED: <a href="https://uts.nlm.nih.gov//snomedctBrowser.html#56246009;0;0;CONCEPT_ID;null;SNOMEDCT_US;null;true;" target="_blank">[56246009] Hypertrophy</a>
	                	</div>
	                	<div class="yesNoButtons">
	                		<button type="button" class="btn btn-success btn-md">Sim</button>
	                		<button type="button" class="btn btn-danger btn-md">Não</button>
	                	</div>
	                	<div style="clear:both"></div>
	                </div>
	                
	               -->
	                
	                
	                
	            </div>
	        </div>
	    </div>
	</div>
	
	
	
	
	
	<script type="text/javascript">
	
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
	    		modalRelation($from, $to, null);
	    		
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
		var $itens = $("span[tokenid=" + toks[0] + "]");
		
		for(var i = 1; i < toks.length; i++){
			
			$itens = $itens.add($("span[tokenid=" + toks[i] + "]"));
			
		}
		
		return $itens;
		
	}
	
	/**
	* Obtém todos elementos (objetos jquery) de termos compostos inclusive os <span class='space'> entre eles
	*/
	var getAllTokensElementsByIdWithSpaces = function(token_id){
		
		var toks = token_id.split(",");
		var $startElement = $("span[tokenid=" + toks[0] + "]");//Obtém objeto jQuery do elemento inicial (primeiro token do termo composto)- variável guardará pilha de elementos selecionados também
	    var $endElement = $("span[tokenid=" + toks[toks.length - 1] + "]");//Obtém objeto jQuery do elemento final (ultimo token do termo composto)
	    var $actualElement = $startElement;//Define elemento atual
		
		do{
			
			//Vai para próximo elemento
	    	$actualElement = $actualElement.next();
	    	
	    	//Guarda pilha com todos elementos selecionados
	    	$startElement = $startElement.add($actualElement);
	    	
	    	//Se encontrou algum termo composto, parar - Evita loop infinito caso alguns dos termos desejados já estejam anotados como termos 
	    	if($actualElement.hasClass("compoundtoken")){
	    		return $startElement;
	    	}
			
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
		
		//Inicia a lista com o primeiro token do termo composto
		var $actual = $("span.token[compoundid="+v+"]:first");
		var $list = $actual;
		var hasTags = $actual.attr("hasTags");//Obtém tags associadas ao termo composto
		var abbr = $actual.attr("abbreviation");
		var $span = $("<span>").addClass("compoundtoken");
		
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
			if(tagid == "131" || tagid == "271"){
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
	$('span.token').dblclick(function(event){
		
		//event.stopPropagation();

		//Se elemento clicado já está definido em um termo composto - Não permite marcação
		if($(this).parent().hasClass("compoundtoken")){
			//Abre DIALOG para termo composto
			modalTag($(this).parent(), true);
		}
		else{
			//Abre DIALOG para SPAN atual
			modalTag($(this), false);
		}
		
	});
	

	
	//Evento para lidar com seleção de termos compostos
	$("#textbox").mouseup(function(event) {
		
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
			modalTag($span, true);
	    	
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
	
	//CLICK para SALVAR ANOTAÇÔES
	$("#enviar,#finalizar").click(function(event){
		
		event.preventDefault();
		
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
		$("span.sentence > span.token[hasTags]").each(function(index, token){
			
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
		$("span.compoundtoken").each(function(index, compound){
			
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
		var jqxhr = $.post( "servlets/TextAnnotation?id=" + $("#id").val(), {tokens:arrTokens, compoundtokens:arrCompound, relations:arrRelations, finalize: finalizeAnnotation}, function(res) {

			//Desbloqueia interface
			$.LoadingOverlay("hide");
			
			if(res.status == true){
				
				$.notify({
					title: "<strong>Sucesso: </strong>",
					message: "Anotações salvas",
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
					message: "Houve um erro ao salvar as anotações",
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
	$(".footer").css("position", "relative");
	//Configura ACCORDION do assistente de anotação
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
	
	var alreadyFound = false;
	//Percorre SENTENÇAS
	$("#textbox .sentence").each(function(i, sentence){
		
		var arrTokens = new Array();
		var arrTokenIds = new Array();
		
		//Percorre TOKENS
		$(sentence).find(".token").each(function(i2, token){
			
			arrTokens[i2] = $(token).text() 
			arrTokenIds[i2] = $(token).attr("tokenid");
			
		});
		
		//Envia solicitação AJAX em busca de possíveis pré-anotações
		var jqxhr = $.post( "servlets/AnnotationAssistant?id=" + $("#id").val(), {sentence_id:$(sentence).attr("sentenceid"), tokens:arrTokens, ids:arrTokenIds}, function(res) {
			
			//Se retornou com sucesso e existem conceitos
			if(res.status && res.concepts.length > 0){
				
				//Percorre conceitos
				$.each(res.concepts, function(i, concept){
					
					var token_ids = concept.tokens[0].id;
					var tag_ids = concept.semanticTypes[0].id;
					var tag_names = concept.semanticTypes[0].name + " ["+concept.semanticTypes[0].code+"]";
					var isMultiple = "";
					
					//Se é TERMO COMPOSTO
					if(concept.tokens.length > 1){
						//Percorre tokens e guarda token ids (100,102,800)
						token_ids = "";
						$.each(concept.tokens, function(u, tok){
							token_ids += tok.id + ","
						});
						//Remove ultima virgula
						token_ids = token_ids.substring(0, token_ids.length-1);
						//Mark as multiple
						isMultiple = " isMultiple";
					}
					
					//Percorre o(s) tipo(s) semantico(s)
					$.each(concept.semanticTypes, function(u, sem){
						
						tag_ids = sem.id;
						tag_names = sem.name + " ["+sem.code+"]";
						
						var html = "<div class=\"well well-sm assistantItem"+isMultiple+"\" id=\""+token_ids+"\">";
						html += "            	<div class=\"description\">";
						html += "            	Deseja anotar o termo <span class=\"term\">"+concept.name+"</span> como <span class=\"semanticType\" tag_id=\""+tag_ids+"\">"+tag_names+"</span>?<br>";
						html += "            	UMLS: <a href=\"#\" target=\"_blank\">[<span class='umlscui'>"+concept.CUI+"</span>] "+concept.name+"</a><br>"; 
						html += "            	<!--SNOMED: <a href=\"#\" target=\"_blank\">[<span class='snomedctid'>000000000</span>] xxxxxxxxxxxx</a>-->";
						html += "        	</div>";
						html += "        	<div class=\"yesNoButtons\">";
						html += "        		<button type=\"button\" class=\"btn btn-success btn-md\">Sim</button>";
						html += "        		<button type=\"button\" class=\"btn btn-danger btn-md\">Não</button>";
						html += "        	</div>";
						html += "        	<div style=\"clear:both\"></div>";
						html += "        </div>";
						
						//Adiciona novo item no assistente
						$("#accordion .panel-body").append(html);
						
						//Aumenta contagem
						$("#assistantNumber").text(parseInt($("#assistantNumber").text())+1);
						
						//Se encontrou resultados e ainda não mostrou mensagem
						if(!alreadyFound ){
							
							$.notify({
								title: "<strong>Assistente de anotação: </strong>",
								message: "Novos termos detectados.",
								icon: "glyphicon glyphicon-ok-circle"
							},{
								type: 'info',
								newest_on_top: true
							});
							
							alreadyFound = true;
						}
					
					});
						
				});
					
				
			}
			else{
				if(!res.status){
					$.notify({
						title: "<strong>Aviso: </strong>",
						message: "O assistente encontrou problemas ao tentar buscar anotações da sentença: " + $(sentence).text(),
						icon: 'glyphicon glyphicon-warning-sign',
					},{
						type: 'warning',
						newest_on_top: true
					});
				}
			}
			
			

		})
		.fail(function() {
			$.notify({
				title: "<strong>Aviso: </strong>",
				message: "O assistente encontrou problemas ao tentar buscar anotações",
				icon: 'glyphicon glyphicon-warning-sign',
			},{
				type: 'danger',
				newest_on_top: true
			});
		  	//console.log( {sentence_id:$(sentence).attr("sentenceid"), tokens:arrTokens, ids:arrTokenIds} );
		});
		
		
	
	});
	
	//Ao passar MOUSE sobre o termo, mostrar onde ele está no texto
	$("#accordion").on("mouseenter", ".assistantItem", function(){
		
		var token_id = $(this)/*.parents(".assistantItem")*/.attr("id");
		var $item;
		
		//Se é sugestão de termo composto
		if($(this).hasClass("isMultiple")){
			$item = getAllTokensElementsById(token_id);
		}
		else{
			$item = $("span[tokenid=" + token_id + "]");
			
			//Se houver o token correspondente como TERMO COMPOSTO já marcado
			if($(".compoundtoken > span[tokenid=" + token_id + "]").size() > 0){
				$item = $("span[tokenid=" + token_id + "]").parent();	
			}
		}
	
		
		//Enfatiza termo com uma borda vermelha
		$item.css("border", "3px solid red");
		//Rolagem da tela vai até o elemento
		$('html, body').animate({
	        scrollTop: $item.offset().top
	    }, 250);
		
	});
	
	$("#accordion").on("mouseleave", ".assistantItem", function(){
		var token_id = $(this)/*.parents(".assistantItem")*/.attr("id");
		var $item;
		//Se é sugestão de termo composto
		if($(this).hasClass("isMultiple")){
			$item = getAllTokensElementsById(token_id);
		}
		else{
			$item = $("span[tokenid=" + token_id + "]");
			$(".compoundtoken > span[tokenid=" + token_id + "]").parent().removeAttr("style");
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
		
		
	});
	
	//TODO: Verificar se o que tem no hasTags é a mesma tag_id que está tentado aplicar. (Ex.: hasTags="41,41")
	//Botão para aceitar pré-anotação do assistente
	$("#accordion").on("click", ".btn-success", function(){
		var $assistantItem = $(this).parents(".assistantItem");
		//Obtém token_id
		var token_id = $assistantItem.attr("id");
		//Obtém tag_id
		var tag_id = $assistantItem.find(".semanticType").attr("tag_id");
		
		var $item;
		var $span;
		
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
				if($item.filter("span[hasTags]").size() > 0){
					
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
			
			//Adiciona recurso de DRAGnDROP ao SPAN
			//Re-executa DragDrop para habilitar funcionalidade para novo Conceito adicionado
			doDragDrop($span);
		}
		else{
		 	$item = $("span[tokenid=" + token_id + "]");
		 	
		 	//Se houver o token correspondente como TERMO COMPOSTO
			if($(".compoundtoken > span[tokenid=" + token_id + "]").size() > 0){
				//Mudado sem testar
				//$item = $("span[tokenid=" + token_id + "]").parent();
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
			
			//Adiciona recurso de DRAGnDROP ao SPAN
			//Re-executa DragDrop para habilitar funcionalidade para novo Conceito adicionado
			doDragDrop($item);
		}
		
		//Esconde proposta de pré-anotação
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
	
	//Faz aparecer menu no hover dos relacionamentos
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
		
	});
	
	$("#resize").click(function(){
		
		if($(this).hasClass("glyphicon-resize-full")){
			$(this).removeClass("glyphicon-resize-full").addClass("glyphicon-resize-small");
			$(".well").css("width", "3000px");
		}
		else{
			$(this).removeClass("glyphicon-resize-small").addClass("glyphicon-resize-full");
			$(".well").css("width", "100%");
		}
		
	});
	
	<%
	//Se for usuário ADMIN
	if(Permissao.isOnlyAdmin(u)){
		%>
			$.notify({
				title: "<strong>Aviso: </strong>",
				message: "Não é possível enviar anotações com usuário Administrador",
				icon: "glyphicon glyphicon-warning-sign"
			},{
				type: 'warning',
				newest_on_top: true
			});
		<%
	}
	
	%>
	
	</script>
	<style type="text/css">
	#annotationContainer{margin-bottom:380px; /*Necessario para rolagem automatica do assistente*/}
	#annotated-token{font-weight: bold;}
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
	
	.panel-default > .panel-heading{
	    /*background: #00B4FF;*/
	    background-color: #d9edf7;
    	border-color: #bce8f1;
	}
	
	.panel-heading {
	    padding: 0;
	    border-top-left-radius: 0px;
	    border-top-right-radius: 0px;
	    color: #31708f;
	}
	
	.panel-group .panel {
	    border-radius: 0;
	}
	
	.panel-title a {
	    text-align: center;
	    width: 100%;
	    display: block;
	    padding: 10px 15px;
	    font-size: 16px;
	    font-family: Helvetica,Arial,sans-serif;
	    outline: none;
	}
	
	.panel-title a:hover, .panel-title a:focus, .panel-title a:active {
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