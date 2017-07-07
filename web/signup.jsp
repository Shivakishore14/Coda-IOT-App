<%-- 
    Document   : signup
    Created on : 4 Jul, 2017, 10:53:56 AM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="static/style.css">
        <script src="static/script.js"></script>
        <title>SignUp Page</title>
    </head>
    <body>
        <center>
            <h1>SignUp</h1>
        </center>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                            <input id="email" type="text" class="form-control" name="email" placeholder="Email">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="fname" type="text" class="form-control" name="fname" placeholder="First Name">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="lname" type="text" class="form-control" name="lname" placeholder="Last Name">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                            <input id="phone" type="text" class="form-control" name="phone" placeholder="Phone Number">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input id="password" type="password" class="form-control" name="password" placeholder="Password">
                        </div>
                        <div class="input-group row full-width">
                            <div class="col-md-4 col-md-offset-4">
                                <input id="submit" class="btn btn-info full-width" value="submit"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <center>
                Already have an account? <a href="login.jsp">click here</a>
            </center>
        </div>
        <div id="notification" class="container-fluid">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4" id="notificationArea"></div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </body>
    <script>
        $("#submit").on("click", function(){
            var obj = {};
            obj.email = $("#email").val();
            obj.fname = $("#fname").val();
            obj.lname = $("#lname").val();
            obj.phone = $("#phone").val();
            obj.password = $("#password").val();

            $.post("signup", obj, function(result){
                result = JSON.parse(result);
                //console.log(result);
                notify(result.message);
            });
        });
    </script>
</html>
