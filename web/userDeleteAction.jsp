<%@page import="java.io.Console"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 유저 삭제 실행 jsp
	db : member
	

 -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>계정 탈퇴</title>
</head>
<body>
	<% 
		// 패스워드를 불러와서 저장함.
		String user_password = request.getParameter("user_password");
	
		// 세션 여부 검출.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user_id,user_password); // 우선적으로 사용자가 입력한 패스워드가 맞는지 구분.
		if(result ==1){ // 패스워드가 사용자 패스워드와 동일.
			// 게시물 삭제 처리. (* 필요한지 확인 요망) 예로, 회원이 삭제되도 게시물은 그대로 가져가는 경우가 많음.
			// 회원 삭제 처리.
			// 세션 문제가 있다면 할당된 세션 해제.
			
			int res = userDAO.delete(user_id); // 유저 삭제.
			session.invalidate(); // 할당된 세션 제거.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴가 성공적으로 이뤄졌습니다.')");
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
		
		

		/*UserDAO userDAO = new UserDAO();
		
		int res = userDAO.delete(user_id);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('탈퇴가 성공적으로 이뤄졌습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	
		/*UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUser_id(),user.getUser_password()); 
		if(result ==1){
			// 게시물 삭제 처리. (* 필요한지 확인 요망) 예로, 회원이 삭제되도 게시물은 그대로 가져가는 경우가 많음.
			// 회원 삭제 처리.
			// 세션 문제가 있다면 할당된 세션 해제.
			
			int res = userDAO.delete(user_id);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('탈퇴가 성공적으로 이뤄졌습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){ // 비밀번호 틀림
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
		}*/
	%>


</body>
</html>