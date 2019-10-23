<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="message.MessageDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!-- 
	사용 : 메세지 실행 jsp
	db : member,message
	

 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메세지 실행</title>
</head>
<body>

<%

	String receUserID = null; // 메세지를 받는 사용자.
	String messageType = null; // 메세지의 타입(거래인지 일반인지를 구분). 중고 거래 게시판에서 사용.
	String messageContent = null; // 메세지 내용.
	String bbsTitle = null; // 게시물 이름. 중고 거래 게시판에서 사용.
	String user_id = null; // 유저 아이디.
	int bbsID = 0; // 게시물 번호. 중고 거래 게시판에서 사용.
	
	if(session.getAttribute("user_id") != null){
		user_id = (String)session.getAttribute("user_id");
	}
	if(user_id == null){ // 로그인이 안된 경우.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하셔야 합니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}else{
		// 메세지를 db에 저장하는 객체 생성.
		MessageDAO mess = new MessageDAO();
		messageType = request.getParameter("messageType");
		
		if(messageType.equals("deal")){ // 거래를 신청할 경우의 메세지 전송. 
			receUserID = request.getParameter("receUserID"); 
			bbsTitle = request.getParameter("bbsTitle");
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			messageContent = "'" + bbsTitle + "' 게시물의 거래신청입니다."; // 만약, 거래신청시엔 이 내용으로 보낸다.

			mess.write(messageContent, receUserID, user_id, bbsID); // 메세지 저장.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('거래 신청이 완료되었습니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}else if(messageType.equals("chat")){ // 일반 커뮤니티 목적의 메세지 전송.
			receUserID = request.getParameter("receUserID");
			messageContent = request.getParameter("messContent");
			
			mess.write(messageContent, receUserID, user_id, bbsID); //메세지 저장.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('메세지를 보냈습니다.')");
			script.println("location.href = 'message.jsp'");
			script.println("</script>");	
			
		}
			
		
		
	}
	

	


%>

</body>
</html>