/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.deliveries;

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
import model.Orders;
import model.OrdersFacade;
import model.Staff;

/**
 *
 * @author erwin
 */
@WebServlet(name = "UpdateDeliveryStatus", urlPatterns = {"/UpdateDeliveryStatus"})
public class UpdateDeliveryStatus extends HttpServlet {

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
        Staff staff = (Staff)session.getAttribute("login");
        
        if (staff == null) {
            // TO-DO: Push to login page
        }
        
        if (staff.getRole() == Enums.StaffRole.ManagingStaff) {
            // TO-DO: Show Unauthorized page
        }
        
        Long orderId = Long.parseLong(request.getParameter("orderId"));
        Orders order = ordersFacade.find(orderId);
        
        if (order == null) {
            // TO-DO: Show Not Found page
        } else {
            String orderStatus = request.getParameter("orderStatus");
            
            switch (orderStatus) {
                case "Pending":
                    order.setStatus(Enums.OrderStatus.Pending);
                    break;
                    
                case "Assigned":
                    order.setStatus(Enums.OrderStatus.Assigned);
                    break;
                    
                case "Delivering":
                    order.setStatus(Enums.OrderStatus.Delivering);
                    break;
                    
                case "Delivered":
                    order.setStatus(Enums.OrderStatus.Delivered);
                    break;
                    
                case "Cancelled":
                    order.setStatus(Enums.OrderStatus.Cancelled);
                    break;
            }
            
            ordersFacade.edit(order);
        }
        
        try (PrintWriter out = response.getWriter()) {
            // TO-DO: If user show orders list
            //        If delivery staff show delivery list
            //        If managing staff show orders list
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
