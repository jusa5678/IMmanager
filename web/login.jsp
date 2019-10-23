<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 
	사용 : 로그인 jsp
	db : member
	

 -->

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<style>
    #al{margin-top:50px;}
    #main_img{width:100%; height:150px; text-align: center; margin-bottom:20px;}
    #login_button{background-color:#F75B5B; border:0;}
    #so_login{ width:70%; height:70%}
    a{font-size: 1.2em; font-weight: bold;}


</style>

<title>로그인</title>

</head>

<body>


<div class="container">
    <div id="main" class="col-lg-4"></div>
   
    <div id="al" class="col-lg-4">
       <a href="./main.jsp">
       	<img id="main_img" src="./image/Main_Logo.png"> <!-- 로고 이미지 -->
       </a>
       
        <div class="jumbotron" style="padding-top:20px;">
        	<!-- 로그인  영역 -->
            <form method="post" action="loginAction.jsp">
            	<!-- 아이디 입력 -->
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" name="user_id" maxlength="20">
                </div>
                
                <!-- 비밀번호 입력 -->
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" name="user_password" maxlength="20">
                </div>
    
                <input id="login_button" type="submit" class="btn btn-primary form-control" value="로그인"> 
            </form>
            <br>
            
            
            <div style="text-align: center;"class="col-lg-16"> <!-- 계정찾기와 회원가입에 대한 부분 -->
                <a style="padding-right: 50px; color:black;">계정찾기</a> <!-- 계정찾기 --> 
                <a href="./join.jsp" style="color:black;">회원가입</a> <!-- 회원가입 -->
            </div>
            
            <div style="text-align: center; "class="col-lg-16"><h2>소셜 로그인</h2> </div> <!-- 소셜 로그인 -->
            
            <div style="text-align: center;" class="col-lg-16"> <!-- 소셜 로그인을 연결한 위치 -->
                <div id="naverIdLogin"></div><!-- //네이버아이디로로그인 버튼 노출 영역 -->
            </div>
            
        </div>

    </div>

<div class="footer"></div>


</div>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script> 
<!-- 네이버아디디로로그인 초기화 Script -->
<script type="text/javascript"> // 네이버 로그인 api.
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "DQEeKJRm0ZFi96kN6HRc", 
            /* 로그인 api를 신청한 개발자마다 부여된 Id로 이것으로 어떤 서비스의 회원이 어떤 Id로 네이버 로그인을 하는지 알 수 있다. */
			callbackUrl: "http://localhost:8080/Team_project/main.jsp", 
            /* 콜백함수는 로그인 한 이후 들어갈 url을 지정해야 한다. 현재 url에 대해선 좀 더 수정해야 할게 많기에 임시로 abc.com로 둔다.*/
			isPopup: true, /* 팝업을 통한 연동처리 여부 */
			loginButton: {color: "green", type: 3, height: 50} /* 로그인 버튼의 타입을 지정 */
		}
	);
	
	/* 설정정보를 초기화하고 연동을 준비 */
	naverLogin.init();
	
</script>

</body>

</html>