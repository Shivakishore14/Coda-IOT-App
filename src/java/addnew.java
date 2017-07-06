/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import myutil.myUtil;
import org.json.simple.JSONObject;

/**
 *
 * @author user
 */
public class addnew extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        JSONObject jo = new JSONObject();
        String what = request.getParameter("what");
        String data = request.getParameter("data");
        String id = (String)session.getAttribute("userid");
        jo.put("message","done");
        if(id == null){
            jo.put("message","not authenticated");
            
        }else{
            myUtil m = new myUtil();
            if(what == null){
                jo.put("message","what is that you need?");
            }else if(what.equals( "getId")){
                int uid = m.getUserId(data);
                jo.put("data", uid);
            }else if(what.equals( "adduser")){
                int uid = m.getUserId(data);
                if(uid == -1){
                    //TODO invite
                    jo.put("message", "invite not yet done");
                }else{
                    
                    String cid = request.getParameter("cid");
                    jo = m.addUser(Integer.toString(uid), cid, "user");
                    jo.put("debug", "adduser");
                }
            }else{
                jo.put("debug", what);
            }
        }
        try (PrintWriter out = response.getWriter()) {
            out.print(jo);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
