<%
if(session.getAttribute("user")==null)
{
    response.sendRedirect("login.jsp");
    return;
}
%>
<html>
    <frameset rows="15%,85%">
        <frame src="heading.jsp" name="f1" noresize>
        <frameset cols="20%,80%">
            <frame src="fList.jsp" name="f2" noresize>
            <frame src="fWelcome.jsp" name="f3">
        </frameset>
    </frameset>
</html>