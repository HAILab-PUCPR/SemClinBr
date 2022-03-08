package helper;

import java.util.ArrayList;

import model.Usuario;

public class StatisticsHelper {
	
	public static String projectAgreement(ArrayList<Usuario> usuarios, int projeto_id){
		String html = "";
		for(Usuario u1 : usuarios)
			for (Usuario u2 : usuarios)
				if(u1.equals(u2))
					html += "<td>1.0</td>";
				else
					html += "<td>"+kappa()+"</td>";
		return html;
	}
	
	//TODO
	public static float kappa(){
		return 0.0f;
	}
	
}
