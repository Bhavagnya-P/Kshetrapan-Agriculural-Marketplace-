<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <h2>Farmers List</h2>
        <center>
            <form method="get">
                Search Farmer:<input type="text" name="search">
                <input type="submit" value="Search">
                <a href="editFarmer.jsp?username=new" target="f3">
                    <input type="button" value="Add New Farmer">
                </a>
            </form>
        </center>
        <br>
        <table border="1">
            <tr>
                <th>Name</th>
                <th>Username</th>
                <th>Phone No</th>
                <th>Address</th>
                <th>Action</th>
            </tr>
<%
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
    ResultSet rs;
    String search=request.getParameter("search");
    if(search!=null && !search.trim().equals(""))
    {
        PreparedStatement ps=con.prepareStatement("select * from users where role='Farmer' and name like ?");
        ps.setString(1,"%"+search+"%");
        rs=ps.executeQuery();
    }
    else
    {
        Statement st=con.createStatement();
        rs=st.executeQuery("select * from users where role='Farmer'");
    }

    while(rs.next())
    {
%>
            <tr>
                <td><%=rs.getString("name")%></td>
                <td><%=rs.getString("username")%></td>
                <td><%=rs.getString("phone")%></td>
                <td><%=rs.getString("address")%></td>
                <td>
                    <a href="editFarmer.jsp?username=<%=rs.getString("username")%>" target="f3">Edit</a>|
                    <a href="deleteFarmer.jsp?username=<%=rs.getString("username")%>" target="f3"
                    onclick="return confirm('Delete this farmer?')">Delete</a>
                </td>
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