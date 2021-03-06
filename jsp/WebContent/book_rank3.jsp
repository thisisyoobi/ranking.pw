<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--
------------------------------------------------------------
* @설명 : 일별 박스오피스 REST 호출 - 서버측에서 호출하는 방식 예제
------------------------------------------------------------
-->
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

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<meta content="@VelosofyYT" name="twitter:creator"/> 
<meta content="https://www.velosofy.com/img/card.png" name="twitter:image:src"/> 
<meta content="228490107301532" property="fb:admins"/> 
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 

	<meta charset="utf-8"/> <meta content="width=device-width, initial-scale=1" name="viewport"/> 
	  

<style type="text/css">

	#movie_1{
		width:100%;
	}
	
	#landing .container{
		padding-top:10px;
		padding-bottom:10px
	}
</style>
	
</head>

<body>

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
	
	<li class="nav-item"> 
	<a class="nav-link" href="https://www.velosofy.com/templates">자유게시판</a> 
	</li> 

	</div> 
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

<h1 class="poppins" style="font-size:50px;">실시간&nbsp<span id="keyword">포털 &nbsp</span>순위</h1> 

<h2 class="lead text-muted">부제목 </h2> 
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 



<h3 class="py-4 poppins"><span class="text-primary">영화 차트</span> </h3>


<div class="row">

<!-- 

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/intro-template-130" title="FREE 2D Intro #130 | After Effects Template">
<img alt="FREE 2D Intro #130 | After Effects Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/vtucu0vNnl8/mqdefault.jpg" title="FREE 2D Intro #130 | After Effects Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/c4d-template-69" title="FREE 3D Intro #69 | Cinema 4D/AE Template">
<img alt="FREE 3D Intro #69 | Cinema 4D/AE Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/xCA1UJbR6P8/mqdefault.jpg" title="FREE 3D Intro #69 | Cinema 4D/AE Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/intro-template-129" title="FREE 2D Intro #129 | Sony Vegas/After Effects Template">
<img alt="FREE 2D Intro #129 | Sony Vegas/After Effects Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/6RYDBuX-qvE/mqdefault.jpg" title="FREE 2D Intro #129 | Sony Vegas/After Effects Template" width="100%"/>
</a>
</div>

<div class="col-md-3 templates">
<a class="card mb-4 shadow-sm" href="/template/c4d-template-68" title="FREE 3D Intro #68 | Cinema 4D/AE Template">
<img alt="FREE 3D Intro #68 | Cinema 4D/AE Template" class="hoverable" loading="lazy" src="https://i.ytimg.com/vi/71R1MC8Is44/mqdefault.jpg" title="FREE 3D Intro #68 | Cinema 4D/AE Template" width="100%"/>
</a>
</div>
 -->
 
<div class="col-md-3 templates" style="width:100%;">
	<table class="table table-striped table-hover" id="movie_1" style="">
		<thead class="thead-dark">
		<tr  style="width:100%;">
			<th>순위</th>
			<th>영화명</th>
		</tr>
		</thead>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList}">
			<c:forEach items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}" var="boxoffice">
				<tr  style="width:100%;">
					<td style="width:25%;">
						<c:out value="${boxoffice.rank }" />
					</td>
					<td style="width:90%;">
						<c:out value="${boxoffice.movieNm }" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.boxofficeType}" /></span>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.showRange}" /></span>
	<br><br>
</div>

<br>
<div class="col-md-3 templates" style="width:100%;">
	<table   border="1" id="movie_1" style="">
		<tr style="width:100%;">
			<td>순위</td>
			<td>영화명</td>
		</tr>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList}">
			<c:forEach items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}" var="boxoffice">
				<tr style="width:100%;">
					<td style="width:10%;">
						<c:out value="${boxoffice.rank }" />
					</td>
					<td style="width:90%;">
						<c:out value="${boxoffice.movieNm }" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.boxofficeType}" /></span>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.showRange}" /></span>
	<br><br>
</div>

<br>
<div class="col-md-3 templates" style="width:100%;">
	<table   border="1" id="movie_1" style="">
		<tr style="width:100%;">
			<td>순위</td>
			<td>영화명</td>
		</tr>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList}">
			<c:forEach items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}" var="boxoffice">
				<tr style="width:100%;">
					<td style="width:10%;">
						<c:out value="${boxoffice.rank }" />
					</td>
					<td style="width:90%;">
						<c:out value="${boxoffice.movieNm }" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.boxofficeType}" /></span>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.showRange}" /></span>
	<br><br>
</div>

<br>
<div class="col-md-3 templates" style="width:100%;">
	<table   border="1" id="movie_1" style="">
		<tr style="width:100%;">
			<td>순위</td>
			<td>영화명</td>
		</tr>
		<c:if test="${not empty dailyResult.boxOfficeResult.dailyBoxOfficeList}">
			<c:forEach items="${dailyResult.boxOfficeResult.dailyBoxOfficeList}" var="boxoffice">
				<tr style="width:100%;">
					<td style="width:10%;">
						<c:out value="${boxoffice.rank }" />
					</td>
					<td style="width:90%;">
						<c:out value="${boxoffice.movieNm }" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.boxofficeType}" /></span>
	<span class="text-primary"><c:out value="${dailyResult.boxOfficeResult.showRange}" /></span>
	<br><br>
</div>


</div>
<!-- 
<div class="text-right">
<a class="btn btn-primary" href="/templates/featured">
                Show 200 more featured templates
            </a>
</div>
 -->
 
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

	<!--
	<c:out value="${dailyResult.boxOfficeResult.boxofficeType}" />
	<c:out value="${dailyResult.boxOfficeResult.showRange}" />
	<br />

	
	<form action="">
		일자:
		<input type="text" name="targetDt" value="<%=targetDt%>">
		최대 출력갯수:
		<input type="text" name="itemPerPage" value="<%=itemPerPage%>">
		영화구분:
		<select name="multiMovieYn">
			<option value="">-전체-</option>
			<option value="Y" <c:if test="${param.multiMovieYn eq 'Y'}"> selected="seleted"</c:if>>다양성영화</option>
			<option value="N" <c:if test="${param.multiMovieYn eq 'N'}"> selected="seleted"</c:if>>상업영화</option>
		</select>
		국적:
		<select name="repNationCd">
			<option value="">-전체-</option>
			<option value="K" <c:if test="${param.repNationCd eq 'K'}"> selected="seleted"</c:if>>한국</option>
			<option value="F" <c:if test="${param.repNationCd eq 'F'}"> selected="seleted"</c:if>>외국</option>
		</select>
		지역:
		<select name="wideAreaCd">
			<option value="">-전체-</option>
			<c:forEach items="${codeResult.codes}" var="code">
				<option value="<c:out value="${code.fullCd}"/>"
					<c:if test="${param.wideAreaCd eq code.fullCd}"> selected="seleted"</c:if>
				><c:out value="${code.korNm}" /></option>
			</c:forEach>
		</select>
		</br>
		<input type="submit" name="" value="조회">
		
	</form> -->
</body>
</html>