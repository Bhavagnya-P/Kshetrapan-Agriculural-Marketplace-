<html>
    <head>
        <title>Kshetrapan</title>
        <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: beige, url('Kshetrapan.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        .container {
            text-align: center;
            padding-top: 100px;
        }
        .image-container{
            text-align:center;
            margin-top:150px;
        }
        </style>
    </head>
    <body bgcolor="beige" text="brown">
        <form action="verify.jsp">
            <center><img src="Kshetrapan.png" width="500" height="250">
            <table border=1>
                <tr>
                    <th>Roles:</th>
                    <td><select name="role">
                        <option>Choose your role</option>
                        <option>Admin</option>
                        <option>Farmer</option>
                        <option>Buyer</option>
                    </select></td>
                </tr>
                <tr>
                    <th>User Name</th>
                    <td><input type="text" name="uname"></td>
                </tr>
                <tr>
                    <th>Password</th>
                    <td><input type="password" name="pwd"></td>
                </tr>
            </table>
            <br/>
            <input type="submit" value="Login">
            </center>
        </form>
        <h3><center>Don't have an account? <br>Then <a href="register.jsp">register here</a></center></h3>
    </body>
</html>