package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Usuario;

/**
 * Servlet implementation class Authentication
 */
public class Authentication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Authentication() {
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
		
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		//Obtém campos enviados via POST pelo formulário
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		//Instancia novo usuário
		Usuario u = new Usuario();
		//Busca usuário com LOGIN e SENHA informados
		u = u.findByLoginAndSenha(login, senha);
		
		if(u == null){
			//response.sendRedirect("../index.html");
			//RequestDispatcher dispatcher = request.getRequestDispatcher("../index.jsp");
			//dispatcher.forward(request, response); 
			session.setAttribute( "error", "Usuário ou senha inválida");
			response.sendRedirect("../index.jsp");
		}
		else{
			session.setAttribute("usuario", u);
			//request.getRequestDispatcher("../painel.jsp").forward(request, response);
			
			//Atualiza o horario do ultimo login do usuario
			u.updateLastAcess();
			response.sendRedirect("../painel.jsp");
		}
		
		
	}

}
