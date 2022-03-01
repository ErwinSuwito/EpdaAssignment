/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.persistence.criteria.Order;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;
import model.Enums;
import model.Enums.OrderStatus;
import model.OrderProduct;
import model.Orders;
import model.OrdersFacade;
import model.Product;
import model.ProductFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "CancelOrder", urlPatterns = {"/CancelOrder"})
public class CancelOrder extends HttpServlet {

    @EJB
    private ProductFacade productFacade;

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
        
        Orders order = ordersFacade.find(request.getParameter("orderId"));
        
        if (!order.getCustomer().getId().equals(customer.getId())) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        if (order.getStatus() == OrderStatus.Delivering 
                || order.getStatus() == OrderStatus.Deleted) {
            session.setAttribute("notice", "Sorry. We can't delete your order at this time.");
            session.setAttribute("noticeBg", "danger");
            
            return;
        }
        
        if (order.getStatus() == OrderStatus.Assigned || order.getStatus() == OrderStatus.Pending) {
            // Re-add the number of quantity for each products purchased
            for(OrderProduct orderProduct : order.getProductBasket()) {
                Product product = orderProduct.getProduct();
                product.incrementQuantity(orderProduct.getQuantityPurchased());
                productFacade.edit(product);
            }
        }
        
        ordersFacade.remove(order);
        response.sendRedirect("customer_profile.jsp");
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
