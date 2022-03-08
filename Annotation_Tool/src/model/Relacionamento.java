package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;
import util.Time;

public class Relacionamento {

	public int id;
	public String tokens1;
	public String tokens2;
	public int tiporelacionamento_id;
	public int anotador_id;
	public Timestamp dataanotacao;
	public int adjudicador = 0;
	
	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO relacionamentos (tokens1, tokens2, tiporelacionamento_id, anotador_id, dataanotacao, adjudicador) VALUES (?, ?, ?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setString(1, this.tokens1);
			ps.setString(2, this.tokens2);
			ps.setInt(3,this.tiporelacionamento_id);
			ps.setInt(4,this.anotador_id);
			ps.setTimestamp(5, Time.getCurrentTimeStamp());
			ps.setInt(6, this.adjudicador);
			ps.executeUpdate();
			
			//Obtém PRIMARY KEYS GERADAS
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			
			//Define o ID gerado
			this.id = res.getInt(1);
			
			return true;
			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir relacionamento no BD");
			e.printStackTrace();
			return false;
		}	

	}	
	
	
	public static boolean deleteRelacionamentosByTextoIdAndUserId(int texto_id, int user_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE \r\n" + 
					"	relacionamentos \r\n" + 
					"FROM \r\n" + 
					"	relacionamentos \r\n" + 
					"INNER JOIN tokens ON (tokens.id IN (relacionamentos.tokens1)) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"WHERE \r\n" + 
					"	sentencas.texto_id = ?\r\n" + 
					"	AND\r\n" + 
					"	relacionamentos.anotador_id = ?");
			ps.setInt(1, texto_id);
			ps.setInt(2, user_id);
			ps.executeUpdate();
			
			return true;
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar relacionamento do BD");
			e.printStackTrace();
			return false;
		}
		
	}
	
	public static boolean deleteRelacionamentosAdjudicadosByTextoIdAndUserId(int texto_id, int user_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE \r\n" + 
					"	relacionamentos \r\n" + 
					"FROM \r\n" + 
					"	relacionamentos \r\n" + 
					"INNER JOIN tokens ON (tokens.id IN (relacionamentos.tokens1)) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"WHERE \r\n" + 
					"	sentencas.texto_id = ?\r\n" + 
					"	AND\r\n" + 
					"	relacionamentos.anotador_id = ? AND relacionamentos.adjudicador = 1");
			ps.setInt(1, texto_id);
			ps.setInt(2, user_id);
			ps.executeUpdate();
			
			return true;
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar relacionamento do BD");
			e.printStackTrace();
			return false;
		}
		
	}
	
	public static ArrayList<Relacionamento> findRelacionamentosByTextoIdAndAnotadorId(int texto_id, int anotador_id){
		
		ArrayList<Relacionamento> relacionamentos = new ArrayList<Relacionamento>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	relacionamentos.* \r\n" + 
					"FROM \r\n" + 
					"	relacionamentos \r\n" + 
					"INNER JOIN tokens ON (tokens.id IN (relacionamentos.tokens1)) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"WHERE \r\n" + 
					"	sentencas.texto_id = ? AND \r\n" + 
					"	relacionamentos.anotador_id = ? AND relacionamentos.adjudicador = 0\r\n" + 
					"ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, texto_id);
			ps.setInt(2, anotador_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				
				Relacionamento a = new Relacionamento();
				
				a.id = res.getInt("id");
				a.tokens1 = res.getString("tokens1");
				a.tokens2 = res.getString("tokens2");
				a.tiporelacionamento_id = res.getInt("tiporelacionamento_id");
				a.anotador_id = res.getInt("anotador_id");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				
				relacionamentos.add(a);
			 }
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return relacionamentos;
	}
		
	public static ArrayList<Relacionamento> findRelacionamentosByTextoId(int texto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	relacionamentos.* \r\n" + 
					"FROM \r\n" + 
					"	relacionamentos \r\n" + 
					"INNER JOIN tokens ON (tokens.id IN (relacionamentos.tokens1)) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"WHERE \r\n" + 
					"	sentencas.texto_id = ? \r\n" + 
					"ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Relacionamento> relacionamentos = new ArrayList<Relacionamento>();
			
			while (res.next()) {
				
				Relacionamento a = new Relacionamento();
				
				a.id = res.getInt("id");
				a.tokens1 = res.getString("tokens1");
				a.tokens2 = res.getString("tokens2");
				a.tiporelacionamento_id = res.getInt("tiporelacionamento_id");
				a.anotador_id = res.getInt("anotador_id");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				
				relacionamentos.add(a);
			 }
			 
			return relacionamentos;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    
		
		return null;
	}
	
	/**
	 * Busca relacionamentos concordantes entre dois anotadores
	 * @param texto_id
	 * @param annotators
	 * @return
	 */
	public static ArrayList<RelacionamentoCompleto> findRelacionamentosConcordantesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators, ArrayList<Token> tokens){
	
		ArrayList<RelacionamentoCompleto> relacionamentos = new ArrayList<RelacionamentoCompleto>();
		int minToken = 0, maxToken = 0;
		PreparedStatement ps1;
		try {
			//Obtém intervalo de valores dos tokens do texto atual
			ps1 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	MIN(t.id) minToken, MAX(t.id) maxToken\r\n" + 
					"FROM\r\n" + 
					"	tokens t\r\n" + 
					"INNER JOIN sentencas s ON (t.sentenca_id = s.id)\r\n" + 
					"WHERE\r\n" + 
					"	s.texto_id = ?");
			
			ps1.setInt(1, texto_id);
			ResultSet rs1 = ps1.executeQuery();
			
			if (rs1.next()) {
				minToken = rs1.getInt("minToken");
				maxToken = rs1.getInt("maxToken");
			}
			rs1.close();
			ps1.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//TODO: Fazer funcionar para mais de dois anotadores
		//Neste caso montar dinamicamente os INNER JOIN na tabela relacionamentos (a2, a3, etc.) e SELECTs
		PreparedStatement ps2;
		try {
			ps2 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	r1.tokens1, r1.tokens2, r1.tiporelacionamento_id, tr.nome\r\n" + 
					"FROM \r\n" + 
					"	relacionamentos r1\r\n" + 
					"INNER JOIN relacionamentos r2 ON (r1.tokens1 = r2.tokens1 AND r1.tokens2 = r2.tokens2 AND r1.tiporelacionamento_id = r2.tiporelacionamento_id AND r1.anotador_id != r2.anotador_id AND r2.adjudicador = 0)\r\n" +
					"INNER JOIN tiposrelacionamentos tr ON (r1.tiporelacionamento_id = tr.id)" + 
					"WHERE\r\n" + 
					"	r1.adjudicador = 0 AND r1.anotador_id = ?  AND (SUBSTRING_INDEX(r1.tokens1,',',1) >= ? AND SUBSTRING_INDEX(r1.tokens1,',',1) <= ?)" +
					"ORDER BY " +
					"   r1.id");
			
			/*
			 * Caso o campo tokens1 tenha o valor 100,101,102
			 * SUBSTRING_INDEX(r1.tokens1,',',1) retorna 100
			 * Ou seja, pegamos o primeiro token definido no campo e verificamos se está no intervalo de tokens do texto atual
			 */
			
			ps2.setInt(1, annotators.get(0).id);//Define primeiro anotador como base para a pesqusia
			ps2.setInt(2, minToken);
			ps2.setInt(3, maxToken);
			ResultSet rs2 = ps2.executeQuery();
			
			while (rs2.next()) {
				
				RelacionamentoCompleto rc = new RelacionamentoCompleto();
				
				rc.tokens1 = rs2.getString("tokens1");
				rc.tokens2 = rs2.getString("tokens2");
				rc.tiporelacionamento_id = rs2.getInt("tiporelacionamento_id");
				rc.relacionamento_name = rs2.getString("nome");
				
				//Adiciona relacionamento
				relacionamentos.add(rc);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		for(RelacionamentoCompleto rc : relacionamentos){
			String[] tokens1 = rc.tokens1.split(",");
			String[] tokens2 = rc.tokens2.split(",");
			
			//Percorre tokens1
			for(String token_id : tokens1){
				for(Token t : tokens){
					if(t.id == Integer.parseInt(token_id)){
						rc.tokens1List.add(t);
					}
				}
			}
			
			//Percorre tokens2
			for(String token_id : tokens2){
				for(Token t : tokens){
					if(t.id == Integer.parseInt(token_id)){
						rc.tokens2List.add(t);
					}
				}
			}
			
			/*try{
				//Percorre tokens1
				for(String token_id : tokens1){
				
					PreparedStatement ps3 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tokens WHERE id = ?");
					ps3.setInt(1, Integer.parseInt(token_id));
					ResultSet rs3 = ps3.executeQuery();
					if (rs3.next()) {
						 Token tk = new Token();
						 tk.id = rs3.getInt("id");
						 tk.sentenca_id = rs3.getInt("sentenca_id");
						 tk.ordem = rs3.getInt("ordem");
						 tk.token = rs3.getString("token");
						 tk.status = rs3.getString("status");
						 
						 rc.tokens1List.add(tk);
					}
					rs3.close();
					ps3.close();
				
				}
				
				//Percorre tokens2
				for(String token_id : tokens2){
				
					PreparedStatement ps4 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tokens WHERE id = ?");
					ps4.setInt(1, Integer.parseInt(token_id));
					ResultSet rs4 = ps4.executeQuery();
					if (rs4.next()) {
						 Token tk = new Token();
						 tk.id = rs4.getInt("id");
						 tk.sentenca_id = rs4.getInt("sentenca_id");
						 tk.ordem = rs4.getInt("ordem");
						 tk.token = rs4.getString("token");
						 tk.status = rs4.getString("status");
						 
						 rc.tokens2List.add(tk);
					}
					rs4.close();
					ps4.close();
				
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
			
			
		}
			
		return relacionamentos;
		
	}
	
	/**
	 * Busca relacionamentos discordantes entre dois anotadores
	 * @param texto_id
	 * @param annotators
	 * @return
	 */
	public static ArrayList<RelacionamentoCompleto> findRelacionamentosDiscordantesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators, ArrayList<Token> tokens){
	
		ArrayList<RelacionamentoCompleto> relacionamentos = new ArrayList<RelacionamentoCompleto>();
		int minToken = 0, maxToken = 0;
		PreparedStatement ps1;
		try {
			//Obtém intervalo de valores dos tokens do texto atual
			ps1 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	MIN(t.id) minToken, MAX(t.id) maxToken\r\n" + 
					"FROM\r\n" + 
					"	tokens t\r\n" + 
					"INNER JOIN sentencas s ON (t.sentenca_id = s.id)\r\n" + 
					"WHERE\r\n" + 
					"	s.texto_id = ?");
			
			ps1.setInt(1, texto_id);
			ResultSet rs1 = ps1.executeQuery();
			
			if (rs1.next()) {
				minToken = rs1.getInt("minToken");
				maxToken = rs1.getInt("maxToken");
			}
			rs1.close();
			ps1.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//TODO: Fazer funcionar para mais de dois anotadores
		//Neste caso montar dinamicamente os INNER JOIN na tabela relacionamentos (a2, a3, etc.) e SELECTs
		PreparedStatement ps2;
		try {
			ps2 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	re.tokens1, re.tokens2, re.tiporelacionamento_id, tr.nome, u.nome as anotador_name\r\n" + 
					"FROM\r\n" + 
					"	relacionamentos re\r\n" + 
					"INNER JOIN tiposrelacionamentos tr ON (re.tiporelacionamento_id = tr.id)\r\n"+
					"INNER JOIN usuarios u ON (re.anotador_id = u.id)" + 
					"WHERE\r\n" + 
					"	re.adjudicador = 0 AND (re.anotador_id = ? OR re.anotador_id = ?) AND (SUBSTRING_INDEX(re.tokens1,',',1) >= ? AND SUBSTRING_INDEX(re.tokens1,',',1) <= ?)\r\n" + 
					"	AND re.id NOT IN (\r\n" + 
					"		SELECT\r\n" + 
					"			r1.id\r\n" + 
					"		FROM \r\n" + 
					"			relacionamentos r1\r\n" + 
					"		INNER JOIN relacionamentos r2 ON (r1.tokens1 = r2.tokens1 AND r1.tokens2 = r2.tokens2 AND r1.tiporelacionamento_id = r2.tiporelacionamento_id AND r1.anotador_id != r2.anotador_id AND r2.adjudicador = 0)\r\n" + 
					"		WHERE\r\n" + 
					"			r1.adjudicador = 0 AND (r1.anotador_id = ? OR r1.anotador_id = ?) AND (SUBSTRING_INDEX(r1.tokens1,',',1) >= ? AND SUBSTRING_INDEX(r1.tokens1,',',1) <= ?)		\r\n" + 
					"	)\r\n" + 
					"ORDER BY " +
					"   re.id");
			
			/*
			 * Caso o campo tokens1 tenha o valor 100,101,102
			 * SUBSTRING_INDEX(r1.tokens1,',',1) retorna 100
			 * Ou seja, pegamos o primeiro token definido no campo e verificamos se está no intervalo de tokens do texto atual
			 */
			
			/*
			 * A subquery busca os relacionamentos CONCORDANTES, portanto busco os relacionamentos que nao estejam no conjunto dos concordantes
			 */
			
			ps2.setInt(1, annotators.get(0).id);
			ps2.setInt(2, annotators.get(1).id);
			ps2.setInt(3, minToken);
			ps2.setInt(4, maxToken);
			ps2.setInt(5, annotators.get(0).id);
			ps2.setInt(6, annotators.get(1).id);
			ps2.setInt(7, minToken);
			ps2.setInt(8, maxToken);
			ResultSet rs2 = ps2.executeQuery();
			
			while (rs2.next()) {
				
				RelacionamentoCompleto rc = new RelacionamentoCompleto();
				
				rc.tokens1 = rs2.getString("tokens1");
				rc.tokens2 = rs2.getString("tokens2");
				rc.tiporelacionamento_id = rs2.getInt("tiporelacionamento_id");
				rc.relacionamento_name = rs2.getString("nome");
				rc.anotador_name = rs2.getString("anotador_name");
				
				//Adiciona relacionamento
				relacionamentos.add(rc);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		for(RelacionamentoCompleto rc : relacionamentos){
			String[] tokens1 = rc.tokens1.split(",");
			String[] tokens2 = rc.tokens2.split(",");
			
			//Percorre tokens1
			for(String token_id : tokens1){
				for(Token t : tokens){
					if(t.id == Integer.parseInt(token_id)){
						rc.tokens1List.add(t);
						rc.termo1 += t.token + " ";
					}
				}
			}
			
			//Percorre tokens2
			for(String token_id : tokens2){
				for(Token t : tokens){
					if(t.id == Integer.parseInt(token_id)){
						rc.tokens2List.add(t);
						rc.termo2 += t.token + " ";
					}
				}
			}
			
			/*try{
				//Percorre tokens1
				for(String token_id : tokens1){
				
					PreparedStatement ps3 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tokens WHERE id = ?");
					ps3.setInt(1, Integer.parseInt(token_id));
					ResultSet rs3 = ps3.executeQuery();
					if (rs3.next()) {
						 Token tk = new Token();
						 tk.id = rs3.getInt("id");
						 tk.sentenca_id = rs3.getInt("sentenca_id");
						 tk.ordem = rs3.getInt("ordem");
						 tk.token = rs3.getString("token");
						 tk.status = rs3.getString("status");
						 
						 rc.tokens1List.add(tk);
						 
						 rc.termo1 += tk.token + " ";
					}
					rs3.close();
					ps3.close();
				
				}
				
				//Percorre tokens2
				for(String token_id : tokens2){
				
					PreparedStatement ps4 = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tokens WHERE id = ?");
					ps4.setInt(1, Integer.parseInt(token_id));
					ResultSet rs4 = ps4.executeQuery();
					if (rs4.next()) {
						 Token tk = new Token();
						 tk.id = rs4.getInt("id");
						 tk.sentenca_id = rs4.getInt("sentenca_id");
						 tk.ordem = rs4.getInt("ordem");
						 tk.token = rs4.getString("token");
						 tk.status = rs4.getString("status");
						 
						 rc.tokens2List.add(tk);
						 
						 
					}
					rs4.close();
					ps4.close();
				
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
			
			
		}
			
		return relacionamentos;
		
	}
		
}