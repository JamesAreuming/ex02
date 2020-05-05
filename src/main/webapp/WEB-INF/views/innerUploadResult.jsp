<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>작성자 : ${test}</p>
	<p>파일이름 : ${file}</p>
	<p><img src = "http://localhost:8080/ex02/resources/upload/${file}"></p>
	<p><img src = "${pageContext.request.contextPath}/resources/upload/${file}"></p>  
</body>
</html>