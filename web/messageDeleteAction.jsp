<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="message.Message" %>
<%@ page import="message.MessageDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 메세지 삭제 jsp
	db : member,message
	

 -->



<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>메세지 삭제</title>
</head>
<body>
	<% 
		// 삭제할 메세지의 번호를 받아와서 저장.
		int messNumber = 0;
		String temp = request.getParameter("messNumber");
		messNumber = Integer.parseInt(temp);
		
		// 메세지를 삭제하는 쿼리를 실행.
		MessageDAO messDAO = new MessageDAO();
		int result = messDAO.delete(messNumber);
		
		if(result == -1){ // 데이터베이스 오류시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = 'message.jsp'");
			script.println("</script>");
		}else{ // 정상적으로 메세지를 삭제할 시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메세지를 삭제하였습니다.')");
			script.println("location.href = 'message.jsp'");
			script.println("</script>");
		}
	

	%>


</body>
</html>