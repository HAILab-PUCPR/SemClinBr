package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.Alocacaotexto;
import model.Anotacao;
import model.Relacionamento;
import model.Texto;
import model.TextoStatus;
import model.Usuario;

/**
 * Servlet implementation class TextAnnotation
 */
public class TextAdjudication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TextAdjudication() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		PrintWriter out = response.getWriter();
		
		//Obtém usuário autenticado
		Usuario u = (Usuario) session.getAttribute("usuario");
		//Obtém projeto atual
		Integer projectid = (int) session.getAttribute("projectid");
		//Obtém ID do anotador
		int anotador_id = u.id;
		//Obtém ID do texto anotado
		int text_id = Integer.parseInt(request.getParameter("id"));
		//Obtém parâmetro que determina a finalização ou não da anotação
		boolean finalize = Boolean.parseBoolean(request.getParameter("finalize"));
		//Obtém parâmetro que determina se foi feita adjudicação completa ou apenas de relacionamentos
		boolean relationOnly = Boolean.parseBoolean(request.getParameter("relationOnly"));
		//Se foi aberto para adjudicação completa
		if(!relationOnly){
			//Apaga adjudicações prévias para este adjudicador e texto
			Anotacao.deleteAdjudicacoesByTextoIdAndUserId(text_id, u.id);
		}
		//Apaga relacionamentos prévios para este anotador e texto
		Relacionamento.deleteRelacionamentosAdjudicadosByTextoIdAndUserId(text_id, u.id);
		
		
	
		boolean status = true;
		
		//Se foi abertura para adjudicação completa
		if(!relationOnly){
			//Obtém TOKENS e suas TAGS
			//Ex.: 3394:17,16
			//3394 = token_id
			//17 e 16 = tags associadas
			try{
				String[] tokens = request.getParameterValues("tokens[]");
				if(tokens != null){
					for(String v : tokens){
						//Separa TOKENID das TAGS
						String[] token = v.split(":");
						//Obtém TOKENID
						int token_id = Integer.parseInt(token[0]);
						//Obtém TAGS associadas
						String[] tags = token[1].split(",");
						
						String abbr = null;
						String umlscui = null;
						String snomedctid = null;
						int index = 2;
						//Enquanto houver parâmetros extras
						while(token.length > index){
							
							if(token[index].contains("abbreviation,"))
								abbr = (token[index].replace("abbreviation,", "").trim().isEmpty()) ? null : token[index].replace("abbreviation,", "").trim();
							else if(token[index].contains("umlscui,"))
								umlscui = (token[index].replace("umlscui,", "").trim().isEmpty()) ? null : token[index].replace("umlscui,", "").trim();
							else if(token[index].contains("snomedctid,"))
								snomedctid = (token[index].replace("snomedctid,", "").trim().isEmpty()) ? null : token[index].replace("snomedctid,", "").trim();
							
							index++;
						}
				
					
						//Percorre tags
						for(String tag_id : tags){
							//Define nova anotação
							Anotacao a = new Anotacao();
							
							a.tag_id = Integer.parseInt(tag_id);
							a.token_id = token_id;
							a.anotador_id = anotador_id;
							a.termocomposto_id = null;
			            	a.adjudicador = true;//Marca como adjudicação
			            	
			            	//Se foi informada abreviatura e está inserindo a tag de abbr
			            	//TODO: Usar a coluna tipo para saber se é tag de abreviatura
			            	a.abreviatura = (tag_id.equals("131") || tag_id.equals("271")) ? abbr : null;
			            	
			            	a.umlscui = umlscui;
			            	a.snomedctid = snomedctid;
			            	
			            	//Se pediu para finalizar, marca como finalizado
			            	if(finalize)
			            		a.status = TextoStatus.FINALIZADO;
			            	else
			            		a.status = TextoStatus.ADJUDICACAO;
			            	
			            	//Insere anotação no banco de dados
			            	a.insert();
			   
							
						}
						
						
					}
				}
			}
			catch(Exception e){
				System.out.println("Erro na inserção dos termos simples");
				e.printStackTrace();
				status = false;
				//Anotacao.deleteAdjudicacoesByTextoIdAndUserId(text_id, u.id);
			}
			
			//Obtém anotações de termos compostos
			try{
				String[] tokens = request.getParameterValues("compoundtokens[]");
				if(tokens != null){
					for(String v : tokens){
						
						//Gera UNIQUE ID para armazenar termos compostos
						UUID uid = UUID.randomUUID();
						
						//Separa TOKENIDs das TAGS
						String[] token = v.split(":");
						//Obtém TOKENIDs
						String[] token_ids = token[0].split(",");
						//Obtém TAGS associadas
						String[] tags = token[1].split(",");
						
						String abbr = null;
						String umlscui = null;
						String snomedctid = null;
						int index = 2;
						//Enquanto houver parâmetros extras
						while(token.length > index){
							
							if(token[index].contains("abbreviation,"))
								abbr = (token[index].replace("abbreviation,", "").trim().isEmpty()) ? null : token[index].replace("abbreviation,", "").trim();
							else if(token[index].contains("umlscui,"))
								umlscui = (token[index].replace("umlscui,", "").trim().isEmpty()) ? null : token[index].replace("umlscui,", "").trim();
							else if(token[index].contains("snomedctid,"))
								snomedctid = (token[index].replace("snomedctid,", "").trim().isEmpty()) ? null : token[index].replace("snomedctid,", "").trim();
							
							index++;
						}
						
						//Percorre tokens
						for(String token_id : token_ids){
							//Percorre tags
							for(String tag_id : tags){
								//Define nova anotação
								Anotacao a = new Anotacao();
								
								a.tag_id = Integer.parseInt(tag_id);
								a.token_id = Integer.parseInt(token_id);
								a.termocomposto_id = uid.toString();
								a.anotador_id = anotador_id;
				            	a.adjudicador = true;//Marca como adjudicação
				            	
				            	//Se foi informada abreviatura e está inserindo a tag de abbr
				            	//TODO: Usar a coluna tipo para saber se é tag de abreviatura
				            	a.abreviatura = (tag_id.equals("131") || tag_id.equals("271")) ? abbr : null;
				            	
				            	a.umlscui = umlscui;
				            	a.snomedctid = snomedctid;
				            	
				            	//Se pediu para finalizar, finaliza anotação
				            	if(finalize)
				            		a.status = TextoStatus.FINALIZADO;
				            	else
				            		a.status = TextoStatus.ADJUDICACAO;
				            	
				            	//Insere anotação no banco de dados
				            	a.insert();
								
							}
							
						}
						
						
					}
				}
			}
			catch(Exception e){
				System.out.println("Erro na inserção dos termos compostos");
				e.printStackTrace();
				status = false;
				//Anotacao.deleteAdjudicacoesByTextoIdAndUserId(text_id, u.id);
			}
		
		}
		
		//Obtém anotações de RELACIONAMENTOS
		try{
			String[] relations = request.getParameterValues("relations[]");
			if(relations != null){
				for(String v : relations){
					
					//Separa em TERMO1, RELACIONAMENTO, TERMO1
					String[] arr = v.split(":");
					
					//Obtém TOKENID(s) do TERMO 1
					//String[] tokens1 = arr[0].split(",");
					//Obtém RELACIONAMENTO associados
					String[] rels = arr[1].split(",");
					//Obtém TOKENID(s) do TERMO 2
					//String[] tokens2 = arr[2].split(",");
					
					//Percorre tipos de relacionamentos (tipos semanticos associados aos tokens)
					for(String rel_id : rels){
						
						//Define novo relacionamento
						Relacionamento r = new Relacionamento();
						
						r.tokens1 = arr[0];//Armazena token_ids separados por vírgula
						r.tokens2 = arr[2];//Armazena token_ids separados por vírgula
						r.tiporelacionamento_id = Integer.parseInt(rel_id);
						r.anotador_id = anotador_id;
						r.adjudicador = 1;//Define como relacionamento ADJUDICADO
						
						//Salva no banco de dados
						r.insert();
						
					}
					
					
				}
			}
		}
		catch(Exception e){
			System.out.println("Erro na inserção dos relacionamentos");
			e.printStackTrace();
			//status = false;
			//Anotacao.deleteAnotacoesByTextoIdAndUserId(text_id, u.id);
		}
		
		//Se inserção deu certo e foi pedido para finalizar anotação
		if(finalize && status){
			//Coloca texto com status FINALIZADO para todos anotadores
			//Tabela que relaciona anotadores ao texto
			Alocacaotexto.updateStatus(text_id, TextoStatus.FINALIZADO);
			//Tabela de textos
		 	Texto.updateStatus(text_id,  TextoStatus.FINALIZADO);
		 	
		}

		out.print("{\"status\":"+status+"}");
		
	}

}
