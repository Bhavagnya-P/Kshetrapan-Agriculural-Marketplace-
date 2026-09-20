<%@page import="java.sql.*"%>
<%
try
{
    int cartid=Integer.parseInt(request.getParameter("cartid"));
    int qty=Integer.parseInt(request.getParameter("qty"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("update cart set quantity=? where cart_id=?");
    ps.setInt(1,qty);
    ps.setInt(2,cartid);
    ps.executeUpdate();
    response.sendRedirect("cart.jsp");
}
catch(Exception e)
{
    out.println(e);
}
%>