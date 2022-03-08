package umls;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONObject;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;
import model.Token;

/*
 * --Selecionar tamanho máximo de termo composto na UMLS
SELECT name, LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) as number FROM translatedumls ORDER BY number DESC
 */

public class Concept {
	
	public String CUI;
	public String name;
	public String URI;
	public String rootSource;
	public ArrayList<SemanticType> semanticTypes = new ArrayList<SemanticType>();
	public ArrayList<Token> tokens = new ArrayList<Token>();//Armazena tokens quando o termo é composto
	final public static int compoundTermMaxSize = 6;//Define tamanho máximo de termos compostos
	public static int compoundTermMaxSizeFound = 0;
	
	public Concept(JSONObject obj){
		
		name = (String) obj.get("name");
		CUI = (String) obj.get("ui");
		URI = (String) obj.get("uri");
		rootSource = (String) obj.get("rootSource");
		
	}
	
	public Concept(){}
	
	public static ArrayList<Concept> findByName(String name){
		
		ArrayList<Concept> cs = new ArrayList<Concept>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM translatedumls WHERE name = ?");
			ps.setString(1, name);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				 Concept c = new Concept();

				 c.CUI = res.getString("CUI");
				 c.name = res.getString("name");
				 
				 cs.add(c);
			 }
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return cs;
	}
	
	public static ArrayList<Concept> findCompoundTerms(int actualPos, String[] tokens, String[] tokenIds){
		
		ArrayList<Concept> cs = new ArrayList<Concept>();
		
		//Se posição atual já está fora dos limites do array de tokens
		if(actualPos >= tokens.length)
			return cs;
		
		//0 = hipertensão
		//1 = hipertensão arterial
		//2 = hipertensão arterial sistemica
		//3 = hipertensão arterial sistemica descartada...
		ArrayList<String> termVariations = new ArrayList<String>();
		
		//Define variações possíveis do termo, respeitando o tamanho máximo
		for(int i = actualPos; i < actualPos + compoundTermMaxSize; i++){

			//Se já não existem tokens a serem percorridos
			if(i >= tokens.length)
				break;
			
			//Se é primeiro TOKEN
			if(i == actualPos)
				termVariations.add(tokens[i]);
			else
				termVariations.add( termVariations.get(termVariations.size()-1) + " " + tokens[i]);//Concatena token atual com todos anteriores
			
			
		}
		
		//Percorre variações possíveis e busca se existe na UMLS TRADUZIDA LOCAL
		for(int i = 1; i < termVariations.size(); i++){

			try {
				//System.out.println("SELECT * FROM translatedumls WHERE name = "+termVariations.get(i));
				PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM translatedumls WHERE name = ?");
				ps.setString(1, termVariations.get(i));
				ResultSet res = ps.executeQuery();
				
				if(res != null)
				while (res.next()) {
					 Concept c = new Concept();

					 c.CUI = res.getString("CUI");
					 c.name = res.getString("name");
					 
					 //Define TOKENS PERTENCENTES AO TERMO (CONCEPT) COMPOSTO
					 for(int u = 0; u <= i; u++){
						 c.tokens.add(new Token(Integer.parseInt(tokenIds[actualPos+u]), tokens[actualPos+u]));
					 }
					 //Adiciona conceito a lista
					 cs.add(c);
					 
					 //Atualiza o tamanho do maior termo composto encontrado
					 compoundTermMaxSizeFound = i + 1;
				 }
				 
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		return cs;
		
		
	}
	

}
