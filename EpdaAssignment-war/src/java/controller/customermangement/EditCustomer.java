/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.customermangement;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;
import model.CustomerFacade;
import model.Enums;
import model.Staff;
import model.StaffFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "EditCustomer", urlPatterns = {"/EditCustomer"})
public class EditCustomer extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;
    
    @EJB
    private StaffFacade staffFacade;

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
        if (state == Enums.LoginStateRole.LoggedOut ||
                state == Enums.LoginStateRole.DeliveryStaff) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        Customer customer;
        String id = request.getParameter("id");
        
        // Checks if the customer editing the customer is the customer itself
        if (state == Enums.LoginStateRole.Customer) {
            customer = (Customer)session.getAttribute("customerLogin");
            if (!customer.getId().equals(id)) {
                response.sendRedirect("unauthorized.jsp");
                return;
            }
        }
        
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");

        Customer customerToEdit = customerFacade.find(id);
        
        // Re-checks if the customer to edit is available on the database
        if (customerToEdit == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }

        customerToEdit.setName(name);
        customerToEdit.setPassword(password);
        customerToEdit.setPhoneNumber(phoneNumber);

        customerFacade.edit(customerToEdit);
        
        if (state == Enums.LoginStateRole.Customer) {
            session.invalidate();
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("notice", "Your details have been changed. Please login again.");
            newSession.setAttribute("noticeBg", "success");
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("customerlist.jsp");
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
