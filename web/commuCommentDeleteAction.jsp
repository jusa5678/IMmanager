<%@page import="java.io.Console"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.Community" %>
<%@ page import="commu_comment.Commu_comment" %>
<%@ page import="commu_comment.Commu_commentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 커뮤니티 게시물 댓글 삭제 jsp
	db : member,commu_board,commu_comment
	

 -->




<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>댓글 삭제</title>
</head>
<body>
	<% 
		// 커뮤니티 게시판에서 받아오는 정보들을 저장.
		int comment_number = 0;
		String temp = request.getParameter("comment_number"); // 댓글 번호를 받아옴.
		comment_number = Integer.parseInt(temp); // 댓글 번호를 int형으로 변경.
		
		// 받아온 정보들을 db에 저장하는 객체 생성.
		Commu_commentDAO commentDAO = new Commu_commentDAO();
		int result = commentDAO.delete(comment_number); // commu_comment 테이블에 저장.
		
		if(result == -1){// 데이터베이스 오류시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}else{// 댓글 삭제가 정상적으로 운영될 시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 삭제하셨습니다.')");
			script.println("location.href = 'commuBoard.jsp'");
			script.println("</script>");
		}
	

	
	
		
	
		
		

	%>


</body>
</html>