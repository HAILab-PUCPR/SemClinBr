<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="helper.GeneralLayoutHelper" %>
<%
 	out.print(GeneralLayoutHelper.getHeader("Autenticação"));
%>
<style type="text/css">
body {
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #eee;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
}
.form-signin .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
</style>
<body>

    <div class="container">

      <form action="servlets/Authentication" method="post" class="form-signin">
        <h2 class="form-signin-heading">Annotation tool</h2>
        <label for="login" class="sr-only">Login</label>
        <input type="email" name="login" id="login" class="form-control" placeholder="Login" required autofocus>
        <label for="senha" class="sr-only">Senha</label>
        <input type="password" name="senha" id="senha" class="form-control" placeholder="Senha" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Lembre de mim
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Entrar</button>
          <% String e = (String) session.getAttribute("error" );
		   if(e != null)
    	      out.print("<br><div class='alert alert-danger' role='alert'>" + e + "</div>"); 
    	%>
      </form>
      

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <!-- <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script> -->
  </body>
</html>