<%-- 
    Document   : login.jsp
    Created on : 4 Jul, 2017, 10:03:20 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession s = request.getSession();
    s.invalidate();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="static/style.css">
        
        <title>Login Page</title>
    </head>
    <body>
        <center>
            <h1>Login</h1>
        </center>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <form action="login" method="POST">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="email" type="text" class="form-control" name="email" placeholder="Email">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input id="password" type="password" class="form-control" name="password" placeholder="Password">
                        </div>
                        <div class="row full-width">
                            <center class="col-md-offset-1">
                                <br>
                                <input type="submit" class="btn btn-info"/>
                            </center>
                            <br>
                        </div>
                        <% 
                            String t = request.getParameter("invalid");
                            if( t != null){
                                out.print("<br><div  class=\"list-group-item list-group-item-danger\">"+t+"</div>");
                            }
                        %>
                    </form>
                    <center>
                        Don't have an account? <a href="signup.jsp">click here</a>
                    </center>
                </div>
            </div>
        </div>
    </body>
</html>
