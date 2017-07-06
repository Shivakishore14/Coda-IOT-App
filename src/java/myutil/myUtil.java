package myutil;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author user
 */
import java.sql.*;  
import org.json.simple.*;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;

import javax.ws.rs.core.*;
import javax.ws.rs.core.MediaType;
import org.glassfish.jersey.internal.util.collection.UnsafeValue;
import org.glassfish.jersey.client.authentication.HttpAuthenticationFeature;
import com.sun.jersey.api.client.ClientResponse;
public class myUtil {
    private String DB_USERNAME = "test";
    private String DB_PASSWORD = "test";
    private String DB_NAME = "coda";
    private Connection con;
    private Statement stmt;
    public myUtil(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/"+DB_NAME,DB_USERNAME,DB_PASSWORD);  
            stmt=con.createStatement();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public void test(){
        try {  
            ResultSet rs=stmt.executeQuery("select * from test");  
            while(rs.next())  
                System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));  
            con.close();  
        }catch(Exception e){ 
            e.printStackTrace();
        }  
    }
    public boolean isValidLogin(String email, String password){
        try {
            PreparedStatement stmt = con.prepareStatement("select password from users where email = ?");
            stmt.setString(1, email);

            ResultSet rs=stmt.executeQuery();

            if(!rs.next()){
                return false;
            }else{
                String p = rs.getString(1);
                if (p.equals(password)){
                    return true;
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public int signup(String email, String lname, String fname, String password, String phone){
        try{
            PreparedStatement stmt = con.prepareStatement("insert into users(email, firstname, lastname, phone, password) values(?,?,?,?,?)");
            stmt.setString(1, email);
            stmt.setString(2, fname);
            stmt.setString(3, lname);
            stmt.setString(4, phone);
            stmt.setString(5, password);
            //System.out.println(email+fname+lname+phone+password);
            //stmt.execute();
            return stmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
        return 0;
    }
    public JSONObject newCompany(String name, String secret, String addr1, String addr2, String city, String state, String country){
        JSONObject jo = new JSONObject();
        jo.put("message","done");
        try{
            PreparedStatement stmt = con.prepareStatement("insert into company(name, secret, addr1, addr2, city, state, country) values(?,?,?,?,?,?,?)");
            stmt.setString(1, name);
            stmt.setString(2, secret);
            stmt.setString(3, addr1);
            stmt.setString(4, addr2);
            stmt.setString(5, city);
            stmt.setString(6, state);
            stmt.setString(7, country);
            
            //System.out.println(email+fname+lname+phone+password);
            //stmt.execute();
            int t = stmt.executeUpdate();
            if ( t != 1){
                jo.put("message", "col modified not 1");
            }
        }catch(Exception e){
            jo.put("message","error");
            e.printStackTrace();
        }
        return jo;
    }
    
    public JSONObject getUserDetails(String email, boolean isAuthenticated){
        JSONObject jo = new JSONObject();
        try{
            PreparedStatement stmt = con.prepareStatement("select id, email, firstname, lastname, phone from users where email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if(!rs.next()){
                jo.put("message", "error");
                return jo;
            }else{
                String fname = rs.getString("firstname");
                String lname = rs.getString("lastname");
                String phone = rs.getString("phone");
                String id = rs.getString("id");
                
                jo.put("message", "done");
                if (isAuthenticated){
                    jo.put("id", id);
                    jo.put("fname", fname);
                    jo.put("lname", lname);
                    jo.put("phone", phone);
                    jo.put("email", email);
                }
                return jo;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return jo;
    }
    
    public JSONObject getCompanyList(String id){
       JSONObject jo = new JSONObject();
       //mysql> select cid , name from company where cid in (select cid from user_company_mapping where userid = ?);
       try{
            PreparedStatement stmt = con.prepareStatement("select cid , name, secret from company where cid in (select cid from user_company_mapping where userid = ?)");
            int tempId = Integer.parseInt(id);
            stmt.setInt(1, tempId);
            ResultSet rs = stmt.executeQuery();
            jo.put("message", "done");
            JSONArray a1 = new JSONArray();
            while (rs.next()){
               JSONObject o = new JSONObject();
               String cname = rs.getString("name");
               String secret = rs.getString("secret");
               int cid = rs.getInt("cid");
               o.put("name", cname);
               o.put("cid", cid);
               o.put("secret", secret);
               a1.add(o);
            }
            jo.put("data", a1);
        }catch(Exception e){
            e.printStackTrace();
            jo.put("message", "error");
        }
       return jo;
    }
    public JSONObject getUserList(String cname){
       JSONObject jo = new JSONObject();
       //mysql> select cid , name from company where cid in (select cid from user_company_mapping where userid = ?);
       try{
            PreparedStatement stmt = con.prepareStatement("select email, firstname, lastname, phone, id from users where id in (select userid from user_company_mapping where cid in (select cid from company where name = ?) )");
            stmt.setString(1, cname);
            ResultSet rs = stmt.executeQuery();
            jo.put("message", "done");
            JSONArray a1 = new JSONArray();
            while (rs.next()){
               JSONObject o = new JSONObject();
               String email = rs.getString("email");
               String fname = rs.getString("firstname");
               String lname = rs.getString("lastname");
               String phone = rs.getString("phone");
               String id = rs.getString("id");
               
               o.put("email",email);
               o.put("id", id);
               o.put("fname", fname);
               o.put("lname", lname);
               o.put("phone", phone);
                    
               a1.add(o);
            }
            jo.put("data", a1);
        }catch(Exception e){
            e.printStackTrace();
            jo.put("message", "error");
        }
       return jo;
    }
    private boolean checkSecret(String secret, int cid){
        try{
            PreparedStatement stmt = con.prepareStatement("select secret from company where cid = ?");
            stmt.setInt(1, cid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()){
                String t = rs.getString("secret");
                return secret.equals(t);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }
    public JSONObject storeSensorData(String id, String timestamp, String secret, String cid, String value){
        JSONObject jo = new JSONObject();
        try{
            int sid = Integer.parseInt(id);
            int cid1 = Integer.parseInt(cid);
            jo.put("message", "done");
            if (checkSecret(secret, cid1)){
                PreparedStatement stmt = con.prepareStatement("insert into sensor_data(sid, timestamp, value) values(?,?,?)");
                stmt.setInt(1, sid);
                stmt.setString(2, timestamp);
                stmt.setString(3, value);
                
                int t = stmt.executeUpdate();
                if (t != 1){
                    jo.put("message","error inserting value");
                }
            }else{
                jo.put("message","secret doesnt match");
            }
        }catch(Exception e){
            e.printStackTrace();
            jo.put("message","error");
        }
        return jo;
    }
    
    public JSONObject createSensor(String type, String cid){
        JSONObject jo=new JSONObject();
        try{
            jo.put("message","done");
            int Cid = Integer.parseInt(cid);
            PreparedStatement stmt = con.prepareStatement("insert into sensors(type, cid) values(?,?)");
            stmt.setString(1, type);
            stmt.setInt(2, Cid);

            int t = stmt.executeUpdate();
            if (t != 1){
                jo.put("message","error inserting value");
            }
        }catch(Exception e){
            jo.put("message", "error");
            e.printStackTrace();
        }
        return jo;
    }
    
    public JSONObject getSensorData(String id){
        JSONObject jo = new JSONObject();
        if(id == null){
            jo.put("message","provide id");
            return jo;
        }
        jo.put("message", "done");
        
        try{
            PreparedStatement stmt = con.prepareStatement("select timestamp, value from sensor_data where sid = ?");
            int sid = Integer.parseInt(id);
            stmt.setInt(1, sid);
            ResultSet rs = stmt.executeQuery();
            JSONArray a1 = new JSONArray();
            while (rs.next()){
               JSONObject o = new JSONObject();
               String timestamp = rs.getString("timestamp");
               String value = rs.getString("value");
               
               o.put("timestamp",timestamp);
               o.put("value", value);
                    
               a1.add(o);
            }
            jo.put("data", a1);
        }catch(Exception e){
            e.printStackTrace();
            jo.put("message", "error");
        }
        return jo;
    }
    
    public JSONObject listSensors(String cid){
        JSONObject jo = new JSONObject();
        if(cid == null){
            jo.put("message","provide company id");
            return jo;
        }
        jo.put("message", "done");
        
        try{
            PreparedStatement stmt = con.prepareStatement("select id, type from sensors where cid = ?");
            int Cid = Integer.parseInt(cid);
            stmt.setInt(1, Cid);
            ResultSet rs = stmt.executeQuery();
            JSONArray a1 = new JSONArray();
            while (rs.next()){
               JSONObject o = new JSONObject();
               String id = rs.getString("id");
               String type = rs.getString("type");
               
               o.put("id", id);
               o.put("type", type);
                    
               a1.add(o);
            }
            jo.put("data", a1);
        }catch(Exception e){
            e.printStackTrace();
            jo.put("message", "error");
        }
        return jo;
    }
    
    public JSONObject addUser(String userid,String cid, String role){
        JSONObject jo = new JSONObject();
        try{
            PreparedStatement stmt = con.prepareStatement("insert into user_company_mapping(userid, cid, role) values(?,?,?);");
            int Cid = Integer.parseInt(cid);
            int UserId = Integer.parseInt(userid);
            
            stmt.setInt(1, UserId);
            stmt.setInt(2, Cid);
            stmt.setString(3, role);
            
            int t = stmt.executeUpdate();
            if (t == 1)
                jo.put("message", "done");
            else 
                jo.put("message", "not inserted");
        }catch(Exception e){
            jo.put("message", "error");
            e.printStackTrace();
        }
        return jo;
    }
    
    public int getUserId(String email){
        try{
            PreparedStatement stmt = con.prepareStatement("select id from users where email = ?");
            System.out.println(email);
            
            stmt.setString(1, email);
            ResultSet rs=stmt.executeQuery();
            while(rs.next()){
                return rs.getInt("id");
            }
//            if(!rs.next()){
//                return -3;
//            }else{
//                return rs.getInt("id");
//            }
            
        }catch(Exception e){
           
            e.printStackTrace();
             return -2;
        }
        
    return -3;
    }
    public int getCompanyId(String name){
        try{
            PreparedStatement stmt = con.prepareStatement("select cid from company where name = ?");
            
            stmt.setString(1, name);
            ResultSet rs=stmt.executeQuery();
            while(rs.next()){
                return rs.getInt("cid");
            }
//            if(!rs.next()){
//                return -3;
//            }else{
//                return rs.getInt("id");
//            }
            
        }catch(Exception e){
           
            e.printStackTrace();
             return -2;
        }
        
    return -1;
    }
    public boolean isAdmin(String uid, String cid){
        try{
            PreparedStatement stmt = con.prepareStatement("select role from user_company_mapping where userid = ? and cid = ?");
            
            int Uid = Integer.parseInt(uid);
            int Cid = Integer.parseInt(cid);
            stmt.setInt(1, Uid);
            stmt.setInt(2, Cid);
            ResultSet rs=stmt.executeQuery();
            while(rs.next()){
                String t =  rs.getString("role");
                if ("admin".equals(t))
                    return true;
                    
            }
//            if(!rs.next()){
//                return -3;
//            }else{
//                return rs.getInt("id");
//            }
            
        }catch(Exception e){
           
            e.printStackTrace();
             return false;
        }
        
    return false;
    }
    public ClientResponse SendSimple(String to) {

        Client client = ClientBuilder.newClient();
        client.register(HttpAuthenticationFeature.basic(
            "api",
            "key-42a05e29fda49664116b2a5d3fa451de"
        ));

        WebTarget mgRoot = client.target("https://api.mailgun.net/v3");

        Form reqData = new Form();
        reqData.param("from", "shivakishore14@gmail.com");
        reqData.param("to", to);
        reqData.param("subject", "Invitation");
        reqData.param("text", "You are invited to IOTAPP register <a href=\"http://localhost:8084/codaIOT/signup.jsp\">here</a>");

        return mgRoot
            .request(MediaType.APPLICATION_FORM_URLENCODED)
            .buildPost(Entity.entity(reqData, MediaType.APPLICATION_FORM_URLENCODED))
            .invoke(ClientResponse.class);
    }
}  

