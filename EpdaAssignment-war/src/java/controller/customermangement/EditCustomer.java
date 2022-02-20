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
import model.Staff;

/**
 *
 * @author erwin
 */
@WebServlet(name = "EditCustomer", urlPatterns = {"/EditCustomer"})
public class EditCustomer extends HttpServlet {

    @EJB
    private CustomerFacade customerFacade;

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
        
        HttpSession session = request.getSession(false);
        Customer customer = (Customer)session.getAttribute("customerLogin");        
        Staff staff = (Staff)session.getAttribute("customerLogin");
        
        try (PrintWriter out = response.getWriter()) {
            if ((customer == null) && (staff == null)) {
                // TO-DO: Push to homepage
            } else {
                String id = request.getParameter("id");
                if ((customer != null && customer.getId().equals(id)) || staff != null) {
                    String email = request.getParameter("email");
                    String name = request.getParameter("name");
                    String password = request.getParameter("password");
                    String phoneNumber = request.getParameter("phoneNumber");
                    
                    Customer customerToEdit = customerFacade.find(id);
                    customerToEdit.setId(email);
                    customerToEdit.setName(name);
                    customerToEdit.setPassword(password);
                    customerToEdit.setPhoneNumber(phoneNumber);
                    
                    customerFacade.edit(customerToEdit);
                    
                    if (customer != null)
                    {
                        session.invalidate();
                        // TO-DO: Redirect to home page
                    } else {
                        // TO-DO: Show to customer list
                    }
                    
                } else {
                    // TO-DO: Show Unauthorized error message
                }
            }
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
