<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="admin.AdminlogDAO" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 커뮤니티 게시물 삭제 jsp
	db : comm_board
	

 -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>IM 관리페이지</title>
</head>
<body>
<%
		// 세션을 할당하는 부분.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		if(user_id == null){ // 로그인이 되어 있지 않을 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자가 아닙니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(!user_id.equals("ADMINISTRATOR")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자가 아닙니다!')");
			script.println("history.back()");
			script.println("</script>");
		}
		// 페이지 넘버를 계산하는 부분.
		
	%>
	<% 
		int bbsID = 0; // sell board 아이디
		bbsID = Integer.parseInt(request.getParameter("bbsID")); // 값을 받아옴.
		
		BbsDAO bbsDAO = new BbsDAO();
		
		int result = bbsDAO.delete(bbsID); // 실행할 때 나온 값을 저장하여, 진행한다.
		
		if(result == -1){ // 오류가 날 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = 'adminBoard2.jsp'");
			script.println("</script>");
		}else{ // 성공적으로 삭제될 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('성공적으로 삭제하였습니다.')");
			script.println("location.href = 'adminBoard2.jsp'");
			script.println("</script>");
			
		}
	
	

	%>


</body>
</html>