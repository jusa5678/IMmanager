<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 
	사용 : 회원 정보 수정 jsp
	db : member
	

 -->

<!doctype html>
<html ng-app="form-demo-app">
	<head>
		<meta charset="UTF-8">
		<title>회원 정보 수정 페이지</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width" , initial-scale="1.0">
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		<script>

// 데이터를 받아와서 처리하는 함수.
function openZipSearch() {
	new daum.Postcode({
		oncomplete: function(data) {
			$('[name=add_number]').val(data.zonecode); // 우편번호 (5자리)
			$('[name=user_address1]').val(data.address);
			$('[name=user_address]').val(data.address + " " + data.buildingName + " (" + data.zonecode + ")");
			
		}
	}).open();
}


</script>
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
		
		// 현재 회원의 정보를 db에서 불러오는 객체 실행.
		User user = new UserDAO().getList(user_id);
		
		%>
	
        <div id="body_top">
            <div class="col-md-5" style="text-align: center;"><a href="./main.jsp"><img src="./image/Main_Logo.png"></a></div>
        </div>
		<div class="container" id="wrap">
			<div class="row">
				<div class="col-md-6 col-md-offset-3" >
					<form name="signUpForm" class="form" role="form" action="./userReviseAction.jsp">
                        <legend>개인 정보 수정</legend>

                        <div class="row">
                          <!-- 아이디 -->
                          <div class="col-xs-6 col-md-6">
                          	<label>사용자 아이디</label>
                            <input type="text" name="user_id" class="form-control input-lg" value="<%=user.getUser_id() %>" readonly/>
                          </div>
                          <!-- 핸드폰 번호 -->
                          <div class="col-xs-6 col-md-6">
                          	<label>전화 번호</label>
                            <input type="number" name="user_number" class="form-control input-lg" value="<%=user.getUser_number() %>" />
                          </div>
                        </div>

                        <br>
                    
                        
                        <br>
                        
                        <div class="row">
                        <!-- 주소 -->
                            <div class="col-xs-12 col-md-12">
                              우편번호 : <input type="text" name="add_number" style="width:25%;" />
                                            <button type="button" class="btn btn-danger" style="width:60px; height:32px;" onclick="openZipSearch()">검색</button><br><br>
<input type="text" name="user_address1" class="form-control input-lg" value="주소" style=" height:30px;" readonly />
<input type="text" name="user_address" class="form-control input-lg" value="<%=user.getUser_address() %>" style=" height:30px;"/><br>
                            </div>
                            
                            
    
                        </div>
                        <br>
                        <br>
                   
                        <!-- 닉네임 -->
                        <label>닉네임</label>
                        <input type="text" name="user_nick" class="form-control input-lg" value="<%=user.getUser_nick() %>" />
                        <br>
                        <!-- 생년월일 -->
                      	<label>생년월일</label>
                        <input type="date" name="user_date" class="form-control input-lg" value="<%=user.getUser_date() %>" />
                        <br><br>
                       
                       <!-- 회원 정보를 수정하기 위해서 비밀번호 입력. -->
                       <label style="background-color:#F1BDBD;">회원 정보를 수정하기 위해 비밀번호를 입력하세요.</label>
                       <input type="password" name="user_password" class="form-control input-lg" placeholder="비밀번호를 입력하세요." />
                       <br>
                       <br>

                        <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit">회원 정보 수정</button>
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