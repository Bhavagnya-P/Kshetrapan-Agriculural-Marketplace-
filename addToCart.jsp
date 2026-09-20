<%@page import="java.sql.*"%>
<%
try
{
    String uname=(String)session.getAttribute("user");
    int pid=Integer.parseInt(request.getParameter("pid"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    PreparedStatement ps = con.prepareStatement("select * from cart where b_uname=? and pid=?");
    ps.setString(1,uname);
    ps.setInt(2,pid);
    ResultSet rs=ps.executeQuery();
    if(rs.next())
    {
        PreparedStatement ps1 = con.prepareStatement("update cart set quantity=quantity+1 where b_uname=? and pid=?");
        ps1.setString(1,uname);
        ps1.setInt(2,pid);
        ps1.executeUpdate();
    }
    else
    {
        PreparedStatement ps2 = con.prepareStatement("insert into cart(b_uname,pid,quantity) values(?,?,?)");
        ps2.setString(1,uname);
        ps2.setInt(2,pid);
        ps2.setInt(3,1);
        ps2.executeUpdate();
    }
    response.sendRedirect("cart.jsp");
}
catch(Exception e)
{
    out.println(e);
}
%>