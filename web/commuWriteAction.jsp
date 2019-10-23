<!--  https://www.youtube.com/watch?v=dfH64W8Vgyk&list=PLRx0vPvlEmdBMeD6NZawEmwHKjzD6ZGqp&index=5 -->
<%@page import="community.CommunityDAO"%>
<%@ page import="community.Community" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<!-- 
	사용 : 커뮤니티 게시판 쓰기 실행 jsp
	db : member,commu_board
	

 -->



<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->


<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>커뮤니티 게시물 쓰기</title>
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
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		String directory = "/usr/local/apache-tomcat-8.5.39/webapps/ROOT/upload2"; // 저장되는 위치.
		//String directory = "C:/Users/junsu/eclipse-workspace/team_project4/WebContent/upload"; // 저장되는 위치.
		//String directory = application.getRealPath("/upload/");
		//  C:/Users/Junsu/eclipse-workspace/Team_project2/WebContent/upload     // 테스트 용도
		//  /usr/local/apache-tomcat-8.5.39/webapps/team_project/upload          // ROOT 안에 둘 경우
		int maxSize = 1024 * 1024 * 100; // 저장되는 이미지의 최고 사이즈.
		String encoding = "UTF-8"; // 인코딩 방식. UTF-8이 권장.
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		// MultipartRequest 객체는 파일 업로드를 실제 수행하는 객체이다.
		// MultipartRequest(request, "파일 저장 경로", "파일크기", "인코딩 방식");
		// 20번째 directory를 지우고, 새롭게 다른 경로를 지정하면 그 경로로 저장된다.
		
		// 글쓰기 화면에서 받아오는 정보들을 저장.
		String fileRealName = multipartRequest.getFilesystemName("file"); // 저장되었을 때의 파일명을 반환한다.
		String fileRealName2 = multipartRequest.getFilesystemName("file2");
		String fileRealName3 = multipartRequest.getFilesystemName("file3");
		
		if(fileRealName == null && fileRealName2 == null && fileRealName3 == null){
			fileRealName = "default.jpg";
		}
		
		if(fileRealName == null){
			if(fileRealName2 == null){
				fileRealName = fileRealName3;
				fileRealName3 = null;
				
			}else{
				fileRealName = fileRealName2;
				fileRealName2 = null;
			}
			
		}
		
		if(fileRealName2 == null){
			if(fileRealName3 != null){
				fileRealName2 = fileRealName3;
				fileRealName3 = null;
			}
		}
		
		String fileUrl = directory + "/" + fileRealName;
		String fileUrl2 = directory + "/" + fileRealName2;
		String fileUrl3 = directory + "/" + fileRealName3;
		
		String bbsTitle = multipartRequest.getParameter("bbsTitle");
		String bbsContent = multipartRequest.getParameter("bbsContent");
		
		// 제목과 내용 길이.
		if(bbsTitle.length() > 9 || bbsContent.length() > 100){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글의 길이가 매우 깁니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
	
		// 게시물을 db에 저장.
		new CommunityDAO().write(bbsTitle, user_id, bbsContent, fileRealName, fileUrl, fileRealName2, fileUrl2, fileRealName3, fileUrl3);		

		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기가 완료되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
	%>
		
</body>
</html>