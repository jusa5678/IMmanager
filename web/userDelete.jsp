<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	사용 : 계정탈퇴 jsp
	db : member
	

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

           p,#nick{
               text-align: center;
            }
            #nick{
               margin-top:20px;            
            }
    
    </style>

<title>계정 탈퇴 페이지</title>

</head>

<body ng-controller="mainCtrl">
	<%
		// 세션을 불러와서 저장함.
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

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto" >
      <li class="nav-item"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="./commuBoard.jsp">커뮤니티 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./sellboard.jsp">판매 게시판</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="#">입찰 게시판</a> <!--  입찰 게시판 경로 지정필요!!  -->
      </li>
    </ul>
     <% 
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
              <a class="dropdown-item" href="#">고객센터</a>
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
              <a class="dropdown-item" href="#">고객센터</a>
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
                		<!-- 계정탈퇴  영역 -->
                        <form name="signUpForm" class="form" role="form" action="./userDeleteAction.jsp">
                                <legend>계정 탈퇴</legend>
                                
                                <!-- 비밀번호 확인 -->
                                <div class="row">
                                  <div class="col-xs-6 col-md-6">
                                    <input type="password" name="user_password" class="form-control input-lg" placeholder="비밀번호를 입력" />
                                    <br><br><br>

                                    <label>경고 : 탈퇴시 모든 정보가 삭제됩니다.</label>
                                <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit">탈퇴</button>
                                  </div>
                                </div>
                               
                        </form>
                </div>
                <br><br><br> <br><br><br> <br><br><br> <br><br><br>
                <br><br><br> <br><br><br> 


            </div>
        
        
        </div> <!-- container 영역이 끝남.-->
        
    </div>
    </div>
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>