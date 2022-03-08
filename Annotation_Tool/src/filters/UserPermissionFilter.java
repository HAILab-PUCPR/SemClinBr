package filters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Permissao;
import model.Usuario;

public class UserPermissionFilter implements Filter {
	
	ArrayList<String> urlSkipList;

	public void init(FilterConfig config) throws ServletException {
		String urls = config.getInitParameter("skip-urls");
		if(urls != null){
			StringTokenizer token = new StringTokenizer(urls, ",");
	
			urlSkipList = new ArrayList<String>();
	
			while (token.hasMoreTokens()) 
				urlSkipList.add(token.nextToken());
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain next)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String url = req.getServletPath();
		
		if(!urlSkipList.contains(url)) {
			
			HttpSession session = req.getSession(false);
			if (null == session){
				res.sendRedirect("index.jsp");
				return;
			}
			else {
				Usuario u = (Usuario) session.getAttribute("usuario");
				if(u == null){
					res.sendRedirect("index.jsp");
					return;
				}
				int permissao = Permissao.findPermissionByPage(url);
				
				if(permissao == -1); //Não existe entrada no BD para a pagina - Libera o acesso
				else{
					int a = (permissao & u.permissao);
					//System.out.println("Pagina: " + url);
					//System.out.println("Pagina perm: " + permissao);
					//System.out.println("User perm: " + u.permissao);
					//System.out.println("Result: " + a);
					if(a == 0){
						System.out.println("Sem permissão!");
						res.sendRedirect("painel.jsp");
						return;
					}
				}
			}	
		}
		next.doFilter(request, response);
	}

	public void destroy() {

	}
}
;