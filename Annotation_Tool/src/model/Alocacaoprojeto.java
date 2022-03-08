package model;

import java.sql.Connection;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class Alocacaoprojeto {

	public static boolean alocateUserToProject(int userId, int projectId){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO alocacaoprojeto (projeto_id, usuario_id) VALUES (?,?)");
			ps.setInt(1,projectId);
			ps.setInt(2,userId);
			return ps.execute();
			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}			
	}	

	public static boolean alocateUsersToProject(int[] userIds, int projectId){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			for(int i = 0; i < userIds.length; i++){
				PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO alocacaoprojeto (projeto_id, usuario_id) VALUES (?,?)");
				ps.setInt(1,projectId);
				ps.setInt(2,userIds[i]);
				boolean erro = ps.execute();
				if(erro)
					return true;
			}			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return true;
		}
		return false;
	}	
	
}
