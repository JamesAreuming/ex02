<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="inMultiUp" method="post" enctype="multipart/form-data">
	<input type="text" name="test" placeholder="작성자이름">
	<input type="file" name="files" multiple="multiple"> <!-- multiple : 파일 여러개 -->
	<input type="submit" value="제출">
	</form>
</body>
</html>