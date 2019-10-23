<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="bbsip.Bbs2" %>	
<%@ page import="bbsip.BbsDAO2" %>	
<%@ page import="pop.Pop" %>	
<%@ page import="pop.PopDAO" %>	
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>간단 컴퓨터 심플트론 3CPB HDY</title>
</head>
<body>
<%
	String user_id = null;

	if(session.getAttribute("user_id") != null){//유저아이디이름으로 세션이 존재하는 회원들은 
		user_id = (String) session.getAttribute("user_id");//유저아이디에 해당 세션값을 넣어준다.
	}

	if(user_id == null){		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비회원은 입찰이 안 됩니다.')");
		//애초에 앞페이지에서 비회원에게 버튼이 표시되지 않기에... 상식내 정상상황 비회원은 여기에 올일이 없지만..
		script.println("location.href = 'ipchalBoard.jsp'");
		script.println("</script>");		
	}//이 밑으로는 실행 되어선 안된다...

	int bbsID = 0 ;

	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	if(bbsID == 0){ //앞에서 정상적으로 bbs를 받아온 페이지라... 정상적으로 접근했다면 이런일은 발생할수는 없다...
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//System.out.println(request.getParameter("bbsID"));
		script.println("alert('유효하지 않은 글입니다!')");
		script.println("location.href = 'ipchalBoard.jsp'");
		script.println("</script>");
	}else if(request.getParameter("myipchal") != null){
		 
		BbsDAO2 bb = new BbsDAO2();
		Bbs2 m1 = bb.getBbs(bbsID);
		
		int startPrice = m1.getStartprice();
		int endPrice = Integer.parseInt(request.getParameter("myipchal"));
		
		PopDAO myPop = new PopDAO(); //인스턴스생성
		
		int result=myPop.popTest(bbsID);		
		
		if(result == -1){ 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('오류입니다.')");
	script.println("history.back()");
	script.println("</script>");
		}else{ //정상. 등록해야한다.*/			
	if(result < endPrice){
		PrintWriter script = response.getWriter();
		myPop.popWrite(bbsID,user_id, endPrice);
		script.println("<script>");
		script.println("alert('입찰 완료 되었습니다.')");
		script.println("location.href = 'ipchal.jsp?bbsID=" + bbsID +"'");
		script.println("</script>");	
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('현재 최고가보다 낮습니다.')");
		script.println("location.href = 'ipchal.jsp?bbsID=" + bbsID +"'");
		script.println("</script>");
	}
		
		}
	}
%>
</body>
</html>