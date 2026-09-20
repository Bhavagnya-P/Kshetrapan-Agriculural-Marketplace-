<%@page import="java.sql.*"%>
<%
try
{
    int cartid=Integer.parseInt(request.getParameter("cartid"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("delete from cart where cart_id=?");
    ps.setInt(1,cartid);
    ps.executeUpdate();
    response.sendRedirect("cart.jsp");
}
catch(Exception e)
{
    out.println(e);
}
%>