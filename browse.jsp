<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Browse Products</h2>
        <table border="1">
            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Category</th>
                <th>Price</th>
                <th>Available Qty</th>
                <th>Rating</th>
                <th>Reviews</th>
                <th>Actions</th>
            </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select p.*, avg(r.rating) avg_rating, count(r.review_id) total_reviews " +
    "from products p left join reviews r on p.pid=r.pid group by p.pid");
    while(rs.next())
    {
%>
            <tr>
                <td>
                    <img src="images/<%=rs.getString("description")%>" width="100" height="100">
                </td>
                <td><b><%=rs.getString("pname")%></b></td>
                <td><%=rs.getString("category")%></td>
                <td><%=rs.getDouble("price")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td>
<%
double rating=rs.getDouble("avg_rating");
if(rs.getInt("total_reviews")==0)
{
    out.print("No Ratings");
}
else
{
    int stars=(int)Math.round(rating);
    for(int i=1;i<=stars;i++)
    {
        out.print("★");
    }
    out.print(" ("+ String.format("%.1f",rating)+")");
}
%>
                </td>
                <td><%=rs.getInt("total_reviews")%></td>
                <td>
                    <a href="addToCart.jsp?pid=<%=rs.getInt("pid")%>">Add To Cart</a>
                    <br><br>
                    <a href="reviews.jsp?pid=<%=rs.getInt("pid")%>">Reviews</a>
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