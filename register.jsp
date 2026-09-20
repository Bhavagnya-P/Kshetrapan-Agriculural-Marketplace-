<%@page import="java.sql.*"%>
<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h1>Registration Page</h1>
            <form method="post">
            <table border="1">
                <tr>
                    <th>Role</th>
                    <td>
                        <select name="role">
                        <option>Farmer</option>
                        <option>Buyer</option>
                        </select>
                </td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <th>Username</th>
                    <td><input type="text" name="uname"></td>
                </tr>
                <tr>
                    <th>Password</th>
                    <td><input type="text" name="pwd"></td>
                </tr>
                <tr>
                    <th>Phone No</th>
                    <td><input type="text" name="phone"></td>
                </tr>
                <tr>
                    <th>Address</th>
                    <td><input type="text" name="address"></td>
                </tr>
            </table>
            <br>
            <input type="submit" value="Register">
            </form>
        </center>
        <%
        try{
        String role=request.getParameter("role");
        String name=request.getParameter("name");
        String username=request.getParameter("uname");
        String password=request.getParameter("pwd");
        String phone=request.getParameter("phone");
        String address=request.getParameter("address");
        if(username!=null){
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db", "Admin", "Root");
        PreparedStatement ps=con.prepareStatement("insert into users values(?,?,?,?,?,?)");
        ps.setString(1, role);
        ps.setString(2, name);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, phone);
        ps.setString(6, address);
        int x=ps.executeUpdate();
        out.println("<center><h3>Registration Successful!</h3></center>");
        response.sendRedirect("login.jsp");
        ps.close();
        con.close();
        }
        }
        catch(Exception e){
            out.println(e);
        }
        %>
    </body>
</html>