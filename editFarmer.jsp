<%@page import="java.sql.*"%>
<%
String username=request.getParameter("username");
String name="";
String password="";
String phone="";
String address="";
boolean addMode=false;
if("new".equals(username))
{
    addMode=true;
}
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
if(!addMode)
{
    PreparedStatement ps = con.prepareStatement("select * from users where username=? and role='Farmer'");
    ps.setString(1,username);
    ResultSet rs=ps.executeQuery();
    if(!rs.next())
    {
        out.println("Farmer Not Found");
        return;
    }
    name=rs.getString("name");
    password=rs.getString("password");
    phone=rs.getString("phone");
    address=rs.getString("address");
}
if(request.getParameter("mode")!=null)
{
    String mode=request.getParameter("mode");
    if("add".equals(mode))
    {
        PreparedStatement ps = con.prepareStatement("insert into users(role,name,username,password,phone,address) values(?,?,?,?,?,?)");
        ps.setString(1,"Farmer");
        ps.setString(2,request.getParameter("name"));
        ps.setString(3,request.getParameter("username"));
        ps.setString(4,request.getParameter("password"));
        ps.setString(5,request.getParameter("phone"));
        ps.setString(6,request.getParameter("address"));
        ps.executeUpdate();
    }
    else
    {
        PreparedStatement ps = con.prepareStatement("update users set name=?,password=?,phone=?,address=? where username=? and role='Farmer'");
        ps.setString(1,request.getParameter("name"));
        ps.setString(2,request.getParameter("password"));
        ps.setString(3,request.getParameter("phone"));
        ps.setString(4,request.getParameter("address"));
        ps.setString(5,request.getParameter("username"));
        ps.executeUpdate();
    }
    response.sendRedirect("manageFarmers.jsp");
}
%>
<html>
    <body bgcolor="beige" text="brown">
        <h2><%= addMode ? "Add Farmer" : "Edit Farmer" %></h2>
        <form method="post">
            <input type="hidden" name="mode" value="<%=addMode?"add":"edit"%>">
            Name:<input type="text" name="name" value="<%=name%>" required>
            <br><br>
            Username:
<%
if(addMode)
{
%>
            <input type="text" name="username" required>
<%
}
else
{
%>

            <input type="hidden" name="username" value="<%=username%>">
            <input type="text" value="<%=username%>" readonly>
<%
}
%>            
            <br><br>
            Password:<input type="text" name="password" value="<%=password%>" required>
            <br><br>
            Phone:<input type="text" name="phone" value="<%=phone%>">
            <br><br>
            Address:<input type="text" name="address" value="<%=address%>">
            <br><br>
            <input type="submit" value="<%= addMode ? "Add Farmer" : "Update Farmer" %>">
        </form>
    </body>
</html>