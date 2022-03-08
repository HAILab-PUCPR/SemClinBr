package helper;

import java.util.ArrayList;
import java.util.HashMap;

import model.Acronimo;
import model.Tag;
import model.Tiporelacionamento;
import model.Token;

public class TextAnnotationHelper {
	
	private static ArrayList<Acronimo> acronimos = Acronimo.select();
	//TODO: não deixar hardcodded isso aqui - Removed
	//public static final int TAG_ACRONIMO = Tag.findIdByTag("abreviação/acrônimo");

	
	public static String getTagSelectBox(ArrayList<Tag> tags, Token token, Integer tag_id, HashMap<Integer,Double> tagStats){
		
		String html = "<select id='tagtoken_"+token.id+"' name='tagtoken_"+token.id+"' tokenid='"+token.id+"' class='tagtoken'>";
		
		/*HashMap<Integer,Double> tagStats = new HashMap<Integer,Double>(); 
		//Percorre a lista de estatíticas em busca do token atual
		for(TokenStats tok : tokenStats){
			//Se encontrou estatistica do token atual
			if(tok.token.id == token.id){
				//Se existem tags armazenadas
				if(tok.tags.size() > 0){
					int cont = 0;
					//Percorre as tags que foram utilizadas para o token atual
					for(Integer tagid: tok.tags){
						//Armazena TAG_ID e PERCENTAGEM
						tagStats.put(tagid, tok.percents.get(cont));
						
						cont++;
					}
					
				}
			}
		}*/
		
		Double maior = 0.0;
		//TODO: Put option selection in JS
		for(Tag t : tags){
		
			try{
				
				//IF TOKEN WAS ALREADY ANNOTATED
				if(tag_id > 0){
					//IF THE ACTUAL TAG IS THE ANNOTATED ONE
					if(tag_id == t.id){
						html += "<option value='"+t.id+"' selected='selected' type='"+t.tipo+"'>"+t.tag+"</option>";
					}
				
				}
				else{//IN CASE THE TOKEN DO NOT HAVE ANNOTATION YET - LOOK FOR PRE-ANNOTATION
					
					//Se token já foi anotado com a tag atual em outro texto
					if(tagStats.containsKey(t.id)){
						//Verifica qual a tag com maior percentagem e deixa esta selecionada
						if(tagStats.get(t.id) > maior){
							html += "<option value='"+t.id+"' selected='selected' type='"+t.tipo+"'>"+t.tag+" ("+tagStats.get(t.id)+" %)</option>";
							//Atualiza a maior porcentagem
							maior = tagStats.get(t.id);
						}
						//Caso tenha sido anotado mas não tem a maior porcentagem
						else{
							html += "<option value='"+t.id+"' type='"+t.tipo+"'>"+t.tag+" ("+tagStats.get(t.id)+" %)</option>";
						}
					}
					else if(t.tipo.equals("A")){ //IF it is an abbreviation tag
						//the abbreviation is on the list? - TODO: Make this test after text review to reduce IO
						if(identificaAcronimo(token))
							html += "<option value='"+t.id+"' selected='selected' type='"+t.tipo+"'>"+t.tag+"</option>";
						else
							html += "<option value='"+t.id+"' type='"+t.tipo+"'>"+t.tag+"</option>";
					}
					else if(t.tipo.equals("N")){
						html += "<option value='"+t.id+"' type='"+t.tipo+"' selected='selected'>"+t.tag+"</option>";
					}
					else{
						html += "<option value='"+t.id+"' type='"+t.tipo+"'>"+t.tag+"</option>";
					}
				}
					
			}
			catch(NullPointerException e){
				html += "<option value='"+t.id+"' type='"+t.tipo+"'>"+t.tag+"</option>";
			}
			
		}
		
		html += "</select>";
		
		return html;
		
	}
	
	public static boolean identificaAcronimo(Token token){
		for(Acronimo a:acronimos)
			
			//if(token.token.equals(a.acronimo))
			
			//Coloca os dois termos em letras minúsculas para testar
			//Evita problemas porque os termos estao 100% em maiúsculas no BD
			
			//TODO: Verificar caso do "da/DA", "de/DE"
			
			if(token.token.toLowerCase().equals(a.acronimo.toLowerCase()))
				return false;
		return false;
	}
	
	public static String getTagAutocompleteSelectBox(ArrayList<Tag> tags){
		
		String html = "<label for=\"tagtoken\">Semantic type(s):</label>"
				+ "<select id='tagtoken' name='tagtoken' multiple='multiple' style='width: 100%'>";
		
		for(Tag t : tags){
		
			try{
				

				html += "<option value='"+t.id+"' type='"+t.tipo+"'>"+t.tag+"</option>";
					
				
			}
			catch(Exception e){
				
			}
			
		}
		
		html += "</select>";
		
		return html;
		
	}
	
	
	public static String getRelationAutocompleteSelectBox(ArrayList<Tiporelacionamento> tps){
		
		String html = "<label for=\"relationtoken\">Relation(s):</label>"
				+ "<select id='relationtoken' name='relationtoken' multiple='multiple' style='width: 100%'>";
		
		for(Tiporelacionamento t : tps){
		
			try{
				

				html += "<option value='"+t.id+"' hieraquia='"+t.hierarquia+"' extra_id='"+t.extra_id+"'>"+t.nome+"</option>";
					
				
			}
			catch(Exception e){
				
			}
			
		}
		
		html += "</select>";
		
		return html;
		
	}
	
	public static String getTagsCssColorRules(ArrayList<Tag> tags){
		
		String css = "";
		for(Tag t : tags){
			
			css += ".select2-selection__choice[title=\""+t.tag+"\"]{background-color:#"+t.cor+"!important;}\r\n"
					+ "span[tag"+t.id+"]{background-color:#"+t.cor+";border: 1px solid #333;cursor:pointer;}\r\n";
			
		}
		
		return css;
	}
	
	public static String getTagsJsArray(ArrayList<Tag> tags){
		
		String js = "<script type=\"text/javascript\">var arrTags = new Array();\r\n";
		int c = 0;
		for(Tag t : tags){
			
			js += "arrTags["+c+"] = "+t.id+";\r\n";
			c++;
			
		}
		
		return js + "</script>";
	}
	
	public static String getTagName(ArrayList<Tag> tags, int tag_id){
		
		for(Tag t : tags){
			if(t.id == tag_id){
				return t.tag;
			}
		}
		
		return "";
		
	}
	
	public static String getTokenName(ArrayList<Token> tokens, int token_id){
		
		for(Token t : tokens){
			if(t.id == token_id){
				return t.token;
			}
		}
		
		return "";
		
	}
	
	public static String getTiporelacionamentoName(ArrayList<Tiporelacionamento> tipos, int id){
		
		for(Tiporelacionamento t : tipos){
			if(t.id == id){
				return t.nome;
			}
		}
		
		return "";
		
	}
}
