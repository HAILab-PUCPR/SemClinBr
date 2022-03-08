package helper;

import java.util.ArrayList;
import java.util.Map;

import model.Anotacao;
import model.Sentenca;
import model.Tag;
import model.Token;
import model.Usuario;
import util.Number;

public class TextAdjudicationHelper {

	
	/**
	 * Monta painel com anotações definitivas do adjudicador
	 * @param sentencas
	 * @param tokens
	 * @param tags
	 * @param anotacoesConcordantes
	 * @return
	 */
	public static String showFinalAnnotations(ArrayList<Sentenca> sentencas, ArrayList<Token> tokens, ArrayList<Tag> tags, Map<Anotacao, Anotacao> anotacoesConcordantes ){
		
		String html = "";
		
		//Percorre senteças
		for(Sentenca s : sentencas){
			
			html += "<span class='sentence' sentenceid='"+s.id+"'>";
			
			//Percorre tokens
			for(Token t : tokens){
				
				//Se token pertence a sentença atual
				if(t.sentenca_id == s.id){
		
					String tokenAttributes = "";
					String spanTooltips = "";
					ArrayList<Integer> tokenTags = new ArrayList<Integer>();
					int qtdeTags = 0;

					//Percorre anotações CONCORDANTES em busca de TAGS para o token atual
					//for(Anotacao a : anotacoes){
					for (Map.Entry<Anotacao, Anotacao> entry : anotacoesConcordantes.entrySet()) {
						
						//TODO: Funciona apenas para DOIS ANOTADORES
						Anotacao a1 = entry.getKey();
						//Anotacao a2 = entry.getValue();

						//Se encontrou anotação para o token atual
						if(a1.token_id == t.id){
							
							//Adiciona atributo para dar a cor da tag respectiva ao token (seguindo as regras CSS)
							tokenAttributes += "tag" + a1.tag_id + "=\""+ a1.tag_id+"\"";
							spanTooltips += "<span tag" + a1.tag_id + "='"+ a1.tag_id+"'>"+ TextAnnotationHelper.getTagName(tags, a1.tag_id) +"</span> ";
							//Armazena tag_id
							tokenTags.add(a1.tag_id);
							qtdeTags++;
						
							//Se for termo composto
							if(a1.termocomposto_id != null)
								tokenAttributes += " compoundId=\""+a1.termocomposto_id+"\"";//Marca como composta para javascript fazer o wrap
									
							//Se tem abreviatura
							if(a1.abreviatura != null)
								tokenAttributes += " abbreviation=\""+a1.abreviatura+"\"";
									
							//Se tem UMLS CUI
							if(a1.umlscui != null)
								tokenAttributes += " umlscui=\""+a1.umlscui+"\"";
							
							//Se tem SNOMED-CT ID
							if(a1.snomedctid != null)
								tokenAttributes += " snomedctid=\""+a1.snomedctid+"\"";
							
						
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
					html += "<span class='token' tokenid='"+t.id+"' "+tokenAttributes+">" + t.token + "</span><span class='space'> </span>";
					
					
				}
				
				
			}
			
			//Quando for colocada a formatação original do texto retirar os <br>
			html += "</span><br><br>";
			
		}
		
		return html;
		
		
	}
	
	/**
	 * Monta painel com anotações individuais dos anotadores
	 * @param sentencas
	 * @param tokens
	 * @param tags
	 * @param anotacoesConcordantes
	 * @return
	 */
	public static String showAnnotations(ArrayList<Sentenca> sentencas, ArrayList<Token> tokens, ArrayList<Tag> tags, ArrayList<Anotacao> anotacoes ){
		
		String html = "";
		
		//Percorre senteças
		for(Sentenca s : sentencas){
			
			html += "<span class='sentence' sid='"+s.id+"'>";
			
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
					html += "<span class='token' tid='"+t.id+"' "+tokenAttributes+">" + t.token + "</span><span class='space'> </span>";
					
					
				}
				
				
			}
			
			//Quando for colocada a formatação original do texto retirar os <br>
			html += "</span><br><br>";
			
		}
		
		return html;
		
		
	}
	
	
	/**
	 * Mostra métricas de adjudicação
	 * @return
	 */
	public static String showAdjudicationMetrics(int texto_id, ArrayList<Usuario> performedAnnotators){
		
		int qtdeAnotacoes1 = Anotacao.getNumberAnotacoesSimples(texto_id, performedAnnotators.get(0).id) + Anotacao.getNumberAnotacoesCompostas(texto_id, performedAnnotators.get(0).id); 
		int qtdeAnotacoes2 = Anotacao.getNumberAnotacoesSimples(texto_id, performedAnnotators.get(1).id) + Anotacao.getNumberAnotacoesCompostas(texto_id, performedAnnotators.get(1).id);
		
		if(Anotacao.getNumberAdjudicacoes(texto_id) < 1)
			return "Não há adjudicações feitas...";
		
		
		int TPsimples1 = Anotacao.getNumberConcordantesSimples(texto_id, performedAnnotators.get(0).id);
		int TPcompostos1 =  Anotacao.getNumberConcordantesCompostos(texto_id, performedAnnotators.get(0).id);
		float TP1 = TPsimples1 + TPcompostos1;
		
		int FPsimples1 = Anotacao.getNumberDiscordantesSimples(texto_id, performedAnnotators.get(0).id);
		int FPcompostos1 =  Anotacao.getNumberDiscordantesCompostos(texto_id, performedAnnotators.get(0).id);
		float FP1 = FPsimples1 + FPcompostos1;
		
		int FNsimples1 = Anotacao.getNumberDiscordantesAdjudicadorSimples(texto_id, performedAnnotators.get(0).id);
		int FNcompostos1 =  Anotacao.getNumberDiscordantesAdjudicadorCompostos(texto_id, performedAnnotators.get(0).id);
		float FN1 = FNsimples1 + FNcompostos1;
		
		Double Precision1 = new Double(TP1 / (TP1 + FP1));
		Double Recall1 = new Double(TP1 / (TP1 + FN1));
		Double FMeasure1 = new Double(2 * Precision1 * Recall1 / (Precision1 + Recall1));
		
		
		
		int TPsimples2 = Anotacao.getNumberConcordantesSimples(texto_id, performedAnnotators.get(1).id);
		int TPcompostos2 =  Anotacao.getNumberConcordantesCompostos(texto_id, performedAnnotators.get(1).id);
		float TP2 = TPsimples2 + TPcompostos2;
		
		int FPsimples2 = Anotacao.getNumberDiscordantesSimples(texto_id, performedAnnotators.get(1).id);
		int FPcompostos2 =  Anotacao.getNumberDiscordantesCompostos(texto_id, performedAnnotators.get(1).id);
		float FP2 = FPsimples2 + FPcompostos2;
		
		int FNsimples2 = Anotacao.getNumberDiscordantesAdjudicadorSimples(texto_id, performedAnnotators.get(1).id);
		int FNcompostos2 =  Anotacao.getNumberDiscordantesAdjudicadorCompostos(texto_id, performedAnnotators.get(1).id);
		float FN2 = FNsimples2 + FNcompostos2;
		
		Double Precision2 = new Double(TP2 / (TP2 + FP2));
		Double Recall2 = new Double(TP2 / (TP2 + FN2));
		Double FMeasure2 = new Double(2 * Precision2 * Recall2 / (Precision2 + Recall2));
		
		String html = "<table class=\"table\">\r\n" + 
				"		    	<thead>\r\n" + 
				"		    		<tr>\r\n" + 
				"		    			<th>Anotador</th>\r\n" + 
				"		    			<th>Qtde anotações</th>\r\n" + 
				"		    			<th>TP</th>\r\n" + 
				"		    			<th>FP</th>\r\n" + 
				"		    			<th>FN</th>\r\n" + 
				"		    			<th>Precision</th>\r\n" + 
				"		    			<th>Recall</th>\r\n" + 
				"		    			<th>F-Measure</th>\r\n" + 
				"		    		</tr>\r\n" + 
				"		    	</thead>\r\n" + 
				"		    	<tbody>" +
			    "					<tr>\r\n" + 
				"		    			<td>Anotador 1 ("+performedAnnotators.get(0).nome+")</td>\r\n" + 
				"		    			<td>"+qtdeAnotacoes1+"</td>\r\n" + 
				"		    			<td>"+(int)TP1+"</td>\r\n" + 
				"		    			<td>"+(int)FP1+"</td>\r\n" + 
				"		    			<td>"+(int)FN1+"</td>\r\n" + 
				"		    			<td>"+Number.round(Precision1.doubleValue(), 3)+"</td>\r\n" + 
				"		    			<td>"+Number.round(Recall1.doubleValue(), 3)+"</td>\r\n" + 
				"		    			<td>"+Number.round(FMeasure1.doubleValue(), 3)+"</td>\r\n" + 
				"		    		</tr>\r\n" + 
				"		    		<tr>\r\n" + 
				"		    			<td>Anotador 2 ("+performedAnnotators.get(1).nome+")</td>\r\n" + 
				"		    			<td>"+qtdeAnotacoes2+"</td>\r\n" + 
				"		    			<td>"+(int)TP2+"</td>\r\n" + 
				"		    			<td>"+(int)FP2+"</td>\r\n" + 
				"		    			<td>"+(int)FN2+"</td>\r\n" + 
				"		    			<td>"+Number.round(Precision2.doubleValue(), 3)+"</td>\r\n" + 
				"		    			<td>"+Number.round(Recall2.doubleValue(), 3)+"</td>\r\n" + 
				"		    			<td>"+Number.round(FMeasure2.doubleValue(), 3)+"</td>\r\n" + 
				"		    		</tr>\r\n" + 
				"		    	</tbody>\r\n" + 
				"		  </table>";
		
		
		
		return html;
		
	}
	
	/**
	 * Monta painel com adjudicações já finalizadas
	 * @param sentencas
	 * @param tokens
	 * @param tags
	 * @param adjudicações
	 * @return
	 */
	public static String showAdjudications(ArrayList<Sentenca> sentencas, ArrayList<Token> tokens, ArrayList<Tag> tags, ArrayList<Anotacao> adjudicacoes ){
		
		String html = "";
		
		//Percorre senteças
		for(Sentenca s : sentencas){
			
			html += "<span class='sentence' sentenceid='"+s.id+"'>";
			
			//Percorre tokens
			for(Token t : tokens){
				
				//Se token pertence a sentença atual
				if(t.sentenca_id == s.id){
		
					String tokenAttributes = "";
					String spanTooltips = "";
					ArrayList<Integer> tokenTags = new ArrayList<Integer>();
					int qtdeTags = 0;

					//Percorre adjudicacoes em busca de TAGS para o token atual
					for(Anotacao a1 : adjudicacoes){
						
						//TODO: Funciona apenas para DOIS ANOTADORES
						//Anotacao a1 = entry.getKey();
						//Anotacao a2 = entry.getValue();

						//Se encontrou anotação para o token atual
						if(a1.token_id == t.id){
							
							//Adiciona atributo para dar a cor da tag respectiva ao token (seguindo as regras CSS)
							tokenAttributes += "tag" + a1.tag_id + "=\""+ a1.tag_id+"\"";
							spanTooltips += "<span tag" + a1.tag_id + "='"+ a1.tag_id+"'>"+ TextAnnotationHelper.getTagName(tags, a1.tag_id) +"</span> ";
							//Armazena tag_id
							tokenTags.add(a1.tag_id);
							qtdeTags++;
						
							//Se for termo composto
							if(a1.termocomposto_id != null)
								tokenAttributes += " compoundId=\""+a1.termocomposto_id+"\"";//Marca como composta para javascript fazer o wrap
									
							//Se tem abreviatura
							if(a1.abreviatura != null)
								tokenAttributes += " abbreviation=\""+a1.abreviatura+"\"";
									
							//Se tem UMLS CUI
							if(a1.umlscui != null)
								tokenAttributes += " umlscui=\""+a1.umlscui+"\"";
							
							//Se tem SNOMED-CT ID
							if(a1.snomedctid != null)
								tokenAttributes += " snomedctid=\""+a1.snomedctid+"\"";
							
						
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
					html += "<span class='token' tokenid='"+t.id+"' "+tokenAttributes+">" + t.token + "</span><span class='space'> </span>";
					
					
				}
				
				
			}
			
			//Quando for colocada a formatação original do texto retirar os <br>
			html += "</span><br><br>";
			
		}
		
		return html;
		
		
	}
	
}
