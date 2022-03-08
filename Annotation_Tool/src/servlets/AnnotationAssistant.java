package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Tag;
import model.Token;
import model.Usuario;
import umls.API;
import umls.Concept;
import umls.SemanticType;

/**
 * Servlet implementation class AnnotationAssitant
 */
public class AnnotationAssistant extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnotationAssistant() {
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
		Integer project_id = (int) session.getAttribute("projectid");
		//Obtém ID do anotador
		int anotador_id = u.id;
		//Obtém ID do texto anotado
		int text_id = Integer.parseInt(request.getParameter("id"));
		//Obtém ID da SENTENÇA enviada
		int sentence_id = Integer.parseInt(request.getParameter("sentence_id"));
		
		JSONObject json = new JSONObject();
		json.put("project_id", project_id);
		json.put("text_id", text_id);
		json.put("sentence_id", sentence_id);

        JSONArray jsonlist = new JSONArray();
        
		boolean status = true;
		//Obtém TOKENS
		//tokens[] = {"Hipertensão", "arterial", "sistêmica"}
		//ids[] = {3340, 3341, 3342}
		try{
			String[] tokens = request.getParameterValues("tokens[]");
			String[] tokenIds = request.getParameterValues("ids[]");
			//Se existem TOKENS
			if(tokens != null){
				//Percorre TOKENS
				for(int i = 0; i < tokens.length; i++){
					//Obtém TOKEN
					String token = tokens[i];
					//Obtém TOKENID
					int token_id = Integer.parseInt(tokenIds[i]);
					//Cria objeto TOKEN
					Token tokenObj = new Token(token_id, token);

					//TODO: Retirar preposições, acentuações/pontuações, etc
					//Se tem LETRAS e TAMANHO > 1
					if(token.matches(".*[a-zA-Z]+.*") && token.length() > 1 && !token.equalsIgnoreCase("em") && !token.equalsIgnoreCase("para") ){
						
						//Busca possíveis termos compostos a partir do token atual
						ArrayList<Concept> cs = Concept.findCompoundTerms(i, tokens, tokenIds);
						
						//Se NÃO encontrou nenhum termo composto na sequencia dos próximos 6 tokens
						if(cs.size() < 1){
							//Busca pelo TOKEN ATUAL no banco UMLS LOCAL TRADUZIDO
							cs = Concept.findByName(token);
						}
						else{
							//Incrementa contador para não precisar mais buscar os próximos tokens
							//Pois já foi encontrado um termo composto
							i = i + Concept.compoundTermMaxSizeFound;
						}
						
						//Se encontrou
						if(cs.size() > 0){

							//Percorre conceitos encontrados
							for(Concept c : cs){
								
								API api = new API();
								
								//Obtém informações detalhadas do Conceito na UMLS (tipos semanticos)
								c = api.getConceptInfo(c);
								
								//Define relação do CONCEITO ao TOKEN no texto
								//Se não for termo composto, define apenas token atual
								if(c.tokens.size() < 1)
									c.tokens.add(tokenObj);
								
								//Cria objeto JSON para o CONCEITO
								JSONObject jsonC = new JSONObject();
								jsonC.put("CUI", c.CUI);
								jsonC.put("name", c.name);
								jsonC.put("URI", c.URI);
								jsonC.put("rootSource", c.rootSource);
								
								//Percorre tipos semânticos
								JSONArray jsonsemlist = new JSONArray();
								for(SemanticType st : c.semanticTypes){
									JSONObject jsonS = new JSONObject();
									jsonS.put("id", Tag.findIdByCodeAndProject(st.code, project_id));//Busca ID do banco local baseado no CODE da UMLS
									jsonS.put("code", st.code);
									jsonS.put("name", st.name);
									jsonsemlist.add(jsonS);
								}
								jsonC.put("semanticTypes", jsonsemlist);
								
								//Percorre tokens
								JSONArray jsontoklist = new JSONArray();
								for(Token t : c.tokens){
									JSONObject jsonT = new JSONObject();
									jsonT.put("id", t.id);
									jsonT.put("token", t.token);
									jsontoklist.add(jsonT);
								}
								jsonC.put("tokens", jsontoklist);
								
								//Adiciona conceito no ARRAY
								jsonlist.add(jsonC);

						        
								
							}
							
						}
						
						
					}
					
				}
			}
		}
		catch(Exception e){
			System.out.println("Erro na alocação dos tokens para busca via API");
			e.printStackTrace();
			status = false;
		}
		
		//Adiciona STATUS da operação
		json.put("status", status);
		
		//Se deu tudo certo durante a busca
		if(status){
			//Adiciona ARRAY de conceitos no objeto
			json.put("concepts", jsonlist);
		}

		//Efetua saída do JSON
		out.print(json.toJSONString());
		
		
	}

}
