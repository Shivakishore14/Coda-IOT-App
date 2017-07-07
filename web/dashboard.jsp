<%-- 
    Document   : dashboard
    Created on : 4 Jul, 2017, 12:53:54 PM
    Author     : user
--%>

<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="myutil.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession s = request.getSession();
    String id = (String) s.getAttribute("userid");
    String name = (String) s.getAttribute("name");
    String CNAME = (String) s.getAttribute("cname");
    String CID = (String) s.getAttribute("cid");
    String SECRET = (String) s.getAttribute("secret");
    
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.min.js"></script>
        <link rel="stylesheet" href="static/style.css">
        <script src="static/script.js"></script>
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
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="cname">select company</span> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <%
                            
                                    //out.print(id);
                                    if (id != null){
                                        JSONObject jo = m.getCompanyList(id);
                                        JSONArray companies = (JSONArray) jo.get("data");
                                        boolean flag = true;
                                        if (companies != null) {
                                            for (Object a : companies) {
                                                flag = false;
                                                JSONObject t = (JSONObject) a;
                                                String cname = (String) t.get("name");
                                                int cid = (int) t.get("cid");
                                                String secret = (String) t.get("secret");
                                %>
                                <li class="list-elt">
                                    <a href="#" secret="<%= secret %>" cid="<%= cid %>" onClick="companyClicked(this)"><%= cname %></a>
                                </li>
                                <%
                                            }
                                        }
                                    }
                                %>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <a href="#" id="btnNew" class="btn full-width"  data-toggle="modal" data-target="#myModal">Create New Company</a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><% out.print(name); %> <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="login.jsp">Log out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <!--div class="panel panel-primary">
                        <div class="panel-heading " id="testHead"><b>Companies</b></div>
                        <%
                            
                            //out.print(id);
                            if (id != null){
                                JSONObject jo = m.getCompanyList(id);
                                JSONArray companies = (JSONArray) jo.get("data");
                                boolean flag = true;
                                if (companies != null) {
                                    for (Object a : companies) {
                                        flag = false;
                                        JSONObject t = (JSONObject) a;
                                        String cname = (String) t.get("name");
                                        int cid = (int) t.get("cid");
                                        String secret = (String) t.get("secret");
                        %>
                        <div class="list-group">
                            <button type="button" class="list-group-item " secret="<%= secret %>" cid="<%= cid %>" onClick="companyClicked(this)"><%= cname %></button>
                        </div>
                        <%
                                    }
                                }
                                if (flag) {
                        %>
                        <div class="list-group">
                            <button type="button" class="list-group-item">No companies</button>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                    <button type="button" id="btnNew" class="btn btn-info full-width"  data-toggle="modal" data-target="#myModal">Create New Company</button><br>
                    <br-->
                    
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
    <script>
        $("#companyRoot").hide();
        $("#userRoot").hide();
        $("#sensorRoot").hide();
        var CID = - 1;
        var SECRET = "";
        var UID = -1;
        var CNAME = "";
        MyChart = {};
        var ctx = document.getElementById("graph").getContext('2d');
        var chart = new Chart(ctx, {
        type: 'line',
                data: {
                    labels: [],
                    datasets: []
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
        });
        VALUES = [];
        TIMESTAMPS = [];
        function getDataSet(vals, label){
            return {
                label: label,
                data: vals,
                borderWidth: 1
            };
        }
        function updateChart(labels, dataset){
            chart.data.labels = labels;
            chart.data.datasets = [dataset];
            chart.update(0);
        }
        function fmtDate(ts){
            var options = {
                month: "short",
                day: "numeric", hour: "2-digit", minute: "2-digit", second : "2-digit"
            }
            //console.log(ts);
            var d = new Date(ts);
            return d.toLocaleDateString("en-US", options);
        }
        function loadSensorData(data, sid){
            var val = [];
            var tim = [];
            for (i in data){
                val.push(data[i].value);
                t = data[i].timestamp;
                tim.push(fmtDate(t));
            }
            updateChart(tim, getDataSet(val, sid));
        }
        function getSensorData(){
            console.log(INTERVAL);
            $.get("sensor", {"action":"get", "id":SENSOR_ID}, function(result){
                result = JSON.parse(result);
                if (result.message == "done"){
                    loadSensorData(result.data, SENSOR_ID);
                } else{
                    notify(result.message);
                }
            });
        }
        var INTERVAL = -1;
        var SENSOR_ID;
        function handleSensorClick(id){
            SENSOR_ID = id;
            if (INTERVAL != -1){
                clearInterval(INTERVAL);
            }
            INTERVAL = setInterval(getSensorData, 1000);
        }
        function renderSensorList(data) {
            s = '<div class="panel-heading " id="testHead"><b>Sensors</b><span class="glyphicon glyphicon-plus-sign add" data-toggle="modal" data-target="#newDeviceModal"></span></div>';
            for (i in data) {
                MyChart[data[i].id] = {values : [], timestamp: []};
                s = s + `
                <div class="list-group">
                    <button type="button" class="list-group-item" onClick="handleSensorClick(`+data[i].id+`);">`+data[i].id+` ( `+data[i].type+`)</button>
                </div>
                `;
            }
            $("#sensorlist").html(s);
        }

        function loadSensors(cid) {
            $.get("sensor", {"action": "list", "cid": cid}, function (result) {
                result = JSON.parse(result);
                if (result.message == "done") {
//                    if(result.data.length>0){
//                        $("#sensorRoot").show();
//                    }
                    renderSensorList(result.data);
                } else {
                    notify(result.message);
                }
            });
        }
        function loadUsers(cid){
            $.get("list",{what:"users", data:CNAME}, function(result){
//              console.log(result);
                result = JSON.parse(result);
                if (result.message == "done"){
//                    if(result.data.length > 0){
//                        $("#userRoot").show();
//                    }
                    s = '<div class="panel-heading " id="testHead"><b>Users</b><span class="glyphicon glyphicon-plus-sign add" data-toggle="modal" data-target="#newUserModal"></span></div>';
                    for (i in result.data){
                        s = s + `
                            <div class="list-group">
                                <button type="button" class="list-group-item">`+result.data[i].fname +" " + result.data[i].lname +`</button>
                            </div>
                        `;
                    }
                    $("#userlist").html(s);
                }else{
                    notify(result.message);
                }
            });
        }
        function changeCompany(cname, cid) {
            $("#defaultCompanyNotselected").hide();
            $(".cname").html(cname);
            $("#companyRoot").show();
            $("#userRoot").show();
            $("#userRoot").show();
            $("#sensorRoot").show();
            CNAME =cname;
            loadSensors(cid);
            $.get("company",{action:"isadmin", cid:CID, uid:UID},function(result){
                result = JSON.parse(result);
                console.log(result);
                $("#userRoot").hide();
                if (result.message == "done"){
                    if(result.data == true){
                        $("#userRoot").show();
                        loadUsers(cid);
                    }
                }
            });
            
            $("#deviceKey").html(SECRET);
        }
        function companyClicked(a) {
            var cid = $(a).attr("cid");
            var cname = $(a).html();
            CID = cid;
            SECRET = $(a).attr("secret");
            $.get("company",{action:"set",cname:cname, cid:cid, secret:SECRET},function(result){
                //console.log(result);
            })
            changeCompany(cname, cid);
        
        }
        function createSensor(){
            type = $("#newSensorType").val();
            $.get("sensor", {"action":"create", "type":type, "cid":CID }, function(result){
                result = JSON.parse(result);
                notify(result.message);
                if (result.message == "done"){
                    loadSensors(CID);
                }
            });
        }
        function newUser(){
            var email = $("#newUserEmail").val();
            console.log(email);
            $.get("addnew",{what:"adduser",data:email,cid:CID},function(result){
                result = JSON.parse(result);
                if (result.message == "done"){
                    notify("done");
                    loadUsers(CID);
                }else{
                    $('#newUserModal').modal('show');
                    notify(result.message);
                }
            });
        }
        function createCompany(){
            var obj = {};
            obj.what = "addCompany";
            obj.addr1 = $("#newCompanyAddress1").val();
            obj.addr2 = $("#newCompanyAddress2").val();
            obj.city = $("#newCompanyCity").val();
            obj.state = $("#newCompanyState").val();
            obj.country = $("#newCompanyCountry").val();
            obj.cname = $("#newCompanyName").val();
            obj.secret = $("#newCompanySecret").val();
            console.log(obj);
            $.get("addnew", obj, function(result){
                result = JSON.parse(result);
                console.log(result);
                if (result.message == "done"){
                    notify("company created");
                }else{
                    notify(result.message);
                }
            });
        }
        function generateSecret(){
             $("#newCompanySecret").val(makeHash());
        }
        function makeHash() {
            var text = "";
            var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

            for (var i = 0; i < 8; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));

            return text;
        }
        <%
            if(CNAME != null && CID != null && SECRET != null){
                %>
                var cid = <%= CID%>;
                var cname = "<%= CNAME%>";
                SECRET = "<%= SECRET%>";
                CID = cid;
                changeCompany(cname, cid);
                <%
            }
            if (id != null){
                %>
                UID = "<%= id%>"    
                <%
            }
        %>
            
    </script>
</html>

