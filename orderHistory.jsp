<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>My Order History</h2>
        <table border="1">
            <tr>
                <th>Order ID</th>
                <th>Farmer</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Order Date</th>
                <th>Status</th>
            </tr>
<%
try
{
    String uname=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select o.*,p.pname from orders o,products p " + 
    "where o.pid=p.pid and o.b_uname=? order by o.order_date desc");
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getInt("order_id")%></td>
                <td><%=rs.getString("f_uname")%></td>
                <td><%=rs.getString("pname")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td><%=rs.getDouble("total_amount")%></td>
                <td><%=rs.getDate("order_date")%></td>
                <td><%=rs.getString("status")%></td>
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