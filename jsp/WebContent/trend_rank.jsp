<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


	<%
		Connection con = null;
		//Naver
		PreparedStatement Naver_PS = null;
		ResultSet Naver_RS = null;
		//Zum
		PreparedStatement Zum_PS = null;
		ResultSet Zum_RS = null;
		
		PreparedStatement Nate_PS = null;
		ResultSet Nate_RS = null;
		
		PreparedStatement Google_PS = null;
		ResultSet Google_RS = null;
		
		String MYSQL_SERVER ="hackery00bi.iptime.org:6666";
		String MYSQL_SERVER_USERNAME = "yoobi";
		String MYSQL_SERVER_PASSWORD = "toor";
		String MYSQL_DATABASE = "jsp_db";
		String URL = "jdbc:mysql://" + MYSQL_SERVER + "/" + MYSQL_DATABASE + "?serverTimezone=UTC";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(URL, MYSQL_SERVER_USERNAME, MYSQL_SERVER_PASSWORD);
		//Naver//
		String naver_query = "select timedata from time_data where type='1m'";
		Naver_PS = con.prepareStatement(naver_query);
		Naver_RS = Naver_PS.executeQuery();
		Naver_RS.next();
		String naver_time = Naver_RS.getString("timedata");

		naver_query = "select * from naver_trends_rank";
		Naver_PS = con.prepareStatement(naver_query);
		Naver_RS = Naver_PS.executeQuery();
		//zum//
		String zum_query = "select * from zum_trends_rank";
		Zum_PS = con.prepareStatement(zum_query);
		Zum_RS = Zum_PS.executeQuery();
		//nate//
		String nate_query = "select * from nate_trends_rank";
		Nate_PS = con.prepareStatement(nate_query);
		Nate_RS = Nate_PS.executeQuery();
		
		//google//
		String Google_query = "select timedata from time_data where type='10m'";
		Google_PS = con.prepareStatement(Google_query);
		Google_RS = Google_PS.executeQuery();
		Google_RS.next();
		String time = Google_RS.getString("timedata");
		
		Google_query = "select * from google_trends_rank";
		Google_PS = con.prepareStatement(Google_query);
		Google_RS = Google_PS.executeQuery();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
		
	%>
			
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>랭킹.pw</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<meta content="@VelosofyYT" name="twitter:creator"/> 
<meta content="https://www.velosofy.com/img/card.png" name="twitter:image:src"/> 
<meta content="228490107301532" property="fb:admins"/> 
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/> 
<link href="https://www.velosofy.com/css/app.css" rel="stylesheet"/> 
<script src="./js/script.js"></script>
<script src="https://www.w3schools.com/lib/w3.js"></script>
<meta charset="utf-8"/> <meta content="width=device-width, initial-scale=1" name="viewport"/> 
	  
  
<!-- 추가해야할거 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/table.css">

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

<body id="header">
<jsp:include page="header.jsp" flush="true"/>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
 <!-- 추가해야할거 -->
 <script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>

<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-40481198-1', 'auto');
    ga('send', 'pageview');
</script>


<main> 

<section id="landing" style="height"> 

<div class="container"> 

<h1 class="poppins" style="font-size:50px;">실시간 검색어 차트</h1> 
<br>
<!-- 
<a class="btn btn-primary my-2" href="https://www.velosofy.com/templates">Find a template</a> 
<a class="btn btn-secondary my-2" href="https://www.velosofy.com/submit">Submit a template</a> 
 -->
</div> 
</section> 

<div class="container pb-5"> 






<div class="row">
	<!-- yoobi delete it
	<div class="col-md-12 templates">
		<select class="select_box1" name="select" onchange="fnMove(value)">
			<option>선택</option>
			<option value="1">네이버</option>
			<option value="2">Zum</option>
			<option value="3">구글</option>
			<option value="4">네이트</option>
		</select>
	</div>
	-->
	<br>

	<div id="div1" class="col-md-3 templates" style="width:100%;">

			<h3>네이버</h3>
			<h6 style="text-align:right;"><%=naver_time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			int count = 0;
			while(Naver_RS.next())
			{
				String rank = Naver_RS.getString("rank");
				String title = Naver_RS.getString("title");
				String url = Naver_RS.getString("url");
				url = url.replaceAll(" ", "+");
	%>
				<tr>
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="30" height="30"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="30" height="30"></td>

	<%
				}
				else if(count == 2)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="30" height="30"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}

		
	%>
		</table>
		<br><br>
	</div>

	<br>
	
	<div id="div2" class="col-md-3 templates" style="width:100%;">
			<h3>Zum</h3>
			<h6 style="text-align:right;"><%=time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Zum_RS.next())
			{
				String rank = Zum_RS.getString("rank");
				String title = Zum_RS.getString("title");
				String url = Zum_RS.getString("url");
				url = url.replaceAll(" ", "+");	
	%>
				<tr>
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="30" height="30"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="30" height="30"></td>

	<%
				}
				else if(count == 2)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="30" height="30"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}
		
		
	%>
	</table>
		<br><br>
	</div>

	<br>
	<div id="div3" class="col-md-3 templates" style="width:100%;">
			<h3>구글</h3>
			<h6 style="text-align:right;"><%=time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Google_RS.next())
			{
				String rank = Google_RS.getString("rank");
				String title = Google_RS.getString("title");				
				String url = Google_RS.getString("url");
				url = url.replaceAll(" ", "+");
	%>
				<tr>
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="30" height="30"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="30" height="30"></td>

	<%
				}
				else if(count == 2)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="30" height="30"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}

	%>
			</table>
		<br><br>
	</div>

	<br>
	<div id="div4" class="col-md-3 templates" style="width:100%;">
		<h3>네이트</h3>
			<h6 style="text-align:right;"><%=time%></h6>
			<table class="table table-hover">
			<!--  
				<thead>
					<tr class="table-info">
						<th class="table-th" style="width:10%; text-align:center;">순 위</th>
						<th class="table-th" style="width:30%; text-align:center;">제 목</th>
					</tr>
				</thead>
			-->
	<%
			count = 0;
			while(Nate_RS.next())
			{
				String rank = Nate_RS.getString("rank");
				String title = Nate_RS.getString("title");
				String url = "https://search.daum.net/nate?thr=sbma&w=tot&q=" + title.replaceAll(" ","+");

	%>
				<tr>
	<%
				if(count == 0)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./gold.png" width="30" height="30"></td>

	<%
				}
				else if(count == 1)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./silver.png" width="30" height="30"></td>

	<%
				}
				else if(count == 2)
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><img src="./bronze.png" width="30" height="30"></td>

	<%
				}
				else
				{
	%>
					<td style="text-align:center; font-weight:700; width:5%"><%=rank%></td>
	<%
				}
	%>

					<td style="font-weight:700;width:30%;"><a href=<%=url%> target="_blank"><%=title%></a></td>
				</tr>
	<%
				count++;
			}

	%>
			</table>
		<br><br>
	</div>


<div w3-include-html="./nav/trend_nav.html"></div>
<script>
	w3.includeHTML();
</script>

 
<div id="backtoTop" style=" position: fixed; bottom: 5px; right: 5px;">
	<a href="#header" style="color:black;"><i class="fa fa-chevron-up" style="width:50px; height:50px; font-size:35px; aria-hidden="true">
		</i>
	</a>
</div>

<!-- 
<div class="text-right">
<a class="btn btn-primary" href="/templates/featured">
                Show 200 more featured templates
            </a>
</div>
 -->
 
 </div>
</div>

</main> 

<script src="https://www.velosofy.com/js/app.js"></script>

	<jsp:include page="visitor_count.jsp" flush="true"/>

</body>
</html>
