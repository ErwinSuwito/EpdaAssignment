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
import model.Enums;
import model.Enums.LoginStateRole;
import model.OrderProduct;
import model.Orders;
import model.OrdersFacade;
import model.Product;
import model.ProductFacade;
import model.Users;
import viewmodels.CartCheckResultViewModel;

/**
 *
 * @author erwin
 */
@WebServlet(name = "AddOrder", urlPatterns = {"/AddOrder"})
public class AddOrder extends HttpServlet {

    @EJB
    private OrdersFacade ordersFacade;

    @EJB
    private ProductFacade productFacade;

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
        LoginStateRole state = helpers.Helpers.checkLoginState(session);
        if (state == LoginStateRole.LoggedOut) {
            session.setAttribute("notice", "Please login before adding items to the shopping cart.");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (state != LoginStateRole.Customer) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        if (session.getAttribute("cart") == null || request.getParameter("address") == null) {
            session.setAttribute("notice", "Not enough information is submitted to process the order. Please try again.");
            session.setAttribute("noticeBg", "danger");
            response.sendRedirect("cart.jsp");
            return;
        }
        
        Orders order = (Orders)session.getAttribute("cart");
        order.setAddress(request.getParameter("address"));
        order.setSubmittedTime(LocalDateTime.now());
        order.setStatus(Enums.OrderStatus.Pending);
        
        CartCheckResultViewModel cartCheckResult = helpers.Helpers.CheckCart(order, productFacade);
        order.setProductBasket(cartCheckResult.getCart());
        double totalAmount = 0.0;
        for (OrderProduct item : cartCheckResult.getCart()) {
            totalAmount += item.getProduct().getPrice() * item.getQuantityPurchased();
            Product product  = productFacade.find(item.getProduct().getId());
            int newQuantity = product.getQuantity() - item.getQuantityPurchased();
            product.setQuantity(newQuantity);
            productFacade.edit(product);
        }
        
        order.setTotalAmount(totalAmount);
        ordersFacade.create(order);
        
        session.removeAttribute("cart");
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
