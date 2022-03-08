package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class Acronimo {

	public int id;
	public String acronimo;
	public String expansao;
	
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO acronimos (acronimo, expansao) VALUES (?, ?)");
			ps.setString(1, this.acronimo);
			ps.setString(2, this.expansao);
			
			return ps.execute();
			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}	
	}	
	
	//Retorna lista de acronimos
	public static ArrayList<Acronimo> select(){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM acronimos");
			ResultSet res = ps.executeQuery();
			
			ArrayList<Acronimo> acronimos = new ArrayList<Acronimo>();
			
			while (res.next()) {
				 Acronimo a = new Acronimo();
				 a.id = res.getInt("id");
				 a.acronimo = res.getString("acronimo");
				 a.expansao= res.getString("expansao");
				 
				 acronimos.add(a);
			 }
			 
			return acronimos;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
}
