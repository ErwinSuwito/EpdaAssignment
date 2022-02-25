/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.usermanagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Enums;
import static model.Enums.LoginStateRole.Customer;
import model.Users;
import model.UsersFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "AddStaff", urlPatterns = {"/AddStaff"})
public class AddStaff extends HttpServlet {

    @EJB
    private UsersFacade usersFacade;

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
        if (state != Enums.LoginStateRole.ManagingStaff) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        Boolean isMale = false;
        Enums.LoginStateRole role;
        String phoneNumber = request.getParameter("phoneNumber");
        String icNumber = request.getParameter("icNumber");
        
        if (request.getParameter("gender") == null || request.getParameter("staffType") == null) {
            session.setAttribute("notice", "Please fill in all fields in the form!");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("addstaff.jsp");
            return;
        }
        
        if (request.getParameter("gender").equals("male"))
            isMale = true;
        
        if (request.getParameter("staffType").equals("delivery")) {
            role = Enums.LoginStateRole.DeliveryStaff;
        } else {
            role = Enums.LoginStateRole.ManagingStaff;
        }
        
        Users checkForDuplicateUser = usersFacade.findByEmail(email);
        if (checkForDuplicateUser != null) {
            session.setAttribute("notice", "Another staff with the same email is found!");
            session.setAttribute("noticeBg", "danger");
            response.sendRedirect("addstaff.jsp");
            return;
        }
        
        Users newStaff = new Users(email, password, name, isMale, phoneNumber, icNumber, role);
        usersFacade.create(newStaff);
        
        response.sendRedirect("stafflist.jsp");
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
