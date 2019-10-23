<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbsip.BbsDAO2"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="bbsip.Bbs2"%>
<%@ page import="bbsip.IpchalSub" %>
<%@ page import="pop.PopDAO"%>
<%@ page import="pop.Pop" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>



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
	
	<style>
		/* 페이징 */
		.pg_wrap {clear:both;margin:0 0 20px;padding:20px 0 0;text-align:center}
		.pg {}
		.pg_page, .pg_current {display:inline-block;padding:0 8px;height:25px;color:#000;letter-spacing:0;line-height:2.2em;vertical-align:middle}
		.pg a:focus, .pg a:hover {text-decoration:none}
		.pg_page {background:#e4eaec;text-decoration:none}
		.pg_start, .pg_prev {/* 이전 */}
		.pg_end, .pg_next {/* 다음 */}
		.pg_current {display:inline-block;margin:0 4px 0 0;background:#333;color:#fff;font-weight:normal}		
	</style>	
	
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
		
	%>>
  	<%
	  	int maxlist = 30; //표시할 게시글 개수 
		// 페이지 넘버 지정.
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
				
		int totalPage = 0;// 전체 페이지를 저장할 변수.
		
		BbsDAO2 bs = new BbsDAO2();
		totalPage = bs.getTotal();
		
		// 1페이지에 8개의 게시물을 불러옴.
		if(totalPage != 0){
			if((totalPage % maxlist) == 0){
				totalPage = (totalPage / maxlist);
			}else{
				totalPage = (totalPage / maxlist + 1);
			}
		}
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
						<li><a href="adminBoard2.jsp">거래게시판</a></li>
						<li><a href="adminBoard3.jsp"><strong>입찰게시판</strong></a></li>
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

			<h1>입찰게시판 관리</h1>
			
			<!-- Table -->
			<!--<h3 class="tit">Table <span class="tag">(table.nostyle)</span></h3>-->
			<br />
			
			<select>
				<option value="">표시</option>
				<option value="">30개씩</option>
				<option value="">50개씩</option>
				<option value="">100개씩</option>
			</select>

			<br />
			
			<table class="nostyle">
				<tr>
				    <th>게시글번호</th>
					<th>게시글제목</th>
					<th>게시글작성일</th>
				    <th>게시글상태</th>
				    <th>게시글복구</th>
				    <th>데이터 영구삭제(주의)</th>
				</tr>
				<%             		
             		BbsDAO2 bbsDAO = new BbsDAO2();
             		UserDAO user = new UserDAO();
             		ArrayList<Bbs2> list = bbsDAO.getList(pageNumber,maxlist);

             		PopDAO mm2 = new PopDAO();
             	             				
            		for (int i = 0; i < list.size(); i++) {
            	%>		
				<tr>
				    <td><%= list.get(i).getBbsID() %></td>
				    <td><a href="boarding2.jsp?bbsID=<%=list.get(i).getBbsID() %>" target="_blank"><%= list.get(i).getBbsTitle()%></a></td>
				    <td><%= list.get(i).getBbsDate().substring(0,19) %></td>
				    <%
						if(list.get(i).getBbsAvailable()==0){					
					%>
					<td>삭제됨</td>
					<%}else{%>
					<td>활성</td>
					<%} %>
					<td><input type="button" name="board1recover" value="복구" onclick="repairQ(<%=list.get(i).getBbsID() %>);"></td>
				    <td><input type="button" name="board1Del" value="삭제" onclick="deleteQ(<%=list.get(i).getBbsID() %>);"></td>
				</tr>			
				<%
					}
				%> 				
			</table>

			<!-- 페이지 트레이 -->	
			<!--
			<nav class="pg_wrap"><span class="pg"><strong class="pg_current">1</strong>
			<a href="#" class="pg_page">2</a>
			<a href="#" class="pg_page">3</a>
			<a href="#" class="pg_page">4</a>
			<a href="#" class="pg_page">5</a>
			<a href="#" class="pg_page">6</a>
			<a href="#" class="pg_page">7</a>
			<a href="#" class="pg_page">8</a>
			<a href="#" class="pg_page">9</a>
			<a href="#" class="pg_page">10</a>
			<a href="#" class="pg_page pg_next">다음</a>
			<a href="#" class="pg_page pg_end">맨끝</a>
			</span></nav>
			-->
			<!-- /페이지 트레이 -->

		</div> <!-- /content -->

	</div> <!-- /cols -->

	<hr class="noscreen" />

	<!-- Footer -->
	<div id="footer" class="box">

		<p class="f-left">&copy; 2019 캡스톤<!-- All Rights Reserved &reg;--></p>
		
	</div> <!-- /footer -->

</div> <!-- /main -->
<script>
	function repairQ(x){
		if(confirm("정말 복구 하시겠습니까?")){
			location.href='adminBoard3RepairAction.jsp?bbsID='+x;
		}else{
			return;
		}
	}
	
	function deleteQ(x){
		if(confirm("정말 영구삭제 하시겠습니까?")){
			location.href='adminBoard3DeleteAction.jsp?bbsID='+x;
		}else{
			return;
		}
	}
</script>
</body>
</html>