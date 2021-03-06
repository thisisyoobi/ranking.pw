<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->
<%
		Connection con = null;
		PreparedStatement Inter_PS = null;
		ResultSet Inter_RS = null;
		
		PreparedStatement Kyobo_PS = null;
		ResultSet Kyobo_RS = null;
		
		PreparedStatement Yes_PS = null;
		ResultSet Yes_RS = null;
		
		PreparedStatement Aladin_PS = null;
		ResultSet Aladin_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);

		/*인터 파크*/
		String Inter_query = "select timedata from time_data where type='10m'";
		Inter_PS = con.prepareStatement(Inter_query);
		Inter_RS = Inter_PS.executeQuery();
		Inter_RS.next();
		String Inter_time = Inter_RS.getString("timedata");	
			
		Inter_query = "select * from interpark_book_rank";
		Inter_PS = con.prepareStatement(Inter_query);
		Inter_RS = Inter_PS.executeQuery();
		
		/*교보 문고*/
		String Kyobo_query = "select timedata from time_data where type='10m'";
		Kyobo_PS = con.prepareStatement(Kyobo_query);
		Kyobo_RS = Kyobo_PS.executeQuery();
		Kyobo_RS.next();
		String Kyobo_time = Kyobo_RS.getString("timedata");	
			
		Kyobo_query = "select * from kyobo_book_rank";
		Kyobo_PS = con.prepareStatement(Kyobo_query);
		Kyobo_RS = Kyobo_PS.executeQuery();
		
		/*예스24*/
		String Yes_query = "select timedata from time_data where type='10m'";
		Yes_PS = con.prepareStatement(Yes_query);
		Yes_RS = Yes_PS.executeQuery();
		Yes_RS.next();
		String Yes_time = Yes_RS.getString("timedata");	
			
		Yes_query = "select * from yes24_book_rank";
		Yes_PS = con.prepareStatement(Yes_query);
		Yes_RS = Yes_PS.executeQuery();
		
		/*알라딘*/
		String Aladin_query = "select timedata from time_data where type='10m'";
		Aladin_PS = con.prepareStatement(Aladin_query);
		Aladin_RS = Aladin_PS.executeQuery();
		Aladin_RS.next();
		String Aladin_time = Aladin_RS.getString("timedata");	
			
		Aladin_query = "select * from aladin_book_rank";
		Aladin_PS = con.prepareStatement(Aladin_query);
		Aladin_RS = Aladin_PS.executeQuery();
	%>
	
<%
	// 파라메터 설정
	String targetDt = request.getParameter("targetDt") == null ? "20200531" : request.getParameter("targetDt"); //조회일자
	String itemPerPage = request.getParameter("itemPerPage") == null ? "10"
			: request.getParameter("itemPerPage"); //결과row수
	String multiMovieYn = request.getParameter("multiMovieYn") == null ? ""
			: request.getParameter("multiMovieYn"); //“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
	String repNationCd = request.getParameter("repNationCd") == null ? "" : request.getParameter("repNationCd"); //“K: : 한국영화 “F” : 외국영화 (default : 전체)
	String wideAreaCd = request.getParameter("wideAreaCd") == null ? "" : request.getParameter("wideAreaCd"); //“0105000000” 로서 조회된 지역코드

	// 발급키
	String key = "e6de7638b492bfab3dff9ab47c1f62c8";
	// KOBIS 오픈 API Rest Client를 통해 호출
	KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);

	// 일일 박스오피스 서비스 호출 (boolean isJson, String targetDt, String itemPerPage,String multiMovieYn, String repNationCd, String wideAreaCd)
	String dailyResponse = service.getDailyBoxOffice(true, targetDt, itemPerPage, multiMovieYn, repNationCd,
			wideAreaCd);

	// Json 라이브러리를 통해 Handling
	ObjectMapper mapper = new ObjectMapper();
	HashMap<String, Object> dailyResult = mapper.readValue(dailyResponse, HashMap.class);

	request.setAttribute("dailyResult", dailyResult);

	// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	String codeResponse = service.getComCodeList(true, "0105000000");
	HashMap<String, Object> codeResult = mapper.readValue(codeResponse, HashMap.class);
	request.setAttribute("codeResult", codeResult);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<meta content="@VelosofyYT" name="twitter:creator"/> 
<meta content="https://www.velosofy.com/img/card.png" name="twitter:image:src"/> 
<meta content="228490107301532" property="fb:admins"/> 
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 

	<meta charset="utf-8"/> <meta content="width=device-width, initial-scale=1" name="viewport"/> 
	
<!-- 추가해야할거 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/table.css">

<style type="text/css">

</style>
	
</head>

<body>
 	<!-- 추가해야할거 -->
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-40481198-1', 'auto');
    ga('send', 'pageview');
</script>

<div id="app"> 

<nav class="navbar navbar-expand-md navbar-light navbar-velosofy"> 
	<div class="container"> 
<nav class="navbar navbar-light"> 
	<a class="navbar-brand " href="./index.jsp"> 
	<img alt="Free Video Templates" class="d-inline-block align-top" height="30" src="https://www.velosofy.com/img/logo.png" title="Free Video Templates" width="30"/> 
	홈페이지이름
	</a> 
</nav> 

<button aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-target="#navbarSupportedContent" data-toggle="collapse" type="button"> 
<span class="navbar-toggler-icon"></span> </button> 

<div class="collapse navbar-collapse" id="navbarSupportedContent"> 
<ul class="navbar-nav mr-auto"> 
	

	<li class="nav-item dropdown"> 
	<a aria-expanded="false" aria-haspopup="true" class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="category-dropdown"> 카테고리 </a> 
	<div aria-labelledby="category-dropdown" class="dropdown-menu dropdown-menu-right mt-n1"> 
	<a class="dropdown-item " href="./trend_rank.jsp" >실시간 랭킹</a> 
	<a class="dropdown-item " href="./music_rank.jsp" >음악 차트</a> 
	<a class="dropdown-item " href="./movie_rank.jsp" >영화 차트</a> 
	<a class="dropdown-item " href="./book_rank.jsp" >도서 차트</a> 
	</div> 
	</li> 
	<li class="nav-item"> 
	<a class="nav-link" href="https://www.velosofy.com/templates">자유게시판</a> 
	</li> 
</ul> 

<ul class="navbar-nav ml-auto"> 
<li class="nav-item"> 
<a class="nav-link" href="https://www.velosofy.com/login">로그인</a> 
</li> 
<li class="nav-item"> <a class="nav-link" href="https://www.velosofy.com/register">회원가입</a> 
</li> 
</ul> 

</div> 

</div> 
</nav> 

<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span>도서&nbsp</span>순위</h1> 

<h2 class="lead text-muted">부제목 </h2> 

</div> 
</section> 

<div class="container pb-5"> 




<div class="row">

<div class="col-md-6 templates">
	<!-- <h3 class="py-4 poppins"><span class="text-primary">인터 파크</span> </h3> -->
				<!-- 추가해야할거 -->
			<h3>인터파크</h3>
			<h6>기준 날짜 : <%=Inter_time%></h6>
			<table class="table table-hover">
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:5%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
	<%
			
			int count = 0;
			while(Inter_RS.next())
			{
				String rank = Inter_RS.getString("rank");
				String title = Inter_RS.getString("title");
				String url = Inter_RS.getString("url");
				String author = Inter_RS.getString("author");
				String publisher = Inter_RS.getString("publisher");
				author = "저자 : "+ author + "\n출판사 : " + publisher;
	%>
			<tbody>
				<tr>
					<td style="text-align:center;" title='<%=author%>'><%=rank%></td>
					<td title='<%=author%>'><a href=<%=url%> target="_blank"><img src="./logo/testpic.jpg" style="max-width:100px; max-height:100px"></img><%=title%></a></td>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	
	<br><br>
</div>


<br>
<div class="col-md-6 templates" >
	<!-- <h3 class="py-4 poppins"><span class="text-primary">교보 문고</span> </h3>  -->
			<h3>교보문고</h3>
			<h6>기준 날짜 : <%=Kyobo_time%></h6>
			<table class="table table-hover">
				<thead>
					<tr class="table-info">
						<th style="width:5%; text-align:center;">순 위</th>
						<th style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
	<%
			count = 0;
			while(Kyobo_RS.next())
			{
				String rank = Kyobo_RS.getString("rank");
				String title = Kyobo_RS.getString("title");
				String url = Kyobo_RS.getString("url");
				String author = Kyobo_RS.getString("author");
				String publisher = Kyobo_RS.getString("publisher");
				author = "저자 : "+ author + "\n출판사 : " + publisher;
	%>		
			<tbody>
				<tr>
					<td style="text-align:center;" title='<%=author%>'><%=rank%></td>
					<td title='<%=author%>'><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	<br><br>
</div>

<br>
<div class="col-md-6 templates" style="width:100%;">
	<!-- <h3 class="py-4 poppins"><span class="text-primary">YES24</span> </h3> -->
			<h3>YES24</h3>
			<h6>기준 날짜 : <%=Yes_time%></h6>
			<table class="table table-hover">
				<thead>
					<tr class="table-info">
						<th style="width:5%; text-align:center;">순 위</th>
						<th style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
	<%
			count = 0;
			while(Yes_RS.next())
			{
				String rank = Yes_RS.getString("rank");
				String title = Yes_RS.getString("title");
				String url = Yes_RS.getString("url");
				String author = Yes_RS.getString("author");
				String publisher = Yes_RS.getString("publisher");
				author = "저자 : "+ author + "\n출판사 : " + publisher;
	%>
			<tbody>
				<tr >
					<td style="text-align:center;" title='<%=author%>'><%=rank%></td>
					<td title='<%=author%>'><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	<br><br>
</div>

<br>
<div class="col-md-6 templates" >
	<!-- <h3 class="py-4 poppins"><span class="text-primary">알라딘</span> </h3> -->
			<h3>알라딘</h3>
			<h6>기준 날짜 : <%=Aladin_time%></h6>
			<table class="table table-hover" >
				<thead>
					<tr class="table-info">
						<th style="width:5%; text-align:center;">순 위</th>
						<th style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
	<%
			count = 0;
			while(Aladin_RS.next())
			{
				String rank = Aladin_RS.getString("rank");
				String title = Aladin_RS.getString("title");
				String url = Aladin_RS.getString("url");
				String author = Aladin_RS.getString("author");
				String publisher = Aladin_RS.getString("publisher");
				author = "저자 : "+ author + "\n출판사 : " + publisher;
	%>
			<tbody>
				<tr>
					<td style="text-align:center;" title='<%=author%>'><%=rank%></td>
					<td title='<%=author%>'><a id="atag" href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}
	%>
			</tbody>
	</table>
	<br><br>
</div>


</div>

 
</div>

</main> 

<script src="https://www.velosofy.com/js/app.js"></script>

<script>
    const keywords = ["포털 ", "음악 ", "영화 ", "도서 "];
    $(document).ready(function() {
        let i = 1;
        setInterval(function() {
            const newKeyword = keywords[i];
            $("#keyword").animate({ opacity: 0 }, function() {
                $(this).text(newKeyword).animate({ opacity: 1 });
            });
            if (i+1 === keywords.length) {
                i = 0;
            } else {
                i++;
            }
        }, 3500);
    });
</script>

	
</body>
</html>




