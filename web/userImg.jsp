<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<!-- 
	사용 : 유저 이미지 변경 jsp
	db : member
	
	이 부분은 임시로 둔 페이지이며, 나중에 회원가입과 회원수정 쪽에 합칠 때 이 페이지를 삭제한다.

 -->

<!doctype html>
<html ng-app="form-demo-app">
	<head>
		<meta charset="UTF-8">
		<title>유저 이미지 변경</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

		<style>
			.container{
				margin-top: 20px;
			}
			input.ng-invalid {
				border: 5px solid red;
            }
            #body_top{
                background-color: red;
                width: 100%;
                height:100px;
                background-color:#F1BDBD;
                margin-top : 30px;
                margin-bottom:30px;
            }
            .footer{
                position:absolute;
                margin-bottom: 0px;
                margin-top:50px;
                width:100%;
                height:100px;
                background-color: #F1BDBD;
            }
            
            img{
                width:40%;
                height:100px;
                text-align: center;
            }
		</style>
		
	</head>
	<body ng-controller="mainCtrl">
	
		<%
		// 세션을 불러와서 저장.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}

		%>
	
        <div id="body_top">
            <div class="col-md-5" style="text-align: center;"><a href="./main.jsp"><img src="./image/Main_Logo.png"></a></div>
        </div>
		<div class="container" id="wrap">
			<div class="row">
				<div class="col-md-6 col-md-offset-3" >
				    <!-- 회원 이미지 수정 영역 -->
					<form name="signUpForm" class="form" role="form" action="./userImgAction.jsp" enctype="multipart/form-data" method="post">
                        <legend>회원 이미지 수정</legend>

                        <input type="file" name="user_img"> <br><br>
						
                        <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit">회원 이미지 수정</button>
                      </form>
					<div>

					</div>
				</div>
			</div>
		</div>
		<div class="footer">


        </div>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
			<script src="js/bootstrap.min.js"></script> 
		
	</body>
</html>