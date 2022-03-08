package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import connection.DbConnection;
import util.Time;

public class Texto {

	public int id;
	public int projeto_id;
	public int aprovador_id;
	public String texto;
	public String status;
	//TODO: Cria problemas quando a data está 0000-00-00 no banco
	//java.sql.SQLException: Value '11û-Este nÃ£o Ã© um teste legal. Outra sentenÃ§a.I0000-00-00 00:00:00' can not be represented as java.sql.Timestamp
	public Timestamp dataatualizacao;

	public Texto(){
	}
	
	public Texto(String texto){
		this.texto = texto;
	}
	
	//Insere um único texto
	public boolean insert(int projeto_id){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO textos (projeto_id, texto, status, dataatualizacao) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, projeto_id);
			ps.setString(2, this.texto);
			ps.setString(3, TextoStatus.REVISAO);
			ps.setTimestamp(4, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
			
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
	
	
	//Insere um ArrayList de textos na tabela do BD
	public static boolean insertXLSTexts(ArrayList<String> t, int projeto_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO textos (projeto_id, texto, status, dataatualizacao) VALUES (?, ?, ?, ?)");
			for(String texto: t){
				ps.setInt(1, projeto_id); //TODO: projeto id
				ps.setString(2, texto);
				ps.setString(3, TextoStatus.REVISAO);
				ps.setTimestamp(4, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
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
	
	//Retorna lista de objetos do tipo Texto selecionados pelo id do Projeto
	public static ArrayList<Texto> findByProjeto_id(int project_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM textos WHERE projeto_id = ?");
			ps.setInt(1, project_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Texto> textos = new ArrayList<Texto>();
			
			while (res.next()) {
				 Texto t = new Texto();
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.aprovador_id = res.getInt("aprovador_id");
				 t.texto = res.getString("texto");
				 t.dataatualizacao = res.getTimestamp("dataatualizacao");
				 t.status = res.getString("status");
				 
				 textos.add(t);
			 }
			 
			return textos;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
	//Retorna lista de objetos do tipo Texto alocados para o id do usuário
	//FIXME: Alterei os métodos que filtram os textos por usuário alocado para mostrarem o status o texto referente ao Usuário
		public static ArrayList<Texto> findByProjeto_idAndUser_id(int project_id, int user_id){
			
			try {
				
				PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT textos.*, alocacaotexto.status as user_status FROM alocacaotexto INNER JOIN textos ON (alocacaotexto.texto_id = textos.id)  WHERE textos.projeto_id = ? AND alocacaotexto.usuario_id = ?");
				ps.setInt(1, project_id);
				ps.setInt(2, user_id);
				ResultSet res = ps.executeQuery();
				
				ArrayList<Texto> textos = new ArrayList<Texto>();
				
				while (res.next()) {
					 Texto t = new Texto();
					 t.id = res.getInt("id");
					 t.projeto_id = res.getInt("projeto_id");
					 t.aprovador_id = res.getInt("aprovador_id");
					 t.texto = res.getString("texto");
					 t.dataatualizacao = res.getTimestamp("dataatualizacao");
					 t.status = res.getString("user_status");
					 
					 textos.add(t);
				 }
				 
				return textos;
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
			
			return null;
		}
		
	
		//Retorna lista de objetos do tipo Texto alocados para o id do usuário com certo status
				public static ArrayList<Texto> findByProjeto_idAndUser_id(int project_id, int user_id, String status){
					
					try {
						
						PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT textos.*, alocacaotexto.status as user_status FROM alocacaotexto INNER JOIN textos ON (alocacaotexto.texto_id = textos.id)  WHERE textos.projeto_id = ? AND alocacaotexto.usuario_id = ? AND alocacaotexto.status = ?");
						ps.setInt(1, project_id);
						ps.setInt(2, user_id);
						ps.setString(3, status);
						ResultSet res = ps.executeQuery();
						
						ArrayList<Texto> textos = new ArrayList<Texto>();
						
						while (res.next()) {
							 Texto t = new Texto();
							 t.id = res.getInt("id");
							 t.projeto_id = res.getInt("projeto_id");
							 t.aprovador_id = res.getInt("aprovador_id");
							 t.texto = res.getString("texto");
							 t.dataatualizacao = res.getTimestamp("dataatualizacao");
							 t.status = res.getString("user_status");
							 
							 textos.add(t);
						 }
						 
						return textos;
					
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			        
					
					return null;
				}
		
	public static Texto findById(int text_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM textos WHERE id = ?");
			ps.setInt(1, text_id); 
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				 Texto t = new Texto();
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.aprovador_id = res.getInt("aprovador_id");
				 t.texto = res.getString("texto");
				 t.status = res.getString("status");
				 t.dataatualizacao = res.getTimestamp("dataatualizacao");
				 
				 return t;
				
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
	//Mesme que o método findByID, porém retorna o objeto Texto com o status referente ao usuário passado, contido na tabela alocacaotexto
	public static Texto findByIdAndUser(int text_id, int user_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT textos.*, alocacaotexto.status as user_status FROM alocacaotexto INNER JOIN textos ON (alocacaotexto.texto_id = textos.id)  WHERE alocacaotexto.texto_id = ? AND alocacaotexto.usuario_id = ?");
			ps.setInt(1, text_id);
			ps.setInt(2, user_id); 
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				 Texto t = new Texto();
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.aprovador_id = res.getInt("aprovador_id");
				 t.texto = res.getString("texto");
				 t.status = res.getString("user_status");
				 t.dataatualizacao = res.getTimestamp("dataatualizacao");
				 
				 return t;
				
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
	public static int findNextId(int current_id, int projeto_id){
		
		try {		
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT id FROM textos WHERE id = (SELECT MIN(id) FROM textos WHERE id > ? and projeto_id = ?)");
			ps.setInt(1, current_id); //TODO: Get from SESSION
			ps.setInt(2, projeto_id); 
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				 return res.getInt("id");
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public static int findPreviousId(int current_id, int projeto_id){
		
		try {		
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT id FROM textos WHERE id = (SELECT MAX(id) FROM textos WHERE id < ? and projeto_id = ?)");
			ps.setInt(1, current_id); //TODO: Get from SESSION
			ps.setInt(2, projeto_id); 
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				 return res.getInt("id");
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public static HashMap<String, Integer> findByStatisticsByProject(int project_id){
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		Integer n;
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT status, COUNT(id) as qtde FROM textos WHERE projeto_id = ? GROUP BY status");
			ps.setInt(1, project_id); 
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				int qtde = res.getInt("qtde");
				 if(res.getString("status").equalsIgnoreCase(TextoStatus.REVISAO)){
				    	map.put(TextoStatus.REVISAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.ANOTACAO)){
				    	map.put(TextoStatus.ANOTACAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.ADJUDICACAO)){
				    	map.put(TextoStatus.ADJUDICACAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.FINALIZADO)){
				    	map.put(TextoStatus.FINALIZADO, qtde);
				 }
				 
				//Get MAP for ALL texts
			    n = map.get("TODOS");
			    //IF not exists, set 1 as value, otherwise sum with the actual value
			    n = (n == null) ? qtde : n + qtde;
		    	//Set the new value to the map
		    	map.put("TODOS", n);
				
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return map;
	}
	
	//Modificado para pegar o status do texto para cada usuário
	public static HashMap<String, Integer> findByStatisticsByProjectAndUser(int project_id, int user_id){
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		Integer n;
		try {
			//Usa alocacaotextos para pegar as estatisticas por cada usuário
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT alocacaotexto.status, COUNT(t.id) as qtde FROM textos as t JOIN alocacaotexto ON (t.id = alocacaotexto.texto_id) WHERE t.projeto_id = ? AND alocacaotexto.usuario_id = ? GROUP BY alocacaotexto.status");
			ps.setInt(1, project_id);
			ps.setInt(2, user_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				int qtde = res.getInt("qtde");
				 if(res.getString("status").equalsIgnoreCase(TextoStatus.REVISAO)){
				    	map.put(TextoStatus.REVISAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.ANOTACAO)){
				    	map.put(TextoStatus.ANOTACAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.ADJUDICACAO)){
				    	map.put(TextoStatus.ADJUDICACAO, qtde);
				 }
				 else if(res.getString("status").equalsIgnoreCase(TextoStatus.FINALIZADO)){
				    	map.put(TextoStatus.FINALIZADO, qtde);
				 }
				 
				//Get MAP for ALL texts
			    n = map.get("TODOS");
			    //IF not exists, set 1 as value, otherwise sum with the actual value
			    n = (n == null) ? qtde : n + qtde;
		    	//Set the new value to the map
		    	map.put("TODOS", n);
				
			 }
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return map;
	}
	
	
	public boolean updateTextAndStatus(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE textos SET texto = ?, status = ?, dataatualizacao = ?, aprovador_id = ? WHERE id = ?");
			ps.setString(1, this.texto);
			ps.setString(2, this.status);
			ps.setTimestamp(3, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
			ps.setInt(4, this.aprovador_id);
			ps.setInt(5, this.id);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			
		}
		
		return false;
		
	}
	
	public static boolean updateStatus(int id, String status){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE textos SET status = ?, dataatualizacao = ? WHERE id = ?");
			ps.setString(1, status);
			ps.setTimestamp(2, Time.getCurrentTimeStamp()); //Usado para gerar o DateTime do mysql
			ps.setInt(3, id);
			
			ps.executeUpdate();
			
			return true;
		}
		catch (SQLException e){
			System.out.println("Erro inserir no BD");
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * Busca todos textos que tenham adjudicação de relacionamentos associada
	 *
	 * @param projeto_id
	 * @return
	 */
	public static ArrayList<Integer> findAllTextsWithRelationAdjudicationByProject(int projeto_id){
		
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	t.id as texto_id, COUNT(t.id) as qtdeAdjudicacoesRelacionamentos\r\n" + 
					"FROM\r\n" + 
					"	textos t\r\n" + 
					"INNER JOIN sentencas s ON (s.texto_id = t.id)\r\n" + 
					"INNER JOIN tokens tk ON (tk.sentenca_id = s.id)\r\n" + 
					"INNER JOIN relacionamentos r ON (SUBSTRING_INDEX(r.tokens1,',',1) = tk.id AND adjudicador = 1)\r\n" + 
					"WHERE\r\n" + 
					"	t.projeto_id = ?\r\n" + 
					"GROUP BY\r\n" + 
					"	t.id");
			ps.setInt(1, projeto_id); 
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				list.add(res.getInt("texto_id"));
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
		
	}
	
}