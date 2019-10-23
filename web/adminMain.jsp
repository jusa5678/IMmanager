<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="admin.AdminlogDAO" %>
<%@ page import="admin.Adminlog" %>
<%@ page import="java.util.ArrayList" %>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" />
	<meta name="robots" content="noindex,nofollow" />
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/reset.css" /> <!-- RESET -->
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/main.css" /> <!-- MAIN STYLE SHEET -->
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/2col.css" title="2col" /> <!-- DEFAULT: 2 COLUMNS -->
	<link rel="alternate stylesheet" media="screen,projection" type="text/css" href="admincss/1col.css" title="1col" /> <!-- ALTERNATE: 1 COLUMN -->
	<!--[if lte IE 6]><link rel="stylesheet" media="screen,projection" type="text/css" href="css/main-ie6.css" /><![endif]--> <!-- MSIE6 -->
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/style.css" /> <!-- GRAPHIC THEME -->
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/mystyle.css" /> <!-- WRITE YOUR CSS CODE HERE -->
	<script type="text/javascript" src="adminjs/jquery.js"></script>
	<script type="text/javascript" src="adminjs/switcher.js"></script>
	<script type="text/javascript" src="adminjs/toggle.js"></script>
	<script type="text/javascript" src="adminjs/ui.core.js"></script>
	<script type="text/javascript" src="adminjs/ui.tabs.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$(".tabs > ul").tabs();
	});
	</script>
	<title>IM 관리페이지</title>
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
<div id="main">

	<!-- Tray -->
	<div id="tray" class="box">

		<p class="f-left box">

			<!-- Switcher -->
			<span class="f-left" id="switcher">
				<a href="#" rel="1col" class="styleswitch ico-col1" title="Display one column"><img src="design/switcher-1col.gif" alt="1 Column" /></a>
				<a href="#" rel="2col" class="styleswitch ico-col2" title="Display two columns"><img src="design/switcher-2col.gif" alt="2 Columns" /></a>
			</span>

			<strong>IM interior manager 관리페이지</strong>

		</p>

		<p class="f-right">접속자: <strong><a href="#">관리자</a></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong><a href="./logoutAction.jsp" id="logout">Log out</a></strong></p>

	</div> <!--  /tray -->

	<hr class="noscreen" />

	<!-- Menu -->
	<!--
	<div id="menu" class="box">

		<ul class="box f-right">
			<li><a href="#"><span><strong>홈으로 &raquo;</strong></span></a></li>
		</ul>
		<ul class="box">
			<li id="menu-active"><a href="#"><span>Lorem ipsum</span></a></li> 
			<li><a href="#"><span>Lorem ipsum</span></a></li>
			<li><a href="#"><span>Lorem ipsum</span></a></li>
			<li><a href="#"><span>Lorem ipsum</span></a></li>
			<li><a href="#"><span>Lorem ipsum</span></a></li>
			<li><a href="#"><span>Lorem ipsum</span></a></li>
			<li><a href="#"><span>Lorem ipsum</span></a></li>
		</ul>
	</div> 
	-->
	<!-- /header -->

	<hr class="noscreen" />

	<!-- Columns -->
	<div id="cols" class="box">

		<!-- Aside (Left Column) -->
		<div id="aside" class="box">

			<div class="padding box">

				<!-- Logo (Max. width = 200px) -->
				<p id="logo"><a href="adminMain.jsp"><img src="img/Logo.png" alt="Our logo" title="Visit Site" /></a></p>

				<!-- Search --> <!--
				<form action="#" method="get" id="search">
					<fieldset>
						<legend>Search</legend>

						<p><input type="text" size="17" name="" class="input-text" />&nbsp;<input type="submit" value="OK" class="input-submit-02" /><br />
						<a href="javascript:toggle('search-options');" class="ico-drop">Advanced search</a></p>
						-->
						<!-- Advanced search -->
						<!--
						<div id="search-options" style="display:none;">

							<p>
								<label><input type="checkbox" name="" checked="checked" /> Option I.</label><br />
								<label><input type="checkbox" name="" /> Option II.</label><br />
								<label><input type="checkbox" name="" /> Option III.</label>
							</p>

						</div> --> <!-- /search-options -->
					<!--
					</fieldset>
				</form>
				
				<!-- Create a new project --><!--
				<p id="btn-create" class="box"><a href="#"><span>Create a new project</span></a></p>
				-->
			</div> <!-- /padding -->

			<ul class="box">
				<li><a href="adminMembor.jsp">회원관리</a></li>
				<li><a href="#">게시글 관리</a></li>
					<ul>
						<li><a href="adminBoard1.jsp">커뮤니티게시판</a></li>
						<li><a href="adminBoard2.jsp">판매 게시판</a></li>
					</ul>
				<!--<li id="submenu-active"><a href="#">Active Page</a> 선택된 항목은 이렇게--><!-- Active -->
				<!--
					<ul>
						<li><a href="#">Lorem ipsum</a></li>
						<li><a href="#">Lorem ipsum</a></li>
						<li><a href="#">Lorem ipsum</a></li>
						<li><a href="#">Lorem ipsum</a></li>
						<li><a href="#">Lorem ipsum</a></li>
					</ul>
				하위 항목 생성법--> 
				</li>				
			</ul>

		</div> <!-- /aside -->

		<hr class="noscreen" />

		<!-- Content (Right Column) -->
		<div id="content" class="box">

			<h1>최근 이벤트</h1>
			<%
				AdminlogDAO ad = new AdminlogDAO();
				ArrayList<Adminlog> list = ad.getLogList();
				for(int i=0; i<list.size(); i++){	
					//메세지타입 1= 관리자 로그인성공 2= 로그인실패 3=게시판 수정 성공
			%>
				<%if(list.get(i).getMessagetype()==1) {%>
					<p class="msg done">[<%=list.get(i).getDate().substring(0,19)%>]  관리자가 로그인에 성공했습니다. (접속IP:<%=list.get(i).getFreemessage() %>)</p>
				<%}else if(list.get(i).getMessagetype()==2){ %>
					<p class="msg warning">[<%=list.get(i).getDate().substring(0,19)%>]  관리자 로그인에 실패하였습니다. (접속IP:<%=list.get(i).getFreemessage() %>)</p>
				<%}else if(list.get(i).getMessagetype()==3){ %>
				<p class="msg info">[<%=list.get(i).getDate().substring(0,19)%>]  커뮤니티 게시판 글을 복구하였습니다. (게시글 번호:<%=list.get(i).getFreemessage() %>)</p>
				<%}else if(list.get(i).getMessagetype()==4){ %>
				<p class="msg info">[<%=list.get(i).getDate().substring(0,19)%>]  커뮤니티 게시판 글을 삭제하였습니다. (게시글 번호:<%=list.get(i).getFreemessage() %>)</p>
				<%} %>
			<%} %>
			<!-- Table -->
			<!--<h3 class="tit">Table <span class="tag">(table.nostyle)</span></h3>-->			
			<!--  경고폼들			
			<p class="msg warning">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			<p class="msg info">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			<p class="msg done">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			<p class="msg error">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
			-->
		</div> <!-- /content -->

	</div> <!-- /cols -->

	<hr class="noscreen" />

	<!-- Footer -->
	<div id="footer" class="box">

		<p class="f-left">&copy; 2019 캡스톤<!-- All Rights Reserved &reg;--></p>
		
	</div> <!-- /footer -->

</div> <!-- /main -->

</body>
</html>