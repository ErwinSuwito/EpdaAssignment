/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.authentication;

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
import model.Enums.LoginStateRole;
import model.Users;
import model.UsersFacade;

/**
 *
 * @author erwin
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Users user = usersFacade.findByEmail(email);
        
        // Removes all previous sessions
        HttpSession session = request.getSession(false);
        if (session != null)
            session.invalidate();
        
        HttpSession newSession = request.getSession();
        
        if (user != null) {
            if (user.getPassword().equals(password)) {
                // Set customer object to session
                newSession.setAttribute("login", user);

                String redirectTo = "";
                // Redirects user to the proper home page for each role
                switch (user.getRole()) {
                    case Customer:
                        redirectTo = "index.jsp";
                        break;
                        
                    case ManagingStaff: 
                        redirectTo = "admin_profile.jsp";
                        break;
                        
                    case DeliveryStaff:
                        redirectTo = "delivery_profile.jsp";
                        break;
                }
                
                response.sendRedirect(redirectTo);
                return;
            }
        }
        
        newSession.setAttribute("notice", "Your email and password doesn't match our records.");
        newSession.setAttribute("noticeBg", "danger");

        // Redirects user to login page
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
