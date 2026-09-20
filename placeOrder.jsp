<%@page import="java.sql.*"%>
<%
String payment=request.getParameter("payment");

if(payment==null)
{
    payment="Unknown";
}
try
{
    String uname=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("select c.pid,c.quantity,p.price,p.f_uname "+
    "from cart c,products p where c.pid=p.pid and c.b_uname=?");
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
        int pid=rs.getInt("pid");
        int qty=rs.getInt("quantity");
        double amount=rs.getDouble("price")*qty;
        String farmer=rs.getString("f_uname");
        PreparedStatement ps1=con.prepareStatement("insert into orders(b_uname,f_uname,pid,quantity,total_amount,order_date,status)"+
        " values(?,?,?,?,?,curdate(),?)");
        ps1.setString(1,uname);
        ps1.setString(2,farmer);
        ps1.setInt(3,pid);
        ps1.setInt(4,qty);
        ps1.setDouble(5,amount);
        ps1.setString(6,"Pending");
        ps1.executeUpdate();
        PreparedStatement ps2=con.prepareStatement("update products set quantity=quantity-? where pid=?");
        ps2.setInt(1,qty);
        ps2.setInt(2,pid);
        ps2.executeUpdate();
    }
    PreparedStatement ps3=con.prepareStatement("delete from cart where b_uname=?");
    ps3.setString(1,uname);
    ps3.executeUpdate();
%>
<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h2>Payment Successful</h2>
            <h3>Payment Method:<%=payment%></h3>
            <h3>Order Placed Successfully</h3>
            <br>
            <a href="orderHistory.jsp">View Order History</a>
        </center>
    </body>
</html>
<%
}
catch(Exception e)
{
    out.println(e);
}
%>