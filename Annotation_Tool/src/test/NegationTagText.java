package test;

import java.util.ArrayList;

import model.Anotacao;
import model.Texto;
import model.Token;

public class NegationTagText {

	FALTA FAZER SCOPE
	Ex.: <cue>não</cue>-<scope>esteroidais</scope>, gestantes ou lactantes. 
	
	public static void main(String[] args) {

		//Find all texts to PHILIPS annotation project
		ArrayList<Texto> textos = Texto.findByProjeto_id(1);
		
		//Iterate texts
		for(Texto tx : textos){
			
			//System.out.println("ORIGINAL: "+ tx.texto + "</original>");
			
			//Get text id
			int texto_id = tx.id;
			
		 	//Get all tokens from text
		 	ArrayList<Token> tokens = Token.findTokensByTextoId(texto_id);
		 	//Get all annotation from text
		 	ArrayList<Anotacao> anotacoes = Anotacao.findAdjudicacoesFinalizadasByTextoId(texto_id);
		 	//List to put all negated tokens
		 	ArrayList<Integer> negatedTokens = new ArrayList<Integer>();
		 	
		 	
		 	//Iterate all annotations from text
			for(Anotacao a : anotacoes){
				
				//Found a negation annotation
				if(a.tag_id == 128 || a.tag_id == 269){
					//Put on the list
					negatedTokens.add(a.token_id);
				}
				
				
			}
		 	
			//Iterate tokens
			for(int i = 0; i < tokens.size(); i++){
				
				//If actual token is negated
				if(negatedTokens.contains(tokens.get(i).id)){
					
					//Shift the list and put the tag in the middle
					tokens.add(i, new Token(0, "<neg>"));
					//Iterate next terms to see if are negated too
					for(int j = i + 1; true; j++){
						
						try{
							//If still have negation, go to the next
							if(negatedTokens.contains(tokens.get(j).id)){
								i++;
							}//If not, close the negation tag
							else{
								tokens.add(j, new Token(0, "</neg>"));
								break;
							}
						
						}
						catch(IndexOutOfBoundsException e){
							System.out.println("Negation on last word!");
							tokens.add(j, new Token(0, "</neg>"));
							break;
						}
						
					}
					
				}
				
			}
			
			System.out.println("<text id='"+texto_id+"'>");
			for(Token t : tokens){
				System.out.print(t.token + " ");
			}
			System.out.print("\n</text>\n\n");
		
		}
	}

}
