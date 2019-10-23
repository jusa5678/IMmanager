<!--  https://www.youtube.com/watch?v=dfH64W8Vgyk&list=PLRx0vPvlEmdBMeD6NZawEmwHKjzD6ZGqp&index=5 -->
<%@page import="user.UserDAO"%>
<%@ page import="user.User" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />

<jsp:setProperty name="bbs" property="bbsID" />

<!-- 
	사용 : 유저 이미지 변경 실행 jsp
	db : member
	
	이 부분은 임시로 둔 페이지이며, 나중에 회원가입과 회원수정 쪽에 합칠 때 이 페이지를 삭제한다.

 -->



<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>유저 이미지 변경</title>
</head>
<body>
	<% 
	// 세션 여부 검출.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
		}
		if(user_id == null){ // 세션이 부여되지 않은 경우 색출.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('정상적이지 않은 접근입니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();


		String directory = "/usr/local/apache-tomcat-8.5.39/webapps/ROOT"; // 저장되는 위치.
		
		int maxSize = 1024 * 1024 * 100; // 저장되는 이미지의 최고 사이즈.
		String encoding = "UTF-8"; // 인코딩 방식. UTF-8이 권장.

		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		// MultipartRequest 객체는 파일 업로드를 실제 수행하는 객체이다.
		// MultipartRequest(request, "파일 저장 경로", "파일크기", "인코딩 방식");
		// 20번째 directory를 지우고, 새롭게 다른 경로를 지정하면 그 경로로 저장된다.
				

		String userImg = multipartRequest.getFilesystemName("user_img"); // 저장되었을 때의 파일명을 반환한다.
		int result = userDAO.userImg(user_id,userImg); // 회원 이미지를 바꿈.
		
		if(result == -1){ // 데이터베이스 오류시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 이미지 수정이 실패했습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}else{ // 회원 이미지가 정상적으로 수정될 시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원 이미지가 수정되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}

	
		
	%>
	
</body>
</html>