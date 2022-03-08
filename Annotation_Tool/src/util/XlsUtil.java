package util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

public class XlsUtil {
	
	private static WritableWorkbook workbookw;
	private static WritableSheet sheetW;
	private static Workbook workbook;
	private static Sheet sheet;
	
	public static void openXLS(InputStream file){
		
		try{
			//Define o charset
			WorkbookSettings ws = new WorkbookSettings();
			ws.setEncoding("ISO-8859-1"); 
			//Abre o XLS como somente leitura
			workbook = Workbook.getWorkbook(file,ws);
			//Seleciona a primeira planilha
			sheet = workbook.getSheet(0);
		}
		
		catch(java.io.FileNotFoundException e){
				System.out.println("Arquivo não encontrado");}
		
		catch(Exception e){
			e.printStackTrace();}
	}
	
	public static ArrayList<String> getTexts(){
		
		//Instancia uma lista para guardar os textos
		ArrayList<String> textos = new ArrayList<String>();
		try{
			for(int i = 0; i < sheet.getRows(); i++){
				//Seleciona os textos da primeira coluna
				String s = sheet.getCell(0, i).getContents();
				//Verifica se uma célula que foi selecionada não possui texto
				if(s != "")
					textos.add(sheet.getCell(0, i).getContents());
				//Em alguns poucos arquivos, o jxl lia linhas a mais após os textos terem terminado, por isso a verificação
			}
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		
		return textos;
	}
	
	
	public static void createXLS(String filename, String sheetname){
		
		try {
			workbookw = Workbook.createWorkbook(new File(filename));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		sheetW = workbookw.createSheet(sheetname, 0);
		
	}
	
	public static void addCell(int coluna, int linha, String text){
	
		Label label = new Label(coluna, linha, text); 
		
		try {
			sheetW.addCell(label);
		} catch (RowsExceededException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	
	}
	
	public static void closeXLS(){
		
		try {
			workbookw.write();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		try {
			workbookw.close();
		} catch (WriteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
