<%-- 
    Document   : dashboard
    Created on : 4 Jul, 2017, 12:53:54 PM
    Author     : user
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="myutil.*"%>
<%
    HttpSession s = request.getSession();
    String id = (String) s.getAttribute("userid");
    String name = (String) s.getAttribute("name");
    String CID = (String) s.getAttribute("cid");
    
    if (id == null) {
        response.sendRedirect("login.jsp?ivalid=please login");
    }
    myUtil m = new myUtil();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="static/style.css">
        <script src="static/script.js"></script>
        <title>View Users</title>
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
             </div><!-- /.container-fluid -->
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">             
                    <div id="userRoot">
                        <div class="panel panel-primary" id="userlist">
                            <div class="panel-heading " id="testHead"><b>Users</b></div>
                            <div class="list-group">
                                <button type="button" class="list-group-item">Loading</button>
                            </div>
                        </div>
                    </div>
                    
                    <div id="sensorRoot">
                        <div class="panel panel-primary" id="sensorlist">
                            <div class="panel-heading " id="testHead"><b>Sensors</b></div>
                            <div class="list-group" id="listTest">
                                <button type="button" class="list-group-item">Loading</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">                    
                    <div class="jumbotron" id="defaultCompanyNotselected">
                        <h1>Select A Company or create new company </h1>
                    </div>
                    <div class="jumbotron" id="companyRoot">
                        <div>
                            <h2 class="cname">Company Name</h2>
                        </div>
                        <hr>
                        <div id="dataGraphRoot">
                            <h2>Data</h2>
                            <canvas id="graph" height="300" width="400"></canvas>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
        <div id="notification" class="container-fluid">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4" id="notificationArea"></div>
                <div class="col-md-4"></div>
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
                        <input type="text" class="form-control" placeholder="Secret" id="newCompanySecret">
                        <button onClick="generateSecret()" class="btn full-width">Generate Secret</button><br>
                        <div id="modalNotification">Status</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="btnCreateNew" onClick="createCompany()">Create Company</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="newDeviceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">New Device</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="deviceType">Device Type</label>
                            <select name="Devicetype" class="form-control"id="newSensorType">
                                <option name="humidity">humidity</option>
                                <option name="temperature">temperature</option>
                                <option name="pressure">pressure</option>
                            </select>
                        </div>
                        <hr>
                        Use Secret : <span id="deviceKey">##</span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="btnCreateNew" onClick="createSensor()">Create Device</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="newUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">New User</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="newUserEmail">User Email</label>
                            <input type="text" class="form-control" placeholder="email" id="newUserEmail">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onClick="newUser()">Add/Invite user</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

