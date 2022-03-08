package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import connection.DbConnection;

/*
 * SQL para importar tipos semânticos UMLS/SNOMED
 * INSERT INTO annotationtool.tags (projeto_id, tag, extra_id, hierarquia, status, tipo, cor)
  		SELECT 1, STY_RL, UI, STN_RTN, "A", null , SUBSTRING((lpad(hex(round(rand() * 10000000)),6,0)),-6)
  		FROM 2016ab_net.srdef WHERE RT = "STY";
  		
  	SQL para importar RELACIONAMENTOS UMLS/SNOMED
  	INSERT INTO `annotationtool`.`tiposrelacionamentos` (`nome`, `traducao`, `extra_id`, `hierarquia`, `status`)
  		SELECT STY_RL, "", UI, STN_RTN, "A" 
  		FROM 2016ab_net.srdef WHERE RT = "RL";
 */

public class Tag {

	public int id;
	public int projeto_id;
	public String tag;
	public String extra_id;
	public String hierarquia;
	public String status;
	public String tipo;
	public String cor;
	
	public Tag(){}
	
	public Tag(int id, String tag, String extra_id, String tipo){
		this.id = id;
		this.tag = tag;
		this.extra_id = extra_id;
		this.tipo = tipo;
	}
	
	public Tag(int id){
		this.id = id;
	}

	public static ArrayList<Tag> findByProjectId(int projeto_id){
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tags WHERE projeto_id = ? AND status='A' ORDER BY tag");
			ps.setInt(1, projeto_id);
			ResultSet res = ps.executeQuery();
			
			ArrayList<Tag> tags = new ArrayList<Tag>();
			
			while (res.next()) {
				 Tag t = new Tag();
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.tag = res.getString("tag");
				 t.tipo = res.getString("tipo");
				 t.cor = res.getString("cor");
				 t.extra_id = res.getString("extra_id");
				 t.hierarquia = res.getString("hierarquia");
				 
				 tags.add(t);
			 }
			 
			return tags;
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return null;
	}
	
	//Retorna somente o id
	public static int findIdByTag(String tag){
		int id = 0;
		
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT id FROM tags WHERE tag = ?");
			ps.setString(1, tag);
			ResultSet res = ps.executeQuery();
			if (res.next()) {
				 id = res.getInt("id");
			 }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return id;
	}
	
	public static int findIdByCodeAndProject(String code, int project_id){
		int id = 0;
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT id FROM tags WHERE extra_id = ? AND projeto_id = ?");
			ps.setString(1, code);
			ps.setInt(2, project_id);
			ResultSet res = ps.executeQuery();
			if (res.next()) {
				 id = res.getInt("id");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return id;
	}
	
	public static Tag findById(int id){
		
		Tag t = new Tag();
		try {
			
			PreparedStatement ps = (PreparedStatement) DbConnection.getInstance().getConnection().prepareStatement("SELECT * FROM tags WHERE id = ?");
			ps.setInt(1, id);
			ResultSet res = ps.executeQuery();
			if (res.next()) {
			
				 t.id = res.getInt("id");
				 t.projeto_id = res.getInt("projeto_id");
				 t.tag = res.getString("tag");
				 t.tipo = res.getString("tipo");
				 t.cor = res.getString("cor");
				 t.extra_id = res.getString("extra_id");
				 t.hierarquia = res.getString("hierarquia");
				 
				 return t;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		
		return t;
	}
		
}
