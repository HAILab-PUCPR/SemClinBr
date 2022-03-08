package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class Tiporelacionamento {
	
	public int id;
	public String nome;
	public int projeto_id;
	public String traducao;
	public String extra_id;
	public String hierarquia;
	public String status;
	
	/**
	 * Obtém apenas tipos de relacionamento principais
	 * @param projeto_id
	 * @return
	 */
	public static ArrayList<Tiporelacionamento> findByProjectId(int projeto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tiposrelacionamentos WHERE projeto_id = ? AND status='A' AND LENGTH(hierarquia) < 3 ORDER BY hierarquia");
			ps.setInt(1, projeto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Tiporelacionamento> tps = new ArrayList<Tiporelacionamento>();
			
			while (res.next()) {
				Tiporelacionamento t = new Tiporelacionamento();
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.nome = res.getString("nome");
				 t.traducao = res.getString("traducao");
				 t.extra_id = res.getString("extra_id");
				 t.hierarquia = res.getString("hierarquia");
				 
				 tps.add(t);
			 }
			 
			return tps;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}

}
