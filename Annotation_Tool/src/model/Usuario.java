package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import connection.DbConnection;
import util.Time;

public class Usuario {

	public int id;
	public String nome;
	public String email;
	public String senha;
	public int permissao;
	public Timestamp ultimo_acesso;
	
	public Usuario(){}
	
	public Usuario(int id, String nome, String email, String senha, int permissao, Timestamp ultimo_acesso){
		this.id = id;
		this.nome = nome;
		this.email = email;
		this.senha = senha;
		this.permissao = permissao;
		this.ultimo_acesso = ultimo_acesso;
	}
	
	public Usuario(String nome, String email, String senha, int permissao){
		this.nome = nome;
		this.email = email;
		this.senha = senha;
		this.permissao = permissao;
	}
	
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO usuarios (nome, email, senha, permissao) VALUES (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, this.nome);
			ps.setString(2, this.email);
			ps.setString(3, this.senha);
			ps.setInt(4, this.permissao);
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
	
	public boolean update(){
	//TODO
		
		return false;
	}
	
	public boolean delete(){
	//TODO	
		
		return false;
	}
	
	
	public boolean findById(int id){
	//TODO	
		
		return false;
	}
	
	public static ArrayList<Usuario> findAll(){
		
		try {
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM usuarios");
			ResultSet res = ps.executeQuery();
			
			ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
			
			while (res.next()) 
				 usuarios.add(new Usuario(res.getInt("id"), 
				 						  res.getString("nome"), 
				 						  res.getString("email"), 
				 						  res.getString("senha"), 
				 						  res.getInt("permissao"),
				 						  res.getTimestamp("ultimo_acesso")));
			return usuarios;
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
      
		return null;
	}
	
	
	public Usuario findByLoginAndSenha(String login, String senha){
		
		PreparedStatement ps;
		try {
			ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM usuarios WHERE email = ? AND senha = ?");
			ps.setString(1, login);
	        ps.setString(2, senha);
			ResultSet res = ps.executeQuery();
			
			 if (res.next()) {
				 this.id = res.getInt("id");
				 this.nome = res.getString("nome");
				 this.email = res.getString("email");
				 this.senha = res.getString("senha");
				 this.permissao = res.getInt("permissao");
				 this.ultimo_acesso = res.getTimestamp("ultimo_acesso");
				 
				return this; 
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Erro na conexão com o BD (provavelmente)");
		}
        
		return null;
	}
	
	public static ArrayList<Usuario> findByProject(int projeto_id){
		
		PreparedStatement ps;
		try {
			ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT u.* FROM usuarios AS u INNER JOIN alocacaoprojeto AS a ON u.id = a.usuario_id WHERE a.projeto_id = ?");
	        ps.setInt(1, projeto_id);
			ResultSet res = ps.executeQuery();
			
	        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
	        
			 while (res.next()) {
				 Usuario u = new Usuario();
				 u.id = res.getInt("id");
				 u.nome = res.getString("nome");
				 u.email = res.getString("email");
				 u.senha = res.getString("senha");
				 u.permissao = res.getInt("permissao");
				 u.ultimo_acesso = res.getTimestamp("ultimo_acesso");
				 
				usuarios.add(u); 
			 }
			 return usuarios;
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		return null;
	}
	
	public static ArrayList<Usuario> findByPerfilAndProject(int permissao, int projeto_id){
		
		PreparedStatement ps;
		try {
			ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT u.* FROM usuarios AS u INNER JOIN alocacaoprojeto AS a ON u.id = a.usuario_id WHERE (u.permissao & ?) = ? AND a.projeto_id = ?");
			ps.setInt(1, permissao);
			ps.setInt(2, permissao);
			ps.setInt(3, projeto_id);
	        ResultSet res = ps.executeQuery();
			
	        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
	        
			 while (res.next()) {
				 Usuario u = new Usuario();
				 u.id = res.getInt("id");
				 u.nome = res.getString("nome");
				 u.email = res.getString("email");
				 u.senha = res.getString("senha");
				 u.permissao = res.getInt("permissao");
				 u.ultimo_acesso = res.getTimestamp("ultimo_acesso");
				 
				usuarios.add(u); 
			 }
			 return usuarios;
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		return null;
	}
	
	public boolean updateLastAcess(){
		this.ultimo_acesso = Time.getCurrentTimeStamp();
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE usuarios SET ultimo_acesso = ? WHERE id = ?");		
			ps.setTimestamp(1, this.ultimo_acesso);
			ps.setInt(2, this.id);
			ps.executeUpdate();
			return false;
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}	
	}	
}
