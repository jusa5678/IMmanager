<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.InputMismatchException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbsip.Bbs2"%>
<%@ page import="bbsip.BbsDAO2"%>
<%@ page import="bbsip.IpchalSub" %>
<%@ page import="pop.PopDAO"%>
<%@ page import="pop.Pop" %>
<%
	//이건 로그인한 사람을 판단하는 부분이다. 어차피 상단메뉴바를 항상 노출시킬것이기 때문에..
 		//이 파트는 반드시 존재해야한다.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
	user_id = (String) session.getAttribute("user_id");
	}
%>
	<%
		int bbsID = 0;
			
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}

		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'ipchalBoard.jsp'");
			script.println("</script>");
		}

		Bbs2 bbs = new BbsDAO2().getBbs(bbsID);
		PopDAO mm = new PopDAO();
		
		BbsDAO2 ip = new BbsDAO2();
		IpchalSub sub = ip.getIpchalSub(bbsID);
	%>

		
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
	<link rel="icon" href="img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
  <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <title>IM interior manager</title>
</head>
<style>
    .nav-item{
        margin-left: 50px;
    }
      .footer{
                position:relative;
                margin-bottom: 0px;
                width:100%;
                height:100px;
                background-color: #F1BDBD;
            }
            .top{
                width:100%;
                height:30px;
                margin-top:0px;
                margin-bottom:0px;
                text-align: right;
            }

            .footer{
                position:relative;
                margin-bottom: 0px;
                width:100%;
                height:100px;
                background-color: #F1BDBD;
            }
            .col-md-3{
                margin-bottom: 60px;

            }
            
            #img{
                width:100%;
                height:200px;
            }
            #nick{
                font-size: 25px;
                font-style:bold;
                text-align:left;
            }
            .my-hr1{
                border:0;
                height:2px;
                background: #ccc;
                position: relative;
            }
           #head_item{
               font-size: 20px;
               font-style: bold;
               text-align:right;
               padding-left: 30px;
           }
           #header_item{
               font-size: 2.5em;
               font-style:BOLD;
               text-align:top;
               margin-left:20px;
               position: relative;
               display:inline;
               
           }
           

           p,#nick{
               text-align: center;
            }
            #nick{
               margin-top:10px;            
            }
            
            #count {

			 height: 167px;
			
			 color: #000;
			
			 padding-left: 100px;
			
			 padding-top:130px;
			
			 background-image: url(http://www.bb.co.kr/data/201302/IJ13607483252985/12.jpg);
			
			 background-repeat: no-repeat;
			
			}
			
			#bt {
			
			 height: 16px;
			
			 width: 49;
			
			 padding-left: 100px;
			
			 padding-top: 0px;
			
			}
    </style>
<body>
	
<nav class="navbar navbar-expand-lg navbar-light" style="margin-top:20px; background-color: #F1BDBD;">
  <a class="navbar-brand" href="./main.jsp"><img src="./image/Main_Logo.png" style="width:170px; margin-top:-15px; margin-bottom:-15px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto" >
      <li class="nav-item"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="commuBoard.jsp" style="font-size: 1.6em; font-style:inherit; font-weight: bold;">커뮤니티<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="sellboard.jsp" style="font-size: 1.6em; font-style:inherit; font-weight: bold;">판매 게시판</a>
      </li>
      
      <li class="nav-item active">
        <a class="nav-link" href="ipchalBoard.jsp" style="font-size: 1.6em; font-style:inherit; font-weight: bold;">입찰 게시판</a>
      </li>
    </ul>
	 <%
		if(user_id == null){ //로그인 상태가 아님.
	%>
    <ul class="nav navbar-nav navbar-right">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" style="font-size: 1.6em; font-style:inherit; font-weight: bold;" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
              회원 관리
            </a>
            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; "href="./login.jsp">로그인</a>
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; "href="./join.jsp">회원가입</a>
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; "href="#">고객센터</a>
            </div>
          </li>
	</ul>
	<script>
					function btnSubmit(){ 
						alert("회원이 아닙니다")
					}
				</script>
	<%
		}else{
	%>
	<ul class="nav navbar-nav navbar-right">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" style="font-size: 1.6em; font-style:inherit; font-weight: bold;" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              회원 관리
            </a>
            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; " href="./message.jsp">메세지</a>
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; " href="./mypage.jsp">마이페이지</a>
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; " href="./logoutAction.jsp">로그아웃</a>
              <a class="dropdown-item" style="font-size: 1.6em; font-style:inherit; " href="#">고객센터</a>
            </div>
          </li>
	</ul>	
	<%
		}
	%>
  </div>
</nav>
  <br>
  <br>
  
  <!--본문-->
  	<script>	  	
  	//CountDownTimer('01/01/2017', 'countdown'); // 폼형태
  	//System.out.println("년도"+list.get(0).getBbsDate().substring(0, 4));
	//System.out.println("월"+list.get(0).getBbsDate().substring(5, 7));
	//System.out.println("일"+list.get(0).getBbsDate().substring(8,10));
	//System.out.println("시"+list.get(0).getBbsDate().substring(11,13));
	//System.out.println("분"+list.get(0).getBbsDate().substring(14,16));
	//System.out.println("초"+list.get(0).getBbsDate().substring(17,19));
	//bbs.getBbsDate().substring(0,19)
	//CountDownTimer('30/30/2020 11:11 ', 'newcountdown');
	
	var ex = 0;
	
  	CountDownTimer('<%=bbs.getEndDate().substring(5,7)%>/<%=bbs.getEndDate().substring(8,10)%>/<%=bbs.getEndDate().substring(0,4)%> <%=bbs.getEndDate().substring(11,13)%>:<%=bbs.getEndDate().substring(14,16)%> ', 'newcountdown'); // 2018년 1월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용합니다.

  	function CountDownTimer(dt, id)
  	{
	  	var end = new Date(dt);
	
	  	var _second = 1000;
	  	var _minute = _second * 60;
	  	var _hour = _minute * 60;
	  	var _day = _hour * 24;
	  	var timer;
	
	  	function showRemaining() {
		  	var now = new Date();
		  	var distance = end - now;
		  	if (distance < 0) {
			
			  	clearInterval(timer);
			  	document.getElementById(id).innerHTML = '만료됨!';
			  	ex = 1;
			
			  	return;
		  	}
		  	var days = Math.floor(distance / _day);
		  	var hours = Math.floor((distance % _day) / _hour);
		  	var minutes = Math.floor((distance % _hour) / _minute);
		  	var seconds = Math.floor((distance % _minute) / _second);
		
		  	document.getElementById(id).innerHTML = days + '일 ';
		  	document.getElementById(id).innerHTML += hours + '시간 ';
		  	document.getElementById(id).innerHTML += minutes + '분 ';
		  	document.getElementById(id).innerHTML += seconds + '초';
	  	}
	
	  	timer = setInterval(showRemaining, 1000);
  	}
  	
  	
  	
  	
  	function btnExecute(){
  		if(ex == 1)
  			alert("끝난 입찰입니다.");
  		else
  			document.form1.submit();

	}
  	
  	</script>
  
  
	
	<%
		PopDAO a1 = new PopDAO();
	
	%>

  
	<div class="product_image_area">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="owl-carousel owl-theme s_Product_carousel">
						<div class="single-prd-item">
							<img class="img-fluid" src="ipchalimg\<%=bbs.getFileName() %>" alt="">  <!-- 555x600사이즈가 가장 이쁨-->
						</div>
						<div class="single-prd-item">
							<img class="img-fluid" src="ipchalimg\<%=bbs.getFileName2() %>" alt="">
						</div>
						<div class="single-prd-item">
							<img class="img-fluid" src="ipchalimg\<%=bbs.getFileName3() %>" alt="">
						</div>						
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1">
					<div class="s_product_text">
						<h3><%= bbs.getBbsTitle() %></h3>
						<h2><font color=red><%= bbs.getStartprice() %>원~</font></h2>
						<ul class="list">
							<li>등록일 : <%=bbs.getBbsDate().substring(0,10) %></li>
							<li>만료일 : <%=bbs.getEndDate().substring(0,10) %></li>
							<%if(a1.popTest(bbsID)==-1){%>
								<li><span>현재 최고가</span> : <font color=red><%= bbs.getStartprice() %>원</font></a></li>
							<%}else{ %>
								<li><span>현재 최고가</span> : <font color=red><%= a1.popTest(bbsID) %>원</font></a></li>
							<%} %>	
								
							<li><span>남은시간</span> : <font color=red><span id="newcountdown"></span></font></a></li>
						</ul>
						<p><%=bbs.getBbsContent() %></p>
						<div class="product_count">
						<form action="popAction.jsp?bbsID=<%=bbsID%>" name="form1" method="post"> 
							<label for="qty">입찰금액:</label>    							      
								<input type="text" name="myipchal" id="sst" size="2" maxlength="50" value="0" title="Quantity:" class="input-text qty" style="width:130px;">
													
								<input type ="button" class="btn btn-primary" style="width:67pt; text-align:center;" onclick="btnExecute();" value="입찰하기">   
						</form>    
						</div>
						<div class="card_area d-flex align-items-center">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div>
	
	<div class="container">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" 
					 aria-selected="true">제품사양</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
					 aria-selected="false">댓글</a>
				</li>				
			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
					<div class="table-responsive">
						<table class="table">
							<tbody>
								<tr>
									<td>
										<h5><strong>가구이름</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_name() %></strong></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5><strong>가구 사이즈</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_size() %></strong></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5><strong>가구 재질</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_material() %></strong></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5><strong>가구 색상</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_color() %></strong></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5><strong>제조사</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_manu() %></strong></h5>
									</td>
								</tr>
								<tr>
									<td>
										<h5><strong>제조일</strong></h5>
									</td>
									<td>
										<h5><strong><%=sub.getF_date() %></strong></h5>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
					<div class="row">
						<div class="col-lg-6">
							<div class="comment_list">
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="./image/user_sample.png" alt="">
										</div>
										<div class="media-body">
											<h4>닉네임</h4>
											<h5>2019.05.20 오후 05:56</h5>
											<a class="reply_btn" href="#">답글</a>
										</div>
									</div>
									<p>물건 아주아주 좋네요 추천 드립니다~</p>
								</div>
								<div class="review_item reply">
									<div class="media">
										<div class="d-flex">
											<img src="./image/user_sample.png" alt="">
										</div>
										<div class="media-body">
											<h4>닉네임</h4>
											<h5>2019.05.20 오후 05:56</h5>
											<a class="reply_btn" href="#">답글</a>
										</div>
									</div>
									<p>헛소리 하지마라.</p>
								</div>
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="./image/user_sample.png" alt="">
										</div>
										<div class="media-body">
											<h4>닉네임</h4>
											<h5>2019.05.20 오후 05:56</h5>
											<a class="reply_btn" href="#">답글</a>
										</div>
									</div>
									<p>댓글 아무거나 입력하시오</p>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="review_box">
								<h4>댓글 남기기</h4>
								<form class="row contact_form" action="contact_process.php" method="post" id="contactForm" novalidate="novalidate">
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control" id="name" name="name" placeholder="이름">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<input type="email" class="form-control" id="email" name="email" placeholder="주소">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control" id="number" name="number" placeholder="휴대폰번호">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<textarea class="form-control" name="message" id="message" rows="1" placeholder="내용"></textarea>
										</div>
									</div>
									<div class="col-md-12 text-right">
										<button type="submit" value="submit" class="btn primary-btn">등록</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	
	</div>
	
	
	<br>
	<br>
	<br>


  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>