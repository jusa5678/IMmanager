<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.Community" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<!-- 
	사용 : 커뮤니티 게시판 jsp
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
     
		   #img{
                width:100%;
                height:200px;
                border-radius: 40px;
            }
            
           #user_img {
		    width: 50px;
		    height:50px;
		    border-radius: 25px; /* 이미지 반크기만큼 반경을 잡기*/
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

<title>커뮤니티 게시판</title>

</head>

<body>

<%
		// 세션을 할당하는 부분.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		// 페이지 넘버를 계산하는 부분.
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		int totalPage = 0; // 전체 페이지를 저장할 변수.
		
		CommunityDAO bs = new CommunityDAO();	
		totalPage = bs.getTotal();
		// 1페이지에 8개의 게시물을 불러옴.
		if(totalPage != 0){
			if((totalPage % 8) == 0){
				totalPage = (totalPage / 8);
			}else{
				totalPage = (totalPage / 8 + 1);
			}
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
      <li class="nav-item active"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
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
      <li class="nav-item active"> <!-- active 속성을 이용해서 클릭된 효과를 줌.-->
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
         
        <br>
        <div class="row"  style="float: right;">
                           
              <br><br>
           
              <!-- 검색 영역 -->
              <form name="select" class="form" role="form" action="./commuSelectBoard.jsp" >
              <div class="input-group">
                 
                 <select name="selectTag" class="form-control">
                   <option value="bbsTitle">제목</option>
                   <option value="userID">글쓴이</option>
                   <option value="bbsContent">내용</option>
                 </select>

                  <input name="selectContent" type="text" class="form-control" placeholder="검색">
                  <span class="input-group-btn">
	              <button class="btn btn-secondary" type="submit">찾기</button>
                  </span>
                  
            </div>
            </form>
            
              <div class="input-group">
      	 <% 
    		if(user_id != null){
    	    %>
    	      <!-- 글쓰기 페이지 이동. -->
              <a href="./commuWrite.jsp"> 
              <input id="login_button" type="submit" class="btn btn-danger" value="글쓰기" style="width:100%"> 
              </a>

              <% 
    		}
           %>
         </div>
        </div>
         

            <!-- 인기 커뮤니티 글 영역-->
            <br><br><br><br><br><br><br>
            
            
            <!-- 커뮤니티 글 영역 -->
            <div class="row">
                    
                
            <% 
        	 // 커뮤니티 db를 불러오는 객체 생성.
            			CommunityDAO bbsDAO = new CommunityDAO();
            
            			UserDAO user = new UserDAO();
						ArrayList<Community> list = bbsDAO.getList(pageNumber);
						for(int i=0; i<list.size(); i++){
						
			%>
                
                <div class="col-md-3">
                <a href="commuBoarding.jsp?bbsID=<%=list.get(i).getBbsID() %>" class="thum bnail">
                		<div class="col-md-12" style="margin-left:20px">
              
                        <p id="title"><%= list.get(i).getBbsTitle() %></p>  <!--  수정 사항 -->
                        </div>
                        <img id="img" src ="upload2/<%=list.get(i).getFileName() %>"> 
                    </a>
                    <!--  <img src="image\user_sample.png" align="top"> -->
                        <p id="nick"><img src="profilepic/def.png" align="top" style="width:10%"><%= list.get(i).getUserID() %> </p>
                        <span style="float:left"> 조회수 : <%= list.get(i).getHits() %> </span>  <span style="float:right"> 추천수 : <%= list.get(i).getRecommend() %> </span><br><br>
                        <p style="float:left; margin-top:-20px">게시일 : <%= list.get(i).getBbsDate().substring(0, 11)%></p>

                 </div>    
					<%
						}
					%>   
			</div>   	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	<div class=".col-md-12" style="text-align:center">
			<%
			// 페이징 영역
				for(int i=1; i<= totalPage; i++){
					
			%>
				<a href="commuBoard.jsp?pageNumber=<%=i%>" class="btn btn-primary btn-arraw-left"><%=i%></a>
			<%
					
				}
			%>			
			
					
				<!--  
					<%
					//ut.write("페이지 넘버 :" + pageNumber);
					//if(bbsDAO.nextPage(pageNumber + 1)){
					%>
					<a href="sellboard.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-default" style=" border: 2px solid #A9D0F5;"><%=pageNumber+1 %></a>
					
					<%
					// }
					// if(pageNumber != 1){
					 %>
					 <a href="sellboard.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-default" style=" border: 2px solid #A9D0F5;"><%=pageNumber-1 %></a>
					 <%
					 //}
					%>
		-->
                
              </div>
            </div> <!-- container 영역이 끝남.-->
        
  
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>