<%@page import="java.sql.*"%>
<%
String uname = (String)session.getAttribute("user");
int totalOrders = 0;
int totalQty = 0;
double totalRevenue = 0;
double deliveredRevenue = 0;
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps1 = con.prepareStatement("select count(*) from orders where f_uname=?");
    ps1.setString(1, uname);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next())
    {
        totalOrders = rs1.getInt(1);
    }
    PreparedStatement ps2 = con.prepareStatement("select ifnull(sum(quantity),0) from orders where f_uname=?");
    ps2.setString(1, uname);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next())
    {
        totalQty = rs2.getInt(1);
    }
    PreparedStatement ps3 = con.prepareStatement("select ifnull(sum(total_amount),0) from orders where f_uname=?");
    ps3.setString(1, uname);
    ResultSet rs3 = ps3.executeQuery();
    if(rs3.next())
    {
        totalRevenue = rs3.getDouble(1);
    }
    PreparedStatement ps4 = con.prepareStatement("select ifnull(sum(total_amount),0) from orders where f_uname=? and status='Delivered'");
    ps4.setString(1, uname);
    ResultSet rs4 = ps4.executeQuery();
    if(rs4.next())
    {
        deliveredRevenue = rs4.getDouble(1);
    }
%>

<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h1>Sales & Earnings Report</h1>
            <h3>Farmer : <%=uname%></h3>
            <br>
            <table border="1" cellpadding="10">
                <tr bgcolor="lightyellow">
                    <th colspan="2">Sales Report</th>
                </tr>
                <tr>
                    <td>Total Orders Received</td>
                    <td><%=totalOrders%></td>
                </tr>
                <tr>
                    <td>Total Quantity Sold</td>
                    <td><%=totalQty%></td>
                </tr>
                <tr bgcolor="lightyellow">
                    <th colspan="2">Earnings Report</th>
                </tr>
                <tr>
                    <td>Total Revenue</td>
                    <td><%=totalRevenue%></td>
                </tr>
                <tr>
                    <td>Revenue From Delivered Orders</td>
                    <td><%=deliveredRevenue%></td>
                </tr>
            </table>
            <br><br>
            <h2>Order Details</h2>
            <table border="1">
                <tr>
                    <th>Order ID</th>
                    <th>Buyer</th>
                    <th>Quantity</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
<%
PreparedStatement ps5 = con.prepareStatement("select * from orders where f_uname=?");
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