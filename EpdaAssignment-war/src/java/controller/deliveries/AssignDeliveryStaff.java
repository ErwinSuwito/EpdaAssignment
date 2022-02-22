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
import model.StaffFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "AssignDeliveryStaff", urlPatterns = {"/AssignDeliveryStaff"})
public class AssignDeliveryStaff extends HttpServlet {

    @EJB
    private StaffFacade staffFacade;

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
        
        if (staff.getRole() == Enums.StaffRole.DeliveryStaff) {
            // TO-DO: Show Unauthorized page
        }
        
        Long orderId = Long.parseLong(request.getParameter("orderId"));
        Orders order = ordersFacade.find(orderId);
        
        if (order == null) {
            // Show Not Found page
        } else {
            String deliveryStaffId = request.getParameter("deliveryStaffId");
            Staff deliveryStaff = staffFacade.find(deliveryStaffId);
            order.setDeliveryStaff(deliveryStaff);
            order.setStatus(Enums.OrderStatus.Assigned);
            ordersFacade.edit(order);
        }
        
        try (PrintWriter out = response.getWriter()) {
            // TO-DO: Show pending orders page
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
