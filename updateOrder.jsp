<%@page import="java.sql.*"%>
<%
int orderId = Integer.parseInt(request.getParameter("order_id"));
String role = (String)session.getAttribute("role");
String uname = (String)session.getAttribute("user");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
PreparedStatement ps;
if(role.equals("Admin"))
{
    ps = con.prepareStatement("select * from orders where order_id=?");
    ps.setInt(1, orderId);
}
else
{
    ps = con.prepareStatement("select * from orders where order_id=? and f_uname=?");
    ps.setInt(1, orderId);
    ps.setString(2, uname);
}
ResultSet rs = ps.executeQuery();
if(!rs.next())
{
    out.println("<h3>Order Not Found</h3>");
    return;
}
%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Update Order Status</h2>
        <form method="post">
            Order ID:<input type="text" value="<%=rs.getInt("order_id")%>" readonly>
            <br><br>
            Current Status:<b><%=rs.getString("status")%></b>
            <br><br>
            New Status:
            <select name="status">
                <option>Pending</option>
                <option>Accepted</option>
                <option>Shipped</option>
                <option>Delivered</option>
                <option>Cancelled</option>
            </select>
            <br><br>
            <input type="submit" value="Update Status">
        </form>
<%
if(request.getParameter("status") != null)
{
    PreparedStatement ps1;

    if(role.equals("Admin"))
    {
        ps1 = con.prepareStatement("update orders set status=? where order_id=?");
        ps1.setString(1, request.getParameter("status"));
        ps1.setInt(2, orderId);
    }
    else
    {
        ps1 = con.prepareStatement("update orders set status=? where order_id=? and f_uname=?");
        ps1.setString(1, request.getParameter("status"));
        ps1.setInt(2, orderId);
        ps1.setString(3, uname);
    }
    int x = ps1.executeUpdate();
    if(x > 0)
    {
        response.sendRedirect("viewOrders.jsp");
    }
}
%>
    </body>
</html>