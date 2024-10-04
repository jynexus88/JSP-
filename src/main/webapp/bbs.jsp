<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<!-- 네비게이션 바 -->
	<nav class="navbar navbar-default" style="margin-bottom: 20px;">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<!-- 'active' 클래스 추가 -->
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>
	<hr>

	<!-- 글쓰기 버튼 추가 -->
	<div class="container" style="text-align: right; margin-bottom: 10px;">
		<a href="write.jsp" class="btn btn-primary">글쓰기</a>
		<!-- 글쓰기 버튼 -->
	</div>

	<%
	int pageNumber = 1; // 기본 페이지 번호 설정
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

	<div class="container">
		<table class="table table-striped"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					<th style="background-color: #eeeeee; text-align: center;">기능</th>
				</tr>
			</thead>
			<tbody>
				<%
				BbsDAO bbsDAO = new BbsDAO();
				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
				for (int i = 0; i < list.size(); i++) {
				%>
				<tr
					onclick="window.location.href='view.jsp?bbsID=<%=list.get(i).getBbsID()%>'"
					style="cursor: pointer;">
					<td><%=list.get(i).getBbsID()%></td>
					<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getBbsDate()%></td>
					<td style="background-color: #ffffff; text-align: center;">
						<button class="btn btn-primary"
							onclick="printPost(<%=list.get(i).getBbsID()%>)">프린트</button>
					</td>
				</tr>
				<div id="bbs-<%=list.get(i).getBbsID()%>" style="display: none;">
					<h1><%=list.get(i).getBbsTitle()%></h1>
					<p>
						작성자:
						<%=list.get(i).getUserID()%></p>
					<p><%=list.get(i).getBbsContent()%></p>
					<p>
						작성일:
						<%=list.get(i).getBbsDate()%></p>
				</div>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- jQuery와 Bootstrap JavaScript 추가 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		function printPost(bbsID) {
			var postContent = document.getElementById('bbs-' + bbsID).innerHTML;
			var originalContents = document.body.innerHTML;
			document.body.innerHTML = postContent;
			window.print();
			document.body.innerHTML = originalContents;
		}
	</script>
</body>
</html>