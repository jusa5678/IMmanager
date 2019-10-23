<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="stopStat.StopStatDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="admin.AdminlogDAO" %>

<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.ArrayList" %>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>

<head>
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

		String userID;
		userID = request.getParameter("userID");
		
		StopStatDAO bbsDAO = new StopStatDAO();
		
		int result = bbsDAO.stopWrite(userID, 1); // 실행할 때 나온 값을 저장하여, 진행한다.
		
		if(result == -1){ // 오류가 날 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터 베이스 오류')");
			script.println("location.href = 'adminMembor.jsp'");
			script.println("</script>");
		}else{ // 성공적으로 삭제될 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('적용되었습니다.')");
			script.println("location.href = 'adminMembor.jsp'");
			script.println("</script>");
			
		}
	
	

	%>
</body>
</html>