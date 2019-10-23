<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbsip.BbsDAO2"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="bbsip.Bbs2"%>
<%@ page import="bbsip.IpchalSub" %>
<%@ page import="pop.PopDAO"%>
<%@ page import="pop.Pop" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date today = new Date();
%>

<%
	//이건 로그인한 사람을 판단하는 부분이다. 어차피 상단메뉴바를 항상 노출시킬것이기 때문에..
 		//이 파트는 반드시 존재해야한다.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
	user_id = (String) session.getAttribute("user_id");
	}
		System.out.print(user_id);
%>
  	<%
  		int pageNumber = 1; //기본 페이지 넘버

  	  			//페이지넘버값이 있을때
  	  			if (request.getParameter("pageNumber") != null) {			
  	  			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
  	  			}
  	%>
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

<title>IM interior manager</title>

</head>

<body>



<nav class="navbar navbar-expand-lg navbar-light" style="margin-top:20px; background-color: #F1BDBD;">
  <a class="navbar-brand" href="./main.jsp"><img src="./img/Logo.png" style="width:170px; margin-top:-15px; margin-bottom:-15px;"></a>
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
      
      <li class="nav-item active">
        <a class="nav-link" href="./ipchalBoard.jsp">입찰 게시판</a>
      </li>
    </ul>
    <%
    	if(user_id == null){ //로그인 상태가 아님.
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
	<script>
					function btnSubmit(){ 
						alert("회원이 아닙니다")
					}
				</script>
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
        <div class="container">
        <br>
        <div class="row"  style="float: right;">
                           
              <br><br>
              <div class="input-group">
                 
                 <select class="form-control"  style="width:120px; height:38px;">
                   <option>제목</option>
                   <option>글쓴이</option>
                 </select>

                  <input type="text" class="form-control"   style="width:300px; height:38px;" placeholder="검색">
                  <span class="input-group-btn">
	              <button class="btn btn-secondary" type="button">찾기</button>
	              <%
	              	if(user_id != null){
	              %>
				  <button class="btn btn-danger" type="button" type="button" onclick="location.href='ipchalwrite.jsp'">글쓰기</button>
				  <%
				  	}
				  %>
                  </span>
                  
            </div>
        </div>

            <br><br><br><br>
            <h2><strong>입찰목록</strong> </h2>   <!-- 8개까지가 가장 깔끔해보인다 -->
			<br><br>
			
            <div class="row"> 
            	<%
             		//여기서 부터 본문들어갈것이고 <tr></tr>태그의 삽입이 시작됨. 포문 돌려서 처리하는 그 시작부분이다
             	             	            		BbsDAO2 bbsDAO = new BbsDAO2();
             	             	            		UserDAO user = new UserDAO();
             	             				ArrayList<Bbs2> list = bbsDAO.getList(pageNumber);
             	             				
             	             				//SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
             	             				//Date to = transFormat.parse(list.get(1).getBbsDate());
             	             				//System.out.println("년도"+list.get(0).getBbsDate().substring(0, 4));
             	             				//System.out.println("월"+list.get(0).getBbsDate().substring(5, 7));
             	             				//System.out.println("일"+list.get(0).getBbsDate().substring(8,10));
             	             				//System.out.println("시"+list.get(0).getBbsDate().substring(11,13));
             	             				//System.out.println("분"+list.get(0).getBbsDate().substring(14,16));
             	             				//System.out.println("초"+list.get(0).getBbsDate().substring(17,19));
             	             				
             	             				PopDAO mm2 = new PopDAO();
             	             				
             	             				for (int i = 0; i < list.size(); i++) {
             	%>
                <div class="col-md-3">
                <a href="ipchal.jsp?bbsID=<%=list.get(i).getBbsID() %>" class="thum bnail">
                        <p><%=list.get(i).getBbsTitle()%></p>
                        <img id="img" src ="ipchalimg\<%=list.get(i).getFileName() %>">
                    </a>
                        <p id="nick"><img src="./image/user_sample.png" align="top"><%=list.get(i).getUserID() %> </p>
                        <p> 
							등록일 : <%=list.get(i).getBbsDate().substring(0, 10)%> <br>
							만료일 : <%=list.get(i).getEndDate().substring(0, 10) %> <br>
							<strong> 입찰 시작가 : <font size=3 color=red><%=list.get(i).getStartprice() %></font><font color=black>원</font></strong> <br>
							<strong> 현재 최고입찰가 : <font size=4 color=red><%=mm2.popTest(list.get(i).getBbsID()) %></font><font color=black>원</font></strong> <br>
						</p>
                 </div> 
				 <%} %>
			
            </div>                	
            	<% if(pageNumber == 1) {%>
					<a href="ipchalBoard.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
				<%}else{ %>
					<%if(bbsDAO.nextPage(pageNumber)!=false){ %>
						<a href="ipchalBoard.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a><!--bbs.jsp?pageNumber=1or+1-->	
					<%}else{ %>
						<a href="ipchalBoard.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a><!--bbs.jsp?pageNumber=1or+1-->	
						<a href="ipchalBoard.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
					<%} %>
				<%} %>              
            </div> <!-- container 영역이 끝남.-->
        
  
        <!-- footer 부분-->
        <div class="footer">


        </div>


</body>

</html>