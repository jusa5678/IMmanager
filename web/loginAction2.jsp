<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="admin.AdminlogDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="stopStat.StopStatDAO" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 이 페이지로 전송되는 데이터들을 'UTF-8'형식으로 바꿈. -->


<jsp:useBean id="user" class="user.User" scope="page" /> <!-- JavaBean사용. 현재 페이지에만 적용. 

<!-- 받아오는 데이터  -->
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_password" />

<!-- 
	사용 : 로그인 실행 jsp
	db : member
	

 -->

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>로그인 실행</title>
</head>
<body>
	<% 
		// 세션 여부 검출.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id"); // 자신에게 할당된 세션 아이디를 받을 수 있게끔 함.
		}
		if(user_id != null){ // 세션이 이미 부여된 경우.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'message.jsp'");
			script.println("</script>");
		}

		
	//로그인 처리에 관한 부분.
	//result는 userDAO의 login함수에서 받아오는 결과를 가지고, 그것을 상황에 맞게끔 출력한다.
		UserDAO userDAO = new UserDAO();
		StopStatDAO stDAO = new StopStatDAO();
		int result = userDAO.login(user.getUser_id(),user.getUser_password()); 
		if(result ==1){
			if(stDAO.getStopUser(user.getUser_id())==1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정지된 계정입니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}else{
				session.setAttribute("user_id", user.getUser_id()); // 로그인 세션 할당.
				if(user.getUser_id().equals("ADMINISTRATOR")){
					AdminlogDAO d1 = new AdminlogDAO();		 		
					try { 
						InetAddress cip = InetAddress.getLocalHost(); 	
						d1.logWrite(1, cip.getHostAddress());
						//System.out.println("Host Name = [" + cip.getHostName() + "]"); 
						//System.out.println("Host Address = [" + cip.getHostAddress() + "]"); 
					} catch (Exception e) { 
						//System.out.println(e); 
					} 
					
				}
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}			
		}
		else if(result == 0){ // 비밀번호 틀림
			if(user.getUser_id().equals("ADMINISTRATOR")){
				AdminlogDAO d1 = new AdminlogDAO();		 		
				try { 
					InetAddress cip = InetAddress.getLocalHost(); 	
					d1.logWrite(2, cip.getHostAddress());					
				} catch (Exception e) { 
				} 				
			}
			PrintWriter script = response.getWriter();		
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){ // 존재하지 않는 아이디.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
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