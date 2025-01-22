<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<style>
    
  .ui-accordion .ui-accordion-content {
	overflow: hidden;
  }  
  .text {
  	height:18px;
  	margin-top:0px;
  	font-size:1.2em; 
  }
  
  #body .button {
  	vertical-align: top;
  }
  #body .textarea {
  	width:595px;
  	height:300px;
  	font-size:1em;
  	font-family: Verdana,Arial,sans-serif;
  	color:#222222;
  }
  #body .tdContent{
  	width:600px;
  	vertical-align: top;
  }
  
  #divVisualD3{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }  
  
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-bodyTopVW.jspf" %>
<!-- 본문영역 (시작) -->
<table style="width:1230px;margin:0px;padding:0px;" border="0">
	<tbody>
		<tr>
			<td class="tdContent" colspan="3">	
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">Network</a></li>
						<li><a href="#tabs-2">Treemap</a></li>
						<li><a href="#tabs-3">Word Cloud</a></li>
						<li><a href="#tabs-4">Pie</a></li>
					</ul>
					<div id="tabs-1"><iframe id="frameView1" src="<c:url value='/visual/openVwMainSub01.do?DATA_ID=A02'/>" frameborder="0" width="100%" height="700px" marginwidth="0" marginheight="0">이 브라우저는 iframe을 지원하지 않습니다.</iframe></div>
					<div id="tabs-2"><iframe id="frameView2" src="<c:url value='/visual/openVwMainSub01.do?DATA_ID=A02'/>" frameborder="0" width="100%" height="700px" marginwidth="0" marginheight="0">이 브라우저는 iframe을 지원하지 않습니다.</iframe></div>
					<div id="tabs-3"><iframe id="frameView3" src="<c:url value='/visual/openVwMainSub01.do?DATA_ID=A02'/>" frameborder="0" width="100%" height="700px" marginwidth="0" marginheight="0">이 브라우저는 iframe을 지원하지 않습니다.</iframe></div>
					<div id="tabs-4"><iframe id="frameView4" src="<c:url value='/visual/openVwMainSub01.do?DATA_ID=A02'/>" frameborder="0" width="100%" height="700px" marginwidth="0" marginheight="0">이 브라우저는 iframe을 지원하지 않습니다.</iframe></div>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<!-- 본문영역 (끝) -->		
<%@ include file="/WEB-INF/include/include-bodyBottom.jspf" %>
<!-- 팝업DIV영역(시작) -->


<!-- 팝업DIV영역(끝) -->
<script type="text/javascript">

	$(document).ready(function(){
		
		/*** Button Style ***/
		
		$( "#tabs" ).tabs();
		
	});	
</script>
</body>
</html>