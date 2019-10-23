<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="bbsip.Bbs2"%>
<%@ page import="bbsip.IpchalSub" %>
<%@ page import="bbsip.BbsDAO2"%>
<%@ page import="pop.PopDAO"%>
<%@ page import="pop.Pop" %>
<%@ page import="community.Community" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="message.MessageDAO" %>
<%@ page import="message.Message" %>

<!-- 
	사용 : 메인 jsp
	db : 미정.
	
	
	메인 페이지는 아직 미정.
	

 -->

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

	<script src="TemplateData/UnityProgress.js"></script>
    <script src="Build/UnityLoader.js"></script>
    <script>
      var gameInstance = UnityLoader.instantiate("gameContainer", "Build/unity2.json", {onProgress: UnityProgress});
    </script>

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
                border-radius: 40px;
            }
            #nick{
                font-size: 20px;
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

           p,#title{
               text-align: center;
            }
            #nick{
               margin-top:20px;            
            }
             #title{
			  width        : 80%;     /* 너비는 변경될수 있습니다. */
			  text-overflow: ellipsis;  /* 위에 설정한 100px 보다 길면 말줄임표처럼 표시합니다. */
			  white-space  : nowrap;    /* 줄바꿈을 하지 않습니다. */
			  overflow     : hidden;    /* 내용이 길면 감춤니다 */
			  display      : block;     /* ie6이상 현재요소를 블럭처리합니다. */
			  font-size    : 14px;
			}
			
			
			
	    #mygameCon { text-align : center; }
			
		#gameContainer {
				width: 900px;
				margin-left: 100px;
				height : 400px;				
			  }
			
			
	 @media ( max-width: 500px ) {
				 
		#gameContainer {
		  width: 360px;
		  height : 360px;
		}
		
		
	}
    </style>

<title>메인 페이지</title>

</head>

<body>
	<%
		// 세션을 할당.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		MessageDAO messDAO = new MessageDAO();
	%>
	
	

<nav class="navbar navbar-expand-lg navbar-light" style="margin-top:20px; background-color: #F1BDBD;">
  <a class="navbar-brand" href="../main.jsp"><img src="../image/Main_Logo.png" style="width:170px; margin-top:-15px; margin-bottom:-15px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="padding-top:30px">
    
    <%
    	if(user_id == null){
    %>
    
      <ul class="navbar-nav mr-auto" >
      <li class="nav-item"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="../commuBoard.jsp">커뮤니티 </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../sellboard.jsp">판매 게시판 <span class="sr-only">(current)</span></a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="../ipchalBoard.jsp">입찰 게시판</a>
      </li>
	  
	  <li class="nav-item active">
        <a class="nav-link" href="../unity/test.jsp">3D 가구배치</a>
      </li>
	  
    </ul>
    
      <ul class="nav navbar-nav navbar-right">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              회원 관리
            </a>
            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="../login.jsp">로그인</a>
              <a class="dropdown-item" href="../join.jsp">회원가입</a>
              <a class="dropdown-item" href="#">고객센터</a>
            </div>
          </li>
	</ul>
    
    <%
    	}else{
    %>
       <ul class="navbar-nav mr-auto" >
       <li><span style="color:red; font-weight:bold;"><%= user_id %></span>님이 접속하셨습니다. </li>
       
         <% 
       		if(messDAO.getTotal(user_id) == 0){
       %>
       <li><span>최근에 받으신 메세지가 없습니다.</span></li>
        
       <%
       		}else{
       %>
       
       <li>
		<span style="color:red; font-weight:bold;"><%= messDAO.getTotal(user_id) %></span>개의 새로운 메세지가 있습니다..
		</li></ul>
		<%
       		}
	%>
       
    
      <ul class="navbar-nav mr-auto" >
      <li class="nav-item active"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="../commuBoard.jsp">커뮤니티 </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../sellboard.jsp">판매 게시판 <span class="sr-only">(current)</span></a>
      </li>  
      <li class="nav-item">
        <a class="nav-link" href="../ipchalBoard.jsp">입찰 게시판</a> <!--  입찰 게시판 경로 지정필요!!  -->
      </li>
    </ul>
	
			<%if(user_id.equals("ADMINISTRATOR")){ %>
				<ul class="nav navbar-nav navbar-right">
		        <li class="nav-item dropdown">
		            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		              회원 관리
		            </a>
		            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
		              <a class="dropdown-item" href="../message.jsp">메세지</a>
		              <a class="dropdown-item" href="../mypage.jsp">마이페이지</a>
		              <a class="dropdown-item" href="../adminMain.jsp">관리페이지</a>
		              <a class="dropdown-item" href="../logoutAction.jsp">로그아웃</a>              
		            </div>
		          </li>
			</ul>	
			
			<%}else{ %>
					<ul class="nav navbar-nav navbar-right">
			        <li class="nav-item dropdown">
			            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			              회원 관리
			            </a>
			            <div class="dropdown-menu bg-light" aria-labelledby="navbarDropdownMenuLink">
			              <a class="dropdown-item" href="../message.jsp">메세지</a>
			              <a class="dropdown-item" href="../mypage.jsp">마이페이지</a>
			              <a class="dropdown-item" href="../logoutAction.jsp">로그아웃</a>
			              <a class="dropdown-item" href="#">고객센터</a>
			            </div>
			          </li>
				</ul>
			<%} %>
	
	<% 
   			}
	%>


  </div>
</nav>
   <!-- center 부분 -->
   <br>
   <br>
		<div id="mygameCon">
		<div id="gameContainer" ></div>
		</div>

</body>

</html>