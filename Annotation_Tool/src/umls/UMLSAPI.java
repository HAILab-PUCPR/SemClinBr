package umls;

import java.util.ArrayList;


/*This example allows you to search terms in the UMLS
Examples are at https://github.com/jayway/rest-assured/tree/master/examples/rest-assured-itest-java/src/test/java/com/jayway/restassured/itest/java
For convenience, google's quick json parser is also included in the pom.xml file:
https://code.google.com/p/quick-json/
You can run this class as a Junit4 test case - be sure and put each of the arguments as VM arguments
You may page through results returned from the /search endpoint until you reach the null  'ui:NONE' or 'name:NO RESULTS'.  These results will always be a single result on their own page.
in your runtime configuration, such as -Dapikey -Dterm = "diabetic foot"

*/

public class UMLSAPI {

/*	public static String apiKey = "04a60822-a6b8-4d70-896d-c00707605359";
	//version is not a required argument - if left out you will search against the latest UMLS publication
	public static String version = "2016AB";
	public static RestTicketClient ticketClient = new RestTicketClient(apiKey);
	//get a ticket granting ticket for this session.
	public static String tgt = ticketClient.getTgt();
	

	public static void getUMLSTerms(ArrayList<String> terms) throws Exception {
		
		for(String term : terms){
			
			System.out.println("==== SEARCH FOR: " + term + " ======");
			int total = 0;
			int pageNumber = 0;
			SearchResult[] results;
			do  {
				pageNumber++;
				
				//Don't go to the second page
				if(pageNumber == 2)
					break;
				
				System.out.println("Fetching results for page "+pageNumber);
		    	RestAssured.baseURI = "https://uts-ws.nlm.nih.gov";
		    	Response response =  given()//.log().all()
		                .request().with()
		                	.param("ticket", ticketClient.getST(tgt))
		                	.param("string", term)
		                	.param("pageNumber",pageNumber)
		                	.param("searchType", "exact")
		                	//uncomment to return CUIs that have at least one matching term from the US Edition of SNOMED CT
		                	//.param("sabs", "SNOMEDCT_US")
		                	//uncomment to return SNOMED CT concepts rather than UMLS CUIs.
		                	//.param("returnIdType", "sourceConcept")
		                	//.param("searchType","exact") //valid values are exact,words, approximate,leftTruncation,rightTruncation, and normalizedString
		        	 .expect()
		       		 .statusCode(200)
		        	 .when().get("/rest/search/"+version);
		    	
		    	String output = response.getBody().asString();
				Configuration config = Configuration.builder().mappingProvider(new JacksonMappingProvider()).build();
				results = JsonPath.using(config).parse(output).read("$.result.results",SearchResult[].class);

		    	//the /search endpoint returns an array of 'result' objects
		    	//See http://documentation.uts.nlm.nih.gov/rest/search/index.html#sample-output for a complete list of fields output under the /search endpoint
		    	for(SearchResult result:results) {
		    		
		    		String ui = result.getUi();
		    		String name = result.getName();
		    		String rootSource = result.getRootSource();
		    		String uri = result.getUri();
		    		System.out.println("ui: " + ui);
		    		System.out.println("name: " + name);
		    		System.out.println("rootSource: " + rootSource);
		    		System.out.println("uri: " + uri);
		    		
		    		System.out.println("**");
		    	}
		    	System.out.println("----------");
		    	total += results.length;
			}while(!results[0].getUi().equals("NONE"));
			//account for the one 'NO RESULTS' result :-/
			total--;
			System.out.println("Found " + total+ " results for "+ term);
			
		}
		
		
	
	

	
		
	}*/
}
