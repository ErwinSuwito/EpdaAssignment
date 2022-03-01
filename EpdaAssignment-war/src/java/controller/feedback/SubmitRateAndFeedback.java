/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.feedback;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Enums;
import model.Feedback;
import model.FeedbackFacade;
import model.Orders;
import model.OrdersFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "SubmitRateAndFeedback", urlPatterns = {"/SubmitRateAndFeedback"})
public class SubmitRateAndFeedback extends HttpServlet {

    @EJB
    private OrdersFacade ordersFacade;

    @EJB
    private FeedbackFacade feedbackFacade;

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
        
        // Gets the current session to check if user is logged in
        HttpSession session = request.getSession(false);
        Enums.LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == Enums.LoginStateRole.LoggedOut) {
            session.setAttribute("notice", "Please login before adding items to the shopping cart.");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (state != Enums.LoginStateRole.Customer) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        if (request.getParameter("id") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        Long orderId = Long.parseLong(request.getParameter("id"));
        
        Orders order = ordersFacade.find(orderId);
        if (order == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        if (request.getParameter("comment") == null || request.getParameter("starCount") == null) {
            response.sendRedirect("submitrateandfeedback.jsp?id" + orderId);
            return;
        }
        
        String comment = request.getParameter("comment");
        int starCount = Integer.parseInt(request.getParameter("starCount"));
        
        Feedback feedback = new Feedback(order, starCount, comment);
        feedbackFacade.create(feedback);
        
        response.sendRedirect("orderdetails.jsp?id=" + order.getId());
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
