<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.Sell_sub" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
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
           
 
			#TopSlider div{width:90%; height:300px; visibility:hidden; position:absolute;}
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
			 p{
               text-align: center;
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
    <%
		// 유저 세션 할당하는 부분.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		UserDAO user = new UserDAO();
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
      <li class="nav-item active">
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
      <li class="nav-item active">
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
   
      
   <%
		// 해당 게시물의 글 번호를 받아오는 부분.
		// url형식으로 받아오는 형식이기 때문에, 전송방식의 변경을 하지 말 것.
	    int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		// 조회수 쿼리 실행.
		BbsDAO a = new BbsDAO();
		a.getView(bbsID); 
		
		// sell board에 있는 부수적인 정보들을 출력.
		BbsDAO sell = new BbsDAO();
		Sell_sub rs_sell = sell.getSub_Sell(bbsID); 
		
   %>
  
        <div class="container">
   
        
            <div class="row" style="margin-top: 50px;">
                 <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      <h2><%= bbs.getBbsTitle() %></h2>
                </div>
                 <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      <%= bbs.getUserID() %>
                </div>
                
                <a href="" class="thum bnail">
                <div id="TopSlider" class=".col-md-12" style="width:90%; height:450px; margin: 10px;">
                
                          
				<%
                
                	if(bbs.getFileName2() == null && bbs.getFileName3() == null){
                %>
               		<div id="top_0"><img src="upload/<%=bbs.getFileName()%>" style="width:82%; height:430px; "></div>
                <%
                	}else if(bbs.getFileName3() == null){
                %>
             		<div id="top_0"><img src="upload/<%=bbs.getFileName()%>" style="width:82%; height:430px; "></div>
            		<div id="top_1"><img src="upload/<%=bbs.getFileName2()%>" style="width:82%; height:430px; "></div>
               <%
                	}else{
               %>      
					<div id="top_0"><img src="upload/<%=bbs.getFileName()%>" style="width:82%; height:430px; "></div>
            		<div id="top_1"><img src="upload/<%=bbs.getFileName2()%>" style="width:82%; height:430px; "></div>	
					<div id="top_2"><img src="upload/<%=bbs.getFileName3()%>" style="width:82%; height:430px; "></div>
				<%
                	}
				%>
                </div>
               </a>
                
                 <a href="" class="thum bnail" text-align: center>
                <div id="TopSliderBtn" class=".col-md-12" style="width:100%; margin: 10px;">
    
				<%
                 	if(bbs.getFileName2() == null && bbs.getFileName3() == null){
                %>
                	<ul id="ul_btns">
						<a href="#" id="btn_0"><li><img src="upload/<%=bbs.getFileName()%>" style="width:85px; height:90px;"></li></a>		    
					</ul>
				<%
                	}else if(bbs.getFileName3() == null){
				%>
               		<ul id="ul_btns">
						<a href="#" id="btn_0"><li><img src="upload/<%=bbs.getFileName()%>" style="width:85px; height:90px;"></li></a>
						<a href="#" id="btn_1"><li><img src="upload/<%=bbs.getFileName2()%>" style="width:85px; height:90px; padding-left: 3px"></li></a>
					</ul>
								
				<%
                	}else{
				%>
					<ul id="ul_btns">
						<a href="#" id="btn_0"><li><img src="upload/<%=bbs.getFileName()%>" style="width:85px; height:90px;"></li></a>
						<a href="#" id="btn_1"><li><img src="upload/<%=bbs.getFileName2()%>" style="width:85px; height:90px; padding-left: 3px"></li></a>
						<a href="#" id="btn_2"><li><img src="upload/<%=bbs.getFileName3()%>" style="width:85px; height:90px; padding-left: 3px"></li></a>
					</ul>
								
				<%
                	}
				%>
                        
                </div>
                </a>
                <div class=".col-md-12" style="width:100%; margin: 10px; background-color: #D5CBCB;">
               
                      <%= bbs.getBbsContent() %>
                </div>
                
                <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                      추천수 : <%= bbs.getRecommend() %> <br>
                      조회수 : <%= bbs.getHits() %><br>
                      게시일 : <%= bbs.getBbsDate() %><br><br>
                      
         <h3> 가구 정보 </h3> 
                       가구 종류 : <%=rs_sell.getF_name() %><br>
                       가구 사이즈 : <%=rs_sell.getF_size() %><br>
                       가구 재질 : <%=rs_sell.getF_material() %><br>
                       가구 색상 : <%=rs_sell.getF_color() %><br>
                       제조사 : <%=rs_sell.getF_manu() %><br>
                       구매일 : <%=rs_sell.getF_date() %><br><br>
                        
                       <h3>판매자 정보</h3>
                       판매자 주소 : <%=user.getList(bbs.getUserID()).getUser_address() %><br><br>
                </div>
                
                  <div class=".col-md-12" style="width:100%; margin: 10px;">
                        <h3>댓글</h3>
                        <!-- 추천 쿼리 실행 -->
                     <form action="./recommendAction.jsp"> 
                     	 <input type="hidden" name="bbsID" value="<%=bbs.getBbsID() %>">
	                     <button class="btn" type="submit"><img src="./image/recommend.jpg" style="width:35px;"></button>
                     </form><br>
                </div>
                <div class=".col-md-12" style="width:100%; margin: 10px;">
               
                       <!-- 댓글 입력 쿼리 실행  -->
                     <form class="form-inline" action="./commentAction.jsp" >
                      <div class="form-group" style="width:100%">
                        <input type="text" class="form-control" name="comment" placeholder="댓글을 입력하세요" style="width:100%;">
                        <input type="hidden" name="bbsID" value="<%=bbsID %>"> <!-- bbsID는 임의 부여가 어렵기 때문에, hidden속성으로 보이지 않게 전송한다. -->
                       <button type="submit" class="btn btn-default" style="width:100%">입력</button>
                      </div>
                  </form> 
                </div>
                  <div class=".col-md-12" style="width:100%; border:1px solid #F1BDBD; margin: 10px;">
               
                     <table class="table table-hover table-condensed" style="text-align: center;">
                  <tbody> <!-- 테이블의 몸통 -->
                      <% 
                      	// sell board의 댓글을 출력하는 객체생성.
                      	CommentDAO commentDAO = new CommentDAO();
                      	ArrayList<Comment> comment = commentDAO.getComment(bbsID);
                      	
                      	for(int i=0; i<comment.size(); i++){
                      %>
        				
					<tr>
						<td><%=comment.get(i).getUser_id() %> </td>
						<td><%=comment.get(i).getComment() %> </td>
						<% 
							// 만약 사용자가 null,즉, 로그인을 하지 않은 상태라면 공백으로 바꾼다.
							if(user_id == null){
								user_id = "";
							}
							
							// 댓글을 작성한 유저가 맞는지 세션을 불러와 검사한다. 로그인을 하지 않은 상태라면 ""상태임으로 당연히 활성화 되지 않는다.	
							if(user_id.equals(comment.get(i).getUser_id())){
						%>
						
						<!-- 댓글 삭제 쿼리 실행  -->
						<!-- 세션을 검사하여 댓글을 작성한 사용자만이 자신의 댓글만 지울 수 있다. -->
						<td style="width:20%"><form class="form-inline" action="./commentDeleteAction.jsp">
							<input type="hidden" name="comment_number" value="<%=comment.get(i).getComment_number() %>">
							<input id="btn btn-danger" class="form-control" type="submit" value="삭제"> 
							</form>
						</td>
						<% 
							}
						
						%>
						
					</tr>

                 
                 <% 
                      	}
                 %>
                 		
				</tbody>
			
			</table>
                </div>
    


            </div><br><br><br>
            
               <div class=".col-md-12" style="width:100%; margin: 5px;">
                        <p>가격 : <%=bbs.getPrice() %></p>
                        <!-- 거래신청 영역 -->
	                    <!-- 거래신청을 할 경우, 해당 사용자에게 메세지를 전송한다. -->
	                    <form name="deal" class="form" role="form" action="./messageAction.jsp" >
	                    <input type="hidden" name="receUserID" value="<%=bbs.getUserID() %>">
	                    <input type="hidden" name="messageType" value="deal">
	                    <input type="hidden" name="bbsTitle" value="<%=bbs.getBbsTitle() %>">
	                    <input type="hidden" name="bbsID" value="<%=bbs.getBbsID() %>">
	                    
	                    <button class="btn btn-lg btn-primary btn-danger btn-block signup-btn" type="submit">거래 신청</button>
	                    
                    </form>
                 </div>
           
        </div> <!-- container 영역이 끝남.-->
        
    
       
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>