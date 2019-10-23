<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.io.Console"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<!-- 
	사용 : 중고 거래 게시물 댓글 생성 jsp
	db : member,bbs,comment
	

 -->

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>댓글 생성</title>
</head>
<body>
	<% 
			// 중고 거래 게시물에서 받아오는 정보들을 저장.
			String comment = null; // 댓글 저장.
			String user_id = null; // 유저 저장.
			int bbsID = 0; 
			comment = request.getParameter("comment"); //댓글 저장.
			
			if(request.getParameter("bbsID") != null){// 게시물 번호 저장.
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}

			// 세션 여부 검출.
			if(session.getAttribute("user_id") != null){
				user_id = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
			}
			
			if(user_id == null){ // 유저가 로그인하지 않은 상태일 때.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 후 이용가능한 서비스입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(bbsID == 0){ // 정상적이지 않은 접근시.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 접근입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(comment == ""){ // 댓글에 아무런 내용을 넣지 않을시.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글을 기입하지 않으셨습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
			
			// 받아온 댓글 정보를 db에 저장하는 객체.
			CommentDAO commentDAO = new CommentDAO();
			int result = commentDAO.write(user_id, bbsID, comment); // comment 테이블에 저장.
			
			if(result == -1){ // 데이터베이스 오류 발생시.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류가 발생했습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}else{ // 댓글 작성이 완료될 경우.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글 작성이 완료되었습니다.')");
				script.println("location.href = 'sellboard.jsp'");
				script.println("</script>");
			}
			}
			
			
	%>


</body>
</html>