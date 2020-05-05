<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(function() {
		$("img#thumbnail").click(function() {
			//var filename = ${file};
			///2020/04/29/s_bbab8fd8-ec65-48c3-bc98-851a88ea951a_말해_뭐해.jpg
			//var test = "/2020/04/29/s_bbab8fd8-ec65-48c3-bc98-851a88ea951a_말해_뭐해.jpg"
			
			var name = $("p#thumbname").text();
			// s_제거
			var start = name.substring(0,12);  // /2020/04/29/
			var end = name.substring(14); // bbab8fd8-ec65-48c3-bc98-851a88ea951a_말해_뭐해.jpg
			
			var filename = start+end;
			alert(filename);
			$("div#bigimg").empty();
			$("div#bigimg").append("<img src='displayFile?filename="+filename+"'>");
			
		})
	})
</script>
</head>
<body>
	${test}<br>
	<p id="thumbname">${file}</p>
	<p><img src = "displayFile?filename=${file}" id="thumbnail"></p> <!-- 데이터를 직접 가져와서 전달 -->
	<!-- 아니면 이미지 data-src="${file}"을 심어서 이름을 받아옴-->
	<!-- var path = $(this).attr("data-src"); -->
	<div id="bigimg">
	
	</div>
</body>
</html>