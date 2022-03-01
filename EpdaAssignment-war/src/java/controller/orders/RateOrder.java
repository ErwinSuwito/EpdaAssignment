/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author erwin
 */
@WebServlet(name = "RateOrder", urlPatterns = {"/RateOrder"})
public class RateOrder extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

    @EJB
    private OrdersFacade ordersFacade;

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
        if (state != Enums.LoginStateRole.Customer) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        Users customer = (Users)session.getAttribute("login");
        
        if (request.getParameter("id") == null) {
            response.sendRedirect("customer_profile.jsp");
            return;
        }
        
        Orders order = ordersFacade.find(Long.parseLong(request.getParameter("id")));
        
        if (order == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }
        
        if (!order.getCustomer().getId().equals(customer.getId())) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        if (request.getParameter("comment") == null || request.getParameter("stars") == null) {
            response.sendRedirect("rateservice.jsp?=id" + order.getId());
            return;
        }
        
        int starCount = Integer.parseInt(request.getParameter("stars"));
        String comment = request.getParameter("comment");
        LocalDateTime submittedOn = LocalDateTime.now();
        
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
