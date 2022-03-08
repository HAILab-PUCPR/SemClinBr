package model;

import java.util.ArrayList;

public class RelacionamentoCompleto extends Relacionamento {
	
	public ArrayList<Token> tokens1List = new ArrayList<Token>();
	public ArrayList<Token> tokens2List = new ArrayList<Token>();
	public String relacionamento_name;
	public String anotador_name;
	public String termo1 = "";
	public String termo2 = "";

}
