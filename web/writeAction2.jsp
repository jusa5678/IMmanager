<!--  https://www.youtube.com/watch?v=dfH64W8Vgyk&list=PLRx0vPvlEmdBMeD6NZawEmwHKjzD6ZGqp&index=5 -->
<%@page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->
<!-- 
	사용 : 중고거래 게시판 글쓰기 실행 jsp
	db : member,bbs,sell_sub
	

 -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>중고 거래 게시판 글쓰기</title>
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
		String directory = "/usr/local/apache-tomcat-8.5.39/webapps/ROOT/upload"; // 저장되는 위치.
		//String directory = "C:/Users/junsu/eclipse-workspace/team_project4/WebContent/upload"; 
		//  C:/Users/Junsu/eclipse-workspace/Team_project2/WebContent/upload    테스트 용도
		//  /usr/local/apache-tomcat-8.5.39/webapps/team_project/upload         ROOT에 넣은 경우.
		//  /usr/local/apache-tomcat-8.5.39/webapps/ROOT/backuptest6/upload     ROOT 안의 폴더에 둔 경우.
		int maxSize = 1024 * 1024 * 100; // 저장되는 이미지의 최고 사이즈.
		String encoding = "UTF-8"; // 인코딩 방식. UTF-8이 권장.
		String bbsTitle = ""; String bbsContent= ""; String f_name = ""; String f_size = ""; 
		String f_material = ""; String f_color = ""; String f_manu =""; String f_date = "";
		int sell = 0;
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		// MultipartRequest 객체는 파일 업로드를 실제 수행하는 객체이다.
		// MultipartRequest(request, "파일 저장 경로", "파일크기", "인코딩 방식");
		// 20번째 directory를 지우고, 새롭게 다른 경로를 지정하면 그 경로로 저장된다.
		
		//String fileName = multipartRequest.getOriginalFileName("file"); //사용자가 직접 지정한 파일명을 반환한다.
		//bbsTitle, bbsContent
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
		
		bbsTitle = multipartRequest.getParameter("bbsTitle");
		bbsContent = multipartRequest.getParameter("bbsContent");
		
		f_name = multipartRequest.getParameter("f_name");
		f_size = multipartRequest.getParameter("f_size");
		f_material = multipartRequest.getParameter("f_material");
		f_color = multipartRequest.getParameter("f_color");
		f_manu = multipartRequest.getParameter("f_manu");
		f_date = multipartRequest.getParameter("f_date");
		sell = Integer.parseInt(multipartRequest.getParameter("sell"));

		// 제목과 내용 길이.
		if(bbsTitle.length() > 9 || bbsContent.length() > 100){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글의 길이가 매우 깁니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
		
		// bbs테이블에 저장.
		new BbsDAO().write(bbsTitle, user_id, bbsContent, fileRealName, fileUrl, fileRealName2, fileUrl2, fileRealName3, fileUrl3, sell);
		// sell_sub 테이블에 저장.
		new BbsDAO().sub_write(f_name, f_size, f_material, f_color, f_manu, f_date);
		
		//out.write("파일명 : " + fileRealName + "<br>"); // 실제 파일명의 테스트 출력
		//out.write("경로 :" + fileUrl + "<br>"); // 저장된 경로 출력
		//out.write("제목 : " + bbsTitle + "<br>"); // 파일명의 테스트 출력
		//out.write("내용 :" + bbsContent + "<br>"); // 실제 파일명 테스트 출력
		
		//out.write("파일명 : " + fileRealName2 + "<br>"); // 실제 파일명의 테스트 출력
		//out.write("경로 :" + fileUrl2 + "<br>"); // 저장된 경로 출력
		
		//out.write("파일명 : " + fileRealName3 + "<br>"); // 실제 파일명의 테스트 출력
		//out.write("경로 :" + fileUrl3 + "<br>"); // 저장된 경로 출력

		PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기가 완료되었습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
	
	%>
		
</body>
</html>