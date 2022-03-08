package test;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;
import model.Anotacao;
import model.Texto;
import model.Usuario;
import util.Number;
import util.XlsUtil;

public class GenerateMetrics {

	public static void main(String[] args) {

		TESTAR/VERIFICAR CALCULO DAS METRICAS
		CALCULAR AGREEMENT
		CRIAR GRAFICO DE MELHORIA DE AGREEMENT DURANTE O PROJETO
		
		
		
		//Cria arquivo XLS
		XlsUtil.createXLS("output\\experiments-final.xls", "Results");
		XlsUtil.addCell(0, 0, "Texto");
		XlsUtil.addCell(1, 0, "Qtde anotações 1");
		XlsUtil.addCell(2, 0, "TP 1");
		XlsUtil.addCell(3, 0, "FP 1");
		XlsUtil.addCell(4, 0, "FN 1");
		XlsUtil.addCell(5, 0, "Precision 1");
		XlsUtil.addCell(6, 0, "Recall 1");
		XlsUtil.addCell(7, 0, "F-Measure 1");
		XlsUtil.addCell(8, 0, "Qtde anotações 2");
		XlsUtil.addCell(9, 0, "TP 2");
		XlsUtil.addCell(10, 0, "FP 2");
		XlsUtil.addCell(11, 0, "FN 2");
		XlsUtil.addCell(12, 0, "Precision 2");
		XlsUtil.addCell(13, 0, "Recall 2");
		XlsUtil.addCell(14, 0, "F-Measure 2");
		
		int cont = 1;
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT\r\n" + 
					"	id\r\n" + 
					"FROM\r\n" + 
					"	textos t \r\n" + 
					"WHERE\r\n" + 
					"	t.projeto_id = 1");
			ResultSet res = ps.executeQuery();
			
			while (res.next()) {

				int texto_id = res.getInt("id"); 
				
				System.out.println("====== Texto " + texto_id + " ======");
				
				//Obtém texto
				Texto texto = Texto.findById(texto_id);
				
				//Busca quais anotadores participaram da anotação deste texto
			 	ArrayList<Usuario> performedAnnotators = Anotacao.findTextPerformedAnnotators(texto_id);
				
				int qtdeAnotacoes1 = Anotacao.getNumberAnotacoesSimples(texto_id, performedAnnotators.get(0).id) + Anotacao.getNumberAnotacoesCompostas(texto_id, performedAnnotators.get(0).id); 
				int qtdeAnotacoes2 = Anotacao.getNumberAnotacoesSimples(texto_id, performedAnnotators.get(1).id) + Anotacao.getNumberAnotacoesCompostas(texto_id, performedAnnotators.get(1).id);
				
				int TPsimples1 = Anotacao.getNumberConcordantesSimples(texto_id, performedAnnotators.get(0).id);
				int TPcompostos1 =  Anotacao.getNumberConcordantesCompostos(texto_id, performedAnnotators.get(0).id);
				float TP1 = TPsimples1 + TPcompostos1;
				
				int FPsimples1 = Anotacao.getNumberDiscordantesSimples(texto_id, performedAnnotators.get(0).id);
				int FPcompostos1 =  Anotacao.getNumberDiscordantesCompostos(texto_id, performedAnnotators.get(0).id);
				float FP1 = FPsimples1 + FPcompostos1;
				
				int FNsimples1 = Anotacao.getNumberDiscordantesAdjudicadorSimples(texto_id, performedAnnotators.get(0).id);
				int FNcompostos1 =  Anotacao.getNumberDiscordantesAdjudicadorCompostos(texto_id, performedAnnotators.get(0).id);
				float FN1 = FNsimples1 + FNcompostos1;
				
				Double Precision1 = new Double(TP1 / (TP1 + FP1));
				Double Recall1 = new Double(TP1 / (TP1 + FN1));
				Double FMeasure1 = new Double(2 * Precision1 * Recall1 / (Precision1 + Recall1));
				
				int TPsimples2 = Anotacao.getNumberConcordantesSimples(texto_id, performedAnnotators.get(1).id);
				int TPcompostos2 =  Anotacao.getNumberConcordantesCompostos(texto_id, performedAnnotators.get(1).id);
				float TP2 = TPsimples2 + TPcompostos2;
				
				int FPsimples2 = Anotacao.getNumberDiscordantesSimples(texto_id, performedAnnotators.get(1).id);
				int FPcompostos2 =  Anotacao.getNumberDiscordantesCompostos(texto_id, performedAnnotators.get(1).id);
				float FP2 = FPsimples2 + FPcompostos2;
				
				int FNsimples2 = Anotacao.getNumberDiscordantesAdjudicadorSimples(texto_id, performedAnnotators.get(1).id);
				int FNcompostos2 =  Anotacao.getNumberDiscordantesAdjudicadorCompostos(texto_id, performedAnnotators.get(1).id);
				float FN2 = FNsimples2 + FNcompostos2;
				
				Double Precision2 = new Double(TP2 / (TP2 + FP2));
				Double Recall2 = new Double(TP2 / (TP2 + FN2));
				Double FMeasure2 = new Double(2 * Precision2 * Recall2 / (Precision2 + Recall2));
				
				System.out.println("TP1: "+ TP1);
				System.out.println("FP1: "+ FP1);
				System.out.println("FN1: "+ FN1);
				System.out.println("P1: "+ Precision1);
				System.out.println("R1: "+ Recall1);
				System.out.println("FM2: "+ FMeasure2);
				System.out.println("TP2: "+ TP2);
				System.out.println("FP2: "+ FP2);
				System.out.println("FN2: "+ FN2);
				System.out.println("P2: "+ Precision2);
				System.out.println("R2: "+ Recall2);
				System.out.println("FM2: "+ FMeasure2);
				
				//Escreve dados no Excel
				XlsUtil.addCell(0, cont, texto.texto);
				XlsUtil.addCell(1, cont, qtdeAnotacoes1+"");
				XlsUtil.addCell(2, cont, TP1+"");
				XlsUtil.addCell(3, cont, FP1+"");
				XlsUtil.addCell(4, cont, FN1+"");
				XlsUtil.addCell(5, cont, Number.round(Precision1.doubleValue(), 3)+"");
				XlsUtil.addCell(6, cont, Number.round(Recall1.doubleValue(), 3)+"");
				XlsUtil.addCell(7, cont, Number.round(FMeasure1.doubleValue(), 3)+"");
				XlsUtil.addCell(8, cont, qtdeAnotacoes2+"");
				XlsUtil.addCell(9, cont, TP2+"");
				XlsUtil.addCell(10, cont, FP2 + "");
				XlsUtil.addCell(11, cont, FN2 + "");
				XlsUtil.addCell(12, cont, Number.round(Precision2.doubleValue(), 3)+"");
				XlsUtil.addCell(13, cont, Number.round(Recall2.doubleValue(), 3)+"");
				XlsUtil.addCell(14, cont, Number.round(FMeasure2.doubleValue(), 3)+"");
	
				cont++;
				
			}
				
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		XlsUtil.closeXLS();

	}

}
