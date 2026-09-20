<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
String uname=(String)session.getAttribute("user");
int pid=Integer.parseInt(request.getParameter("pid"));
String pname="";
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select pname from products where pid=?");
    ps.setInt(1,pid);
    ResultSet rs=ps.executeQuery();
    if(rs.next())
    {
        pname=rs.getString("pname");
    }
    if(request.getParameter("rating")!=null)
    {
        PreparedStatement ps1=con.prepareStatement("insert into reviews(b_uname,pid,rating,comment) values(?,?,?,?)");
        ps1.setString(1, uname);
        ps1.setInt(2, pid);
        ps1.setInt(3, Integer.parseInt(request.getParameter("rating")));
        ps1.setString(4, request.getParameter("comment"));
        ps1.executeUpdate();
%>
<center>
    <h3>Review Submitted Successfully</h3>
</center>
<%
    }
    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Review Product</h2>
        <h3>Product:<%=pname%></h3>
        <form method="post">
            <input type="hidden" name="pid" value="<%=pid%>">
            <table border="1">
                <tr>
                    <th>Rating</th>
                    <td>
                        <select name="rating">
                            <option value="1">★</option>
                            <option value="2">★★</option>
                            <option value="3">★★★</option>
                            <option value="4">★★★★</option>
                            <option value="5">★★★★★</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Comment</th>
                    <td>
                        <textarea name="comment" rows="4" cols="30"></textarea>
                    </td>
                </tr>
            </table>
            <br>
            <input type="submit" value="Submit Review">
        </form>
        <h2>Existing Reviews</h2>
        <table border="1">
            <tr>
                <th>Buyer</th>
                <th>Rating</th>
                <th>Comment</th>
            </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select * from reviews where pid=?");
    ps.setInt(1,pid);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getString("b_uname")%></td>
                <td>
<%
for(int i=1;i<=rs.getInt("rating");i++)
{
    out.print("★");
}
%>
                </td>
                <td><%=rs.getString("comment")%></td>
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