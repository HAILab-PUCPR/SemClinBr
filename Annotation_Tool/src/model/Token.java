package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class Token {

	public int id;
	public int sentenca_id;
	public String token;
	public int ordem;
	public String status;

	public Token(int sentenca_id, String token, int ordem){
		this.sentenca_id = sentenca_id;
		this.token = token;
		this.ordem = ordem;
	}
	
	public Token() {
		// TODO Auto-generated constructor stub
	}
	
	public Token(int id, String token){
		this.id = id;
		this.token = token;
	}

	//Insere um token no BD
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO tokens (sentenca_id, token, ordem, status) VALUES (?, ?, ?, ?)");
			ps.setInt(1, this.sentenca_id);
			ps.setString(2, this.token);
			ps.setInt(3, this.ordem);
			ps.setString(4, TextoStatus.REVISAO);
			return ps.execute();
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}	
	}	
	
	//Insere uma lista de tokens no BD
	public static boolean insertTokenList(ArrayList<Token> t){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO tokens (sentenca_id, token, ordem, status) VALUES (?, ?, ?, \"I\")");
			for(Token tk : t){
				ps.setInt(1, tk.sentenca_id);
				ps.setString(2, tk.token);
				ps.setInt(3, tk.ordem);
				ps.addBatch();
			}
			
			ps.executeBatch();
			return false;
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}
	}
	//Retorna lista de objetos de tokens selecionados pelo id do Projeto
	//FIXME: corrigir select
	public static ArrayList<Token> findByProjeto_id(){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tokens");
			//ps.setInt(1, 1); //TODO: Sempre 1 por enquanto
			ResultSet res = ps.executeQuery();
			
			ArrayList<Token> tokens = new ArrayList<Token>();
			
			while (res.next()) {
				 Token tk = new Token();
				 tk.id = res.getInt("id");
				 tk.sentenca_id = res.getInt("sentenca_id");
				 tk.ordem = res.getInt("ordem");
				 tk.token = res.getString("token");
				 tk.status = res.getString("status");
				 
				 tokens.add(tk);
			}
			return tokens;
		}
		
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
}
			
	public static boolean deleteTokensByTextoId(int texto_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE tokens FROM tokens INNER JOIN sentencas ON sentencas.id = tokens.sentenca_id WHERE sentencas.texto_id = ?");
			ps.setInt(1, texto_id);
			ps.executeUpdate();
			
			return true;		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar do BD");
			e.printStackTrace();
			return true;
		}
	}
	
	public static ArrayList<Token> findTokensByTextoId(int texto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT tokens.* FROM tokens INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE sentencas.texto_id = ? ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Token> tokens = new ArrayList<Token>();
			
			while (res.next()) {
				Token t = new Token();
				t.id = res.getInt("id");
				t.sentenca_id = res.getInt("sentenca_id");
				t.token = res.getString("token");
				t.ordem = res.getInt("ordem");
				t.status = res.getString("status");
				
				tokens.add(t);
			 }
			 
			return tokens;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
}