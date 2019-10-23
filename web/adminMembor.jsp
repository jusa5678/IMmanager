<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="stopStat.StopStatDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>



<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta http-equiv="content-language" />
	<meta name="robots" content="noindex,nofollow" />
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/reset.css" />
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/main.css" /> 
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/2col.css" title="2col" /> 
	<link rel="alternate stylesheet" media="screen,projection" type="text/css" href="admincss/1col.css" title="1col" /> 	
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/style.css" /> 
	<link rel="stylesheet" media="screen,projection" type="text/css" href="admincss/mystyle.css" />
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
		
	%>
<%
		// 세션을 할당하는 부분.
		/*
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		*/
		// 페이지 넘버를 계산하는 부분.
		
		int maxlist = 30; //표시할 게시글 개수 
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int totalPage = 0; // 전체 페이지를 저장할 변수.
		
		UserDAO bs = new UserDAO();	
		totalPage = bs.getTotal();
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
				<li><a href="adminMembor.jsp"><strong>회원관리</strong></a></li>
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

			<h1>회원관리</h1>

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
				    <th>회원아이디</th>
					<th>회원분류</th>
					<th>가입일</th>
				    <th>이름</th>
				    <th>회사</th>
				    <th>전화번호</th>
				    <th>주소</th>
				    <th>생일</th>
				    <th>등록사진</th>
				    <th>이용관리</th>
				    <th>회원상태</th>
				    <th>영구삭제(주의)</th>
				</tr>
				<% 
           			UserDAO user = new UserDAO();
					ArrayList<User> list = user.getListAd();
					StopStatDAO stDAO = new StopStatDAO();
					for(int i=0; i<list.size(); i++){						
				%>
				<tr>
				    <td><%=list.get(i).getUser_id()%> </td>
				    <%if(list.get(i).getUser_con() == 0) {%>
				    <td>일반회원</td>
				    <%}else if(list.get(i).getUser_con() == 1){ %>
				    <td>사업자</td>
				    <%}else if(list.get(i).getUser_con() == 99){ %>
				    <td style="color:blue;">관리자</td>
				    <%}else{ %>
				    <td>기타회원</td>
				    <%} %>	
				    <%if(list.get(i).getUser_con() == 99) {%>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    	<td></td>
				    <%}else{ %>
				    	<td><%=list.get(i).getJoin_date() %></td>
					    <td><%=list.get(i).getName() %> </td>
					    <td><%=list.get(i).getCompany() %></td>
					    <td><%=list.get(i).getUser_number() %></td>
					    <td><%=list.get(i).getUser_address() %></td>
					  	<td><%=list.get(i).getUser_date() %></td>
					  	<td><input type="button" name="memPhoto" value="확인" onclick="alert('유저사진')"></td>					
					    <td>
					    <select onchange="selectEvent(this)">
							<option value="none">기본</option>
							<option value="<%=list.get(i).getUser_id()%>">5일정지</option>
							<option value="<%=list.get(i).getUser_id()%>">10일정지</option>
							<option value="<%=list.get(i).getUser_id()%>">영구정지</option>
						</select>
						</td>
						<%//정지면 1을 반환한다. 즉 정지된 계정 %>
						<%if(stDAO.getStopUser(list.get(i).getUser_id())==1){%>
							<td style="color:red;">정지</td>
						<%}else{ %>
							<td>정상</td>
						<%} %>		
					    <td><input type="button" name="memDel1" value="삭제" onclick="alert('삭제')"></td>	
				    <%} %>
				    								    
				</tr>
				<%} %>
			</table>

			<!-- 페이지 트레이 -->	
						
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
	function selectEvent(selectObj) {
		if(selectObj.value=="none"){
			
		}else{
			if(confirm("정말 정지 하시겠습니까?")){
				location.href='adminMemborStopAction.jsp?userID='+selectObj.value;
			}else{
				return;
			}
		}
	}
</script>
</body>
</html>