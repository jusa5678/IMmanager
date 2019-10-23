<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
	<meta charset="uft-8" />
	<title>summernote</title>
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1.0">
	
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 

<!-- include summernote css/js -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote.js"></script>

<!-- include summernote css/js-->
<link href="plugins/summernote/summernote.css" rel="stylesheet">
<script src="plugins/summernote/summernote.js"></script>
<!-- summer note korean language pack -->
<script src="plugins/summernote/lang/summernote-ko-KR.js"></script>

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
	
</head><!-- ./summernote_input.jsp -->
<body>
	<%
		// 세션을 할당.
		String user_id = null;
		if(session.getAttribute("user_id") != null){
			user_id = (String)session.getAttribute("user_id");
		}
	%>

	      	<div id="body_top"> <!-- 로고 이미지 -->
            <div class="col-md-5" style="text-align: center;"><a href="./main.jsp"><img src="./image/Main_Logo.png"></a></div>
        </div>


<div class="container">

	<div class="row">
		<form name="writeForm" action="./commuWriteAction.jsp" method="post" enctype="multipart/form-data">
	
		<label>제목을 입력하세요.</label>
		<input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" >
		<br>

	<label>글을 입력하세요.</label>
		<textarea name="bbsContent" id="summernote"></textarea>
        <script>
            $(document).ready(function() {
                $('#summernote').summernote({ // summernote를 사용하기 위한 선언
  	 		      height: 300,          // 기본 높이값
	 		      minHeight: null,      // 최소 높이값(null은 제한 없음)
	 		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	 		      focus: true,          // 페이지가 열릴때 포커스를 지정함
	 		      lang: 'ko-KR',         // 한국어 지정(기본값은 en-US)
	 		      disableDragAndDrop: true,
				});
			});
		</script>
	
		<div class=".col-md-12">
		<label>이미지 업로드</label>
		<input type="file" name="file"> <br>
		<input type="file" name="file2"> <br>
		<input type="file" name="file3"> <br>
		</div>
	
		
		<input type="submit"  class="btn btn-danger pull-right" value="글쓰기" style="width:100%">
		
		</form>

		</div>
		</div>
			<br><br><br>
		       <!-- footer 부분-->
        <div class="footer">


        </div>
	
</body>
</html>