package util;

import java.util.ArrayList;

import model.Acronimo;
import model.Anotacao;
import model.Tag;
import model.Token;

public class AcronymTagger {
	
	public static final int TAG_ACRONIMO = Tag.findIdByTag("abreviação/acrônimo");
	//TODO: Rever esse usuário aqui
	public static final int ANOTACAO_AUTOMATICA = 0;
	public static ArrayList<Acronimo> acronimos = Acronimo.select();

	public static boolean identificaAcronimo(ArrayList<Token> tokens){
		for(Token t:tokens)
			for(Acronimo a:acronimos)
				if(t.token.equals(a.acronimo)){
					Anotacao an = new Anotacao(TAG_ACRONIMO, t.id, ANOTACAO_AUTOMATICA);
					an.insert();
				}
		return true;
	}
}
