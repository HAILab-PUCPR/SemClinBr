$(function(){
	
	//Clear localStorage
	localStorage.clear();
	
	//Adiciona evento de ONCHANGE nos campos de definição de TAGS (classe .tagtoken)
	$(".tagtoken").change(function(){
		
		//Mark token as OK
		$(this).parent().removeClass().addClass("token").addClass("green-border");
		
		//TODO: Show abbreviation dialog even if the abbr option is re-selected
		//Verify if it is an abbreviation
		if( $(this).find("option:selected").attr("type") == "A" ){
			
			//Get abbreviation word
			var abbr = $(this).siblings(".tokentext").text();
			
			//Set on input field
			$("#abbreviation-short").val(abbr);
			
			//Open DIALOG
			$("#abbreviation-dialog").dialog({
				title:"Add Abbreviation",
				modal:true,
				close: function(event, ui){ 
					$(this).find("input[type=text]").val("");//Erase all fields before close
		        } 
			});
			
		}
		
	});
	
	//TODO: Finish
	$("abbreviation-button").click(function(){
		
		//get the extended abbr
		//Store on localStorage
		
	});
	
	$(".addrelationbutton").click(function(){
		
		//Get the sentence ID
		var sentenceid = $(this).parents("[sentenceid]").attr("sentenceid");
	
		$(this)
			.parents("[sentenceid]")
			.clone()
			.find(".showrelationbutton")
				.hide()
			.end()
			.find("select")
				.prop("disabled", "disabled")
				//.before("<input type='checkbox'>")
			.end()
			/*.find("input[type=checkbox]")
				.click(function(event){
					event.preventDefault();
				})
			.end()*/
			.find(".token")
				.css("cursor", "pointer")
				.click(function(event){
					
					event.stopPropagation();
					//Get checkbox status
					var v = $(this).find("input[type=checkbox]").prop('checked');
					//Change checkbox checked status
					$(this).find("input[type=checkbox]").prop('checked', !v);
					//Mark all the DIV as checked
					$(this).toggleClass("relationselected");
				})
			.end()
			.find(".addrelationbutton")
				.click(function(event){
					
					//Get all relations - if exists
					var relations = (localStorage.getItem("relations") == null) ? [] : JSON.parse(localStorage.getItem("relations"));
					var aux = [];
					
					//Iterate selected tokens
					$(this).parents("[sentenceid]").find(".relationselected").each(function( index, element ) {
						
						//Get TOKENID
						var tokenid = $(element).attr("tokenid");
						
						//Add tokenid to aux array
						aux.push(tokenid);
						
					});
					
					//Add actual relation to the relations array
					relations.push(aux);
					//Store on localStorage
					localStorage.setItem("relations", JSON.stringify(relations));
					
					//Close active dialog
					$(this).parents(".ui-dialog-content").dialog('close');
					
					//Activate SHOW RELATIONS button
					$("div[sentenceid="+sentenceid+"]").find(".showrelationbutton").prop('disabled', false);
					
				})
			.end()
				.dialog({
						title:"Add Relationship",
						modal:true,
						close: function(event, ui){ 
							$(this).dialog('destroy').remove();//Completely remove after closing
				        } 
				});
		
	});
	
	
	$(".showrelationbutton").click(function(){
		
		
		
		//Has relations?
		if(localStorage.getItem("relations") != null){
			
			//Parse JSON
			var relations = JSON.parse(localStorage.getItem("relations"));
			
			//Iterate relations
			for (var i = 0; i < relations.length; i++) {
				//Iterate tokens in a relation
				for(var j = 0; j < relations[i].length; j++){
					
					$("div[tokenid="+relations[i][j]+"]")
						.clone()
						.find("select")
							.remove()
						.end()
							.appendTo("#relations-dialog");
					
				}
			
				//Wrap tokens inside DIV
				$("#relations-dialog > .token").wrapAll( "<div class='relationitem' relationkey='"+i+"' ></div>" );
				
				//Add the remove button
				$("<input type='button' value='X' class='removerelation' relationkey='"+i+"' relationid=''>").appendTo(".relationitem[relationkey="+i+"]");
				
				//Fazer funcionalidade de remover - tirar do DOM e localStorage
				//Fazer funcionalidade de cadastro da anotação - usar .serialize() + JSON do localStorage - Fazer loading...
			}
			
		}
		else{
			
		}
		
		
		
		//Open DIALOG
		$("#relations-dialog").dialog({
			title:"Text relationships",
			modal:false,
			close: function(event, ui){ 
				$(this).find(".relationitem").remove();//Erase all displayed relations
	        } 
		});
		
	});
	
});
