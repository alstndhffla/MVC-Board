<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<!-- JSP 표준 태그 라이브러리인 JSTL. 이를 사용하려면 taglib 태그를 이용해 톰캣에 알려줘야한다. 
	fmt(포메팅 - 지역, 메시지 형식, 숫자 및 날짜형식), core(코어 - 변수지원, 흐름 제어, 반복문 처리, URL 처리) -->    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- c:set 은 변수지정시 사용하는 JSTL의 코어 태그 라이브러리이다. -->
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!-- HashMap으로 저장해서 넘어온 값들은 이름이 길어 사용하기 불편하므로 c:set 태그를 이용해 각 값들을 짧은 변수 이름으로 저장 -->
<c:set  var="articlesList"  value="${articlesMap.articlesList}" />
<c:set  var="totArticles"  value="${articlesMap.totArticles}" />
<c:set  var="section"  value="${articlesMap.section}" />
<c:set  var="pageNum"  value="${articlesMap.pageNum}" />

<!-- 스크립틀릿(JSP에서 순수 자바코드를 사용하기 위해 사용함. -->
<%
  request.setCharacterEncoding("UTF-8");
%>

<!-- 글목록을 표시하는 JSP. <forEach>태그를 이용해 articlesList 속성으로 포워딩된 글 목록을 차례로 전달받아 표시.
	<forEach>태그 반복 시 각 글의 level 값이 1보다 크면 답글이므로 다시 내부 <forEach>태그를 이용해
	1부터 level 값까지 반복하면서 공백을 만들고(들여쓰기) 답글을 표시. 이때 level 값이 1보다 크지 않으면 부모 글이므로
	공백 없이 표시한다. -->  
	
<!DOCTYPE html>
<html>
<head>
 <style>
   .no-uline {text-decoration:none;}
   
   <!-- 선택된 페이지 번호를 빨간색으로 표시. 페이징기능 -->
   .sel-page{text-decoration:none;color:red;}	
   
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
  </style>
  <meta charset="UTF-8">
  <title>글목록창</title>
</head>
<body>
<table align="center" border="1"  width="80%"  >
  <tr height="10" align="center"  bgcolor="lightgreen">
     <td >글번호</td>
     <td >작성자</td>              
     <td >제목</td>
     <td >작성일</td>
  </tr>
<c:choose>
  <c:when test="${empty articlesList}" >
    <tr  height="10">
      <td colspan="4">
         <p align="center">
            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
        </p>
      </td>  
    </tr>
  </c:when>
  
  <c:when test="${!empty articlesList}" >  	
    <c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >			<!-- articleList로 포워딩된 글 목록을 <forEach>태그를 이용해 표시 -->
     <tr align="center">    
	<td width="5%">${articleNum.count}</td>			<!-- <forEach> 태그의 varStatus의 count 속성을 이용해 글 번호를 1부터 자동으로 표시 -->
	<td width="10%">${article.id }</td>
	<td align='left'  width="35%">
	    <span style="padding-right:30px"></span>			<!-- 왼쪽으로 30px만큼 여백을 준 후 글 제목을 표시 --> 
	   <c:choose>
	      <c:when test='${article.level > 1 }'>			<!-- level 값이 1보다 큰 경우는 자식 글이므로 level 값만큼 부모 글 밑에 공백으로 들여쓰기하여 자식 글임을 표시 -->
	         <c:forEach begin="1" end="${article.level }" step="1">			<!-- 부모 글 기준으로 왼쪽 여백을 level 값만큼 채워 답글을 부모 글에 대해 들여쓰기 -->
	             <span style="padding-left:10px"></span> 
	         </c:forEach>
	         <span style="font-size:12px;">[답변]</span>
                   <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>	<!-- 공백 다음에 자식 글을 표시 -->
	          </c:when>
	          <c:otherwise>
	            <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
	          </c:otherwise>
	        </c:choose>
	  </td>
	  <td  width="10%"><fmt:formatDate value="${article.writeDate}" /></td> 
	</tr>
    </c:forEach>
     </c:when>
    </c:choose>
</table>

<div class="cls2">
 <c:if test="${totArticles != null }" >		<!-- 전체 글 수에 따라 페이징 표시를 다르게 한다. -->
      <c:choose>
        <c:when test="${totArticles >100 }">  <!-- 전체 글 수가 100보다 클 때 -->
	      <c:forEach   var="page" begin="1" end="10" step="1" >
	      
	      	<!-- 섹션 값 2부터는 앞 섹션으로 이동할 수 있는 pre를 표시 -->
	         <c:if test="${section >1 && page==1 }">
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp; pre </a>
	         </c:if>
	         
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
	         
	         <!-- 페이지 번호 10 오른쪽에는 다음 섹션으로 이동할 수 있는 next를 표시 -->
	         <c:if test="${page ==10 }">
	          <a class="no-uline" href="${contextPath }/board/listArticles.do?section=${section+1}&pageNum=${section*10+1}">&nbsp; next</a>
	         </c:if>
	         
	      </c:forEach>
        </c:when>
        
        <c:when test="${totArticles ==100 }" >  <!-- 전체 글 수가 100개일 때는 첫번째 섹션의 10개 페이지만 표시하면 된다.  -->
	      <c:forEach   var="page" begin="1" end="10" step="1" >
	        <a class="no-uline"  href="#">${page } </a>
	      </c:forEach>
        </c:when>
        
        <c:when test="${totArticles< 100 }" >   <!-- 전체 글 수가 100개보다 적을 때 페이징을 표시한다. -->
	      <!-- 글 수가 100개가 되지 않으므로 표시되는 페이지는 10개가 되지 않고, 전체 글 수를 10으로 나누어 구한 몫에 1을 더한 페이지까지 표시된다. -->
	      <c:forEach   var="page" begin="1" end="${totArticles/10 +1}" step="1" >
	         <c:choose>
	         
	         <!-- 페이지 번호와 컨트롤러에서 넘어온 pageNum 이 같은 경우 페이지 번호를 빨간색으로 표시하여 현재 사용자가 보고 있는 페이지임을 알린다. -->
	           <c:when test="${page==pageNum }">
	            <a class="sel-page"  href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
	          </c:when>
	          
	          <c:otherwise>
	          	<!-- 페이지 번호를 클릭하면 section 값과 pageNum 값을 컨트롤러에 전송한다. -->
	            <a class="no-uline"  href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
	          </c:otherwise>
	        </c:choose>
	      </c:forEach>
        </c:when>
      </c:choose>
    </c:if>
</div>    
<br><br>
<a  class="cls1"  href="${contextPath}/board/articleForm.do"><p class="cls2">글쓰기</p></a>
</body>
</html>