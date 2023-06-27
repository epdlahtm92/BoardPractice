<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="kopo17.dao.*" %> <!-- dao 임포트 -->
<% request.setCharacterEncoding("utf-8"); %> <!-- 파라미터 인코딩 -->

<!DOCTYPE html>
<html>
	<head>
		<%
			int root_id = 0; // 아이디 변수 초기화
			if (request.getParameter("root_id") != null) { // 파라미터 받아와서 변수에 대입
				root_id = Integer.parseInt(request.getParameter("root_id"));
			}
			
			int re_level = 0;// 변수 초기화
			if (request.getParameter("re_level") != null){// 파라미터 받아와서 변수에 대입
				re_level = Integer.parseInt(request.getParameter("re_level"));
			}
			
			int re_order = 0;// 변수 초기화
			if (request.getParameter("re_order") != null){// 파라미터 받아와서 변수에 대입
				re_order = Integer.parseInt(request.getParameter("re_order"));
			}
			
			String title = null;// 변수 초기화
			if (request.getParameter("title") != null) {// 파라미터 받아와서 변수에 대입
				title = request.getParameter("title");
			}
			
			String content = null;// 변수 초기화
			if (request.getParameter("content") != null) {// 파라미터 받아와서 변수에 대입
				content = request.getParameter("content");
			}
			
			
			BoardDao boardDao = new BoardDaoImpl(); //클래식 객체 선언
			String[] res = boardDao.insertOne(root_id, re_level, re_order, title, content); // 레코드 추가하는 메서드 호출
		%>
		<title>새 글 쓰기</title>
	</head>
	<body>
		<%=res[0] %> <!--  결과 출력 -->
		<br>
		<button onclick="location.href='./InputNewForm.jsp'">글 쓰기</button> <!-- 돌아가기버튼 -->
		<button onclick="location.href='./SelectOne.jsp?id=<%=res[1] %>&new=new'">글 보기</button> <!-- 돌아가기버튼 -->
		<button onclick="location.href='./ShowList.jsp?id=<%=res[1] %>&new=new'">글 목록</button> <!-- 글 목록 보기 버튼 -->
	</body>
</html>