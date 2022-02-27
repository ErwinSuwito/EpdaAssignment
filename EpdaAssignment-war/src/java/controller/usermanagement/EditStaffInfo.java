/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.usermanagement;

import java.io.IOException;
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
@WebServlet(name = "EditStaffInfo", urlPatterns = {"/EditStaffInfo"})
public class EditStaffInfo extends HttpServlet {

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
        if (state == Enums.LoginStateRole.Customer
                || state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        Users staff = (Users) session.getAttribute("login");

        String staffId = request.getParameter("id");
        String newStaffId = request.getParameter("email");
        Users staffToEdit = usersFacade.find(staffId);

        if (staffToEdit == null) {
            response.sendRedirect("notfound.jsp");
            return;
        }

        if (request.getParameter("password") == null || request.getParameter("password").isEmpty()) {
            staffToEdit.setPassword(request.getParameter("password"));
        }
        
        staffToEdit.setPhoneNumber(request.getParameter("phoneNumber"));
        staffToEdit.setIcNumber(request.getParameter("icNumber"));
        staffToEdit.setName(request.getParameter("name"));

        if (staff.getRole() == Enums.LoginStateRole.ManagingStaff) {
            if (request.getParameter("gender") != null) {
                if (request.getParameter("gender").equals("male")) {
                    staffToEdit.setIsMale(true);
                } else {
                    staffToEdit.setIsMale(false);
                }
            }
            
            if (request.getParameter("staffType") != null) {
                if (request.getParameter("staffType").equals("delivery")) {
                    staffToEdit.setRole(Enums.LoginStateRole.DeliveryStaff);
                } else {
                    staffToEdit.setRole(Enums.LoginStateRole.ManagingStaff);
                }
            }
        }

        usersFacade.edit(staffToEdit);

        if (staff.getId().equals(staffToEdit.getId())) {
            session.invalidate();
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("noticeBg", "success");
            newSession.setAttribute("notice", "Your data has been updated. Please login again.");
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("stafflist.jsp");
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
