/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.orders;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Enums;
import model.OrderProduct;
import model.Orders;
import model.Users;

/**
 *
 * @author erwin
 */
@WebServlet(name = "DeleteItemFromCart", urlPatterns = {"/DeleteItemFromCart"})
public class DeleteItemFromCart extends HttpServlet {

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
            response.sendRedirect("index.jsp");
            return;
        }

        Orders order;
        if (session.getAttribute("cart") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (request.getParameter("productId") == null) {
            session.setAttribute("notice", "Item not found in cart");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("cart.jsp");
            return;
        }

        order = (Orders) session.getAttribute("cart");
        Long productId = Long.parseLong(request.getParameter("productId"));
        OrderProduct orderProduct = null;
        int itemIndex = -1;

        for (OrderProduct cartItem : order.getProductBasket()) {
            if (cartItem.getProduct().getId().equals(productId)) {
                itemIndex = order.getProductBasket().indexOf(cartItem);
                break;
            }
        }

        if (itemIndex == -1) {
            session.setAttribute("notice", "Item not found in cart");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("cart.jsp");
            return;
        }

        order.getProductBasket().remove(itemIndex);
        session.setAttribute("cart", order);
        session.setAttribute("notice", "Product deleted from cart!");
        session.setAttribute("noticeBg", "success");
        response.sendRedirect("cart.jsp");
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
