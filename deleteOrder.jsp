<%@page import="java.sql.*"%>
<%
String role = (String)session.getAttribute("role");
if(!role.equals("Admin"))
{
    out.println("<h3>Access Denied</h3>");
    return;
}
try
{
    int orderId = Integer.parseInt(
    request.getParameter("order_id"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("delete from orders where order_id=?");
    ps.setInt(1, orderId);
    int x = ps.executeUpdate();
    if(x > 0)
    {
        response.sendRedirect("viewOrders.jsp");
    }
    else
    {
        out.println("<h3>Order Not Found</h3>");
    }

    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>