<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="community.CommunityDAO" %>
<%@ page import="community.Community" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!-- 
	사용 : 커뮤니티 게시물 검색 jsp
	db : member,commu_board
	

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

           p{
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
    
    </style>

<title>커뮤니티 게시물 검색</title>

</head>

<body>

<%
		// 세션을 할당.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		// 페이지 넘버를 저장.
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

		// 검색 조건을 지정.
		String selectType = null; // 검색 타입. (제목,내용...)
		String selectContent = null; // 검색할 내용.
		selectType = request.getParameter("selectTag");
		selectContent = request.getParameter("selectContent");
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

            <!-- 인기 커뮤니티 글 -->
            <br><br><br><br><br><br><br>
            
            <div class="row">
                    
                
            <% 
					// 검색 쿼리실행
					if(selectContent == ""){ // 검색 내용에 아무것도 입력 안 할시.
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('검색 값을 입력하세요.')");
						script.println("history.back()");
						script.println("</script>");
					}else{
						UserDAO user = new UserDAO();
						
						// 검색 쿼리를 실행하는 객체 생성.
						CommunityDAO bbs = new CommunityDAO();
						ArrayList<Community> list =  bbs.getSelect(selectType, selectContent);
						
						if(list.size() == 0){
					%>
							<div class=".col-md-12" style="margin:10px;">
							<h3> 찾고자 하는 게시물이 없습니다. </h3>
							</div>
							
							
					<%
						}else{
							for(int i=0; i<list.size(); i++){
	
			%>
                
                <div class="col-md-3">
                <a href="commuBoarding.jsp?bbsID=<%= list.get(i).getBbsID() %>" class="thum bnail">
                <div class="col-md-12" style="margin-left:20px">
                        <p id="title"><%= list.get(i).getBbsTitle() %></p></div>
                        <img id="img" src ="upload2/<%= list.get(i).getFileName() %>">
                    </a>
                        <p id="nick"><img src="profilepic/def.png" align="top" style="width:10%"><%= list.get(i).getUserID() %> </p>
                        <span style="float:left"> 조회수 : <%= list.get(i).getHits() %></span> <span style="float:right"> 추천수 : <%= list.get(i).getRecommend() %></span> 
                        <br><br><p style="float:left; margin-top:-20px">게시일 : <%= list.get(i).getBbsDate().substring(0, 11)%></p>
                 </div>    
            
                        
					<%
							}
						}
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

                
              
            </div> <!-- container 영역이 끝남.-->
        
  
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>