package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Alocacaotexto;
import model.Anotacao;
import model.Relacionamento;
import model.Sentenca;
import model.Texto;
import model.Token;
import model.Usuario;
import util.AcronymTagger;
import util.Tokenizer;

/**
 * Servlet implementation class TextReview
 */
public class TextReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TextReview() {
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
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		//response.setContentType("text/html");
		//response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		//Obtém usuário autenticado
		Usuario u = (Usuario) session.getAttribute("usuario");
		Integer projectid = (int) session.getAttribute("projectid");
		
		//Obtém campos enviados via POST pelo formulário
		String id = request.getParameter("id");
		String texto = request.getParameter("texto");
		String status = request.getParameter("status");
		int[] selectedUsersId = Arrays.stream(request.getParameterValues("selectedUser")).mapToInt(Integer::parseInt).toArray();
		//int[] selectedUsersId = {5,6};
		//Instancia novo texto
		Texto t = new Texto();

		t.aprovador_id = (u == null) ? 1 : u.id;
		t.id = Integer.parseInt(id);
		t.status = status;
		t.texto = texto;
		
		//Atualiza TEXTO e STATUS
		if(t.updateTextAndStatus()){
			
			//Apaga possíveis anotações, tokens e sentencas do texto atual
			//TODO: Refazer função para apagar relacionamentos do texto para todos usuários
			//Relacionamento.deleteRelacionamentosByTextoId(t.id);
			Anotacao.deleteAnotacoesByTextoId(t.id);
			Token.deleteTokensByTextoId(t.id);
			Sentenca.deleteSentencasByTextoId(t.id);
			
			//Envia texto corrigido para a tabela de SENTENCAS e TOKENS
			Tokenizer.tokenizaString(t); 
			
			//Limpar a tabela e define usuarios alocados para o texto
			Alocacaotexto.alocateUsersToText(selectedUsersId, t.id, status);
			
			response.sendRedirect("../textList.jsp?id=" + projectid);
		}
		else{
			response.sendRedirect("../textReview.jsp?id=" + id);
		}
		
	}

}
