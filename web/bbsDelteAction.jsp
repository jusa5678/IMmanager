<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 중고 거래 게시물 삭제 jsp
	db : bbs,sell_sub
	

 -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>게시글 삭제</title>
</head>
<body>
	<% 
		int bbsID = 0; // sell board 아이디
		bbsID = Integer.parseInt(request.getParameter("bbsID")); // 값을 받아옴.
		
		BbsDAO bbsDAO = new BbsDAO();
		
		int result = bbsDAO.delete(bbsID); // 실행할 때 나온 값을 저장하여, 진행한다.
		
		if(result == -1){ // 오류가 날 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = 'mypage.jsp'");
			script.println("</script>");
		}else{ // 성공적으로 삭제될 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성공적으로 삭제하였습니다.')");
			script.println("location.href = 'mypage.jsp'");
			script.println("</script>");
			
		}
	
	

	%>


</body>
</html>