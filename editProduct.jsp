<%@page import="java.sql.*"%>
<%
int pid=Integer.parseInt(request.getParameter("pid"));
String role=(String)session.getAttribute("role");
String uname=(String)session.getAttribute("user");
String pname="";
String category="";
double price=0;
int quantity=0;
String description="";
String farmer="";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "root", "Root");
if(pid!=0)
{
    PreparedStatement ps;
    if(role.equals("Admin"))
    {
        ps=con.prepareStatement("select * from products where pid=?");
        ps.setInt(1,pid);
    }
    else
    {
        ps=con.prepareStatement("select * from products where pid=? and f_uname=?");
        ps.setInt(1,pid);
        ps.setString(2,uname);
    }
    ResultSet rs=ps.executeQuery();
    if(!rs.next())
    {
        out.println("Product Not Found");
        return;
    }
    farmer=rs.getString("f_uname");
    pname=rs.getString("pname");
    category=rs.getString("category");
    price=rs.getDouble("price");
    quantity=rs.getInt("quantity");
    description=rs.getString("description");
}
if(request.getParameter("pname")!=null)
{
    if(pid==0)
    {
        PreparedStatement ps1;
        if(role.equals("Admin"))
        {
            ps1=con.prepareStatement("insert into products(f_uname,pname,category,price,quantity,description) values(?,?,?,?,?,?)");
            ps1.setString(1, request.getParameter("f_uname"));
        }
        else
        {
            ps1=con.prepareStatement("insert into products(f_uname,pname,category,price,quantity,description) values(?,?,?,?,?,?)");
            ps1.setString(1,uname);
        }
        ps1.setString(2, request.getParameter("pname"));
        ps1.setString(3, request.getParameter("category"));
        ps1.setDouble(4, Double.parseDouble(request.getParameter("price")));
        ps1.setInt(5, Integer.parseInt(request.getParameter("quantity")));
        ps1.setString(6,request.getParameter("description"));
        ps1.executeUpdate();
    }
    else
    {
        PreparedStatement ps1;
        if(role.equals("Admin"))
        {
            ps1=con.prepareStatement("update products set pname=?,category=?,price=?,quantity=?,description=? where pid=?");
            ps1.setString(1, request.getParameter("pname"));
            ps1.setString(2, request.getParameter("category"));
            ps1.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps1.setInt(4, Integer.parseInt(request.getParameter("quantity")));
            ps1.setString(5, request.getParameter("description"));
            ps1.setInt(6,pid);
        }
        else
        {
            ps1=con.prepareStatement("update products set pname=?,category=?,price=?,quantity=?,description=? where pid=? and f_uname=?");
            ps1.setString(1, request.getParameter("pname"));
            ps1.setString(2, request.getParameter("category"));
            ps1.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps1.setInt(4, Integer.parseInt(request.getParameter("quantity")));
            ps1.setString(5, request.getParameter("description"));
            ps1.setInt(6,pid);
            ps1.setString(7,uname);
        }
        ps1.executeUpdate();
    }
    response.sendRedirect("manageProducts.jsp");
}
%>

<html>
    <body bgcolor="beige" text="brown">
        <h2><%= (pid==0) ? "Add Product" : "Edit Product" %></h2>
        <form method="post">
<%
if(role.equals("Admin") && pid==0)
{
%>
            Farmer Username:
            <input type="text" name="f_uname">
            <br><br>
<%
}
%>
            Product Name:
            <input type="text" name="pname" value="<%=pname%>">
            <br><br>
            Category:<input type="text" name="category" value="<%=category%>">
            <br><br>
            Price:<input type="text" name="price" value="<%=price%>">
            <br><br>
            Quantity:<input type="text" name="quantity" value="<%=quantity%>">
            <br><br>
            Image:<input type="text" name="description" value="<%=description%>">
            <br><br>
            <input type="submit" value="<%= (pid==0) ? "Add Product" : "Update Product" %>">
        </form>
    </body>
</html>