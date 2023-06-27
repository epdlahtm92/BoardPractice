<%@ page contentType="text/html; charset=UTF-8" %><%--utf8 로 문자형 정해주기--%>
<%@ page import="kopo17.dao.*" %> <!-- dao 임포트 -->
<%@ page import="kopo17.domain.*" %> <!-- 도메인 임포트 -->
<% request.setCharacterEncoding("utf-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
	<head>
		<style>@import "./Style.css";</style><!-- css 파일 임포트 -->
		<%
			int id = 0; // 아이디 변수 초기화
			if (request.getParameter("id") != null) { // 파라미터 받아와서 변수에 대입
				id = Integer.parseInt(request.getParameter("id"));
			}
			
			String newRecord = null;
			if (request.getParameter("new") != null){ // 파라미터 받아와서 변수에 대입
				newRecord = request.getParameter("new");
			}
			
			BoardDao boardDao = new BoardDaoImpl(); // 클래스 객체 선언
			RecordOnBoard selectOne = boardDao.selectOne(id); // 하나만 조회하는 메서드 호출
			
			int root_id = 0; // 변수 초기화
			if(selectOne.getRoot_id() == 0) { // 이 글이 원글이라면
				root_id = selectOne.getId(); // 루트아이디 변수에 현재 글 번호 넘겨주기
			} else {
				root_id = selectOne.getRoot_id();//댓글이라면 원글의 번호 넣기
			}
			
		%>
		<title>선택한 글 보기</title>
	</head>
	<body>
		<table>
			<tbody>
				<tr><td class="leftIndex">번호</td><td style="width:400px"><%=selectOne.getId() %></td></tr> <!-- 호출한 메서드 값 출력 -->
				<%
					if (selectOne.getRoot_id() != 0){ // 원글이라면 생략할 부분
						out.println("<tr><td class='leftIndex'>원글</td><td>" + selectOne.getRoot_id() + "</td></tr>"); // 원글 번호
						out.println("<tr><td class='leftIndex'>댓글 수준</td><td>" + selectOne.getRe_level() + "</td></tr>"); // 댓글 수준
						out.println("<tr><td class='leftIndex'>댓글내 순서</td><td>" + boardDao.replyOrderCount(selectOne.getRoot_id(), selectOne.getRe_level(), selectOne.getRe_order()) + "</td></tr>"); // 댓글 내 순서
					} else {}
				%>
				<tr><td class="leftIndex">제 목</td><td><textarea style="border:0px; width:90%; text-align:center" rows="1" readonly><%=selectOne.getTitle() %></textarea></td></tr> <!-- 호출한 메서드 값 출력 -->
				<tr><td class="leftIndex">일 자</td><td><%=selectOne.getRecord_date() %></td></tr> <!-- 호출한 메서드 값 출력 -->
				<tr><td class="leftIndex">조회 수</td><td><%=selectOne.getVisit_count() %></td></tr> <!-- 호출한 메서드 값 출력 -->
				<tr><td class="leftIndex">내 용</td><td><textarea style="border:0px; width:90%; height:300px;"><%=selectOne.getContent() %></textarea></td></tr> <!-- 호출한 메서드 값 출력 -->
			</tbody>
			<tfoot>
				<tr>
					<td colspan=2>
						<button onclick="location.href='./ShowList.jsp?id=<%=id %>&new=<%=newRecord %>'">목록</button> <!--  전체 목록으로 돌아가기 -->
						<%
							if(selectOne.isModable() == true) {
						%>
							<button onclick="location.href='./InputNewForm.jsp?id=<%=selectOne.getId() %>&root_id=<%=root_id %>&re_level=<%=selectOne.getRe_level() %>&re_order=<%=selectOne.getRe_order() %>'">댓글달기</button> <!-- 수정하기 버튼 -->
							<button onclick="location.href='./InputModForm.jsp?id=<%=selectOne.getId() %>'">수정하기</button> <!-- 수정하기 버튼 -->
						<%	
							} else {}
						%>
					</td>
				</tr>
			</tfoot>
		</table>
	</body>
</html>