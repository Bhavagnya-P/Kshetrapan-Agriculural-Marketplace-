<%@page import="java.sql.*"%>
<%
try
{
    int pid = Integer.parseInt(request.getParameter("pid"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement( "delete from products where pid=?");
    ps.setInt(1,pid);
    ps.executeUpdate();
    response.sendRedirect("manageProducts.jsp");
}
catch(Exception e)
{
    out.println(e);
}
%>