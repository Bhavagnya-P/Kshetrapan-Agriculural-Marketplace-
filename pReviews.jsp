<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
int pid=Integer.parseInt(request.getParameter("pid"));
String pname="";
%>
<html>
    <body bgcolor="beige" text="brown">
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("select pname from products where pid=?");
    ps.setInt(1,pid);
    ResultSet rs=ps.executeQuery();
    if(rs.next())
    {
        pname=rs.getString("pname");
    }
%>
        <h2>Reviews for <%=pname%></h2>
        <table border="1">
            <tr>
                <th>Buyer</th>
                <th>Rating</th>
                <th>Comment</th>
            </tr>
<%
    PreparedStatement ps2 = con.prepareStatement("select * from reviews where pid=?");
    ps2.setInt(1,pid);
    ResultSet rs2=ps2.executeQuery();
    while(rs2.next())
    {
%>
            <tr>
                <td><%=rs2.getString("b_uname")%></td>
                <td>
<%
for(int i=1;i<=rs2.getInt("rating");i++)
{
    out.print("★");
}
%>
                </td>
                <td><%=rs2.getString("comment")%></td>
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