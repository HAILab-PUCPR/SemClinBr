package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import model.Alocacaotexto;
import model.Anotacao;
import model.Permissao;
import model.Texto;
import model.Usuario;

/**
 * Servlet implementation class TextList
 */
public class TextList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TextList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		PrintWriter out = response.getWriter();
		
		//Obtém ID do texto com status alterado
		int text_id = Integer.parseInt(request.getParameter("text_id"));
		//Obtém valor selecionado
		String text_status = request.getParameter("selected_value");
		//Obtém ID do usuário
		int user_id = ((Usuario) session.getAttribute("usuario")).id;
		boolean result;
		
		//Se é ADMINISTRADOR
		//Atualiza status para TODOS usuários relacionados ao texto
		if(Permissao.isOnlyAdmin((Usuario)session.getAttribute("usuario"))){
			//Tabela que relaciona anotadores ao texto
			result = Alocacaotexto.updateStatus(text_id, text_status);
			//Tabela de textos
		 	Texto.updateStatus(text_id, text_status);
		 	//Tabela de anotações
		 	Anotacao.updateStatus(text_id, text_status);
		}
		else{
			//Atualiza status apenas para usuário atual - OPÇÃO DESABILITADA NA INTERFACE
			result = Alocacaotexto.updateStatus(text_id, user_id, text_status);
		}
		
		//Retorna resultado da operação
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		//Efetua saída do JSON
		out.print(json.toJSONString());
	}

}