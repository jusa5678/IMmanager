<%@page import="java.io.Console"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 회원 정보 수정 실행jsp
	db : member
	

 -->


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>회원 정보 수정</title>
</head>
<body>
	<% 
		// 세션을 불러와서 저장.
		String user_password = null;
		String user_number_String = null;
		int user_number = 0;

		// 패스워드,폰 번호 를 저장하고 int형으로 변환.
		user_password = request.getParameter("user_password");
		user_number_String = request.getParameter("user_number");
		user_number = Integer.parseInt(user_number_String);
	
		// 세션 여부 검출.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
		}
		
		if(user_password == ""){//패스워드가 공백으로 입력시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 입력하지 않으셨습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user_id,user_password); // 먼저, 회원의 비밀번호가 맞는지를 구분.
		if(result ==1){ // 회원의 비밀번호가 맞음.
			
			//회원 정보 수정.
			int res = userDAO.revise(user_id, user_number , request.getParameter("user_address"),  request.getParameter("user_nick"), request.getParameter("user_date"));
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 수정이 정상적으로 처리되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
				

		}else if(result == 0){ // 비밀번호 틀림
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 2){ // 데이터베이스 오류.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		

	%>


</body>
</html>