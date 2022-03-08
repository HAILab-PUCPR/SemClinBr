package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import connection.DbConnection;
import util.Time;

public class Alocacaotexto {
	
	public int projeto_id;
	public int usuario_id;
	public int texto_id;

	public static boolean alocateUsersToText(int[] userIds, int textId, String status){
		//Limpa as alocações antes de inserir as novas
		deleteAlocation(textId);
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO alocacaotexto (texto_id, usuario_id, dataatualizacao, status) VALUES (?,?,?,?)");
			for(int i = 0; i < userIds.length; i++){
				ps.setInt(1, textId);
				ps.setInt(2,userIds[i]);
				ps.setTimestamp(3, Time.getCurrentTimeStamp());
				ps.setString(4, status);
				ps.execute();
				
			}
		}
		catch (SQLException e){
			System.out.println("Erro alocar usuários ao texto");
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public static boolean deleteAlocation(int textId){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE FROM alocacaotexto WHERE texto_id = ?");
			ps.setInt(1, textId);
			return ps.execute();
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar alocação de texto para usuário");
			e.printStackTrace();
			return true;
		}			
	}

	public static boolean updateStatus(int user_id, int text_id, String status){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE alocacaotexto SET status = ?, dataatualizacao = ? WHERE usuario_id = ? AND texto_id = ?");
			ps.setString(1, status);
			ps.setTimestamp(2, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
			ps.setInt(3, user_id);
			ps.setInt(4, text_id);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (SQLException e){
			System.out.println("Erro ao atualizar status do texto " + text_id + " para usuario " + user_id);
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean updateStatus(int text_id, String status){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE alocacaotexto SET status = ?, dataatualizacao = ? WHERE texto_id = ?");
			ps.setString(1, status);
			ps.setTimestamp(2, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
			ps.setInt(3, text_id);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (SQLException e){
			System.out.println("Erro ao atualizar status do texto " + text_id);
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * Obtém as relações de alocação entre usuários(anotadores) e textos
	 * @param projeto_id
	 * @return
	 */
	public static HashMap<Integer, ArrayList<String>> findAllTextUsersAlocationByProject(int projeto_id){
		
		//Obtém ID de todos textos do projeto
		String textos_id = "";
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT id FROM textos " + 
					"WHERE\r\n" + 
					"	projeto_id = ?");
			ps.setInt(1, projeto_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				
				textos_id += res.getInt("id") + ","; 
				
			}
			//Retura ultima virgula
			textos_id = textos_id.substring(0, textos_id.length() - 1);
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//Obtém permissões dos textos do projeto apenas
		ArrayList<String> list;
		HashMap<Integer, ArrayList<String>> map = new HashMap<Integer, ArrayList<String>>();
		try {
			
			Statement s = (Statement) DbConnection.getInstance().getConnection().createStatement();
			ResultSet res = s.executeQuery("SELECT\r\n" + 
					"	at.texto_id, u.nome\r\n" + 
					"FROM\r\n" + 
					"	alocacaotexto at\r\n" + 
					"INNER JOIN usuarios u ON (at.usuario_id = u.id)\r\n" + 
					"WHERE\r\n" + 
					"	texto_id IN ("+textos_id+")");
			
			while (res.next()) {
				
				list = map.get(res.getInt("texto_id"));//Obtém lista de usuarios para o texto_id (se existir)
		    	//Se não existir lista de usuarios para o texto_id
				if(list == null){
					list = new ArrayList<String>();//Cria lista
		    	}
				list.add(res.getString("nome"));//Adiciona usuario atual a lista
		    	//Armazena nova lista no MAP
		    	map.put(res.getInt("texto_id"), list);
				
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
		
	}
}
