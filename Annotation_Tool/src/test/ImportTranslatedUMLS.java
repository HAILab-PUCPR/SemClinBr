package test;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

public class ImportTranslatedUMLS {
	
	public static void main(String[] args) throws FileNotFoundException, IOException{
		int count = 0;
		//Open the UMLS list file
		try (BufferedReader br = new BufferedReader(new FileReader("input/umls2013.european.and.brazilian.portuguese.TRANSLATED.FINAL-2ndexecution.txt"))) {
		    String line;
		    
		    //Iterate lines
		    while ((line = br.readLine()) != null) {
		    	
		    	//Remove quotation
		    	line = line.replace("\"", "");
		    	
		    	//Separate two columns (UMLS CODE and UMLS TERM)
		    	String[] split = line.split("\t");
		    	String umlscode = split[0];
		    	String umlsoriginalname = split[1];
		    	String umlsname = split[2];
		    	
		    	try{
					Connection conn = DbConnection.getInstance().getConnection();
					
					PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO translatedumls (CUI, originalname, name) VALUES (?, ?, ?)");
					ps.setString(1, umlscode);
					ps.setString(2, umlsoriginalname);
					ps.setString(3, umlsname);
					ps.execute();
					
					count++;
					
					System.out.println(count + " = " + umlscode);
				}
				catch (SQLException e){
					System.out.println("Erro inserir no BD = " + umlscode + " = " + umlsname);
					e.printStackTrace();
				}	
		    	
		    }
		    
		}
		
	}

}
