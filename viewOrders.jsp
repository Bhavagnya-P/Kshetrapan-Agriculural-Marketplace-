<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Orders List</h2>
        <table border="1">
            <tr>
                <th>Order ID</th>
<%
String role=(String)session.getAttribute("role");
if(role.equals("Admin"))
{
%>
                <th>Buyer</th>
                <th>Farmer</th>
<%
}
else
{
%>
                <th>Buyer</th>
<%
}
%>
                <th>Product ID</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Order Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    ResultSet rs;
    if(role.equals("Admin"))
    {
        Statement st = con.createStatement();
        rs = st.executeQuery("select * from orders");
    }
    else
    {
        String uname = (String)session.getAttribute("user");
        PreparedStatement ps = con.prepareStatement("select * from orders where f_uname=?");
        ps.setString(1, uname);
        rs = ps.executeQuery();
    }
    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getInt("order_id")%></td>
<%
if(role.equals("Admin"))
{
%>
                <td><%=rs.getString("b_uname")%></td>
                <td><%=rs.getString("f_uname")%></td>
<%
}
else
{
%>
                <td><%=rs.getString("b_uname")%></td>
<%
}
%>
                <td><%=rs.getInt("pid")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td><%=rs.getDouble("total_amount")%></td>
                <td><%=rs.getDate("order_date")%></td>
                <td><%=rs.getString("status")%></td>
                <td>
                    <a href="updateOrder.jsp?order_id=<%=rs.getInt("order_id")%>" target="f3">Update</a>
<%
if(role.equals("Admin"))
{
%>
        |
                <a href="deleteOrder.jsp?order_id=<%=rs.getInt("order_id")%>" target="f3">Delete</a>
<%
}
%>
                </td>
            </tr>
<%
    }
    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>
        </table>
    </body>
</html>