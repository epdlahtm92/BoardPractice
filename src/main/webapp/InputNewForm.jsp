<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"  %>
<%@ page import="kopo17.dao.*" %> <!-- dao 임포트 -->
<!DOCTYPE html>
<html>
	<script>
		function characterCheck(obj){
		  // 허용하고 싶은 특수문자가 있다면 여기서 삭제
		  var regExp = /<!--|-->/gi; 
		 // var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
		
		  if( regExp.test(obj.value) ){
		     alert("해당 문자는 입력하실수 없습니다.");
		     obj.value = obj.value.trim().substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		  }
		
		}
		
		function spaceCheck(){
			 var titleBox = document.getElementById("titleBox").value.trim();
			 document.getElementById("titleBox").value = titleBox;
		}
		
		function textCheck(){
			var textareaStr = document.getElementById("content").value;
			var titleBoxStr =  document.getElementById("titleBox").value;
			document.getElementById("content").value = textareaStr.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("\\", "&#39;");
			document.getElementById("titleBox").value = titleBoxStr.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("\\", "&#39;");
			
		}
	</script>
	<head>
		<%
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
			
			int id = 0; // 아이디 변수 초기화
			if (request.getParameter("id") != null) { // 파라미터 받아와서 변수에 대입
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			int root_id = 0; // 아이디 변수 초기화
			if (request.getParameter("root_id") != null) { // 파라미터 받아와서 변수에 대입
				root_id = Integer.parseInt(request.getParameter("root_id"));
			}
			
			int re_level = 0;
			if (request.getParameter("re_level") != null){
				re_level = Integer.parseInt(request.getParameter("re_level")) + 1;
			}
			
			int re_order = 0;
			if (request.getParameter("re_order") != null){
				re_order = Integer.parseInt(request.getParameter("re_order")) + 1;
			}
			
		%>
		<style>@import "./Style.css";</style><!-- css 파일 임포트 -->
		<title>새 글 쓰기</title>
	</head>
	<body>
		<form method="post">
			<table>
				<tbody>
					<%
						if (request.getParameter("root_id") != null) {
							out.println("<tr><td class='leftIndex'>원글 번호</td><td>" + request.getParameter("id") + "</td></tr>");
							out.println("<input type='hidden' name='root_id' value=" + root_id + ">");
							out.println("<input type='hidden' name='re_level' value=" + re_level + ">");
							out.println("<input type='hidden' name='re_order' value=" + re_order + ">");
						} else {
							out.println("<tr><td class='leftIndex'>번호</td><td>신규</td></tr>"); // 표 내용 출력
						}
					%>
					<tr><td class="leftIndex">제목</td>
						<td><input type="text" name="title" id="titleBox" value="" required></td></tr> <!-- 이름 필수 입력 사항 -->
					<tr><td class="leftIndex">일자</td><td><%=sdf.format(now) %></td></tr>
					<tr><td class="leftIndex">내용</td>
						<td><textarea name="content" id="content" style="width:300px; height:300px;"></textarea></td></tr> <!-- 내용은 textarea로 받기 -->
				</tbody>
				<tfoot>
					<tr>
						<td colspan=2>
							<button type="button" onclick="location.href='./ShowList.jsp'">목록</button> <!-- 전체조회로 돌아가기 -->
							<input type="submit" onclick=spaceCheck();textCheck() formaction="./InsertNewOne.jsp" value="글 쓰기"></td> <!-- 새 레코드 입력 하기 -->
					</tr>
				</tfoot>
			</table>
		</form>
	</body>
</html>