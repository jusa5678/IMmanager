<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="bbsip.Bbs2" %>	
<%@ page import="bbsip.BbsDAO2" %>	
<%@ page import="pop.Pop" %>	
<%@ page import="pop.PopDAO" %>	
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set���ξ��½������̼���.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ��ǻ�� ����Ʈ�� 3CPB HDY</title>
</head>
<body>
<%
	String user_id = null;

	if(session.getAttribute("user_id") != null){//�������̵��̸����� ������ �����ϴ� ȸ������ 
		user_id = (String) session.getAttribute("user_id");//�������̵� �ش� ���ǰ��� �־��ش�.
	}

	if(user_id == null){		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('��ȸ���� ������ �� �˴ϴ�.')");
		//���ʿ� ������������ ��ȸ������ ��ư�� ǥ�õ��� �ʱ⿡... ��ĳ� �����Ȳ ��ȸ���� ���⿡ ������ ������..
		script.println("location.href = 'ipchalBoard.jsp'");
		script.println("</script>");		
	}//�� �����δ� ���� �Ǿ �ȵȴ�...

	int bbsID = 0 ;

	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	if(bbsID == 0){ //�տ��� ���������� bbs�� �޾ƿ� ��������... ���������� �����ߴٸ� �̷����� �߻��Ҽ��� ����...
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//System.out.println(request.getParameter("bbsID"));
		script.println("alert('��ȿ���� ���� ���Դϴ�!')");
		script.println("location.href = 'ipchalBoard.jsp'");
		script.println("</script>");
	}else if(request.getParameter("myipchal") != null){
		 
		BbsDAO2 bb = new BbsDAO2();
		Bbs2 m1 = bb.getBbs(bbsID);
		
		int startPrice = m1.getStartprice();
		int endPrice = Integer.parseInt(request.getParameter("myipchal"));
		
		PopDAO myPop = new PopDAO(); //�ν��Ͻ�����
		
		int result=myPop.popTest(bbsID);		
		
		if(result == -1){ 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('�����Դϴ�.')");
	script.println("history.back()");
	script.println("</script>");
		}else{ //����. ����ؾ��Ѵ�.*/			
	if(result < endPrice){
		PrintWriter script = response.getWriter();
		myPop.popWrite(bbsID,user_id, endPrice);
		script.println("<script>");
		script.println("alert('���� �Ϸ� �Ǿ����ϴ�.')");
		script.println("location.href = 'ipchal.jsp?bbsID=" + bbsID +"'");
		script.println("</script>");	
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('���� �ְ����� �����ϴ�.')");
		script.println("location.href = 'ipchal.jsp?bbsID=" + bbsID +"'");
		script.println("</script>");
	}
		
		}
	}
%>
</body>
</html>