package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Pattern;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;
import util.Time;

public class Anotacao {

	public int id;
	public Integer tag_id;
	public int token_id;
	public int anotador_id;
	public String termocomposto_id;
	public String status;
	public boolean adjudicador;
	public Timestamp dataanotacao;
	public String abreviatura;
	public String umlscui;
	public String snomedctid;
	

	//public Date dataanotacao;
	//Ver qual dos dois é melhor usar

	public Anotacao(int tag_id, int token_id, int anotador_id){
		this.tag_id = tag_id;
		this.token_id = token_id;
		this.anotador_id = anotador_id;
		this.termocomposto_id = null;
	}

	public Anotacao() {
		// TODO Auto-generated constructor stub
	}

	public boolean insert(){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO anotacoes (tag_id, token_id, anotador_id, termocomposto_id, status, adjudicador, dataanotacao, abreviatura,umlscui,snomedctid) VALUES (?, ?, ?, ?, ?, ? ,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
			ps.setInt(1, this.tag_id);
			ps.setInt(2, this.token_id);
			ps.setInt(3,this.anotador_id);
			ps.setString(4, this.termocomposto_id);
			ps.setString(5,this.status);
			ps.setBoolean(6,this.adjudicador);
			ps.setTimestamp(7, Time.getCurrentTimeStamp());
			ps.setString(8, this.abreviatura);
			ps.setString(9, this.umlscui);
			ps.setString(10, this.snomedctid);
			ps.executeUpdate();
			
			//Obtém PRIMARY KEYS GERADAS
			ResultSet res = ps.getGeneratedKeys();
			res.next();
			
			//Define o ID gerado
			this.id = res.getInt(1);
			
			return true;
			
		}
		
		catch (SQLException e){
			System.out.println("Erro inserir anotação no BD");
			e.printStackTrace();
			return false;
		}	

	}	
	
	public static boolean deleteAnotacoesByTextoId(int texto_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE anotacoes FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE adjudicador = 0 AND sentencas.texto_id = ?");
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
	
	public static boolean deleteAnotacoesByTextoIdAndUserId(int texto_id, int usuario_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE anotacoes FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE adjudicador = 0 AND sentencas.texto_id = ? AND anotador_id = ?");
			ps.setInt(1, texto_id);
			ps.setInt(2, usuario_id);
			ps.executeUpdate();
			
			return true;
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar do BD");
			e.printStackTrace();
			return true;
		}
	}
	
	
	public static ArrayList<Anotacao> findAnotacoesByTextoIdAndAnotadorId(int texto_id, int anotador_id){
		
		ArrayList<Anotacao> anotacoes = new ArrayList<Anotacao>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT anotacoes.* FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE adjudicador = 0 AND sentencas.texto_id = ? AND anotacoes.anotador_id = ? ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, texto_id);
			ps.setInt(2, anotador_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				Anotacao a = new Anotacao();
				a.id = res.getInt("id");
				a.tag_id = res.getInt("tag_id");
				a.token_id = res.getInt("token_id");
				a.anotador_id = res.getInt("anotador_id");
				a.termocomposto_id = res.getString("termocomposto_id");
				a.status = res.getString("status");
				a.adjudicador = res.getBoolean("adjudicador");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				a.abreviatura = res.getString("abreviatura");
				a.umlscui = res.getString("umlscui");
				a.snomedctid = res.getString("snomedctid");
				
				anotacoes.add(a);
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return anotacoes;
	}
	
	/**
	 * Busca estatísticas dos TOKENS individualmente (não considera termos compostos)
	 * @param tokens
	 * @return
	 */
	public static ArrayList<TokenStats> findTokensStatistics(ArrayList<Token> tokens, int usuario_id){
		
		ArrayList<TokenStats> stats = new ArrayList<TokenStats>();

		try {
			
			String sql = "SELECT " + 
					"	tags.id, tags.tag, tags.extra_id, tags.tipo, COUNT(tags.tag) as count, sum(100) / total as percent " + 
					"FROM " + 
					"	anotacoes a " + 
					"INNER JOIN tokens t ON (a.token_id = t.id) " + 
					"INNER JOIN tags ON (a.tag_id = tags.id) " + 
					"CROSS JOIN (SELECT COUNT(tags.tag) as total FROM " + 
					"					anotacoes a " + 
					"				INNER JOIN tokens t ON (a.token_id = t.id) " + 
					"				INNER JOIN tags ON (a.tag_id = tags.id) " + 
					"				WHERE " + 
					"					adjudicador = 0 AND t.token = ? AND a.anotador_id = ?) x " + 
					"WHERE " + 
					"	t.token = ? AND a.anotador_id = ? AND a.termocomposto_id IS NULL " + 
					"GROUP BY " + 
					"	1";
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement(sql);
			//System.out.println(sql);
			
			for(Token t: tokens){
				//System.out.println(t.token);
				ps.setString(1, t.token);
				ps.setInt(2, usuario_id);
				ps.setString(3, t.token);
				ps.setInt(4, usuario_id);
				
				ResultSet res = ps.executeQuery();
				
				TokenStats ts = new TokenStats();
				ts.token = t;
				
				while (res.next()) {
					
					ts.tags.add(new Tag(res.getInt("id"), res.getString("tag"), res.getString("extra_id"), res.getString("tipo")));
					ts.percents.add(res.getDouble("percent"));
					
				}
				
				stats.add(ts);
			
			}
			
			return stats;
			
			
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stats;
		
	}

	public static ArrayList<Anotacao> findAnotacoesByTextoId(int texto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT anotacoes.* FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE adjudicador = 0 AND sentencas.texto_id = ? ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Anotacao> anotacoes = new ArrayList<Anotacao>();
			
			while (res.next()) {
				Anotacao a = new Anotacao();
				a.id = res.getInt("id");
				a.tag_id = res.getInt("tag_id");
				a.token_id = res.getInt("token_id");
				a.anotador_id = res.getInt("anotador_id");
				a.termocomposto_id = res.getString("termocomposto_id");
				a.status = res.getString("status");
				a.adjudicador = res.getBoolean("adjudicador");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				a.abreviatura = res.getString("abreviatura");
				a.umlscui = res.getString("umlscui");
				a.snomedctid = res.getString("snomedctid");
				
				anotacoes.add(a);
			 }
			 
			return anotacoes;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;

	}
	
	public static String geraTermoCompostoId(){
		try {
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT uuid()");
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getString("uuid()");
			 }
			 

			
		} catch (SQLException e){
			e.printStackTrace();
			return "error";
		}
		return null;
	}
	
	public static ArrayList<Anotacao> findAnotacoesBypProjetoIdAndAnotadorId(int projeto_id, int anotador_id){
		//TODO
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT anotacoes.* FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE adjudicador = 0 AND sentencas.texto_id = ? AND anotacoes.anotador_id = ? ORDER BY sentencas.ordem, tokens.ordem");
			ps.setInt(1, projeto_id);
			ps.setInt(2, anotador_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Anotacao> anotacoes = new ArrayList<Anotacao>();
			
			while (res.next()) {
				Anotacao a = new Anotacao();
				a.id = res.getInt("id");
				a.tag_id = res.getInt("tag_id");
				a.token_id = res.getInt("token_id");
				a.anotador_id = res.getInt("anotador_id");
				a.termocomposto_id = res.getString("termocomposto_id");
				a.status = res.getString("status");
				a.adjudicador = res.getBoolean("adjudicador");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				a.abreviatura = res.getString("abreviatura");
				a.umlscui = res.getString("umlscui");
				a.snomedctid = res.getString("snomedctid");
				
				anotacoes.add(a);
			 }
			 
			return anotacoes;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
	
	public static String getMostUsedAbbreviationFor(String abbr, int anotador_id, int projeto_id){
		
		String expandedAbbr = "";
		
		try {
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT anotacoes.abreviatura, COUNT(anotacoes.abreviatura) as qtde FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) INNER JOIN textos ON (textos.id = sentencas.texto_id) WHERE adjudicador = 0 AND textos.projeto_id = ? AND anotacoes.anotador_id = ? AND TRIM(tokens.token) = ? AND anotacoes.abreviatura IS NOT NULL AND anotacoes.abreviatura != \"\" GROUP BY anotacoes.abreviatura ORDER BY qtde DESC");
			ps.setInt(1, projeto_id);
			ps.setInt(2, anotador_id);
			ps.setString(3, abbr);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				expandedAbbr = res.getString("abreviatura");
			 }

		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return expandedAbbr;
		
	}
	
	
	/**
	 * Busca estatísticas dos TERMOS COMPOSTOS
	 * @param tokens
	 * @return
	 */
	/*public static ArrayList<TermoCompostoStats> findCompoundTermsStatistics(ArrayList<Token> tokens, int usuario_id){
		
		
		//Define SQL que Busca token atual nas estatísticas de anotação do anotador
		String sql = "SELECT " + 
					"	termocomposto_desc, length(termocomposto_desc)-length(replace(termocomposto_desc,' ',''))+1 as numTokens " + 
					"FROM " + 
					"	termoscompostos " + 
					"WHERE " + 
					"	anotador_id=? AND termocomposto_desc like ?"
					+ "GROUP BY" + 
					"	termocomposto_desc " + 
					"ORDER BY" + 
					"	numTokens";
		//Já deixa Statement preparado para reutilização durante a repetição
		PreparedStatement ps = null;
		try {
			ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement(sql);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		//Define SQL que Busca todas ocorrencias agrupadas pelas tags utilizadas (Para evitar resultset grande demais)
		sql = "SELECT " + 
				"	tags_id, COUNT(termocomposto_desc) as qtdeAnotacoes " + 
				"FROM " + 
				"	termoscompostos " + 
				"WHERE " + 
				"	anotador_id=? AND termocomposto_desc = ? "
				+ "GROUP BY" + 
				"	tags_id ";
		//Já deixa Statement preparado para reutilização durante a repetição
		PreparedStatement pst = null;
		try {
			pst = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement(sql);
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		ArrayList<TermoCompostoStats> stats = new ArrayList<TermoCompostoStats>();
		
		//Percorre os tokens em busca de variações de termos compostos
		for(int i = 0; i < tokens.size(); i++){
			
			//Obtém token atual
			Token t = tokens.get(i);
			
			//Inicia termo (Ex.: Hipertensão)
			String token = t.token;
			
			//Se token for pontuação, ignora
			if (Pattern.matches("\\p{Punct}", token))
				continue;
			
			
			//Define o tamanho do maior termo encontrado para o token atual (em qtde de palavras)
			int maiorTermoEncontrado = 0;
			System.out.println("Token: " + token);
			
			ResultSet res = null;
			try{
				//Busca token atual nas estatísticas de anotação do anotador
				ps.setInt(1, usuario_id);
				ps.setString(2, token + " %");
				res = ps.executeQuery();
				//Percorre termos encontrados iniciados com o token atual (Ex.: Acesso central, Acesso venoso, acesso periférico)
				while (res.next()) {
					
					//Obtém qtde de tokens do termo encontrado
					int numTokens = res.getInt("numTokens");
					//Obtém termo encontrado na estatística
					String termoEncontrado = res.getString("termocomposto_desc").toLowerCase();
					String termoTexto = "";
					//Monta termo encontrado no texto com a mesma qtde de palavras do termo encontrado nas estatísticas
					for(int j=i; j < i + numTokens; j++){
						termoTexto += tokens.get(j).token + " ";
					}
					termoTexto = termoTexto.trim().toLowerCase();//remove espaços no final e colocar em lowercase
					System.out.println(termoTexto + " = " + termoEncontrado + " ?");
					//Se termo do texto é igual ao encontrado nas estatísticas
					if(termoEncontrado.equals(termoTexto)){
						
						//Define como maior termo encontrado até o momento (O SELECT está ordenado por numTokens ASC)
						maiorTermoEncontrado = numTokens - 1;//-1 pois alem de somar este valor ao i, o for fará o i++
						
						//Define HASHMAP para armazenar totais utilização de cada TAG
						HashMap<String, Integer> qtdeTags = new HashMap<String, Integer>();
						float totalOcorrenciasTermo = 0;
						
						ResultSet r = null;
						
						//Busca todas ocorrencias agrupadas pelas tags utilizadas (Para evitar resultset grande demais)
						pst.setInt(1, usuario_id);
						pst.setString(2, termoEncontrado);
						r = pst.executeQuery();
						//Percorre ocorrencias que tenham sido marcadas com diferentes tags (Ex.: 55 - 68,55 - 68)
						while (r.next()) {
							
							//Obtém tags anotadas para anotação atual
							String tags[] = r.getString("tags_id").split(",");
							//Obtém qtde de anotações para a mesma(s) tag(s)
							int qtdeAnotacoes = r.getInt("qtdeAnotacoes");
							//Soma ao total
							totalOcorrenciasTermo += qtdeAnotacoes;
							System.out.println("Qtde anotacoes: "+ qtdeAnotacoes);
							//Percorre tags anotadas
							for(String tag : tags){
								
								//Se tag atual já foi contabilizada antes
								if(qtdeTags.containsKey(tag))
									qtdeTags.put(tag, qtdeTags.get(tag) + qtdeAnotacoes);//Incrementa total
								else
									qtdeTags.put(tag, qtdeAnotacoes);//Define 1
								
								
							}
							
						}
						
						//Define nova estatistica de Termo composto
						TermoCompostoStats tc = new TermoCompostoStats();
						tc.termo = termoEncontrado;
					
						//Percorre totais das tags para o termo
						for (Map.Entry<String, Integer> entry : qtdeTags.entrySet()) {
				
							int tag = Integer.parseInt(entry.getKey());
						    double totalOcorrenciaTag = entry.getValue();
						   
						    //Adiciona tag a estatistica do termo atual
						    tc.tags.add(new Tag(tag));
						    //Adiciona porcentagem
						    tc.percents.add( (totalOcorrenciaTag*100) / totalOcorrenciasTermo);
						    
						}
						
						//Adiciona a lista de estatisticas
						stats.add(tc);

						
					}
					
				}
				
				
			} catch (SQLException e) {
				System.out.println("Erro ao montar SQL para buscar estatistica do token '" + token + "' para o usuario " + usuario_id);
				e.printStackTrace();
			}
			
			//Se encontrou
			//i = i + maiorTermoEncontrado;
			
			
		}
		
		return stats;

		
	}*/
	
	
	public static ArrayList<TermoCompostoStats> findCompoundTermsStatistics(ArrayList<Token> tokens, int usuario_id){
		
		//Inicia lista de estatísticas
		ArrayList<TermoCompostoStats> stats = new ArrayList<TermoCompostoStats>();

		//Define termos encontrados separados por virgula
		String termsCommaSeparated = "";		
		//Define os tokens separados por vírgula
		String tokensCommaSeparated = "";
		
		//Percorre os tokens e une-os em uma string separada por virgula
		for(int i = 0; i < tokens.size(); i++){
			
			//Obtém token atual
			Token t = tokens.get(i);
		
			//Se token NÃO for pontuação
			if (!Pattern.matches("\\p{Punct}", t.token))
				tokensCommaSeparated += "\""+t.token+"\",";
			
			
		}
		
		//Define SQL que Busca estatísticas de anotação do anotador que contenham os tokens do texto atual
		String sql = "SELECT " + 
					"	termocomposto_desc, length(termocomposto_desc)-length(replace(termocomposto_desc,' ',''))+1 as numTokens " + 
					"FROM " + 
					"	termoscompostostable " + 
					"WHERE " + 
					"	anotador_id="+usuario_id+" AND SUBSTRING_INDEX(termocomposto_desc, ' ', 1) IN ("+tokensCommaSeparated.substring(0, tokensCommaSeparated.length()-1)+") "
					+ "GROUP BY" + 
					"	termocomposto_desc " + 
					"ORDER BY" + 
					"	numTokens";
		
		PreparedStatement ps = null;
		try {
			ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement(sql);
			ResultSet res = null;
			res = ps.executeQuery();
			//Percorre as ocorrências que iniciem com algum dos tokens do texto
			while (res.next()) {
				
				//Percorre todos tokens novamente para tentar encontrar ocorrências
				for(int i = 0; i < tokens.size(); i++){
					
					//Obtém token atual
					Token t = tokens.get(i);
					
					//Obtém qtde de tokens do termo encontrado
					int numTokens = res.getInt("numTokens");
					//Obtém termo encontrado na estatística
					String termoEncontrado = res.getString("termocomposto_desc").toLowerCase();
					String termoTexto = "";
					try{
						//Monta termo encontrado no texto com a mesma qtde de palavras do termo encontrado nas estatísticas
						for(int j=i; j < i + numTokens; j++){
							termoTexto += tokens.get(j).token + " ";
						}
					}
					catch(IndexOutOfBoundsException e){
						break;//Se já ultrapassou o limite dos tokens, sai da repetição
					}
					termoTexto = termoTexto.trim().toLowerCase();//remove espaços no final e colocar em lowercase
					
					//Se termo do texto é igual ao encontrado nas estatísticas
					if(termoEncontrado.equals(termoTexto)){
						
						//Adiciona a lista de termos encontrados
						termsCommaSeparated += "\""+termoEncontrado+"\",";
						
					}
					
				}
				
			}
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		//Se achou algum termo
		if(!termsCommaSeparated.isEmpty()){
		
			//Define HASHMAP para armazenar totais utilização de cada TAG
			HashMap<String, Integer> qtdeTags = new HashMap<String, Integer>();
			float totalOcorrenciasTermo = 0;
			
			//Define SQL que Busca todas ocorrencias agrupadas pelas tags utilizadas (Para evitar resultset grande demais)
			sql = "SELECT " + 
					"	termocomposto_desc, tags_id, COUNT(termocomposto_desc) as qtdeAnotacoes " + 
					"FROM " + 
					"	termoscompostostable " + 
					"WHERE " + 
					"	anotador_id="+usuario_id+" AND termocomposto_desc IN ("+termsCommaSeparated.substring(0, termsCommaSeparated.length()-1)+") "
					+ "GROUP BY" + 
					"	termocomposto_desc, tags_id "
					+ "ORDER BY"
					+ " length(termocomposto_desc)-length(replace(termocomposto_desc,' ','')) DESC";
			
			PreparedStatement pst = null;
			try {
				pst = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement(sql);
				String termoAtual = "";
				//Busca todas ocorrencias agrupadas pelas tags utilizadas (Para evitar resultset grande demais)
				ResultSet r = pst.executeQuery();
				//Controla iterações
				int cont = 0;
				//Percorre ocorrencias que tenham sido marcadas com diferentes tags (Ex.: 55 - 68,55 - 68)
				while (r.next()) {
					
					/*Exemplo de resultset
					acesso venoso;55;1
					Acesso venoso;68,55;2
					acesso venoso central;68,55;1
					bem perfundidas;29;2
					diurese efetiva;33;1
					Dreno suctor;68;1
					estável hemodinamicamente;29;1
					MÉDIA QUANTIDADE;74;3
					pele íntegra;20,29;1
					pupilas;29;1
					VENTILAÇÃO MECÂNICA;55;1*/
			
					//Se termo atual for diferente do anterior - Então mudou de termo
					if(!termoAtual.equalsIgnoreCase(r.getString("termocomposto_desc"))){
						
						//Se não for PRIMEIRA ITERAÇÃO - Adiciona estatistica do termo anterior
						if(cont != 0){
							//Define nova estatistica de Termo composto
							TermoCompostoStats tc = new TermoCompostoStats();
							tc.termo = termoAtual;
						
							//Percorre totais das tags para o termo
							for (Map.Entry<String, Integer> entry : qtdeTags.entrySet()) {
				
								int tag = Integer.parseInt(entry.getKey());
							    double totalOcorrenciaTag = entry.getValue();
							   
							    //Adiciona tag a estatistica do termo atual
							    tc.tags.add(new Tag(tag));
							    //Adiciona porcentagem
							    tc.percents.add( (totalOcorrenciaTag*100) / totalOcorrenciasTermo);
							    
							}
							
							//Adiciona a lista de estatisticas
							stats.add(tc);
						}
						
						//Zera lista de estatística de tags
						qtdeTags = new HashMap<String, Integer>();
						//Zera ocorrencias
						totalOcorrenciasTermo = 0;
						
					}
					
					
					//Obtém termo atual
					termoAtual = r.getString("termocomposto_desc");
					//Obtém tags anotadas para anotação atual
					String tags[] = r.getString("tags_id").split(",");
					//Obtém qtde de anotações para a mesma(s) tag(s)
					int qtdeAnotacoes = r.getInt("qtdeAnotacoes");
					//Soma ao total
					totalOcorrenciasTermo += qtdeAnotacoes;
					
					//Percorre tags anotadas
					for(String tag : tags){
						
						//Se tag atual já foi contabilizada antes
						if(qtdeTags.containsKey(tag))
							qtdeTags.put(tag, qtdeTags.get(tag) + qtdeAnotacoes);//Incrementa total
						else
							qtdeTags.put(tag, qtdeAnotacoes);//Define 1
						
						
					}
					
					cont++;
					
				}
				
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
		}
		
		
		return stats;

		
	}
	
	/**
	 * Busca anotadores que realizaram anotação no texto
	 * @param texto_id
	 * @return
	 */
	public static ArrayList<Usuario> findTextPerformedAnnotators(int texto_id){
		
		ArrayList<Usuario> users = new ArrayList<Usuario>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	u.id, u.nome, u.email, u.ultimo_acesso\r\n" + 
					"FROM\r\n" + 
					"	textos t\r\n" + 
					"INNER JOIN sentencas s ON (t.id = s.texto_id)\r\n" + 
					"INNER JOIN tokens tk ON (s.id = tk.sentenca_id)\r\n" + 
					"INNER JOIN anotacoes a ON (tk.id = a.token_id)\r\n" + 
					"INNER JOIN usuarios u ON (a.anotador_id = u.id)\r\n" + 
					"WHERE\r\n" + 
					"	adjudicador = 0 AND t.id = ?\r\n" + 
					"GROUP BY t.id, a.anotador_id\r\n" +
					"ORDER BY u.id");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			
			while (res.next()) {
				Usuario u = new Usuario();
				
				u.id = res.getInt("id");;
				u.nome = res.getString("nome");;
				u.email = res.getString("email");
				u.ultimo_acesso = res.getTimestamp("ultimo_acesso");
				
				users.add(u);
			 }
			 
		
		} catch (SQLException e) {
			System.out.println("Erro ao busca anotadores do texto: " + texto_id);
			e.printStackTrace();
		}
        
		
		return users;
		
	}
	
	
	/**
	 * Busca anotadores que foram relacionados ao texto
	 * @param texto_id
	 * @return
	 */
	public static ArrayList<Usuario> findTextRelatedAnnotators(int texto_id){
		
		ArrayList<Usuario> users = new ArrayList<Usuario>();
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	u.id, u.nome, u.email, u.ultimo_acesso\r\n" + 
					"FROM \r\n" + 
					"	alocacaotexto a\r\n" + 
					"INNER JOIN usuarios u ON (u.id = a.usuario_id)\r\n" + 
					"WHERE\r\n" + 
					"	texto_id = ?");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			
			while (res.next()) {
				Usuario u = new Usuario();
				
				u.id = res.getInt("id");;
				u.nome = res.getString("nome");;
				u.email = res.getString("email");
				u.ultimo_acesso = res.getTimestamp("ultimo_acesso");
				
				users.add(u);
			 }
			 
		
		} catch (SQLException e) {
			System.out.println("Erro ao busca anotadores relacionados ao texto: " + texto_id);
			e.printStackTrace();
		}
        
		
		return users;
		
	}
	
	public static ArrayList<Anotacao> findAnotacoesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators){
		
		ArrayList<Anotacao> anotacoes = new ArrayList<Anotacao>();
		
		//Obtém o ID de todos anotadores
		String annotators_id = "";
		for(Usuario u: annotators){
			annotators_id += u.id + ",";
		}
		annotators_id = annotators_id.substring(0, annotators_id.length()-1);
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	anotacoes.*\r\n" + 
					"FROM \r\n" + 
					"	anotacoes \r\n" + 
					"INNER JOIN tokens ON (tokens.id = anotacoes.token_id) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"WHERE \r\n" + 
					"	adjudicador = 0 AND sentencas.texto_id = ? AND (anotacoes.anotador_id IN ("+annotators_id+"))\r\n" + 
					"ORDER BY \r\n" + 
					"	sentencas.ordem, tokens.ordem, tag_id, anotador_id");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				Anotacao a = new Anotacao();
				a.id = res.getInt("id");
				a.tag_id = res.getInt("tag_id");
				a.token_id = res.getInt("token_id");
				a.anotador_id = res.getInt("anotador_id");
				a.termocomposto_id = res.getString("termocomposto_id");
				a.status = res.getString("status");
				a.adjudicador = res.getBoolean("adjudicador");
				a.dataanotacao = res.getTimestamp("dataanotacao");
				a.abreviatura = res.getString("abreviatura");
				a.umlscui = res.getString("umlscui");
				a.snomedctid = res.getString("snomedctid");
				
				anotacoes.add(a);
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return anotacoes;
	}
	
	/**
	 * Busca anotações concordantes entre os anotadores (FUNCIONA APENAS PARA DOIS ANOTADORES)
	 * @param texto_id
	 * @param annotators
	 * @return
	 */
	public static Map<Anotacao, Anotacao> findAnotacoesConcordantesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators){
		
		Map<Anotacao, Anotacao> anotacoes = new LinkedHashMap<Anotacao, Anotacao>();
		
		try {
			
			//TODO: Fazer funcionar para mais de dois anotadores
			//Neste caso montar dinamicamente os INNER JOIN na tabela anotações (a2, a3, etc.) e SELECTs
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	a1.id id1, a1.tag_id tag_id1, a1.token_id token_id1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, \r\n" + 
					"	a2.id id2, a2.tag_id tag_id2, a2.token_id token_id2, a2.anotador_id anotador_id2, a2.termocomposto_id termocomposto_id2, a2.status status2, a2.adjudicador adjudicador2, a2.dataanotacao dataanotacao2, a2.abreviatura abreviatura2, a2.umlscui umlscui2, a2.snomedctid snomedctid2\r\n" + 
					"FROM \r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id AND ( (a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL) OR (a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL) ) )\r\n" + 
					"WHERE \r\n" + 
					"	a1.adjudicador = 0 AND a2.adjudicador = 0 AND sentencas.texto_id = ? AND a1.anotador_id = ? AND \r\n" +
					"   (SELECT COUNT(*) size FROM	anotacoes a3 WHERE a3.termocomposto_id = a1.termocomposto_id) = (SELECT COUNT(*) size FROM	anotacoes a4 WHERE a4.termocomposto_id = a2.termocomposto_id) " + 
					"ORDER BY \r\n" + 
					"	sentencas.ordem, tokens.ordem, a1.tag_id, a1.anotador_id");
			ps.setInt(1, texto_id);
			ps.setInt(2, annotators.get(0).id);//Define primeiro anotador como base para a pesqusia
			ResultSet res = ps.executeQuery();
			
			//( (a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL) OR (a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL) )
			//Este trecho evita que uma parte de uma anotação composta seja considerada igual uma anotação de termo simples
			//Ou seja, a anotação só é considerada igual se as duas são simples ou as duas fazem parte de uma anotação composta
			
			//(SELECT COUNT(*) size FROM	anotacoes a3 WHERE a3.termocomposto_id = a1.termocomposto_id) = (SELECT COUNT(*) size FROM	anotacoes a4 WHERE a4.termocomposto_id = a2.termocomposto_id)
			//Este trecho verifica se uma anotação (para caso de ser composta) tem a mesma quantidade de termos
			//Ex.: pupilas isocóricas vs. pupilas isocóricas fotorreajentes
			//Neste caso mesmo que as tags marcadas para os tokens "pupilas" e "isocoricas" sejam iguai, não deve ser considerado concordante
			
			while (res.next()) {
				Anotacao a1 = new Anotacao();
				a1.id = res.getInt("id1");
				a1.tag_id = res.getInt("tag_id1");
				a1.token_id = res.getInt("token_id1");
				a1.anotador_id = res.getInt("anotador_id1");
				a1.termocomposto_id = res.getString("termocomposto_id1");
				a1.status = res.getString("status1");
				a1.adjudicador = res.getBoolean("adjudicador1");
				a1.dataanotacao = res.getTimestamp("dataanotacao1");
				a1.abreviatura = res.getString("abreviatura1");
				a1.umlscui = res.getString("umlscui1");
				a1.snomedctid = res.getString("snomedctid1");
				
				Anotacao a2 = new Anotacao();
				a2.id = res.getInt("id2");
				a2.tag_id = res.getInt("tag_id2");
				a2.token_id = res.getInt("token_id2");
				a2.anotador_id = res.getInt("anotador_id2");
				a2.termocomposto_id = res.getString("termocomposto_id2");
				a2.status = res.getString("status2");
				a2.adjudicador = res.getBoolean("adjudicador2");
				a2.dataanotacao = res.getTimestamp("dataanotacao2");
				a2.abreviatura = res.getString("abreviatura2");
				a2.umlscui = res.getString("umlscui2");
				a2.snomedctid = res.getString("snomedctid2");
				
				anotacoes.put(a1, a2);
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return anotacoes;
	}
	
	
	/**
	 * Busca anotações SIMPLES DISCORDANTES entre os anotadores (FUNCIONA APENAS PARA DOIS ANOTADORES)
	 * @param texto_id
	 * @param annotators
	 * @return
	 */
	public static ArrayList<AnotacaoCompleta> findAnotacoesSimplesDiscordantesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators){
		
		//Map<AnotacaoCompleta, AnotacaoCompleta> anotacoes = new LinkedHashMap<AnotacaoCompleta, AnotacaoCompleta>();
		ArrayList<AnotacaoCompleta> anotacoes = new ArrayList<AnotacaoCompleta>();
		
		try {
			
			//TODO: Fazer funcionar para mais de dois anotadores
			//Neste caso montar dinamicamente os INNER JOIN na tabela anotações (a2, a3, etc.) e SELECTs
			/*PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1, \r\n" + 
					"	a2.id id2, a2.tag_id tag_id2, t2.tag tag_name2, a2.token_id token_id2, tokens.token token_name2, a2.anotador_id anotador_id2, a2.termocomposto_id termocomposto_id2, a2.status status2, a2.adjudicador adjudicador2, a2.dataanotacao dataanotacao2, a2.abreviatura abreviatura2, a2.umlscui umlscui2, a2.snomedctid snomedctid2, u2.nome anotador_name2 \r\n" +
					"FROM \r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)\r\n" +
					"INNER JOIN tags t1 ON (a1.tag_id = t1.id)\r\n" +
					"INNER JOIN tags t2 ON (a2.tag_id = t2.id)\r\n" +
					"INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id)\r\n" +
					"INNER JOIN usuarios u2 ON (a2.anotador_id = u2.id)\r\n" +
					"WHERE \r\n" + 
					"	sentencas.texto_id = ? AND a1.anotador_id = ? AND a1.termocomposto_id IS NULL AND a1.id NOT IN \r\n" + 
					"	(\r\n" + 
					"		SELECT \r\n" + 
					"			a1.id \r\n" + 
					"		FROM \r\n" + 
					"			anotacoes a1\r\n" + 
					"		INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)\r\n" + 
					"		WHERE \r\n" + 
					"			sentencas.texto_id = ? AND a1.anotador_id = ?\r\n" + 
					"	)\r\n" + 
					"ORDER BY \r\n" + 
					"	sentencas.ordem, tokens.ordem, a1.tag_id, a1.anotador_id");*/
					PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT   \r\n" + 
							"	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1\r\n" + 
							"FROM   \r\n" + 
							"	anotacoes a1  \r\n" + 
							"INNER JOIN tokens ON (tokens.id = a1.token_id)   \r\n" + 
							"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   \r\n" + 
							"INNER JOIN tags t1 ON (a1.tag_id = t1.id) \r\n" + 
							"INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id) \r\n" + 
							"WHERE   \r\n" + 
							"	a1.adjudicador = 0 AND sentencas.texto_id = ? AND (a1.anotador_id = ? OR a1.anotador_id = ?) AND a1.termocomposto_id IS NULL AND (a1.id) NOT IN   \r\n" + 
							"	(  \r\n" + 
							"		SELECT   \r\n" + 
							"			a1.id\r\n" + 
							"		FROM   \r\n" + 
							"			anotacoes a1  \r\n" + 
							"		INNER JOIN tokens ON (tokens.id = a1.token_id)   \r\n" + 
							"		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   \r\n" + 
							"		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)  \r\n" + 
							"		WHERE   \r\n" + 
							"			a1.adjudicador = 0 AND a2.adjudicador = 0 AND sentencas.texto_id = ?\r\n" + 
							"	)  \r\n" + 
							"ORDER BY   \r\n" + 
							"	sentencas.id, tokens.id, a1.anotador_id");
			ps.setInt(1, texto_id);
			ps.setInt(2, annotators.get(0).id);//Define primeiro anotador como base para a pesqusia
			ps.setInt(3, annotators.get(1).id);//Define segundo anotador como base para a pesqusia
			ps.setInt(4, texto_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				AnotacaoCompleta a1 = new AnotacaoCompleta();
				a1.id = res.getInt("id1");
				a1.tag_id = res.getInt("tag_id1");
				a1.token_id = res.getInt("token_id1");
				a1.anotador_id = res.getInt("anotador_id1");
				a1.termocomposto_id = res.getString("termocomposto_id1");
				a1.status = res.getString("status1");
				a1.adjudicador = res.getBoolean("adjudicador1");
				a1.dataanotacao = res.getTimestamp("dataanotacao1");
				a1.abreviatura = res.getString("abreviatura1");
				a1.umlscui = res.getString("umlscui1");
				a1.snomedctid = res.getString("snomedctid1");
				
				a1.anotador_name = res.getString("anotador_name1");
				a1.tag_name = res.getString("tag_name1");
				a1.token_name = res.getString("token_name1");
				
				anotacoes.add(a1);
				
				/*AnotacaoCompleta a2 = new AnotacaoCompleta();
				a2.id = res.getInt("id2");
				a2.tag_id = res.getInt("tag_id2");
				a2.token_id = res.getInt("token_id2");
				a2.anotador_id = res.getInt("anotador_id2");
				a2.termocomposto_id = res.getString("termocomposto_id2");
				a2.status = res.getString("status2");
				a2.adjudicador = res.getBoolean("adjudicador2");
				a2.dataanotacao = res.getTimestamp("dataanotacao2");
				a2.abreviatura = res.getString("abreviatura2");
				a2.umlscui = res.getString("umlscui2");
				a2.snomedctid = res.getString("snomedctid2");
				
				a2.anotador_name = res.getString("anotador_name2");
				a2.tag_name = res.getString("tag_name2");
				a2.token_name = res.getString("token_name2");
				
				anotacoes.put(a1, a2);*/
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return anotacoes;
	}
	
	
	/**
	 * Busca anotações COMPOSTAS DISCORDANTES entre os anotadores (FUNCIONA APENAS PARA DOIS ANOTADORES)
	 * @param texto_id
	 * @param annotators
	 * @return
	 */
	public static ArrayList<AnotacaoCompleta> findAnotacoesCompostasDiscordantesByTextoIdAndAnnotators(int texto_id, ArrayList<Usuario> annotators){
		
		//Map<AnotacaoCompleta, AnotacaoCompleta> anotacoes = new LinkedHashMap<AnotacaoCompleta, AnotacaoCompleta>();
		ArrayList<AnotacaoCompleta> anotacoes = new ArrayList<AnotacaoCompleta>();
		
		try {
			
			//TODO: Fazer funcionar para mais de dois anotadores
			//Neste caso montar dinamicamente os INNER JOIN na tabela anotações (a2, a3, etc.) e SELECTs
			/*PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1, \r\n" + 
					"	a2.id id2, a2.tag_id tag_id2, t2.tag tag_name2, a2.token_id token_id2, tokens.token token_name2, a2.anotador_id anotador_id2, a2.termocomposto_id termocomposto_id2, a2.status status2, a2.adjudicador adjudicador2, a2.dataanotacao dataanotacao2, a2.abreviatura abreviatura2, a2.umlscui umlscui2, a2.snomedctid snomedctid2, u2.nome anotador_name2 \r\n" +
					"FROM \r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)\r\n" + 
					"INNER JOIN tags t1 ON (a1.tag_id = t1.id)\r\n" +
					"INNER JOIN tags t2 ON (a2.tag_id = t2.id)\r\n" +
					"INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id)\r\n" +
					"INNER JOIN usuarios u2 ON (a2.anotador_id = u2.id)\r\n" +
					"WHERE \r\n" + 
					"	sentencas.texto_id = ? AND a1.anotador_id = ? AND a1.termocomposto_id IS NOT NULL AND a1.id NOT IN \r\n" + 
					"	(\r\n" + 
					"		SELECT \r\n" + 
					"			a1.id \r\n" + 
					"		FROM \r\n" + 
					"			anotacoes a1\r\n" + 
					"		INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" + 
					"		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id)\r\n" + 
					"		WHERE \r\n" + 
					"			sentencas.texto_id = ? AND a1.anotador_id = ?\r\n" + 
					"	)\r\n" + 
					"ORDER BY \r\n" + 
					"	sentencas.ordem, tokens.ordem, a1.tag_id, a1.anotador_id");*/
					PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT   \r\n" + 
							"	a1.id id1, a1.tag_id tag_id1, t1.tag tag_name1, a1.token_id token_id1, tokens.token token_name1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1, u1.nome anotador_name1\r\n" + 
							"FROM   \r\n" + 
							"	anotacoes a1  \r\n" + 
							"INNER JOIN tokens ON (tokens.id = a1.token_id)   \r\n" + 
							"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   \r\n" + 
							"INNER JOIN tags t1 ON (a1.tag_id = t1.id) \r\n" + 
							"INNER JOIN usuarios u1 ON (a1.anotador_id = u1.id) \r\n" + 
							"WHERE   \r\n" + 
							"	a1.adjudicador = 0 AND sentencas.texto_id = ? AND (a1.anotador_id = ? OR a1.anotador_id = ?) AND a1.termocomposto_id IS NOT NULL AND (a1.id) NOT IN   \r\n" + 
							"	(  \r\n" + 
							"		SELECT   \r\n" + 
							"			a1.id\r\n" + 
							"		FROM   \r\n" + 
							"			anotacoes a1  \r\n" + 
							"		INNER JOIN tokens ON (tokens.id = a1.token_id)   \r\n" + 
							"		INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id)   \r\n" + 
							"		INNER JOIN anotacoes a2 ON (a1.token_id = a2.token_id AND a1.tag_id = a2.tag_id AND a1.anotador_id != a2.anotador_id AND a1.id != a2.id AND ( (a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL) OR (a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL) ) )  \r\n" + 
							"		WHERE   \r\n" + 
							"			a1.adjudicador = 0 AND a2.adjudicador = 0 AND sentencas.texto_id = ? AND \r\n" +
							"			(SELECT COUNT(*) size FROM	anotacoes a3 WHERE a3.termocomposto_id = a1.termocomposto_id) = (SELECT COUNT(*) size FROM	anotacoes a4 WHERE a4.termocomposto_id = a2.termocomposto_id)" + 
							"	)  \r\n" + 
							"ORDER BY   \r\n" + 
							"	a1.anotador_id, a1.termocomposto_id, a1.tag_id,a1.token_id");
			ps.setInt(1, texto_id);
			ps.setInt(2, annotators.get(0).id);//Define primeiro anotador como base para a pesqusia
			ps.setInt(3, annotators.get(1).id);//Define segundo anotador como base para a pesqusia
			ps.setInt(4, texto_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				AnotacaoCompleta a1 = new AnotacaoCompleta();
				a1.id = res.getInt("id1");
				a1.tag_id = res.getInt("tag_id1");
				a1.token_id = res.getInt("token_id1");
				a1.anotador_id = res.getInt("anotador_id1");
				a1.termocomposto_id = res.getString("termocomposto_id1");
				a1.status = res.getString("status1");
				a1.adjudicador = res.getBoolean("adjudicador1");
				a1.dataanotacao = res.getTimestamp("dataanotacao1");
				a1.abreviatura = res.getString("abreviatura1");
				a1.umlscui = res.getString("umlscui1");
				a1.snomedctid = res.getString("snomedctid1");
				
				a1.anotador_name = res.getString("anotador_name1");
				a1.tag_name = res.getString("tag_name1");
				a1.token_name = res.getString("token_name1");
				
				anotacoes.add(a1);
				
				/*AnotacaoCompleta a2 = new AnotacaoCompleta();
				a2.id = res.getInt("id2");
				a2.tag_id = res.getInt("tag_id2");
				a2.token_id = res.getInt("token_id2");
				a2.anotador_id = res.getInt("anotador_id2");
				a2.termocomposto_id = res.getString("termocomposto_id2");
				a2.status = res.getString("status2");
				a2.adjudicador = res.getBoolean("adjudicador2");
				a2.dataanotacao = res.getTimestamp("dataanotacao2");
				a2.abreviatura = res.getString("abreviatura2");
				a2.umlscui = res.getString("umlscui2");
				a2.snomedctid = res.getString("snomedctid2");
				
				a2.anotador_name = res.getString("anotador_name2");
				a2.tag_name = res.getString("tag_name2");
				a2.token_name = res.getString("token_name2");
				
				anotacoes.put(a1, a2);*/
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return anotacoes;
	}
	
	
	
	public static boolean deleteAdjudicacoesByTextoIdAndUserId(int texto_id, int usuario_id){
		
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("DELETE anotacoes FROM anotacoes INNER JOIN tokens ON (tokens.id = anotacoes.token_id) INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) WHERE sentencas.texto_id = ? AND anotador_id = ? AND adjudicador = 1");
			ps.setInt(1, texto_id);
			ps.setInt(2, usuario_id);
			ps.executeUpdate();
			
			return true;
		}
		
		catch (SQLException e){
			System.out.println("Erro ao apagar adjudicaçao do texto " + texto_id + " e usuario " + usuario_id);
			e.printStackTrace();
			return true;
		}
	}
	
	/**
	 * Busca número de anotações concordantes com o adjudicador para termos SIMPLES (TRUE POSITIVES)
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberConcordantesSimples(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number \r\n" + 
					"FROM\r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"INNER JOIN anotacoes a2 ON\r\n" + 
					"		(\r\n" + 
					"			a2.anotador_id = ? AND\r\n" + 
					"			a1.token_id = a2.token_id AND \r\n" + 
					"			a1.tag_id = a2.tag_id AND \r\n" + 
					"			a1.anotador_id != a2.anotador_id AND \r\n" + 
					"			a1.id != a2.id AND \r\n" + 
					"			a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL	\r\n" + 
					"		)\r\n" + 
					"INNER JOIN tokens t2 ON (t2.id = a2.token_id)\r\n" + 
					"INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)\r\n" + 
					"INNER JOIN tags ta2 ON (ta2.id = a2.tag_id)\r\n" + 
					"WHERE\r\n" + 
					"	a1.adjudicador = 1 AND s.texto_id = ?");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	/**
	 * Busca número de anotações concordantes com o adjudicador para termos COMPOSTOS  (TRUE POSITIVES)
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberConcordantesCompostos(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	(\r\n" + 
					"	SELECT\r\n" + 
					"		a1.id\r\n" + 
					"	FROM\r\n" + 
					"		anotacoes a1\r\n" + 
					"	INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"	INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"	INNER JOIN anotacoes a2 ON\r\n" + 
					"			(\r\n" + 
					"				a2.anotador_id = ? AND\r\n" + 
					"				a1.token_id = a2.token_id AND \r\n" + 
					"				a1.tag_id = a2.tag_id AND \r\n" + 
					"				a1.anotador_id != a2.anotador_id AND \r\n" + 
					"				a1.id != a2.id AND \r\n" + 
					"				a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL	\r\n" + 
					"			)\r\n" + 
					"	INNER JOIN tokens t2 ON (t2.id = a2.token_id)\r\n" + 
					"	INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)\r\n" + 
					"	INNER JOIN tags ta2 ON (ta2.id = a2.tag_id)\r\n" + 
					"	WHERE\r\n" + 
					"		a1.adjudicador = 1 AND s.texto_id = ?\r\n" + 
					"	GROUP BY\r\n" + 
					"		a1.termocomposto_id) tab");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	/**
	 * Busca número de anotações discordantes com o adjudicador para termos SIMPLES  (FALSE POSITIVES)
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberDiscordantesSimples(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)\r\n" + 
					"WHERE\r\n" + 
					"	a1.anotador_id = ? AND s.texto_id = ? AND a1.termocomposto_id IS NULL AND a1.id NOT IN \r\n" + 
					"	(\r\n" + 
					"	SELECT\r\n" + 
					"		a2.id\r\n" + 
					"	FROM\r\n" + 
					"		anotacoes a1\r\n" + 
					"	INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"	INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"	INNER JOIN anotacoes a2 ON\r\n" + 
					"			(\r\n" + 
					"				a2.anotador_id = ? AND\r\n" + 
					"				a1.token_id = a2.token_id AND \r\n" + 
					"				a1.tag_id = a2.tag_id AND \r\n" + 
					"				a1.anotador_id != a2.anotador_id AND \r\n" + 
					"				a1.id != a2.id AND \r\n" + 
					"				( \r\n" + 
					"					(a1.termocomposto_id IS NULL AND a2.termocomposto_id IS NULL)\r\n" + 
					"				) \r\n" + 
					"			)\r\n" + 
					"	WHERE\r\n" + 
					"		a1.adjudicador = 1 AND s.texto_id = ?\r\n" + 
					"	)");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ps.setInt(3, anotador_id);
			ps.setInt(4, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	/**
	 * Busca número de anotações discordantes com o adjudicador para termos COMPOSTOS  (FALSE POSITIVES)
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberDiscordantesCompostos(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	(SELECT\r\n" + 
					"		a1.id\r\n" + 
					"	FROM\r\n" + 
					"		anotacoes a1\r\n" + 
					"	INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"	INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"	INNER JOIN tags ta1 ON (ta1.id = a1.tag_id)\r\n" + 
					"	WHERE\r\n" + 
					"		a1.anotador_id = ? AND s.texto_id = ? AND a1.termocomposto_id IS NOT NULL AND a1.id NOT IN \r\n" + 
					"		(\r\n" + 
					"		SELECT\r\n" + 
					"			a2.id\r\n" + 
					"		FROM\r\n" + 
					"			anotacoes a1\r\n" + 
					"		INNER JOIN tokens t1 ON (t1.id = a1.token_id)\r\n" + 
					"		INNER JOIN sentencas s ON (s.id = t1.sentenca_id)\r\n" + 
					"		INNER JOIN anotacoes a2 ON\r\n" + 
					"				(\r\n" + 
					"					a2.anotador_id = ? AND\r\n" + 
					"					a1.token_id = a2.token_id AND \r\n" + 
					"					a1.tag_id = a2.tag_id AND \r\n" + 
					"					a1.anotador_id != a2.anotador_id AND \r\n" + 
					"					a1.id != a2.id AND \r\n" + 
					"					( \r\n" + 
					"						(a1.termocomposto_id IS NOT NULL AND a2.termocomposto_id IS NOT NULL)\r\n" + 
					"					) \r\n" + 
					"				)\r\n" + 
					"		WHERE\r\n" + 
					"			a1.adjudicador = 1 AND s.texto_id = ?\r\n" + 
					"		)\r\n" + 
					"	GROUP BY a1.termocomposto_id) tab");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ps.setInt(3, anotador_id);
			ps.setInt(4, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	/**
	 * Busca número de anotações discordantes com o adjudicador para termos SIMPLES  (FALSE NEGATIVES)
	 * Anotações SIMPLES do adjudicador que não tenham sido feitas pelo anotador
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberDiscordantesAdjudicadorSimples(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	anotacoes a\r\n" + 
					"INNER JOIN tokens t ON (t.id = a.token_id)\r\n" + 
					"INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"INNER JOIN tags ON (tags.id = a.tag_id)\r\n" + 
					"WHERE\r\n" + 
					"	adjudicador = 1 AND s.texto_id = ? AND a.termocomposto_id IS NULL AND (a.token_id, a.tag_id) NOT IN \r\n" + 
					"	(\r\n" + 
					"		SELECT\r\n" + 
					"			a.token_id, a.tag_id\r\n" + 
					"		FROM\r\n" + 
					"			anotacoes a\r\n" + 
					"		INNER JOIN tokens t ON (t.id = a.token_id)\r\n" + 
					"		INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"		INNER JOIN tags ON (tags.id = a.tag_id)\r\n" + 
					"		WHERE\r\n" + 
					"			a.anotador_id = ? AND s.texto_id = ? AND a.termocomposto_id IS NULL \r\n" + 
					"	)");
			ps.setInt(1, texto_id);
			ps.setInt(2, anotador_id);
			ps.setInt(3, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	/**
	 * Busca número de anotações discordantes com o adjudicador para termos COMPOSTOS  (FALSE NEGATIVES)
	 * Anotações COMPOSTAS do adjudicador que não tenham sido feitas pelo anotador
	 * @param performedAnnotators
	 * @return
	 */
	public static int getNumberDiscordantesAdjudicadorCompostos(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	(SELECT\r\n" + 
					"		a.id\r\n" + 
					"	FROM\r\n" + 
					"		anotacoes a\r\n" + 
					"	INNER JOIN tokens t ON (t.id = a.token_id)\r\n" + 
					"	INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"	INNER JOIN tags ON (tags.id = a.tag_id)\r\n" + 
					"	WHERE\r\n" + 
					"		adjudicador = 1 AND s.texto_id = ? AND a.termocomposto_id IS NOT NULL AND (a.token_id, a.tag_id) NOT IN \r\n" + 
					"		(\r\n" + 
					"			SELECT\r\n" + 
					"				a.token_id, a.tag_id\r\n" + 
					"			FROM\r\n" + 
					"				anotacoes a\r\n" + 
					"			INNER JOIN tokens t ON (t.id = a.token_id)\r\n" + 
					"			INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"			INNER JOIN tags ON (tags.id = a.tag_id)\r\n" + 
					"			WHERE\r\n" + 
					"				a.anotador_id = ? AND s.texto_id = ? AND a.termocomposto_id IS NOT NULL \r\n" + 
					"		)\r\n" + 
					"	GROUP BY a.termocomposto_id) tab");
			ps.setInt(1, texto_id);
			ps.setInt(2, anotador_id);
			ps.setInt(3, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	public static int getNumberAnotacoesSimples(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	anotacoes a\r\n" + 
					"INNER JOIN tokens t ON (t.id = token_id)\r\n" + 
					"INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"WHERE\r\n" + 
					"	a.anotador_id = ? AND s.texto_id = ? AND a.termocomposto_id IS NULL");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	public static int getNumberAnotacoesCompostas(int texto_id, int anotador_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	(SELECT\r\n" + 
					"		a.id\r\n" + 
					"	FROM\r\n" + 
					"		anotacoes a\r\n" + 
					"	INNER JOIN tokens t ON (t.id = token_id)\r\n" + 
					"	INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"	WHERE\r\n" + 
					"		a.anotador_id = ? AND s.texto_id = ? AND a.termocomposto_id IS NOT NULL\r\n" + 
					"	GROUP BY a.termocomposto_id) tab");
			ps.setInt(1, anotador_id);
			ps.setInt(2, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}

	
	public static int getNumberAdjudicacoes(int texto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	COUNT(*) number\r\n" + 
					"FROM\r\n" + 
					"	anotacoes a\r\n" + 
					"INNER JOIN tokens t ON (t.id = token_id)\r\n" + 
					"INNER JOIN sentencas s ON (s.id = t.sentenca_id)\r\n" + 
					"INNER JOIN tags ON (tags.id = tag_id)\r\n" + 
					"WHERE\r\n" + 
					"	adjudicador = 1 AND s.texto_id = ?");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			if (res.next()) {
				return res.getInt("number");
			}
			 
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return 0;
	}
	
	/**
	 * Atualiza status de todas atualizações feitas por TODOS anotadores a um determinado texto
	 * @param text_id
	 * @param status
	 * @return
	 */
	public static boolean updateStatus(int text_id, String status){
		try{
			Connection conn = DbConnection.getInstance().getConnection();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE anotacoes a JOIN tokens t ON (t.id = a.token_id) JOIN sentencas s ON (s.id = t.sentenca_id) SET a.status = ? WHERE s.texto_id = ?");
			ps.setString(1, status);
			ps.setInt(2, text_id);
			
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
	 * Busca adjudicações feitas para determinado texto
	 * @param texto_id
	 * @return
	 */
	public static ArrayList<Anotacao> findAdjudicacoesFinalizadasByTextoId(int texto_id){
		
		ArrayList<Anotacao> adjudicacoes = new ArrayList<Anotacao>();
		
		try {
			
			//TODO: Fazer funcionar para mais de dois anotadores
			//Neste caso montar dinamicamente os INNER JOIN na tabela anotações (a2, a3, etc.) e SELECTs
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT \r\n" + 
					"	a1.id id1, a1.tag_id tag_id1, a1.token_id token_id1, a1.anotador_id anotador_id1, a1.termocomposto_id termocomposto_id1, a1.status status1, a1.adjudicador adjudicador1, a1.dataanotacao dataanotacao1, a1.abreviatura abreviatura1, a1.umlscui umlscui1, a1.snomedctid snomedctid1 \r\n" + 
					"FROM \r\n" + 
					"	anotacoes a1\r\n" + 
					"INNER JOIN tokens ON (tokens.id = a1.token_id) \r\n" + 
					"INNER JOIN sentencas ON (sentencas.id = tokens.sentenca_id) \r\n" +  
					"WHERE \r\n" + 
					"	a1.adjudicador = 1 AND sentencas.texto_id = ? \r\n" + 
					"ORDER BY \r\n" + 
					"	sentencas.ordem, tokens.ordem, a1.tag_id, a1.anotador_id");
			ps.setInt(1, texto_id);
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {
				Anotacao a1 = new Anotacao();
				a1.id = res.getInt("id1");
				a1.tag_id = res.getInt("tag_id1");
				a1.token_id = res.getInt("token_id1");
				a1.anotador_id = res.getInt("anotador_id1");
				a1.termocomposto_id = res.getString("termocomposto_id1");
				a1.status = res.getString("status1");
				a1.adjudicador = res.getBoolean("adjudicador1");
				a1.dataanotacao = res.getTimestamp("dataanotacao1");
				a1.abreviatura = res.getString("abreviatura1");
				a1.umlscui = res.getString("umlscui1");
				a1.snomedctid = res.getString("snomedctid1");
				
				adjudicacoes.add(a1);
			 }
			 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return adjudicacoes;
	}

}

