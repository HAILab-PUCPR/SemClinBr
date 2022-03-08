package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import model.Texto;
import model.Token;
import util.AcronymTagger;
import util.Tokenizer;
import util.XlsUtil;


/**
 * Servlet implementation class textImport
 */
public class TextImport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TextImport() {
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
		HttpSession session = request.getSession();
		try {
			
			int projectid = (int) session.getAttribute("projectid");
			//int projeto_id = Integer.parseInt(request.getAttribute("projecto_id").toString());
	        List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	        for (FileItem item : items) {
	            if (item.isFormField()) {
	                // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
	                //String fieldName = item.getFieldName();
	                //String fieldValue = item.getString();
	                // ... (do your job here)
	            } else {
	                // Process form file field (input type="file").
	                String fieldName = item.getFieldName();
	                String a = item.getName();
	                String fileName = FilenameUtils.getName(item.getName());
	                InputStream fileContent = item.getInputStream();
	               
	                //Abre e le o arquivo XLS usando a ferramenta JXL
	                XlsUtil.openXLS(fileContent);
	                ArrayList<String> textos = XlsUtil.getTexts();
	               
	                for(String s:textos){
	                	//Insere os textos no BD
	                	Texto t = new Texto(s);
	                	t.insert(projectid);
	                	
	                	//Separa sentenças, tokeniza e insere no BD
	                	//Tokenizer.tokenizaCogroo(t);
	                	Tokenizer.tokenizaString(t);
	                
	                	
	                }

	                //Redireciona para LISTAGEM DE TEXTOS (textList.jsp)
	    			response.sendRedirect("../textList.jsp?id=" + projectid);
	                
	            }
	        }
	    } catch (FileUploadException e) {
	        throw new ServletException("Cannot parse multipart request.", e);
	    }
		
		
	}

}
