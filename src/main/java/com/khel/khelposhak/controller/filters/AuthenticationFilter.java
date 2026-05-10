package com.khel.khelposhak.controller.filters;

import com.khel.khelposhak.utils.SessionUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author akashadhikari
 */
@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    private static final String LOGIN = "/LogServ";
    private static final String LOGIN_PAGE = "/pages/login.jsp";
    private static final String REGISTER = "/regServ";
    private static final String REGISTER_PAGE = "/pages/register.jsp";
    private static final String HOME = "/homeS";
    private static final String HOME_PAGE = "/pages/home.jsp";
    private static final String CART = "/CartS";
    private static final String CART_PAGE = "/pages/cart.jsp";
    private static final String PRODUCTS = "/products";
    private static final String PRODUCTS_PAGE = "/pages/allProducts.jsp";
    private static final String ABOUT_PAGE = "/pages/about.jsp";
    private static final String CONTACT_PAGE = "/pages/contact.jsp";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (isStaticResource(uri)) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.getAttribute(req, "user") != null;

        boolean isHomePage = uri.endsWith(HOME) || uri.endsWith(HOME_PAGE);
        boolean isAuthPage = uri.endsWith(LOGIN) || uri.endsWith(LOGIN_PAGE)
                || uri.endsWith(REGISTER) || uri.endsWith(REGISTER_PAGE);
        boolean isCartPage = uri.endsWith(CART) || uri.endsWith(CART_PAGE);
        boolean isProductsPage = uri.endsWith(PRODUCTS) || uri.endsWith(PRODUCTS_PAGE);
        boolean isAboutPage = uri.endsWith(ABOUT_PAGE);
        boolean isContactPage = uri.endsWith(CONTACT_PAGE);

        String context = req.getContextPath();

        // If not logged in
        if (!isLoggedIn) {
            if (isAuthPage || isHomePage || isProductsPage || isCartPage || isAboutPage || isContactPage) {  // Add isProductsPage
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(context + LOGIN_PAGE);
            }
            return;
        }

        // If logged in
        if (isAuthPage) {
            res.sendRedirect(context + HOME_PAGE);
            return;
        }

        chain.doFilter(request, response);
    }
    
    /**
     * Check if the request is for a static resource that should be publicly
     * accessible
     */
    private boolean isStaticResource(String uri) {
        return uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".jpg")
                || uri.endsWith(".jpeg")
                || uri.endsWith(".png")
                || uri.endsWith(".gif")
                || uri.endsWith(".svg")
                || uri.endsWith(".ico")
                || uri.endsWith(".woff")
                || uri.endsWith(".woff2")
                || uri.endsWith(".ttf")
                || uri.contains("/css/")
                || uri.contains("/js/")
                || uri.contains("/images/")
                || uri.contains("/fonts/");
    }

    @Override
    public void destroy() {
    }
}
