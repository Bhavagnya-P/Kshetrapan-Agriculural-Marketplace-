<%@page import="java.sql.*"%>
<%
String uname = (String)session.getAttribute("user");
int totalProducts = 0;
int totalOrders = 0;
int pendingOrders = 0;
double revenue = 0;
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps1 = con.prepareStatement("select count(*) from products where f_uname=?");
    ps1.setString(1, uname);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next())
    {
        totalProducts = rs1.getInt(1);
    }
    PreparedStatement ps2 = con.prepareStatement("select count(*) from orders where f_uname=?");
    ps2.setString(1, uname);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next())
    {
        totalOrders = rs2.getInt(1);
    }
    PreparedStatement ps3 = con.prepareStatement("select count(*) from orders where f_uname=? and status='Pending'");
    ps3.setString(1, uname);
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next())
    {
        pendingOrders = rs3.getInt(1);
    }
    PreparedStatement ps4 = con.prepareStatement("select ifnull(sum(total_amount),0) from orders where f_uname=? and status='Delivered'");
    ps4.setString(1, uname);
    ResultSet rs4 = ps4.executeQuery();
    if(rs4.next())
    {
        revenue = rs4.getDouble(1);
    }
%>
<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h1>Farmer Dashboard</h1>
            <table border="1" cellpadding="15">
                <tr>
                    <th>Total Products</th>
                    <th>Total Orders</th>
                </tr>
                <tr>
                    <td><%=totalProducts%></td>
                    <td><%=totalOrders%></td>
                </tr>
                <tr>
                    <th>Pending Orders</th>
                    <th>Total Revenue</th>
                </tr>
                <tr>
                    <td><%=pendingOrders%></td>
                    <td><%=revenue%></td>
                </tr>
            </table>
            <br><br>
            <h2>Recent Orders</h2>
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>Buyer</th>
                    <th>Quantity</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
<%
PreparedStatement ps5 = con.prepareStatement("select * from orders where f_uname=? order by order_date desc limit 5");
ps5.setString(1, uname);
ResultSet rs5 = ps5.executeQuery();
while(rs5.next())
{
%>
                <tr>
                    <td><%=rs5.getInt("order_id")%></td>
                    <td><%=rs5.getString("b_uname")%></td>
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