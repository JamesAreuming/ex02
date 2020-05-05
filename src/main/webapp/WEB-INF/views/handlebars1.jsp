<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<div id="temp1">
		
	</div>
	<script>
		var source = "<h1>{{title}}</h1><p>{{name}}</p>"; //틀
		var d2 = {title:"My title", name:"My name"};
		
		var template = Handlebars.compile(source); // function이 return
		
		var text2 = template(d2); // json데이터가 들어간 tag text return
		
		$("#temp1").html(text2);
	</script>
	
	<hr>
	
	<div id="temp2"></div>
	<script>
		var s2 = "<h1>{{hobby1}}</h1><h2>{{hobby2}}</h2><h3>{{hobby3}}</h3>";
		var data = {hobby1:"축구",hobby2:"검도",hobby3:"야구"};
		
		var temp2 = Handlebars.compile(s2);
		
		var text = temp2(data);
		
		$("#temp2").html(text);
	</script>
	
	<hr>
		
	<div id="temp3"></div>
	<script>
		var d3 = {hobby1:"축구3",hobby2:"검도3",hobby3:"야구3"};
		$("#temp3").html(temp2(d3));
	</script>
	
	<hr>
	<div id="temp4"></div>
	
	<!-- 틀 -->
	<script id="template" type="text/x-handlebars-template">
		<span>{{name}}</span>
		<div>
			<span>{{userId}}</span><br>
			<span>{{addr}}</span><br>
			<span>{{email}}</span><br>
		</div>
	</script>
	
	<script>
		var s4 = $("#template").html();  // = var s2 = "<h1>{{hobby1}}</h1><h2>{{hobby2}}</h2><h3>{{hobby3}}</h3>";
		var d4 = {name:"정아름", userId:"cara3245", addr:"대실역남로 50", email:"134ewes"};
		
		var f4 = Handlebars.compile(s4);
		$("#temp4").html(f4(d4));
	</script>
</body>
</html>