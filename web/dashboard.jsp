<%-- 
    Document   : dashboard
    Created on : 4 Jul, 2017, 12:53:54 PM
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
        
        <title>Dashboard</title>
    </head>
    <body>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">DashBoard</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <div class="panel panel-primary">
			 <div class="panel-heading " id="testHead"><b>Companies</b></div>
                            <div class="list-group" id="listTest">
  				<button type="button" class="list-group-item">Loading</button>
                            </div>
                    </div>
                    <button type="button" id="btnNew" class="btn btn-info full-width"  data-toggle="modal" data-target="#myModal">Create New Company</button><br>
                </div>
                <div class="col-md-9">
<!--                    
                    <div class="jumbotron" id="defaultCompanyNotselected">
                        <h1>Select A Company or create new company </h1>
                    </div>
                    -->
                    <div class="jumbotron">
                        <div>
                            <h2 id="cname">Company Name</h2>
                        </div>
                        <div>
                            
                        </div>
                    </div>
                </div>
            </div>  
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">New Company</h4>
                    </div>
                    <div class="modal-body">
                        <input type="text" class="form-control" placeholder="Company name" id="newCompanyName"><br>
                        <input type="text" class="form-control" placeholder="Address 1" id="newCompanyAddress1"><br>
                        <input type="text" class="form-control" placeholder="Address 2" id="newCompanyAddress2"><br>
                        <input type="text" class="form-control" placeholder="city" id="newCompanyCity"><br>
                        <input type="text" class="form-control" placeholder="state" id="newCompanyState"><br>
                        <input type="text" class="form-control" placeholder="country" id="newCompanyCountry"><br>
                        <div id="modalNotification">Status</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="btnCreateNew">Create Company</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

