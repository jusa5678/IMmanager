<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 
	사용 : 커뮤니티 게시물 jsp
	db : member,commu_board,commu_comment
	

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
<script	src="https://code.jquery.com/jquery-3.0.0.min.js" integrity="sha256-JmvOoLtYsmqlsWxa7mDSLMwa6dZ9rrIdtrrVYRnDRH0="   crossorigin="anonymous"></script>
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
           
 
			#TopSlider div{width:90%; height:300px; visibility:hidden; position:absolute; text-align:center}
			/*
			#TopSlider div{width:498px;height:298px; float:left; visibility:hidden; position:absolute;}
			*/
			ul {
			    list-style:none;
			    padding:0; 
			}
			
			li {
			   
			    float: left;
			}
			 #user_img {
				width: 50px;
				height:50px;
				border-radius: 25px; /* 이미지 반크기만큼 반경을 잡기*/
			} 
				

    </style>
    <script>

    // 슬라이드 이미지 기능을 구성하는 스크립트 부분
    var intv;
    var current = 0;
    var sIdx = 0;
	var sCnt =  4;
	

    function startTopSlider() {
	    intv = setInterval(function () {
            $("#ul_btns").find("a").eq(current++ % sCnt).click();
        }, 3000);
    }

    function setBnr(idx, bnr, allTab, addCls) {
        $(bnr).css("visibility", "hidden")
              .eq(idx).css("visibility", "visible");
        $(allTab).removeClass(addCls);
        $(allTab).eq(idx).addClass(addCls);
    }

    $(document).ready(function () {
	    
        //set init
        $("#top_0").css("visibility", "visible");
        $("#btn_0").addClass("on");
        startTopSlider();
		
		
		$("#ul_btns").find("a").click(function(){
			var idx = $(this).attr("id").split("_")[1];
			setBnr(idx, "#TopSlider > div" , "#ul_btns > a" , "on" );
			
		}); 
    });
    
</script>
  
<title>커뮤니티 게시물</title>

</head>

<body>


<nav class="navbar navbar-expand-lg navbar-light" style="margin-top:20px; background-color: #F1BDBD;">
  <a class="navbar-brand" href="./main.jsp"><img src="./image/Main_Logo.png" style="width:170px; margin-top:-15px; margin-bottom:-15px;"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent" style="padding-top:30px">
    <ul class="navbar-nav mr-auto" >
      <li class="nav-item active"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
        <a class="nav-link" href="./commuBoard.jsp">커뮤니티 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./sellboard.jsp">판매 게시판</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="#">입찰 게시판</a> <!--  입찰 게시판 경로 지정필요!!  -->
      </li>
    </ul>
   
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
	
  </div>
</nav>
   <!-- center 부분 -->
   
  
  
        <div class="container">
   
        
            <div class="row" style="margin-top: 100px;">
                 <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      <h2>제목</h2>
                </div>
                 <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      아이디
                </div>
                
                <a href="" class="thum bnail">
                <div id="TopSlider" class=".col-md-12" style="width:90%; height:300px; margin: 10px;">
                
                          
								<div id="top_0"><img src="upload/1.jpg" style="width:90%; height:300px; "></div>
								<div id="top_1"><img src="upload/1.jpg" style="width:90%; height:300px; "></div>
								<div id="top_2"><img src="upload/1.jpg" style="width:90%; height:300px; "></div>
				
                </div>
               </a>
                
                 <a href="" class="thum bnail" text-align: center>
                <div id="TopSliderBtn" class=".col-md-12" style="width:100%; margin: 10px;">
    
								<ul id="ul_btns">
								    <a href="#" id="btn_0"><li><img src="upload/1.jpg" style="width:85px; height:90px;"></li></a>
								    <a href="#" id="btn_1"><li><img src="upload/1.jpg" style="width:85px; height:90px; padding-left: 3px"></li></a>
								    <a href="#" id="btn_2"><li><img src="upload/1.jpg" style="width:85px; height:90px; padding-left: 3px"></li></a>
								</ul>
							
                        
                </div>
                </a>
                <div class=".col-md-12" style="width:100%; margin: 10px; background-color: #D5CBCB;">
               
                      내용
                </div>
                
                <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      추천수 : 10 <br>
                      조회수 : 21<br>
                      게시일 : 2012.0204
                </div>
                
                  <div class=".col-md-12" style="width:100%; margin: 10px;">
                        <h3>댓글</h3>
                        <!-- 추천 쿼리 실행 -->
                     <form action="./recommendAction.jsp"> 
                     	 
	                     <button class="btn" type="submit"><img src="./image/recommend.jpg" style="width:35px;"></button>
                     </form><br>
                </div>
                <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                       <!-- 댓글 입력 쿼리 실행  -->
                     <form class="form-inline" action="./commuCommentAction.jsp" >
                      <div class="form-group">
                        <input type="text" class="form-control" name="comment" placeholder="댓글을 입력하세요" style="width:300px;">
                        
                       <button type="submit" class="btn btn-default" style="width:300px">입력</button>
                      </div>
                  </form> 
                </div>
                  <div class=".col-md-12" style="width:100%; border:1px solid #F1BDBD; margin: 10px;">
               
                    <table class="table table-hover table-condensed" style="text-align: center;">
                  <tbody> <!-- 테이블의 몸통 -->
                     
        				
					<tr>
						<td>이상 </td>
						<td>안녕하세요 </td>
				
						
					</tr>

               
                 		
				</tbody>
			
			</table>
                </div>
    


            </div>
           
        </div> <!-- container 영역이 끝남.-->
        
    
       
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>