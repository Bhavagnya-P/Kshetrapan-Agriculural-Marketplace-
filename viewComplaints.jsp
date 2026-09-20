<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>All Complaints</h2>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Buyer</th>
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
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from complaints");
    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getInt("complaint_id")%></td>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getString("f_uname")%></td>
                <td><%=rs.getString("subject")%></td>
                <td><%=rs.getString("message")%></td>
                <td><%=rs.getString("reply")==null ? "No Reply Yet" : rs.getString("reply")%></td>
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