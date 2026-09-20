<%@page import="java.sql.*"%>
<%
String uname=(String)session.getAttribute("user");
try
{
    if(request.getParameter("subject")!=null)
    {
        String farmer=request.getParameter("f_uname");
        String subject=request.getParameter("subject");
        String message=request.getParameter("message");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
        PreparedStatement ps = con.prepareStatement("insert into complaints(username,f_uname,subject,message,status) values(?,?,?,?,?)");
        ps.setString(1,uname);
        ps.setString(2,farmer);
        ps.setString(3,subject);
        ps.setString(4,message);
        ps.setString(5,"Pending");
        ps.executeUpdate();
        con.close();
%>
<center>
    <h3>Complaint Submitted Successfully</h3>
</center>
<%
    }
}
catch(Exception e)
{
    out.println(e);
}
%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Raise Complaint</h2>
        <form method="post">
            <table border="1">
                <tr>
                <th>Farmer Username</th>
                <td><input type="text" name="f_uname" required></td>
            </tr>
            <tr>
                <th>Subject</th>
                <td><input type="text" name="subject" required></td>
            </tr>
            <tr>
                <th>Message</th>
                <td>
                    <textarea name="message" rows="4" cols="30" required></textarea>
                </td>
            </tr>
        </table>
        <br>
        <input type="submit" value="Submit Complaint">
    </form>
    <h2>My Complaints</h2>
    <table border="1">
        <tr>
            <th>ID</th>
           <th>Farmer</th>
           <th>Subject</th>
            <th>Complaint</th>
            <th>Reply</th>
            <th>Status</th>
        </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select * from complaints where username=?");
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
%>
        <tr>
            <td><%=rs.getInt("complaint_id")%></td>
            <td><%=rs.getString("f_uname")%></td>
            <td><%=rs.getString("subject")%></td>
            <td><%=rs.getString("message")%></td>
            <td>
<%
String reply=rs.getString("reply");
if(reply==null || reply.trim().equals(""))
{
    out.println("No Reply Yet");
}
else
{
    out.println(reply);
}
%>
            </td>
            <td><%=rs.getString("status")%></td>
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