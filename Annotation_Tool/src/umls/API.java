package umls;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import model.Token;

public class API {

	public static String apiKey = "41269c76-1628-4df6-9cea-a26f6149be2d";
	//version is not a required argument - if left out you will search against the latest UMLS publication
	public static String version = "2016AB";
	
	public static String tgt = getTGT();
	
	public String st;
	
	public Concept getConceptInfo(Concept concept){
		//System.out.println("==== getConceptInfo = " + concept.name + " =====");
		//System.out.println("TGT: " + API.tgt);
		
		try {
			
			HttpClient httpClient = HttpClientBuilder.create().build();
		    
	    	String output = "", o;
	    	
	    	URIBuilder builder = new URIBuilder();
		    builder
		    	.setScheme("https")
		    	.setHost("uts-ws.nlm.nih.gov")
		    	.setPath("/rest/content/current/CUI/" + concept.CUI)
		    	.setParameter("ticket", getServiceTicket());
		   
		    HttpGet getRequest = new HttpGet(builder.build());
	    	
			HttpResponse response = httpClient.execute(getRequest);
			
			if (response.getStatusLine().getStatusCode() != 200) {
				System.out.println("==== getConceptInfo = " + concept.name + " =====");
				System.out.println("TGT: " + API.tgt);
				System.out.println("HTTP error code : " + response.getStatusLine().getStatusCode() + " - " +builder.build());
			}
			
			BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));
			
			while ((o = br.readLine()) != null) {
				output += o;
			}
			
			JSONParser parser = new JSONParser();

	        try {

	            Object obj = parser.parse(output);

	            JSONObject jsonObject = (JSONObject) obj;
	            
	            JSONObject result = (JSONObject) jsonObject.get("result");

	            JSONArray semanticTypes = (JSONArray) result.get("semanticTypes");
	 
	            /*
	             *  "semanticTypes": [
			            {
			                "name": "Injury or Poisoning",
			                "uri": "https://uts-ws.nlm.nih.gov/rest/semantic-network/2015AB/TUI/T037"
			            }
			        ],
	             */
	            Iterator<JSONObject> iterator = semanticTypes.iterator();
	            while (iterator.hasNext()) {
	            	JSONObject item = iterator.next();
	            	
	            	String name = (String) item.get("name");
	            	String code = (String) item.get("uri");
	            	String[] aux = code.split("/");
	            	code = aux[aux.length-1];
	            	
                	concept.semanticTypes.add(new SemanticType(code, name));
	                
	            }
	            
	        }
	        catch(Exception e){
	        	
	        }
	        
		}
		catch(Exception e){
	        	
	    }

		
		return concept;
		
	}
	
	/**
	 * Busca termos pelo nome
	 * @param terms
	 * @return
	 * @deprecated
	 */
	public ArrayList<Concept> searchTermsByName(ArrayList<String> terms){
		
		ArrayList<Concept> concepts = new ArrayList<Concept>();
		try {
			
			HttpClient httpClient = HttpClientBuilder.create().build();
		    
		    //Percorre termos
		    for(String term : terms){
		    
		    	String output = "", o;
		    	
		    	System.out.println("\n\n===========" + term + "=============");
		    	
		    	URIBuilder builder = new URIBuilder();
			    builder
			    	.setScheme("https")
			    	.setHost("uts-ws.nlm.nih.gov")
			    	.setPath("/rest/search/" + version)
			    	.setParameter("ticket", getServiceTicket())
			    	.setParameter("string", term)
			    	.setParameter("searchType", "exact")//valid values are exact,words, approximate,leftTruncation,rightTruncation, and normalizedString
			    	.setParameter("pageSize", "5")
			    	.setParameter("sabs", "WHOPOR,ICPCPOR,MDRPOR,MSHPOR");//Busca apenas nos vocabulários em pt-br
				    //.setParameter("sabs", "SNOMEDCT_US")//uncomment to return CUIs that have at least one matching term from the US Edition of SNOMED CT 
			    	//.setParameter("returnIdType", "sourceConcept")//uncomment to return SNOMED CT concepts rather than UMLS CUIs.
			    	//.setParameter("pageNumber", pageNumber);
			   
			    HttpGet getRequest = new HttpGet(builder.build());
		    	
				HttpResponse response = httpClient.execute(getRequest);
				
				if (response.getStatusLine().getStatusCode() != 200) {
					System.out.println("HTTP error code : " + response.getStatusLine().getStatusCode() + " - " +builder.build());
				}
				
				BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));
				
				while ((o = br.readLine()) != null) {
					output += o;
				}
				
				JSONParser parser = new JSONParser();

		        try {

		            Object obj = parser.parse(output);

		            JSONObject jsonObject = (JSONObject) obj;
		            //System.out.println(jsonObject);

		            JSONObject result = (JSONObject) jsonObject.get("result");
		            //System.out.println(result);

		            JSONArray results = (JSONArray) result.get("results");
		            //System.out.println(results);
		            Iterator<JSONObject> iterator = results.iterator();
		            while (iterator.hasNext()) {
		            	JSONObject item = iterator.next();
		            	//Se não existem resultados
		                if(item.get("ui").equals("NONE") && item.get("name").equals("NO RESULTS")){
		                	//System.out.println("Não existem resultados");
		                }
		                else{
		                	/*System.out.println(item.get("name"));
		                	System.out.println(item.get("rootSource"));
		                	System.out.println(item.get("uri"));
		                	System.out.println(item.get("ui"));
		                	System.out.println("------------------------");*/
		                	Concept c = new Concept(item);
		                	
		                	concepts.add(c);
		                }
		            }
		            
		            /*
		             * {

					    "ui": "C0009044",
					    "rootSource": "SNOMEDCT_US",
					    "uri": "https://uts-ws.nlm.nih.gov/rest/content/2015AA/CUI/C0009044",
					    "name": "Closed fracture carpal bone"
					
					}
		             */
		           

		        } catch (ParseException e) {
		            e.printStackTrace();
		        }

				
		    }
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return concepts;
		
	}
	
	/**
	 * Obtém Service Ticket - A Service Ticket expires after one use or five minutes from the time of generation, whichever comes first. Each REST API call requires a new Service Ticket.
	 * Use your service tickets as the value for the ‘ticket’ query parameter in GET calls to https://uts-ws.nlm.nih.gov/rest, such as this call to retrieve information about CUI:C0018787: 
	 * https://uts-ws.nlm.nih.gov/rest/content/current/CUI/C0018787?ticket=ST-134-HUbXGfI765aSj0UqtdvU-cas
	 * @return
	 */
	public String getServiceTicket(){
		
		//System.out.println("--- getServiceTicket() ---");
		
		String output = "", o;
		try {
			
			HttpClient httpClient = HttpClientBuilder.create().build();
			
			URIBuilder builder = new URIBuilder();
		    builder.setScheme("https").setHost("utslogin.nlm.nih.gov").setPath("/cas/v1/tickets/" + tgt);
		   
		    HttpPost postRequest = new HttpPost(builder.build());
		    
		    List<NameValuePair> params = new ArrayList<NameValuePair>();
		    params.add(new BasicNameValuePair("service", "http://umlsks.nlm.nih.gov"));
		    postRequest.setEntity(new UrlEncodedFormEntity(params));
		    
			HttpResponse response = httpClient.execute(postRequest);
			
			if (response.getStatusLine().getStatusCode() != 200) {
				System.out.println("--- getServiceTicket() ---");
				System.out.println("HTTP error code : " + response.getStatusLine().getStatusCode() + " - " +builder.build());
			}
			
			BufferedReader br = new BufferedReader(new InputStreamReader((response.getEntity().getContent())));
			
			while ((o = br.readLine()) != null) {
				output += o;
			}
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		st = output;
		//System.out.println("ST: " + st);
		
		return output;
		
	}
	
	/**
	 * Obtém Ticket-Granting Ticket - Válido por 8 horas
	 * @return
	 */
	public static String getTGT(){
		
		
		try {
			
			HttpClient httpClient = HttpClientBuilder.create().build();
			
			URIBuilder builder = new URIBuilder();
		    builder.setScheme("https").setHost("utslogin.nlm.nih.gov").setPath("/cas/v1/api-key");
		   
		    
		    HttpPost postRequest = new HttpPost(builder.build());
		    
		    List<NameValuePair> params = new ArrayList<NameValuePair>();
		    params.add(new BasicNameValuePair("apikey", apiKey));
		    postRequest.setEntity(new UrlEncodedFormEntity(params));
		    
			HttpResponse response = httpClient.execute(postRequest);
			
			if (response.getStatusLine().getStatusCode() != 201) {
				System.out.println("--- getTgt() ---");
				System.out.println("HTTP error code : " + response.getStatusLine().getStatusCode() + " - " +builder.build());
			}
 
			Header h[] = response.getAllHeaders();
			for(int i = 0; i < h.length; i++){
				if(h[i].getName().equals("Location")){
					return h[i].getValue().substring(h[i].getValue().indexOf("TGT"));
				}
			}
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
		
	}

}
