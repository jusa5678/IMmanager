<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<!-- 
	사용 : 중고거래 게시판 추천 jsp
	db : member,bbs
	

 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 게시물 추천</title>
</head>
<body>

<% 
	// 세션을 불러와서 저장함.
	String user_id = null;
	if(session.getAttribute("user_id") != null){
		user_id = (String)session.getAttribute("user_id");
	}
	
	// 해당 게시글 번호를 받아와서 저장.
	int bbsID = 0;
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
	
	
	if(user_id == null){ // 로그인이 되어 있지 않은 경우.
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
	}else{
		// 추천 쿼리를 실행하는 객체 실행.
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.getRecommend(bbsID);
		
		if(result == -1){ // 데이터베이스 오류시.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{ // 추천이 완료될 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천하였습니다.')");
			script.println("location.href = 'sellboard.jsp'");
			script.println("</script>");
		}
	}


%>


</body>
</html>