package helper;

import java.util.Calendar;

public class GeneralLayoutHelper {
	
	public static String getHeader(String title){
		
		String html = "<!DOCTYPE html>\r\n" + 
				"<html>\r\n" + 
				"  <head>\r\n" + 
				"    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n" + 
				"    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n" + 
				"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n" + 
				"    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->\r\n" + 
				"    <meta name=\"description\" content=\"\">\r\n" + 
				"    <meta name=\"author\" content=\"\">\r\n" + 
				"    <link rel=\"icon\" href=\"../../favicon.ico\">\r\n" + 
				"\r\n" + 
				"    <title>Annotation Tool - "+title+"</title>\r\n" + 
				"\r\n" + 
				"    <!-- Bootstrap core CSS -->\r\n" + 
				"    <link href=\"js/bootstrap-3.3.7-dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n" +
				"    <link href=\"css/general.css\" rel=\"stylesheet\">\r\n" + 
				"\r\n" + 
				"    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->\r\n" + 
				"    <!-- <link href=\"../../assets/css/ie10-viewport-bug-workaround.css\" rel=\"stylesheet\">-->\r\n" + 
				"\r\n" + 
				"    <!-- Custom styles for this template -->\r\n" + 
				"    <!-- <link href=\"navbar-static-top.css\" rel=\"stylesheet\"> -->\r\n" + 
				"\r\n" + 
				"    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->\r\n" + 
				"    <!--[if lt IE 9]>\r\n" + 
				"      <script src=\"https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js\"></script>\r\n" + 
				"      <script src=\"https://oss.maxcdn.com/respond/1.4.2/respond.min.js\"></script>\r\n" + 
				"    <![endif]-->\r\n" + 
				"	<!-- CSS Select2 -->"+ 
				"	<link href=\"js/select2-4.0.3/dist/css/select2.min.css\" rel=\"stylesheet\" />" + 
				"	<!-- CSS Notify -->"+ 
				"	<link href=\"css/animate.css\" rel=\"stylesheet\" />" + 
				"  </head>\r\n" + 
				"\r\n";
		
		return html;
		
	}
	
	public static String getTop(String title){
		
		//TODO: Fazer menu ficar ativo dependendo do título
		String html = getHeader(title) +
				"  <body>\r\n" + 
				"\r\n" + 
				"    <!-- Static navbar -->\r\n" + 
				"    <nav class=\"navbar navbar-default navbar-static-top\">\r\n" + 
				"      <div class=\"container\">\r\n" + 
				"        <div class=\"navbar-header\">\r\n" + 
				"          <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#navbar\" aria-expanded=\"false\" aria-controls=\"navbar\">\r\n" + 
				"            <span class=\"sr-only\">Toggle navigation</span>\r\n" + 
				"            <span class=\"icon-bar\"></span>\r\n" + 
				"            <span class=\"icon-bar\"></span>\r\n" + 
				"            <span class=\"icon-bar\"></span>\r\n" + 
				"          </button>\r\n" + 
				"          <a class=\"navbar-brand\" href=\"painel.jsp\">Annotation Tool</a>\r\n" + 
				"        </div>\r\n" + 
				"        <div id=\"navbar\" class=\"navbar-collapse collapse\">\r\n" + 
				"          <ul class=\"nav navbar-nav\">\r\n" + 
				"            <li class=\"active\"><a href=\"painel.jsp\">Painel</a></li>\r\n" + 
				"            <li class=\"dropdown\">\r\n" + 
				"              <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">Anotação <span class=\"caret\"></span></a>\r\n" + 
				"              <ul class=\"dropdown-menu\">\r\n" + 
				"                <li><a href=\"projectSelection.jsp?redirect=textImport\">Importar textos</a></li>\r\n" + 
				"            	<li><a href=\"projectSelection.jsp?redirect=textList\">Listar textos</a></li>\r\n" + 
				"            	<li><a href=\"projectSelection.jsp?redirect=textExport\">Exportar textos</a></li>\r\n" + 
				"                <!-- <li role=\"separator\" class=\"divider\"></li>\r\n" + 
				"                <li class=\"dropdown-header\">Nav header</li>\r\n" + 
				"                <li><a href=\"#\">Separated link</a></li>\r\n" + 
				"                <li><a href=\"#\">One more separated link</a></li> -->\r\n" + 
				"              </ul>\r\n" + 
				"            </li>\r\n" + 
				"            <li><a href=\"projectSelection.jsp?redirect=statistics\">Estatísticas</a></li>\r\n" + 
				"            <li class=\"dropdown\">\r\n" + 
				"              <a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">Gerenciamento <span class=\"caret\"></span></a>\r\n" + 
				"              <ul class=\"dropdown-menu\">\r\n" + 
				"              	<li><a href=\"projectManagement.jsp\">Projetos</a></li>\r\n" + 
				"				<li><a href=\"userManagement.jsp\">Usuários</a></li>\r\n" + 
				"			</ul>\r\n" + 
				"			</li>\r\n" + 
				"          </ul>\r\n" + 
				"          <ul class=\"nav navbar-nav navbar-right\">\r\n" + 
				"            <li class=\"active\"><a href=\"./\">Projeto atual <span class=\"sr-only\">(current)</span></a></li>\r\n" + 
				"            <li><a href=\"index.jsp\">Logout</a></li>\r\n" + 
				"          </ul>\r\n" + 
				"        </div><!--/.nav-collapse -->\r\n" + 
				"      </div>\r\n" + 
				"    </nav>";
		
		return html;
		
	}
	
	public static String getFooter(){
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		String html = "<footer class=\"footer\">\r\n" + 
				"      <div class=\"container\">\r\n" + 
				"        <p class=\"text-muted\" style=\"text-align:center\">"+year+" Annotation Tool &reg;.</p>\r\n" + 
				"      </div>\r\n" + 
				"    </footer>";
		
		return html;
		
	}
	
	public static String getBootstrap(){
		
		String html = " <!-- Bootstrap core JavaScript\r\n" + 
				"    ================================================== -->\r\n" + 
				"    <!-- Placed at the end of the document so the pages load faster -->\r\n" + 
				"    <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js\"></script>\r\n" + 
				"    <script>window.jQuery || document.write('<script src=\"../../assets/js/vendor/jquery.min.js\"><\\/script>')</script>\r\n" + 
				"    <script src=\"js/bootstrap-3.3.7-dist/js/bootstrap.min.js\"></script>\r\n" + 
				"    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->\r\n" + 
				"    <!-- <script src=\"../../assets/js/ie10-viewport-bug-workaround.js\"></script>-->\r\n" +
			    "	\r\n<script src=\"js/select2-4.0.3/dist/js/select2.min.js\"></script>" +
			    "	\r\n<script src=\"js/jquery-ui-1.12.0.custom/jquery-ui.min.js\"></script>"
			    + "\r\n<script src=\"js/bootstrap-notify-master/bootstrap-notify.min.js\"></script>"
			    + "\r\n<script src=\"js/jquery-loading-overlay-1.4.1/src/loadingoverlay.min.js\"></script>";
		
		return html;
		
	}

}
