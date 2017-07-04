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
    public boolean isValidLogin(String username, String password){
        try {
            PreparedStatement stmt = con.prepareStatement("select password from test where name = ?");
            stmt.setString(1, username);

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
}  

