/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sk.coda.iot;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import com.sk.coda.iot.myutil.MyUtil;
/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/sensor"})
public class Sensor extends HttpServlet {
	private final static Logger LOGGER = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        LOGGER.setLevel(Level.SEVERE);
        LOGGER.finest("GET on Sensor servlet");
        
        RequestDispatcher rd = request.getRequestDispatcher("emulator.html");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	LOGGER.setLevel(Level.SEVERE);
    	LOGGER.finest("POST on Sensor sevlets");
    	response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        JSONObject jo = new JSONObject();
        if (action == null){
            jo.put("message","provide an action");
        }else if(action.equals("get")){
            String id = request.getParameter("id");
            jo = new MyUtil().getSensorData(id);
        }else if(action.equals("put")){
            String timeStamp = request.getParameter("timestamp");
            String id = request.getParameter("id");
            String cid = request.getParameter("cid");
            String secret = request.getParameter("secret");
            String value = request.getParameter("value");
            
            jo = new MyUtil().storeSensorData(id, timeStamp, secret, cid, value);
        }else if(action.equals("create")){
            String type = request.getParameter("type");
            String cid = request.getParameter("cid");
            
            jo = new MyUtil().createSensor(type, cid);
        }else if(action.equals("list")){
            String cid = request.getParameter("cid");
            
            jo = new MyUtil().listSensors(cid);
        }
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.print(jo);
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
