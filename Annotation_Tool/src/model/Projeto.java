package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import connection.DbConnection;

public class Projeto {
	
	public int id;
	public String nome;

	public Projeto(int id, String nome){
		this.id = id;
		this.nome = nome;
	}
	
	public Projeto (String nome){
		this.nome = nome;
	}
	
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO projetos (nome) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, this.nome);
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
	
	public static ArrayList<Projeto> findAll(){
		
		try {
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM projetos");
			ResultSet res = ps.executeQuery();
			
			ArrayList<Projeto> projetos = new ArrayList<Projeto>();
			
			while (res.next()) 
				 projetos.add(new Projeto(res.getInt("id"), res.getString("nome")));
			 
			return projetos;
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
      
		return null;
	}

}
