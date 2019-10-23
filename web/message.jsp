<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="message.MessageDAO" %>
<%@ page import="message.Message" %>
<!-- 
	사용 : 메세지 jsp
	db : member,message
	

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

           p,#nick{
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
    
    </style>

<title>메세지 페이지</title>

</head>

<body>
	<%
		// 세션을 할당.
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
			<!-- 메세지 창 영역 -->
            <div class="row">
                
                <div class="col-md-12">
                	<!-- 수신 된 메세지 테이블 -->
                    <h3> 수신 된 메세지 </h3>
                    <table class="table table-hover table-condensed" style="text-align: center; border: 1px solid #dddddd">
				<thead> <!-- 테이블의 가장 위 -->
					<tr>
						<th style="background-color: #F1BDBD; text-align: center;">보낸 사람 </th>
						<th style="background-color: #F1BDBD; text-align: center;">메세지 </th>
						<th style="background-color: #F1BDBD; text-align: center;"> </th> <!-- 삭제,답변 버튼을 두기 위해서 일부로 지정. -->
					</tr>
				</thead>
				<tbody> <!-- 테이블의 몸통 -->
				
				<%
					// 메세지를 db에서 불러오는 객체 실행.
					MessageDAO messDAO = new MessageDAO();
					ArrayList<Message> list =  messDAO.getMessage(user_id);
					
					// 조회수 증가 쿼리 실행.
					MessageDAO messDAO2 = new MessageDAO();
					
					
					for(int i=0; i<list.size(); i++){
						messDAO2.ChangeView(list.get(i).getMessNumber());
				%>

					<tr>

						<td><%=list.get(i).getSentUserID() %></td> <!-- 보낸 사람 -->
						
						<% 
							if(list.get(i).getBbsID() == 0){
						%>
						
						<td><%=list.get(i).getMessContent() %></td> <!-- 메세지 내용 -->
						
						<% 
							}else{
						%>
						
						<td> <a href="sellBoarding.jsp?bbsID=<%= list.get(i).getBbsID() %>"> <%=list.get(i).getMessContent() %> </a></td> <!-- 메세지 내용 -->
						
						<%
							}
						%>
						
						
						
						<td><form class="form" action="./messageDeleteAction.jsp"> <!-- 삭제 버튼 -->
							<input type="hidden" name="messNumber" value="<%=list.get(i).getMessNumber() %>">
							<input id="btn btn-inline" class="form-control" type="submit" value="삭제" style="background-color: #F75B5B; color:white;"> 
							</form>
							
							
							<form class="form" action="./messagePopup.jsp">
							<input type="hidden" name="sentUser" value="<%=list.get(i).getSentUserID() %>">
							
							<input id="btn btn-inline" class="form-control" type="submit" value="답장" style="background-color: #F1BDBD;">
							
							
							
							</form>
							
				
							</td>
							
					</tr>
				<%
					}
				%>
				

				</tbody>
			
			</table>
                </div>
                <br><br><br><br><br><br>
         
                

            </div>
            <!-- 메세지 보내기 영역 -->
            <h3> 메세지 보내기 </h3>
            <div class="row">
            	 <div class="col-md-3">
            			
            			<form class="form" action="./messagePopup.jsp">
                			<input id="btn" class="form-control" type="submit" value="메세지 보내기" style="background-color: #F1BDBD;"> 
						
						</form>
            
                </div>
            </div>
            <br><br><br><br><br><br>
                
        </div> <!-- container 영역이 끝남.-->
  
        <!-- footer 부분-->
        <div class="footer">


        </div>
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>



</body>

</html>