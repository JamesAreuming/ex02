<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#dropBox img{
		width: 200px;
		height: 200px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	
	$(function() {

		$("#file").change(function() {
			//var file = $(this)[0].files[0]; // $(this)[0] : javascript 객체
			
			var files = $(this)[0].files;
			//var file = e.target.files;        https://greatps1215.tistory.com/5
			console.log(files);
			
 			for(var i = 0; i<files.length;i++){
				var reader = new FileReader(); //javascript 객체
				reader.readAsDataURL(files[i]);
				reader.onload = function(e){
					var $img = $("<img>").attr("src", e.target.result);
					$("#dropBox").append($img);
				}
 			}
		})
	})
</script>
</head>
<body>
	<form action="outUp2" method="post" enctype="multipart/form-data">
	<input type="text" name="test" placeholder="작성자이름sdfsd">
	<input type="file" name="files" id="file" multiple="multiple"> <!-- name="files" -->
	<input type="submit" value="제출">
	</form>
	
	<div id="dropBox"></div>
</body>
</html>