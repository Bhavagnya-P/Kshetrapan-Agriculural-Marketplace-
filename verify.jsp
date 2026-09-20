<%@page import="java.sql.*"%>

<%

String role=request.getParameter("role");
String uname=request.getParameter("uname");
String pwd=request.getParameter("pwd");

try
{
    if(role.equals("Admin"))
    {
        if(uname.equals("Admin") && pwd.equals("Admin"))
        {
            session.setAttribute("user",uname);
            session.setAttribute("role","Admin");
            response.sendRedirect("AdminPage.jsp");
        }
        else
        {
            out.println("Invalid Admin Login");
        }
    }
    else
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
        PreparedStatement ps = con.prepareStatement("select * from users where role=? and username=? and password=?");
        ps.setString(1,role);
        ps.setString(2,uname);
        ps.setString(3,pwd);
        ResultSet rs=ps.executeQuery();
        if(rs.next())
        {
            session.setAttribute("user",uname);
            session.setAttribute("role",role);
            if(role.equals("Farmer"))
                response.sendRedirect("FarmerPage.jsp");
            else if(role.equals("Buyer"))
                response.sendRedirect("BuyerPage.jsp");
        }
        else
        {
            out.println("Invalid Login");
        }
        rs.close();
        ps.close();
        con.close();
    }
}
catch(Exception e)
{
    out.println(e);
}
%>