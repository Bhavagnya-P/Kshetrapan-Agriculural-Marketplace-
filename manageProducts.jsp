<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Products List</h2>
        <center>
            <form method="get">
                Search Product:<input type="text" name="search">
                <input type="submit" value="Search">
                <a href="editProduct.jsp?pid=0" target="f3">
                    <input type="button" value="Add New Product">
                </a>
            </form>
        </center>
        <br>
        <table border="1">
            <tr>
                <th>ID</th>
<%
String role=(String)session.getAttribute("role");
if(role!=null && role.equals("Admin"))
{
%>
                <th>Farmer</th>
<%
}
%>
                <th>Product</th>
                <th>Category</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Image</th>
                <th>Rating</th>
                <th>Reviews</th>
                <th>View Reviews</th>
                <th>Action</th>
            </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    ResultSet rs;
    String search=request.getParameter("search");
    if(role.equals("Admin"))
    {
        if(search!=null && !search.trim().equals(""))
        {
            PreparedStatement ps = con.prepareStatement("select p.*,avg(r.rating) avg_rating,count(r.review_id) total_reviews "+
            "from products p left join reviews r on p.pid=r.pid where p.pname like ? group by p.pid");
            ps.setString(1, "%"+search+"%");
            rs=ps.executeQuery();
        }
        else
        {
            Statement st=con.createStatement();
            rs=st.executeQuery("select p.*,avg(r.rating) avg_rating,count(r.review_id) total_reviews "+
            "from products p left join reviews r on p.pid=r.pid group by p.pid");
        }
    }
    else
    {
        String uname=(String)session.getAttribute("user");
        if(search!=null && !search.trim().equals(""))
        {
            PreparedStatement ps = con.prepareStatement("select p.*,avg(r.rating) avg_rating,count(r.review_id) total_reviews "+
            "from products p left join reviews r on p.pid=r.pid where p.f_uname=? and p.pname like ? group by p.pid");
            ps.setString(1,uname);
            ps.setString(2,"%"+search+"%");
            rs=ps.executeQuery();
        }
        else
        {
            PreparedStatement ps = con.prepareStatement("select p.*,avg(r.rating) avg_rating,count(r.review_id) total_reviews "+
            "from products p left join reviews r on p.pid=r.pid where p.f_uname=? group by p.pid");
            ps.setString(1,uname);
            rs=ps.executeQuery();
        }
    }
    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getInt("pid")%></td>
<%
if(role.equals("Admin"))
{
%>
                <td><%=rs.getString("f_uname")%></td>
<%
}
%>
                <td><%=rs.getString("pname")%></td>
                <td><%=rs.getString("category")%></td>
                <td>₹<%=rs.getDouble("price")%></td>
                <td><%=rs.getInt("quantity")%></td>
                <td>
                    <img src="images/<%=rs.getString("description")%>" width="100" height="100">
                </td>
                <td>
<%
double rating=rs.getDouble("avg_rating");
if(rs.getInt("total_reviews")==0)
{
    out.print("No Ratings");
}
else
{
    out.print(String.format("%.1f",rating)+"/5");
}
%>
            </td>
            <td><%=rs.getInt("total_reviews")%></td>
            <td>
                <a href="pReviews.jsp?pid=<%=rs.getInt("pid")%>" target="f3">View Reviews</a>
            </td>
            <td>
                <a href="editProduct.jsp?pid=<%=rs.getInt("pid")%>" target="f3">Edit</a>|
                <a href="deleteProduct.jsp?pid=<%=rs.getInt("pid")%>" target="f3" onclick="return confirm('Delete this product?')">Delete</a>
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