<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- JavaBean사용. 현재 페이지에만 적용. -->

<!-- 받아오는 데이터  -->
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_number" />
<jsp:setProperty name="user" property="user_password" />
<jsp:setProperty name="user" property="user_address" />
<jsp:setProperty name="user" property="user_con" />
<jsp:setProperty name="user" property="user_nick" />
<jsp:setProperty name="user" property="user_date" />



<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>회원 가입 실행</title>
</head>
<body>
	<%
	
		// 세션 여부 검출.
		String userID = null;
		if(session.getAttribute("user_id") != null){
			userID = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
		}
		if(userID != null){ // 세션이 이미 부여된 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		if(user.getUser_id() == null || user.getUser_password() == null ||
		 user.getUser_address() == null){ // 회원가입시 미입력 부분 처리.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); 
			if(result == -1){ // 아이디 존재.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{ // 회원가입 성공.
				session.setAttribute("userID", user.getUser_id()); // 로그인 세션 할당.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'"); // 회원가입이 되었을 때는 메인 페이지로 이동.
				script.println("</script>");
			}
		}
			
		
		
	
	%>


</body>
</html>