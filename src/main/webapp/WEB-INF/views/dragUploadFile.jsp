<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#dropBox{
		width: 400px;
		height: 300px;
		border: 1px solid gray;
	}
	#dropBox img{
		width: 100px;
		height: 100px;
	}
	#dropBox div.wrap{
		width: 110px;
		height: 110px;
		border: 1px solid red;
		position: relative;
	}
	#dropBox button.Xbtn{
		position: absolute;
		left: 0;
		top: 0;
	}
	#dropBox div.wrap img{
/* 		position: absolute;
		left: 0;
		top: 0;	 */	
	}	
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<form id="f1">
		<input type="text" name="test">
		<input type="submit" value="전송">
	</form>
	<div id="dropBox">
	</div>
<script id="template" type="text/x-handlebars-template">
{{#each.}}
<div class="wrap">
	<button class="Xbtn" data-name="{{file}}">X</button>
	<img src="displayFile?filename={{file}}">
</div>
{{/each}}
</script>	
<script>
	var formData = new FormData(); // 서버로 보낼 데이터를 담음 // file업로드시에 쓰임
	
		$("#dropBox").on("dragenter dragover", function(e) {
			e.preventDefault();
			//console.log(e);
		})
		
		$("#dropBox").on("drop", function(e) {
			e.preventDefault();
			//console.log("drop");
			
			var files = e.originalEvent.dataTransfer.files;
			var file = files[0]; //file 1개만
			console.log(file);
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.addEventListener("load",function(){
				var $img = $("<img>").attr("src",reader.result);
				$("#dropBox").append($img);
			})
			
			formData.append("files", file); //key : files에 file data가 추가됨
		})
		
		$("#f1").submit(function(e) {
			e.preventDefault();
			
			formData.append("test", $("input[name='test']").val());
			$.ajax({
				url:"drag",
				type:"post",
				data : formData,
				processData : false, //file을 같이 서버로 보낼시 셋팅 :  processData:false/contentType: false
				contentType: false,
				success:function(res){
					console.log(res);
					if(res.length > 0){
						alert("완료");
						$("#dropBox").empty();
						
						var source =$("#template").html();
						var fnc = Handlebars.compile(source);
						$("#dropBox").append(fnc(res));
						
/* 						$(res).each(function(i,obj){
							//var $img = $("<img>").attr("src","displayFile?filename="+obj); //byte로 내놔라
							//$("#dropBox").append($img);
							

						}) */
					}
				}
			})
		})
		
		$(document).on("click", ".Xbtn", function(){
			var filename = $(this).attr("data-name");
			console.log(filename);
			var $del = $(this).parent();
			
			$.ajax({
				url: "${pageContext.request.contextPath}/deleteFile",
				type: "get",
				data : {filename:filename},
				dataType:"text",
				success:function(res){
					console.log(res); // SUCCESS
					if(res == "SUCCESS"){
						alert("사진이 삭제되었습니다"+filename);
						$del.remove();
						/* $("img[src*='"+filename+"']").parent().remove();
						$("img[src*='"+filename+"']").prev().remove();
						$("img[src*='"+filename+"']").remove(); */
					}
				}
			})
		})
</script>
</html>