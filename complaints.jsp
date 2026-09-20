<%@page import="java.sql.*"%>
<%
try
{
    if(request.getParameter("cid")!=null)
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
        PreparedStatement ps = con.prepareStatement("update complaints set reply=?,status=? where complaint_id=?");
        ps.setString(1,request.getParameter("reply"));
        ps.setString(2,request.getParameter("status"));
        ps.setInt(3,Integer.parseInt(request.getParameter("cid")));
        ps.executeUpdate();
        con.close();
    }
}
catch(Exception e)
{
    out.println(e);
}
%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Customer Complaints</h2>
        <table border="1" cellpadding="5">
            <tr>
                <th>Complaint ID</th>
                <th>Buyer Username</th>
                <th>Subject</th>
                <th>Complaint</th>
                <th>Reply</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
<%
try
{
    String uname=(String)session.getAttribute("user");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    PreparedStatement ps = con.prepareStatement("select * from complaints where f_uname=?");
    ps.setString(1,uname);
    ResultSet rs=ps.executeQuery();
    while(rs.next())
    {
%>
            <tr>
                <form method="post">
                    <input type="hidden" name="cid" value="<%=rs.getInt("complaint_id")%>">
                    <td><%=rs.getInt("complaint_id")%></td>
                    <td><%=rs.getString("username")%></td>
                    <td><%=rs.getString("subject")%></td>
                    <td><%=rs.getString("message")%></td>
                    <td>
                        <input type="text" name="reply" value="<%=rs.getString("reply")==null?"":rs.getString("reply")%>" size="25">
                    </td>
                    <td>
                        <select name="status">
                            <option<%= "Pending".equals(rs.getString("status"))?"selected":"" %>>
                                Pending
                            </option>
                            <option<%= "In Progress".equals(rs.getString("status"))?"selected":"" %>>
                                In Progress
                            </option>
                            <option<%= "Resolved".equals(rs.getString("status"))?"selected":"" %>>
                                Resolved
                            </option>
                        </select>
                    </td>
                    <td><input type="submit" value="Update"></td>
                </form>
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