<%@page import="java.sql.*"%>
<%
String uname=(String)session.getAttribute("user");
int totalOrders=0;
int cartItems=0;
int totalComplaints=0;
int totalReviews=0;
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps1=con.prepareStatement("select count(*) from orders where b_uname=?");
    ps1.setString(1,uname);
    ResultSet rs1=ps1.executeQuery();
    if(rs1.next())
    {
        totalOrders=rs1.getInt(1);
    }
    PreparedStatement ps2=con.prepareStatement("select count(*) from cart where b_uname=?");
    ps2.setString(1,uname);
    ResultSet rs2=ps2.executeQuery();
    if(rs2.next())
    {
        cartItems=rs2.getInt(1);
    }
    PreparedStatement ps3=con.prepareStatement("select count(*) from complaints where username=?");
    ps3.setString(1,uname);
    ResultSet rs3=ps3.executeQuery();
    if(rs3.next())
    {
        totalComplaints=rs3.getInt(1);
    }
    PreparedStatement ps4=con.prepareStatement("select count(*) from reviews where b_uname=?");
    ps4.setString(1,uname);
    ResultSet rs4=ps4.executeQuery();
    if(rs4.next())
    {
        totalReviews=rs4.getInt(1);
    }
%>
<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h1>Buyer Dashboard</h1>
            <table border="1" cellpadding="12">
                <tr>
                    <th>Total Orders</th>
                    <th>Items In Cart</th>
                </tr>
                <tr>
                    <td><%=totalOrders%></td>
                    <td><%=cartItems%></td>
                </tr>
                <tr>
                    <th>Complaints Raised</th>
                    <th>Reviews Given</th>
                </tr>
                <tr>
                    <td><%=totalComplaints%></td>
                    <td><%=totalReviews%></td>
                </tr>
            </table>
            <br><br>
            <h2>Recent Orders</h2>
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Quantity</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
<%
PreparedStatement ps5=con.prepareStatement("select * from orders where b_uname=? order by order_date desc limit 5");
ps5.setString(1,uname);
ResultSet rs5=ps5.executeQuery();
while(rs5.next())
{
%>
                <tr>
                    <td><%=rs5.getInt("order_id")%></td>
                    <td><%=rs5.getInt("pid")%></td>
                    <td><%=rs5.getInt("quantity")%></td>
                    <td><%=rs5.getDouble("total_amount")%></td>
                    <td><%=rs5.getString("status")%></td>
                </tr>
<%
}
%>
            </table>
        </center>
    </body>
</html>
<%
con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>