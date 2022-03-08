package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import connection.DbConnection;

public class Sentenca {

	public int id;
	public int texto_id;
	public String sentenca;
	public int ordem;
	public String status;
	
	public Sentenca(int texto_id, String sentenca, int ordem){
		this.texto_id = texto_id;
		this.sentenca = sentenca;
		this.ordem = ordem;
	}
	
	public Sentenca() {
		// TODO Auto-generated constructor stub
	}

	//Insere uma única sentença
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO sentencas (texto_id, sentenca, ordem, status) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, this.texto_id);
			ps.setString(2, this.sentenca);
			ps.setInt(3, this.ordem);
			ps.setString(4, TextoStatus.ANOTACAO);
			
			ps.executeUpdate();
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			this.id = res.getInt(1);
			return false;
			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}	
	}	

	
	public static boolean deleteSentencasByTextoId(int texto_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE FROM sentencas WHERE texto_id = ?");
			ps.setInt(1, texto_id);
			ps.executeUpdate();
			
			return true;
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar do BD");
			e.printStackTrace();
			return true;
		}
	}
	
	public static ArrayList<Sentenca> findSentencasByTextoId(int texto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM sentencas WHERE texto_id = ?");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Sentenca> sentencas = new ArrayList<Sentenca>();
			
			while (res.next()) {
				Sentenca s = new Sentenca();
				s.id = res.getInt("id");
				s.texto_id = res.getInt("texto_id");
				s.sentenca = res.getString("sentenca");
				s.ordem = res.getInt("ordem");
				s.status = res.getString("status");
				
				sentencas.add(s);
			 }
			 
			return sentencas;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
}