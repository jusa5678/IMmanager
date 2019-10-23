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
	사용 : 메세지 전송 jsp
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

<title>메세지 전송창</title>

</head>

<body>
	<%
		// 세션을 받아와서 저장.
		String user_id = null;
		String sent_id = null;
	
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
		
		sent_id = request.getParameter("sentUser");
	%>
	<br>
   <!-- center 부분 -->
        <div class="container">
        <!-- 메세지 영역. -->
        <h2>메세지</h2>

            <div class="row">
                <div class="col-md-12">
                	<form class="form" action="./messageAction.jsp">
						<input type="hidden" name="messageType" value="chat"> <!-- 일반사용일 경우엔 Type에 chat을 지정하여 이후 메세지를 보낼 때 구분. -->
						
						<%
							if(sent_id == null){
						%>
						<input type="text" name="receUserID" class="form-control" placeholder="받는 유저" />
						
						<% 
							}else{
						%>
						<input type="text" name="receUserID" class="form-control" value="<%=sent_id %>"/>
						
						<%
							}
						%>
						
						<input type="text" name="messContent" class="form-control" placeholder="메세지 입력" />
						<input id="btn" class="form-control" type="submit" value="메세지 입력" style="background-color: #F1BDBD;"> 
					</form>
                </div>
                <div class="col-md-12" style="margin-top:10px;">
                <a href="./message.jsp">돌아가기</a>
                </div>
            </div>

                
        </div> <!-- container 영역이 끝남.-->
  

</body>

</html>