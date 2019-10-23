<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.Community" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<!-- 
	사용 : 사용자 페이지 jsp
	db : member,commu_board,bbs
	

 -->



<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./slick/slick.css">
<link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

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
           a{
               font-size: 1.5em;
               font-style:inherit;
               font-weight: bold;
           }
           a:link { color: black; text-decoration: none;} /* 클릭하지 않은 링크(a 태그)  지정 */
           a:visited { color: black; text-decoration: none;} /* 클릭한 링크(a 태그) 지정 */

           #nick{
               text-align: center;
            }
            #nick{
               margin-top:20px;            
            }
             * {
		      box-sizing: border-box;
		    }
		
		    .slider {
		        width: 50%;
		        
		    }
		
		    .slick-slide {
		      margin: 0px 20px;
		    }
		
		    .slick-slide img {
		      width: 100%;
		    }
		
		    .slick-prev:before,
		    .slick-next:before {
		      color: black;
		    }
		
		
		    .slick-slide {
		      transition: all ease-in-out .3s;
		      opacity: .2;
		    }
		
		    .slick-active {
		      opacity: .5;
		    }
		
		    .slick-current {
		      opacity: 1;
		    }
		    
		    #title{
			  width        : 80%;     /* 너비는 변경될수 있습니다. */
			  text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
			  white-space  : nowrap;    /* 줄바꿈을 하지 않습니다. */
			  overflow     : hidden;    /* 내용이 길면 감춤니다 */
			  display      : block;     /* ie6이상 현재요소를 블럭처리합니다. */
			  font-size    : 14px;
			}
    
    </style>

<title>사용자 페이지</title>

</head>

<body>
	<%
		// 세션을 할당하고 저장.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
	%>

<nav class="navbar navbar-expand-lg navbar-light" style="margin-top:20px; background-color: #F1BDBD;">
  <a class="navbar-brand" href="./main.jsp"><img src="./image/Main_Logo.png" style="width:170px; margin-top:-15px; margin-bottom:-15px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent" style="padding-top:30px">
<%
  		if(user_id == null){
  	%>
  
    <ul class="navbar-nav mr-auto" >
      <li class="nav-item"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="./commuBoard.jsp">커뮤니티 </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./sellboard.jsp">판매 게시판 <span class="sr-only">(current)</span></a>
      </li>
      

    </ul>
    <% 
  		}else{
  			
    %>
       <ul class="navbar-nav mr-auto" >
       <li><p><span style="color:red; font-weight:bold;"><%= user_id %></span>님이 접속하셨습니다. </p></li>
       </ul>
    
      <ul class="navbar-nav mr-auto" >
      <li class="nav-item"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="./commuBoard.jsp">커뮤니티 </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./sellboard.jsp">판매 게시판 <span class="sr-only">(current)</span></a>
      </li>
      

    </ul>
    
    <% 
  		}
    	if(user_id == null){
    %>
    <ul class="nav navbar-nav navbar-right">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              회원 관리
            </a>
            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="./login.jsp">로그인</a>
              <a class="dropdown-item" href="./join.jsp">회원가입</a>
            </div>
          </li>
	</ul>
	<% 
   		}else{
	%>
	<ul class="nav navbar-nav navbar-right">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              회원 관리
            </a>
            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="./message.jsp">메세지</a>
              <a class="dropdown-item" href="./mypage.jsp">마이페이지</a>
              <a class="dropdown-item" href="./logoutAction.jsp">로그아웃</a>
            </div>
          </li>
	</ul>
	
	<% 
   		}
	%>
			

  </div>
</nav>
   <!-- center 부분 -->
        <div class="container">
            <br><br>

            <div class="row">
                
                <div class="col-md-12">
                	<!-- 회원 수정 영역 -->
                        <h3>개인 정보 수정</h3>
                    <!-- 개인정보 수정 -->
                    <a href="./userRevise.jsp"> 
                        <input id="login_button" type="submit" class="btn btn-danger" value="회원 정보 수정">
                    </a>
                    <!-- 계정 탈퇴 -->
                    <a href="./userDelete.jsp"> 
                        <input id="login_button" type="submit" class="btn btn-danger" value="계정 탈퇴"> 
                    </a>
                    <!-- 회원의 이미지 수정 -->
                    <!-- 나중에 이미지 수정 버튼을 지우고, 회원 가입이나 회원 수정란에 한꺼번에 변경할 수 있도록 함. -->

                </div>
                <br><br><br><br><br><br>
                    
                <div class="col-md-12">
            	<!-- 사용자가 쓴 중고 거래 게시물 확인 -->
                 <h3>등록 중고 거래 게시물</h3>
                 <% 
                   //db에서 중고 거래 게시물을 가져오는 객체 생성.
                   BbsDAO bbs = new BbsDAO();
				   ArrayList<Bbs> list = bbs.getUserBbs(user_id);
                 
				   if(list.size() == 0){ // 만약, 사용자가 글을 하나도 쓰지 않을 경우.
                 %>
                   		<%=user_id %> 회원님께서 작성하신 게시물이 없습니다.
                 <%
				   }
                 %>
                 
				<section class="variable slider" style="width:100%">
             	   <% 
                	
				   for(int i=0;i<list.size();i++){ 
                %>
                
				    <div style="width:100%">
				        <a href="boarding2.jsp?bbsID=<%= list.get(i).getBbsID() %>" class="thum bnail">
                        <p id="title"><%= list.get(i).getBbsTitle() %></p>
                        <img id="img" src ="upload/<%=list.get(i).getFileName() %>" style="width:100px;height:100px">
                    </a>
                    <p> 조회수 : <%= list.get(i).getHits() %> <br> 추천수 : <%= list.get(i).getRecommend() %> 
                       <br><p><%= list.get(i).getBbsDate().substring(0, 11)%></p>
                              <form name="bbsDelete" class="form" role="form" action="./bbsDelteAction.jsp">
            					<input type="hidden" name="bbsID" value="<%=list.get(i).getBbsID() %>">
                                <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit" style="height:40px;">삭제</button>
                        </form>
				    </div>
				  
          
					<% 
				   }
				   %>
				</section>
				</div>
     
				<br><br><br><br><br><br>
				
				 <div class="col-md-12">
				 <!-- 사용자가 쓴 커뮤니티 게시물 확인 -->
				 <br><br>
                 <h3>등록 커뮤니티 게시물</h3>
                 <% 
               	   //db에서 커뮤니티 게시물을 가져오는 객체 생성.
                   CommunityDAO com_bbs = new CommunityDAO();
				   ArrayList<Community> list1 = com_bbs.getUserBbs(user_id);
                 
				   if(list1.size() == 0){ // 만약, 사용자가 글을 하나도 쓰지 않을 경우.
                 %>
                   		<%=user_id %> 회원님께서 작성하신 게시물이 없습니다.
                 <%
				   }
                 %>
                 
				<section class="variable slider" style="width:100%">
             	   <% 
                  // BbsDAO bbs = new BbsDAO();
				  // ArrayList<Bbs> list = bbs.getUserBbs(user_id);
				   //out.write(user_id);
                	
				   for(int i=0;i<list1.size();i++){ 
                %>
                
				    <div style="width:100%">
				        <a href="commuBoarding.jsp?bbsID=<%= list1.get(i).getBbsID() %>" class="thum bnail">
                        <p id="title"><%= list1.get(i).getBbsTitle() %></p>
                        <img id="img" src ="upload2/<%=list1.get(i).getFileName() %>" style="width:100px;height:100px">
                    </a>
                    <p> 조회수 : <%= list1.get(i).getHits() %> <br> 추천수 : <%= list1.get(i).getRecommend() %> 
                       <br><p><%= list1.get(i).getBbsDate().substring(0, 11)%></p>
                              <form name="bbsDelete" class="form" role="form" action="./commuDeleteAction.jsp">
            					<input type="hidden" name="bbsID" value="<%=list1.get(i).getBbsID() %>">
                                <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit" style="height:40px;">삭제</button>
                        </form>
				    </div>
				  
          
					<% 
				   }
				   %>
				</section>
				<br>
				</div>
					<br><br><br><br><br><br>
            </div>
        
        
        </div> <!-- container 영역이 끝남.-->
        
        <br><br>
        
    </div>
    </div>
        <!-- footer 부분-->
        <div class="footer">


        </div>
         <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="./slick/slick.min.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
  	  // 슬라이드 이미지의 설정 부분.
      $(".variable").slick({
        dots: true,
        infinite: false,
        variableWidth: true
      });
</script>


</body>

</html>