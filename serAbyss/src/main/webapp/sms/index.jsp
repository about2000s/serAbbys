<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <title>SMS 프로젝트</title>
    </head>
    <form method="post" name="smsForm" action="smssend.jsp">
        <input type="hidden" name="action" value="go">
        <textarea name="msg" cols="30" rows="10" style="width:455px;" placeholder="내용 입력"></textarea>
        <br>
        <input type="text" name="rphone" placeholder="ex)010-2345-3434"><!-- 나중에 문자열 스플릿 해서 내보내면 된다! -->
        <br>
        <input type="hidden" name="sphone1" value = "010">
        <input type="hidden" name="sphone2" value = "2860">
        <input type="hidden" name="sphone3" value = "2892">
        <br>
        <input type="submit" value="전송">
    </form>
	</body>
</html>