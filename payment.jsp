<html>
    <body bgcolor="beige" text="brown">
        <center>
            <h2>Payment Gateway</h2>
            <form action="placeOrder.jsp" method="post">
                <table border="1">
                    <tr>
                        <th colspan="2">Select Payment Method</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="payment" value="UPI" checked>
                        </td>
                        <td>UPI</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="payment" value="Card">
                        </td>
                        <td>Credit / Debit Card</td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" name="payment" value="COD">
                        </td>
                        <td>Cash On Delivery</td>
                    </tr>
                </table>
                <br>
                <input type="submit" value="Proceed Payment">
            </form>
        </center>
    </body>
</html>