<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>My Cart</h2>
        <table border="1">
            <tr>
                <th>Cart ID</th>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            <th>Action</th>
        </tr>
<%
double grandTotal=0;
try
{
    String uname=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select c.cart_id,c.pid,c.quantity,p.pname,p.price "+
    "from cart c, products p where c.pid=p.pid and c.b_uname=?");
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
        double total=rs.getDouble("price")*rs.getInt("quantity");
        grandTotal+=total;
%>
        <tr>
            <td><%=rs.getInt("cart_id")%></td>
            <td><%=rs.getString("pname")%></td>
            <td><%=rs.getDouble("price")%></td>
            <td>
                <form action="updateCart.jsp" method="post">
                    <input type="hidden" name="cartid" value="<%=rs.getInt("cart_id")%>">
                    <input type="number" name="qty" value="<%=rs.getInt("quantity")%>" min="1">
                    <input type="submit" value="Update">
                </form>
            </td>
            <td><%=total%></td>
            <td>
                <a href="removeCart.jsp?cartid=<%=rs.getInt("cart_id")%>" target="f3">Remove</a>
            </td>
        </tr>
<%
    }
%>
        <tr>
            <th colspan="4">Grand Total</th>
            <th><%=grandTotal%></th>
            <th></th>
        </tr>
    </table>
    <br>
    <form action="payment.jsp" method="post">
        <input type="submit" value="Place Order">
    </form>
<%
con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>
    </body>
</html>