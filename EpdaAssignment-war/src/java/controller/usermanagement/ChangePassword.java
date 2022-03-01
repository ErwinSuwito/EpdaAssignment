/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.usermanagement;

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
import model.Users;
import model.UsersFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

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
        if (state == Enums.LoginStateRole.LoggedOut) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (request.getParameter("id") == null || request.getParameter("currentPassword") == null
                || request.getParameter("newPassword1") == null || request.getParameter("newPassword2") == null) {
            session.setAttribute("notice", "Please fill in all required information");
            session.setAttribute("noticeBg", "warning");
            response.sendRedirect("changepassword.jsp");
            return;
        }

        Long id = Long.parseLong(request.getParameter("id"));
        String currentPassword = request.getParameter("currentPassword");
        String newPassword1 = request.getParameter("newPassword1");
        String newPassword2 = request.getParameter("newPassword2");

        Users user = (Users) session.getAttribute("login");
        if (!user.getId().equals(Long.parseLong(request.getParameter("id")))) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        if (!newPassword1.equals(newPassword2)) {
            session.setAttribute("notice", "New password does not match!");
            session.setAttribute("noticeBg", "danger");
            response.sendRedirect("changepassword.jsp");
            return;
        }

        user.setPassword(newPassword2);
        usersFacade.edit(user);

        session.invalidate();
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("noticeBg", "success");
        newSession.setAttribute("notice", "Your password have been changed. Please login again.");
        response.sendRedirect("login.jsp");
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
