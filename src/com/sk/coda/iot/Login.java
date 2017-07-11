/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sk.coda.iot;

import java.util.logging.Logger;
import java.util.logging.Level;
import com.sk.coda.iot.myutil.MyUtil;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.simple.*;
import com.sk.coda.iot.myutil.*;
/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/login"})
public class Login extends HttpServlet {
//	public void init(ServletConfig config) throws ServletException {
//	    super.init(config);
//	    try {
//            MyLogger.setup();
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new RuntimeException("Problems with creating the log files");
//        }
//	}
	//private final static Logger LOGGER = Logger.getLogger(Login.class.getName());
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		LOGGER.setLevel(Level.INFO);
        LOGGER.finest("Login Servlet Get Request");

    	HttpSession session = request.getSession();
        String option = (String) request.getAttribute("option");
        if("logout".equals(option)) {
        	LOGGER.info("logged out user : " + (String)session.getAttribute("userid") );
        	session.invalidate();
        }
    	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.setLevel(Level.SEVERE);
        LOGGER.finest("POST on login servlet");
        HttpSession session = request.getSession(true);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        PrintWriter out = response.getWriter();
        boolean isValid = new MyUtil().isValidLogin(email, password);
        if ( isValid ){
            JSONObject o = new MyUtil().getUserDetails(email, true);
            String id = (String)o.get("id");
            String name = (String)o.get("fname") +" "+ (String)o.get("lname");
            session.setAttribute("email", email);
            session.setAttribute("userid", id);
            session.setAttribute("name", name);
            LOGGER.info("login attempt successfull user :"+email);
            response.sendRedirect("/codaiot/dashboard");
        }else{
        	LOGGER.info("login attempt invalid user :" + email);
            session.invalidate();
            response.sendRedirect("/codaiot/login?invalid=try%20again");
        }
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
