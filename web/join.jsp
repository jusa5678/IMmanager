<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	사용 : 회원 저장 jsp
	db : member
	

 -->

<!doctype html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width" , initial-scale="1.0">
		<title>회원 가입</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		

		<script>

// 주소 데이터를 받아와서 처리하는 함수.
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
	<body>
        <div id="body_top"> <!-- 로고 이미지 -->
            <div class="col-md-5" style="text-align: center;"><a href="./main.jsp"><img src="./image/Main_Logo.png"></a></div>
        </div>
		<div class="container" id="wrap">
		
			<!-- 회원가입 전체영역 -->
			<div class="row">
				<div class="col-md-6 col-md-offset-3">
					<form name="signUpForm" class="form" role="form" action="joinAction.jsp">
                        <legend>회원가입</legend>
                        <h4>필수 항목</h4>
                        <div class="row">
                          <!-- 아이디 -->
                          <div class="col-xs-6 col-md-6">
                            <label>아이디 입력</label>
                            <input type="text" name="user_id" class="form-control input-lg" placeholder="아이디 입력" />
                          </div>
                          <!-- 핸드폰 번호 -->
                          <div class="col-xs-6 col-md-6">
                            <label>연락처 입력</label>
                            <input type="number" name="user_number" class="form-control input-lg" placeholder="연락처 입력" />
                          </div>
                        </div>

                        <br>
                        <div class="row">
                        	<!-- 비밀번호 -->
                            <div class="col-xs-6 col-md-6">
                              <label>비밀번호 입력</label>
                              <input type="password" name="user_password" class="form-control input-lg" placeholder="비밀번호 입력" />
                            </div>
                            <!-- 비밀번호 재확인 -->
                            <!-- 아직 비밀번호 재확인 기능 없음 -->
                            <div class="col-xs-6 col-md-6">
                              <label>비밀번호 재입력</label>
                              <input type="password" name="RE_PASSWORD" class="form-control input-lg" placeholder="비밀번호 재입력" />
                            </div>
                        </div>
                        
                        <br>
                        <div class="row">
                        <!-- 주소 -->
                            <div class="col-xs-12 col-md-12">
                            	우편번호 : <input type="text" name="add_number" style="width:25%;" />
                                       <button type="button" class="btn btn-danger" style="width:60px; height:32px;" onclick="openZipSearch()">검색</button><br><br>
								<input type="text" name="user_address1" class="form-control input-lg" value="주소" style=" height:30px;" readonly />
								<input type="text" name="user_address" class="form-control input-lg" value="상세주소" style=" height:30px;"/><br>
                            </div>
                            
                            
                        <div class="row">
                        <!-- 회원 구분 -->
                            <div class="col-xs-12 col-md-12">
                                <div class="form-group" style="text-align: center;"> 
									<div class="btn-group" data-toggle="buttons">
										<!-- 일반회원일시, 값은 0 -->
										<label class="btn btn-danger active">
											<input type="radio" name="user_con" autocomplete="off" value="0" checked>일반회원
										</label>
										<!-- 업체회원일시, 값은 1 -->
										<label class="btn btn-danger">
											<input type="radio" name="user_con" autocomplete="off" value="1" >업체회원
										</label>
									</div>
								</div>   
                            </div>
                            
                        </div>
     
                        </div>
                        <br>
                        <br>
                        <h4>선택 항목</h4> 
                        
                        <!-- 닉네임 입력 -->
                        <label>닉네임 입력</label>
                        <input type="text" name="user_nick" class="form-control input-lg" placeholder="닉네임 입력" />
                        <br>
                        <!-- 생년월일 입력 -->
                      	<label>생년월일</label>
                        <input type="date" name="user_date" class="form-control input-lg" placeholder="" />
                        <br><br>

                        <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit">회원가입</button>
                      </form>
					<div>

					</div>
				</div>
			</div>
		</div>
		<div class="footer">


        </div>
			<script src="js/bootstrap.min.js"></script> 
		
	</body>
</html>