package model;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class Permissao {
	
	//FIXME: Não deixar esses valores fixos
	// Fazer isso aqui mesmo?
	public static final int NENHUMA = 0;
	public static final int REVISOR = 1;
	public static final int ANOTADOR = 2;
	public static final int ADJUDICADOR = 4;
	public static final int ADMINISTRADOR = 8;
	
	public static int findPermissionByPage(String pagina){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM permissoes WHERE pagina = ?");
			ps.setString(1, pagina);
			ResultSet res = ps.executeQuery();
			
			if(res.next())
				return res.getInt("permissao");
		}
		
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1;
}
	
	public static int getAllPrivilegesNumber(){
		return REVISOR + ANOTADOR + ADJUDICADOR + ADMINISTRADOR;
	}
	
	public static boolean isAdmin(Usuario u){
		//Se for apenas ADMIN ou for ADMIN+outro perfil
		if(Integer.compare(u.permissao, ADMINISTRADOR) >= 0)
			return true;
		
		return false;
	}
	
	public static boolean isOnlyAdmin(Usuario u){
		//Se for apenas ADMIN
		if(Integer.compare(u.permissao, ADMINISTRADOR) == 0)
			return true;
		
		return false;
	}
	
	public static boolean isRevisor(Usuario u){
		//Se permissão for ímpar - Tem perfil de Revisor(1) atrelado
		if(Integer.compare(u.permissao, REVISOR) == 0 || u.permissao % 2 != 0)
			return true;
		
		return false;
	}
	
	public static boolean isAnotador(Usuario u){
		
		if(Integer.compare(u.permissao, ANOTADOR) == 0)
			return true;
		
		return false;
	}
	
	public static boolean isAdjudicador(Usuario u){
		
		if(Integer.compare(u.permissao, ADJUDICADOR) == 0 || u.permissao == 5 || u.permissao == 6 || u.permissao == 7 || u.permissao == 12)
			return true;
		
		return false;
	}
	
}