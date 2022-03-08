package util;

import java.util.Locale;

import org.cogroo.analyzer.Analyzer;
import org.cogroo.analyzer.ComponentFactory;
import org.cogroo.text.Document;
import org.cogroo.text.Sentence;
import org.cogroo.text.impl.DocumentImpl;

import model.Sentenca;
import model.Texto;
import model.Token;

public class Tokenizer {

	/**
	 * Separa texto em SENTENCAS e TOKENS
	 * PROBLEMAS QUANDO UTILIZAMOS TEXTOS EM MAIUSCULAS
	 * @param t
	 */
	public static void tokenizaCogroo(Texto t){
		
		ComponentFactory factory = ComponentFactory.create(new Locale("pt", "BR"));
		Analyzer cogroo = factory.createPipe();
		// Create a document and set the text.
		Document document = new DocumentImpl();
	    document.setText(t.texto);
	    // analyze it
	    cogroo.analyze(document);
	    //Navigate the SENTENCES
	    int sentence_order = 0;
	    
		//ArrayList<Token> tokens = new ArrayList<Token>(); //Faz parte do trecho que insere em batch
		
	    for (Sentence sentence : document.getSentences()) {
	    		    
			//String str = sentence.getText();	//Verificar a sentenca gerada
	    	Sentenca s = new Sentenca(t.id, sentence.getText(), sentence_order);
			s.insert();
			
			/*
			//Este trecho insere todos os tokens em um batch e insere todos de uma vez ao terminar de processar o texto			
			int token_order = 0;
	    	for(org.cogroo.text.Token tk:sentence.getTokens()){
				tokens.add(new Token(s.id, tk.getLexeme(), token_order));
			    token_order++;
	    	}	*/
	    	
	    	//Este trecho insere um token por vez no BD, após ler ele
	    	  
	    	int token_order = 0;
	    	for(org.cogroo.text.Token tk:sentence.getTokens()){
				Token token = new Token(s.id, tk.getLexeme(), token_order);
				token.insert();
			    token_order++;
	    	}
	    	
	    	sentence_order++;
	    }
		//Token.insertTokenList(tokens); //Faz parte do trecho que insere em batch

	}
	
	public static void tokenizaString(Texto t){
		//Separa a string em sentenças
		String[] sentences = t.texto.split("(?<=[.!?])\\s*");
		
		//ArrayList<Token> tokens = new ArrayList<Token>(); //Faz parte do trecho que insere em batch
		
		//Percorre a lista de sentenças e as insere no BD
		for (int i=0; i < sentences.length; i++){
		    String sentence = sentences[i];
			Sentenca s = new Sentenca(t.id, sentence, i);
			s.insert();
			
			//TODO: Resolver problema de números com casas decimais - 10.5 está se transformando em 3 tokens (10, . , 5)
			//Separa cada uma das sentenças em tokens
		    String[] words = sentence.split("\\s+|(?<=[,.!?:-;=#()])|(?=[,.!?:-;=#()])");//Gera tokens em branco quando: Teste # outra palavra
		    //String[] words = sentence.split("\\s+|(?<=[,.!?:-;=#()])");//Não separa a pontuação do token
			//String[] words = sentence.split("[\\p{Punct}\\s]+");//Perde a pontuação
			
			
		    //Percorre a lista de tokens e os insere no BD
			
		    /*
			//Este trecho insere todos os tokens em um batch e insere todos de uma vez ao terminar de processar o texto		
		    for (int j=0; j < words.length; j++) {
			   String word = words[j];
			   tokens.add(new Token(s.id, word, j));
		   }	*/
			
			//Este trecho insere um token por vez no BD, após ler ele
		    int token_order = 0;
		    for (int j=0; j < words.length; j++) {
				String word = words[j];
				//Resolver problema da Regex estar gerando tokens vazios
				if(!word.trim().isEmpty()){
					Token tk = new Token(s.id, word, token_order);
					tk.insert();
					token_order++;
				}
		    }
	   }
	   //Token.insertTokenList(tokens); //Faz parte do trecho que insere em batch
	}
}
