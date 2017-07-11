package com.sk.coda.iot;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sk.coda.iot.myutil.MyUtil;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LOGGER.setLevel(Level.SEVERE);
		LOGGER.finest("GET on Dashboard");
		HttpSession s = request.getSession();
	    String id = (String) s.getAttribute("userid");
	    String name = (String) s.getAttribute("name");
	    String cname = (String) s.getAttribute("cname");
	    String cid = (String) s.getAttribute("cid");
	    String secret = (String) s.getAttribute("secret");
	    
		if (id == null) {
	        LOGGER.severe("Access denied User not logged in");
			response.sendRedirect("/codaiot/login?ivalid=please login");
	        
		}else {
	    	request.setAttribute("userid", id);
			request.setAttribute("name", name);
			request.setAttribute("cname", cname);
			request.setAttribute("cid", cid);
			request.setAttribute("secret", secret);
			MyUtil m = new MyUtil();
			JSONObject jo = m.getCompanyList(id);
	        JSONArray companies = (JSONArray) jo.get("data");
	        request.setAttribute("companyList", companies);
	        
	    	RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
			rd.forward(request, response);
	    }
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
