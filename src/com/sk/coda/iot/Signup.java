/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sk.coda.iot;

import com.sk.coda.iot.myutil.MyUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.*;

/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/signup"})
public class Signup extends HttpServlet {
	
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	LOGGER.setLevel(Level.SEVERE);
    	LOGGER.finest("GET on signup servlet");
    	HttpSession session = request.getSession();
        session.invalidate();
    	RequestDispatcher rd= request.getRequestDispatcher("signup.jsp");
    	rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
    	LOGGER.setLevel(Level.SEVERE);
    	LOGGER.finest("POST on signup servlet");
    	HttpSession session = request.getSession();
        session.invalidate();
        JSONObject jo = new JSONObject();
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String password = request.getParameter("password");
        int changes = new MyUtil().signup(email, lname, fname, password, phone);
        if (changes == 1){
        	LOGGER.info("created user :" +email);
            jo.put("message", "done");
        }else{
        	LOGGER.info("couldn't create user :"+email);
            jo.put("message","try again");
        }
        out.print(jo);
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
