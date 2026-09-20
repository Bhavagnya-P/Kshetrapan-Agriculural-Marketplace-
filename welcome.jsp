<%@page import="java.sql.*"%>
<%
int farmers = 0;
int buyers = 0;
int products = 0;
int orders = 0;
try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
    Statement st = con.createStatement();
    ResultSet rs;
    // Total Farmers
    rs = st.executeQuery("select count(*) from users where role='Farmer'");
    if(rs.next())
    {
        farmers = rs.getInt(1);
    }
    // Total Buyers
    rs = st.executeQuery("select count(*) from users where role='Buyer'");
    if(rs.next())
    {
        buyers = rs.getInt(1);
    }
    // Total Products
    rs = st.executeQuery("select count(*) from products");
    if(rs.next()){
        products = rs.getInt(1);
    }
    // Total Orders
    rs = st.executeQuery("select count(*) from orders");
    if(rs.next()){
        orders = rs.getInt(1);
    }
    con.close();
}
catch(Exception e)
{
    out.println(e);
}
%>

<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h1>Admin Dashboard</h1>
            <h3>Welcome Admin</h3>
            <table border="1" cellpadding="15" cellspacing="5">
                <tr bgcolor="beige">
                <th>Total Farmers</th>
                <th>Total Buyers</th>
                <th>Total Products</th>
                <th>Total Orders</th>
            </tr>
            <tr>
                <td align="center"><%= farmers %></td>
                <td align="center"><%= buyers %></td>
                <td align="center"><%= products %></td>
                <td align="center"><%= orders %></td>
            </tr>
        </table>
    </center>