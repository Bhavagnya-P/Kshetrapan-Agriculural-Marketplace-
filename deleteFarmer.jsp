<%@page import="java.sql.*"%>
<%
try
{
    String username = request.getParameter("username");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("delete from users where username=? and role='Farmer'");
    ps.setString(1, username);
    int x = ps.executeUpdate();
    response.sendRedirect("manageFarmers.jsp");
}
catch(Exception e)
{
    out.println(e);
}
%>