<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 설정하기(API) -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<style>

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
    
  #divProjectPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }  
  
  .ui-accordion .ui-accordion-content {
	overflow: hidden;
  }
  
  
  #divJobPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }
  
  #divSrcProPop{
  	display:none;
  }

  #divSrcProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divSrcProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divSrcProPop .inputLabel2{
  	display:inline-block;
  	text-align:center;
  }
 
  #divSrcProPop .inputText{
  	height:20px;
  }
      
  #divInpProPop{
  	display:none;
  }
  #divInpProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divInpProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }  
  
  #divInpProPop .inputText{
  	height:20px;
  }  
  
  #divOupProPop{
  	display:none;
  }
  #divOupProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divOupProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }  
  
  #divOupProPop .inputText{
  	height:20px;
  }
    
  .text {
  	height:18px;
  	margin-top:0px;
  	font-size:1.2em; 
  }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-bodyTopDS.jspf" %>
<!-- 본문영역 (시작) -->
<table style="width:1230px;margin:0px;padding:0px;" border="0">
	<tbody>
		<tr>
			<td class="tdContent">			
				<div id="divProjectPro">
					<h3>프로젝트</h3>
					<div><span class="inputLabel">프로젝트ID</span>
					<input id="txtProjId" type="text" class="text" style="width:100px;margin-left:10px;text-align: center;margin-top:2px;" disabled="disabled" spellcheck='false' >
					<input id="txtProjNm" type="text" class="text" style="width:250px;margin-left:5px;margin-top:2px;" disabled="disabled" spellcheck='false' >
					<button id="goProjPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">...</button></div>
				</div>
			</td>
			<td></td>
			<td class="tdContent">
				<div id="divJobPro">
					<h3>작업</h3>
					<div><span class="inputLabel">작업ID</span>
					<input id="txtJobId" type="text" class="text" style="width:100px;margin-left:10px;text-align: center;margin-top:0px;" disabled="disabled" spellcheck='false' >
					<input id="txtJobNm" type="text" class="text" style="width:250px;margin-left:5px;margin-top:2px;" disabled="disabled" spellcheck='false' >
					<button id="goJobPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">...</button>
					<button id="goTempJobPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">복제</button></div>
				</div>
			</td>
		</tr>	
		<tr>
			<td class="tdContent" colspan="3">
				<table id="tabSource"></table>
			</td>			
		</tr>
		<tr>
			<td class="tdContent" style="line-height:2.8;" colspan="3">
				<button id="goSrcNew" class="button" style="width:70px;">등록</button>
				<button id="goSrcDel" class="button" style="width:70px;">삭제</button>
				<button id="goSrcCopy" class="button" style="width:70px;">복제</button>
			</td>			
		</tr>
		<tr>
			<td class="tdContent">
				<table id="tabInput"></table>
			</td>
			<td></td>
			<td class="tdContent">
				<table id="tabOutput"></table>
			</td>			
		</tr>
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goInpNew" class="button" style="width:70px;">등록</button>
				<button id="goInpDel" class="button" style="width:70px;">삭제</button>
			</td>
			<td></td>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goOupNew" class="button" style="width:70px;">등록</button>
				<button id="goOupDel" class="button" style="width:70px;">삭제</button>
			</td>			
		</tr>		
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<input id="txtInputValOrg" type="text" class="text" style="width:545px;" spellcheck='false' ></input><button id="goInpList" class="button" style="width:50px;">목록</button>
				<input id="txtInputVal" type="text" class="text" style="width:545px;" spellcheck='false' ></input><button id="goApply" class="button" style="width:50px;">적용</button>
			</td>
			<td></td>
			<td class="tdContent" style="line-height:2.8;">
				<input id="txtUrl" type="text" class="text" style="width:420px;" spellcheck='false' ></input><button id="goApi" class="button" style="width:50px;">검증</button><button id="goApiView" class="button" style="width:50px;">원문</button>
				<button id="goRunApiSave" class="button" style="width:70px;">수집하기</button>
				<button id="exportFileBtn" class="button" style="width:70px;">파일생성</button>
			</td>
		</tr>
		<tr>
			<td class="tdContent">
				<table id="tabRunInput"></table>
			</td>
			<td></td>
			<td class="tdContent">
				<textarea id="txtPageSource" spellcheck='false' class="textarea"></textarea>
			</td>
		</tr>
	</tbody>
</table>
<!-- 본문영역 (끝) -->		
<%@ include file="/WEB-INF/include/include-bodyBottom.jspf" %>

<!-- 팝업DIV영역(시작) -->

<div id="divProjPop" title="프로젝트 선택" >
	<table id="tabProject"></table>
</div>
<div id="divJobPop" title="작업 선택" >
	<table id="tabJob"></table>
</div>
<div id="divTempInpValPop" title="복수 입력값 선택" >
	<table id="tabTempInpVal"></table>
</div>

<div id="divTempJobPop" title="복제대상 작업 선택" >
	<table id="tabTempJob"></table>
</div>

<div id="divCopySrcPop" title="복제대상 소스 선택" >
	<table id="tabCopySrc"></table>
</div>

<div id="divSrcProPop" title="소스 속성정보" style="line-height:2.8;">
<span class="inputLabel">프로젝트ID(*)</span><input id="txtSrcProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">작업ID(*)</span><input id="txtSrcProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스ID(*)</span><input id="txtSrcProSrcId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스명(*)</span><input id="txtSrcProSrcNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">소스(*)</span><input id="txtSrcProSrcVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">단일소스여부(*)</span><select id="selSrcProSrcDivCd" ><option value="SURL">단일소스</option><option value="MURL">복수소스</option></select>
<br/><span class="inputLabel">소스참조구분(*)</span><select id="selSrcProSrcTypCd" ><option value="INPUT">직접입력</option><option value="TABLE">API 수집DB</option></select>
<br/><span class="inputLabel">인코딩유형(*)</span><input id="txtSrcProSrcEncode" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">UTF-8,EUC-KR</span>

<br/><span class="inputLabel">호출방법(*)</span><select id="selSrcProMethod" ><option value="GET">GET</option><option value="POST">POST</option><option value="GET_POST">GET/POST</option></select>
<br/><span class="inputLabel">인증여부(*)</span><select id="selSrcProAuthYn" ><option value="Y">인증사용</option><option value="N">인증생략</option></select>
<br/><span class="inputLabel">출력양식(*)</span><select id="selSrcProOutFmt" ><option value="JSON">JSON</option><option value="XML">XML</option></select>
<br/><span class="inputLabel">XML Prefix</span><input id="txtSrcProXmlPrefix" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">XML Prefix</span>
<br/><span class="inputLabel">XML NamespaceURI</span><input id="txtSrcProXmlNamespaceuri" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">XML NamespaceURI</span>
<br/><span class="inputLabel">수집지연시간</span><input id="txtSrcProDelayTime" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">1000=1초</span>
<br/><span class="inputLabel">출력순서(*)</span><input id="txtSrcProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수를 입력하세요.</span>


<div id="divSrcProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanSrcProMsg"></span></p>
	</div>
</div>
</div>
</div>

<div id="divInpProPop" title="입력항목 속성정보" style="line-height:2.8;">
<span class="inputLabel">프로젝트ID(*)</span><input id="txtInpProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">작업ID(*)</span><input id="txtInpProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스ID(*)</span><input id="txtInpProSrcId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">입력ID(*)</span><input id="txtInpProInpId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">입력항목유형(*)</span><select id="selInpProInpType" style="width:350px;"><option value="URL">웹주소 파라미터</option><option value="REQ">서버요청 파라미터</option></select>
<br/><span class="inputLabel">입력항목명(*)</span><input id="txtInpProInpNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">입력항목키(*)</span><input id="txtInpProInpKey" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">입력값</span><input id="txtInpProInpVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">값유형</span><select id="selInpProPrmType" style="width:350px;"><option value="FIX_SING">단일 고정값</option><option value="FIX_MULT">복수 고정값</option><option value="DB_MULT">복수 DB값</option><option value="ADJ_LOOP">가변 반복값</option></select>
<br/><span class="inputLabel">구분자</span><input id="txtInpProPrmDlm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">복수 고정값일때 구분자</span>
<br/><span class="inputLabel">시작값</span><input id="txtInpProStrNum" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">가변 반복값일때 시작값</span>
<br/><span class="inputLabel">증가값</span><input id="txtInpProIncNum" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">가변 반복값일때 증가값</span>
<br/><span class="inputLabel">인코딩</span><input id="txtInpProInpEncode" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">UTF8 or Empty</span>
<br/><span class="inputLabel">사용여부</span><select id="selInpProUseYn" style="width:350px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">출력순서</span><input id="txtInpProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수를 입력하세요.</span>
<div id="divInpProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanInpProMsg"></span></p>
	</div>
</div>
</div>
</div>

<div id="divOupProPop" title="출력항목 속성정보" style="line-height:2.8;">
<span class="inputLabel">프로젝트ID(*)</span><input id="txtOupProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">작업ID(*)</span><input id="txtOupProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스ID(*)</span><input id="txtOupProSrcId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">출력ID(*)</span><input id="txtOupProOupId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">출력항목명(*)</span><input id="txtOupProOupNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">출력항목키(*)</span><input id="txtOupProOupKey" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">출력레벨(*)</span><select id="selOupProOupDiv" style="width:350px;"><option value="ROOT">요약정보</option><option value="LIST">목록정보</option><option value="ITEMKEY">항목키</option></select>
<br/><span class="inputLabel">출력값유형(*)</span><select id="selOupProOupType" style="width:350px;"><option value="NODE">노드</option><option value="NODESET">노드집합</option><option value="TIME_URL">임시URL</option><option value="BASE_URL">기본URL</option><option value="STRING">문자값</option><option value="NUMBER">숫자값</option><option value="DATE">날짜</option><option value="DATETIME">시간</option></select>
<br/><span class="inputLabel">출력명령문</span><input id="txtOupProOupExp" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">XML추출식</span>
<br/><span class="inputLabel">설명</span><input id="txtOupProOupDesc" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">사용여부</span><select id="selOupProUseYn" style="width:350px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">출력순서</span><input id="txtOupProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수를 입력하세요.</span>
<div id="divOupProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanOupProMsg"></span></p>
	</div>
</div>
</div>
</div>

<!-- 팝업DIV영역(끝) -->

<script type="text/javascript">
	var rowNum = 10;
	var _projRowId = '';
	var _jobRowId = '';
	var _srcRowId = '';
	var _inpRowId = '';
	var _oupRowId = '';
	var _inpValRowId = '';
	var _srcViewRowId = '';
	var _regexViewF1RowId = '';
	var _regexViewR1RowId = '';
	var _projId = '';
	var _jobId = '';
	var _srcId = '';
	var _tempJobRowId = '';
	var _tempUsrId = '';
	var _tempProjId = '';
	var _tempJobId = '';
	var _tempSrcId = '';
	var _copySrcRowId = '';
	var _tempInpValRowId = '';
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#goSrcNew" ).button();
		$( "#goSrcDel" ).button();
		$( "#goSrcCopy" ).button();
		$( "#goInpNew" ).button();
		$( "#goInpDel" ).button();
		$( "#goOupNew" ).button();
		$( "#goOupDel" ).button();
		
		$("#goProjPop").button();
		$("#goJobPop").button();
		$("#goTempJobPop").button();
		
		$( "#goInpList" ).button();
		$( "#goApply" ).button();
		$( "#goApi" ).button();
		$( "#goApiView" ).button();
		$( "#goRunApiSave" ).button();
		$( "#exportFileBtn" ).button();

		$( "#divProjectPro" ).accordion();
		$( "#divJobPro" ).accordion();
		
		//var htmlInpProInpType = '<select id="selInpProInpType"><option value="URL" selected="selected">URL</option><option value="REQUEST">REQUEST</option></select>';
		//$("#divInpProInpType").html(htmlInpProInpType);
		
		/*** Source properties Poupup ***/
		$( "#divSrcProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveSrcInfo();
						//$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			],
			open: function( event, ui ) {
				// ★ 중요 ★ dialog 팝업 div에서 jquery ui에서 사용하는 selectmenu를 사용할때.. 뒤로 숨기는 현상 해결을 위해서
				// dialog 를 open한 이후에 selectmenu를 재호출한다. 이때, 기본 선택값은 다시 지정한다.
				var srcDivCd = 'SURL';
				if(_srcRowId != ''){srcDivCd = $("#tabSource").jqGrid ('getCell', _srcRowId, 'SRC_DIV_CD');}
				$("#selSrcProSrcDivCd").selectmenu();
				$("#selSrcProSrcDivCd").val(srcDivCd);
				$('#selSrcProSrcDivCd').selectmenu('refresh', true);
				
				var srcTypCd = 'INPUT';
				if(_srcRowId != ''){srcTypCd = $("#tabSource").jqGrid ('getCell', _srcRowId, 'SRC_TYP_CD');}
				$("#selSrcProSrcTypCd").selectmenu();
				$("#selSrcProSrcTypCd").val(srcTypCd);
				$('#selSrcProSrcTypCd').selectmenu('refresh', true);
				
				var method = 'GET';
				if(_srcRowId != ''){method = $("#tabSource").jqGrid ('getCell', _srcRowId, 'METHOD');}
				$("#selSrcProMethod").selectmenu();
				$("#selSrcProMethod").val(method);
				$('#selSrcProMethod').selectmenu('refresh', true);
				
				var authYn = 'N';
				if(_srcRowId != ''){authYn = $("#tabSource").jqGrid ('getCell', _srcRowId, 'AUTH_YN');}
				$("#selSrcProAuthYn").selectmenu();
				$("#selSrcProAuthYn").val(authYn);
				$('#selSrcProAuthYn').selectmenu('refresh', true);
				
				var outFmt = 'XML';
				if(_srcRowId != ''){outFmt = $("#tabSource").jqGrid ('getCell', _srcRowId, 'OUT_FMT');}
				$("#selSrcProOutFmt").selectmenu();
				$("#selSrcProOutFmt").val(outFmt);
				$('#selSrcProOutFmt').selectmenu('refresh', true);
			}
		});	
		
		/*** API Input properties Poupup ***/
		$( "#divInpProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveInpInfo();
						//$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			],
			open: function( event, ui ) {
				// ★ 중요 ★ dialog 팝업 div에서 jquery ui에서 사용하는 selectmenu를 사용할때.. 뒤로 숨기는 현상 해결을 위해서
				// dialog 를 open한 이후에 selectmenu를 재호출한다. 이때, 기본 선택값은 다시 지정한다.
				var inpType = 'URL';
				if(_inpRowId != ''){inpType = $("#tabInput").jqGrid ('getCell', _inpRowId, 'INP_TYPE');}
				$("#selInpProInpType").selectmenu();
				$("#selInpProInpType").val(inpType);
				$('#selInpProInpType').selectmenu('refresh', true);
				
				var prmType = 'FIX_SING';
				if(_inpRowId != ''){prmType = $("#tabInput").jqGrid ('getCell', _inpRowId, 'PRM_TYPE');}
				$("#selInpProPrmType").selectmenu();
				$("#selInpProPrmType").val(prmType);
				$('#selInpProPrmType').selectmenu('refresh', true);
				
				var useYn = 'Y';
				if(_inpRowId != ''){useYn = $("#tabInput").jqGrid ('getCell', _inpRowId, 'USE_YN');}
				$("#selInpProUseYn").selectmenu();
				$("#selInpProUseYn").val(useYn);
				$('#selInpProUseYn').selectmenu('refresh', true);
			}
		});	
		
		/*** API Output properties Poupup ***/
		$( "#divOupProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveOupInfo();
						//$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			],
			open: function( event, ui ) {
				// ★ 중요 ★ dialog 팝업 div에서 jquery ui에서 사용하는 selectmenu를 사용할때.. 뒤로 숨기는 현상 해결을 위해서
				// dialog 를 open한 이후에 selectmenu를 재호출한다. 이때, 기본 선택값은 다시 지정한다.
				var oupDiv = 'ITEMKEY';
				if(_oupRowId != ''){oupDiv = $("#tabOutput").jqGrid ('getCell', _oupRowId, 'OUP_DIV');}
				$("#selOupProOupDiv").selectmenu();
				$("#selOupProOupDiv").val(oupDiv);
				$('#selOupProOupDiv').selectmenu('refresh', true);
				
				var oupType = 'STRING';
				if(_oupRowId != ''){oupType = $("#tabOutput").jqGrid ('getCell', _oupRowId, 'OUP_TYPE');}
				$("#selOupProOupType").selectmenu();
				$("#selOupProOupType").val(oupType);
				$('#selOupProOupType').selectmenu('refresh', true);
				
				var useYn = 'Y';
				if(_oupRowId != ''){useYn = $("#tabOutput").jqGrid ('getCell', _oupRowId, 'USE_YN');}
				$("#selOupProUseYn").selectmenu();
				$("#selOupProUseYn").val(useYn);
				$('#selOupProUseYn').selectmenu('refresh', true);
			}
		});			
		

		
		/*** Selected Project Poupup ***/
		$( "#divProjPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 625,
			buttons: [
				{
					text: "확인",
					click: function() {
						fn_setProjPro();
						$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});	
		
		/*** Selected Job Poupup ***/
		$( "#divJobPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "확인",
					click: function() {
						fn_setJobPro();
						$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		/*** Selected Template Job Poupup ***/
		$( "#divTempInpValPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 875,
			buttons: [
				{
					text: "적용",
					click: function() {
						_alert('cfm','','fn_setTempInpValPro');
						$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		/*** Selected Template Job Poupup ***/
		$( "#divTempJobPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "적용",
					click: function() {
						_alert('cfm','','fn_setTempJobPro');
						$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		/*** Selected Copy Source Poupup ***/
		$( "#divCopySrcPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "적용",
					click: function() {
						_alert('cfm','','fn_setCopySrcPro');
						$( this ).dialog( "close" );
					}
				},
				{
					text: "취소",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		
		$("#divProjPop" ).dialog( "close" );
		$("#divJobPop" ).dialog( "close" );
		$("#divTempInpValPop" ).dialog( "close" );
		$("#divTempJobPop" ).dialog( "close" );
		$("#divCopySrcPop" ).dialog( "close" );
		
		$( "#divSrcProPop" ).dialog( "close" );
		$( "#divInpProPop" ).dialog( "close" );
		$( "#divOupProPop" ).dialog( "close" );
		
		/*** Project Grid ***/
		var tabProj = $("#tabProject");
		tabProj.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['프로젝트ID','프로젝트명'],
		   	colModel:[
		   		{name:'PROJ_ID',index:'PROJ_ID', width:50, align:'center'},
		   		{name:'PROJ_NM',index:'PROJ_NM', width:300}		   		
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: false,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:false,
		   	loadtext:"Loading...",
		   	caption: "프로젝트"
		});
		
		tabProj.jqGrid('setGridParam', 
				{gridComplete: gridCompleteProj()});
		tabProj.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_projRowId = rowId;
				}});
		tabProj.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_setProjPro(rowId);
					$( "#divProjPop" ).dialog( "close" );
					event.preventDefault();					
				}});
	
		/*** Job Grid ***/
		var tabJob = $("#tabJob");
		tabJob.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['작업ID','작업명'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:50, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:150}		   		
		   	],
		   	//rowNum:rowNum,
			width:450,
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: false,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:false,
		   	loadtext:"Loading...",
		   	caption: "작업"
		});
		
		tabJob.jqGrid('setGridParam', 
				{gridComplete: gridCompleteJob()});
		tabJob.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_jobRowId = rowId;
				}});
		tabJob.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_setJobPro(rowId);
					$( "#divJobPop" ).dialog( "close" );
					event.preventDefault();					
				}});
		
		/*** Temp Job Grid ***/
		var tabTempJob = $("#tabTempJob");
		tabTempJob.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['프로젝트ID','프로젝트명','작업ID','작업명','사용자ID'],
		   	colModel:[
				{name:'PROJ_ID',index:'PROJ_ID', width:50, align:'center', hidden:true},
				{name:'PROJ_NM',index:'PROJ_NM', width:50, align:'center', hidden:true},
		   		{name:'JOB_ID',index:'JOB_ID', width:50, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:200},
		   		{name:'USR_ID',index:'USR_ID',hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:450,
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: false,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:false,
		   	loadtext:"Loading...",
		   	caption: "작업"
		});
		
		tabTempJob.jqGrid('setGridParam', 
				{gridComplete: gridCompleteTempJob()});
		tabTempJob.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_tempJobRowId = rowId;
				}});
		
		/*** Copy Source Grid ***/
		var tabCopySrc = $("#tabCopySrc");
		tabCopySrc.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['프로젝트ID','작업ID','소스ID','소스명','사용자ID'],
		   	colModel:[
				{name:'PROJ_ID',index:'PROJ_ID', width:50, align:'center', hidden:true},
		   		{name:'JOB_ID',index:'JOB_ID', width:50, align:'center', hidden:true},
		   		{name:'SRC_ID',index:'SRC_ID', width:50, align:'center'},
		   		{name:'SRC_NM',index:'SRC_NM', width:200},
		   		{name:'USR_ID',index:'USR_ID',hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:450,
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: false,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:false,
		   	loadtext:"Loading...",
		   	caption: "소스"
		});
		
		tabCopySrc.jqGrid('setGridParam', 
				{gridComplete: gridCompleteCopySrc()});
		tabCopySrc.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_copySrcRowId = rowId;
				}});
		
		/*** Source Grid ***/
		var tabSrc = $("#tabSource");
		tabSrc.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['소스ID','소스명', '소스', '호출방법', '인증여부', '출력양식', '지연시간', 'Prefix', 'NameSspace', 'ProjId', 'JobId', 'SrcDivCd', 'SrcTypCd', 'SrcEncode', 'SrcValPostion', 'DispOrd'],
		   	colModel:[
		   		{name:'SRC_ID',index:'SRC_ID', width:50, align:'center'},
		   		{name:'SRC_NM',index:'SRC_NM', width:150},
		   		{name:'SRC_VAL',index:'SRC_VAL', width:400},
		   		{name:'METHOD',index:'METHOD', width:30, align:'center'},	
		   		{name:'AUTH_YN',index:'AUTH_YN', width:30, align:'center'},	
		   		{name:'OUT_FMT',index:'OUT_FMT', width:30, align:'center'},
		   		{name:'DELAY_TIME',index:'DELAY_TIME', width:30, align:'right'},
		   		{name:'XML_PREFIX',index:'XML_PREFIX', width:30, hidden: true},
		   		{name:'XML_NAMESPACEURI',index:'XML_NAMESPACEURI', width:100, hidden: true},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'JOB_ID',index:'JOB_ID', hidden: true},	
		   		{name:'SRC_DIV_CD',index:'SRC_DIV_CD', hidden: true},	
		   		{name:'SRC_TYP_CD',index:'SRC_TYP_CD', hidden: true},
		   		{name:'SRC_ENCODE',index:'SRC_ENCODE', hidden: true},
		   		{name:'SRC_VAL_POSITION',index:'SRC_VAL_POSITION', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:1230,
			height:100,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "소스"
		});
		
		tabSrc.jqGrid('setGridParam', 
				{gridComplete: gridCompleteSrc()});
		
		tabSrc.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_srcRowId = rowId;
					fn_setSrcPro(rowId);			        
			        fn_selectInpList();
			        fn_selectOupList();
				}});
		
		tabSrc.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
			        $("#spanSrcProMsg").text("");
					$("#divSrcProMsg").css("display", "none");
			        $( "#divSrcProPop" ).dialog( "open" );
					event.preventDefault();
				}});
			
	
		/*** API Input Grid ***/
		var tabInp = $("#tabInput");	
		tabInp.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['입력ID','입력항목유형','입력항목명','입력항목키', '입력값', '시작값','증가값', 'Type', 'Dlm','Encode', 'UseYn', 'ProjId', 'JobId', 'SrcId','DispOrd'],
		   	colModel:[
		   		{name:'INP_ID',index:'INP_ID', width:60, align:'center'},
		   		{name:'INP_TYPE',index:'INP_TYPE', width:50, align:'center'},
		   		{name:'INP_NM',index:'INP_NM', width:100},
		   		{name:'INP_KEY',index:'INP_KEY', width:150},
		   		{name:'INP_VAL',index:'INP_VAL', width:150},
		   		{name:'STR_NUM',index:'STR_NUM', width:50, align:'center'},
		   		{name:'INC_NUM',index:'INC_NUM', width:50, align:'center'},
		   		{name:'PRM_TYPE',index:'PRM_TYPE', width:70, align:'center', hidden: true},
		   		{name:'PRM_DLM',index:'PRM_DLM', width:50, align:'center', hidden: true},
		   		{name:'INP_ENCODE',index:'INP_ENCODE', width:50, align:'center', hidden: true},
		   		{name:'USE_YN',index:'USE_YN', hidden: true},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'JOB_ID',index:'JOB_ID', hidden: true},
		   		{name:'SRC_ID',index:'SRC_ID', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:156,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "입력항목"
		});
		
		tabInp.jqGrid('setGridParam', 
				{gridComplete: gridCompleteInp()});
		
		tabInp.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_inpRowId = rowId;
					fn_setInpPro(rowId);
				}});
		tabInp.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanInpProMsg").text("");
					$("#divInpProMsg").css("display", "none");					
					$( "#divInpProPop" ).dialog( "open" );
					event.preventDefault();
				}});
		
		/*** Temp Job Grid ***/
		var tabTempInpVal = $("#tabTempInpVal");
		tabTempInpVal.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['No','URL'],
		   	colModel:[
				{name:'ROW_NUM',index:'ROW_NUM', width:50, align:'center'},
				{name:'INP_VAL',index:'INP_VAL', width:800, align:'left'}
		   	],
		   	//rowNum:rowNum,
			width:850,
			height:450,//"100%",
			hidegrid : false,
		   	viewrecords: false,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:false,
		   	loadtext:"Loading...",
		   	caption: "복수입력값"
		});
		
		tabTempInpVal.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_tempInpValRowId = rowId;
				}});
		tabTempInpVal.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_applyTempInpval(rowId);
					$( "#divTempInpValPop" ).dialog( "close" );
					event.preventDefault();					
				}});
		
		/*** API Output Grid ***/
		var tabOup = $("#tabOutput");	
		tabOup.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['출력ID','출력항목명', '출력항목키', '출력레벨', '출력값유형', 'Exp', 'Desc', 'UseYn', 'ProjId', 'JobId', 'SrcId','DispOrd'],
		   	colModel:[
		   		{name:'OUP_ID',index:'OUP_ID', width:40, align:'center'},
		   		{name:'OUP_NM',index:'OUP_NM', width:100},
		   		{name:'OUP_KEY',index:'OUP_KEY', width:150},
		   		{name:'OUP_DIV',index:'OUP_DIV', width:50, align:'center'},
		   		{name:'OUP_TYPE',index:'OUP_TYPE', width:50, align:'center'},
		   		{name:'OUP_EXP',index:'OUP_EXP', hidden: true},
		   		{name:'OUP_DESC',index:'OUP_DESC', hidden: true},
		   		{name:'USE_YN',index:'USE_YN', hidden: true},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'JOB_ID',index:'JOB_ID', hidden: true},
		   		{name:'SRC_ID',index:'SRC_ID', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:156,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "출력항목"
		});
		
		tabOup.jqGrid('setGridParam', 
				{gridComplete: gridCompleteOup()});
		
		tabOup.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_oupRowId = rowId;
					fn_setOupPro(rowId);
				}});
		tabOup.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanOupProMsg").text("");
					$("#divOupProMsg").css("display", "none");					
					$( "#divOupProPop" ).dialog( "open" );
					event.preventDefault();
				}});
		
		/*** API Run Input Grid ***/
		var tabRunInp = $("#tabRunInput");	
		tabRunInp.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['입력ID','입력항목키', '입력값', '적용값', 'Type', 'Encode', 'Param.Type'],
		   	colModel:[
		   		{name:'INP_ID',index:'INP_ID', width:60, align:'center'},
		   		{name:'INP_KEY',index:'INP_KEY', width:100},
		   		{name:'INP_VAL',index:'INP_VAL', width:200},
		   		{name:'INP_EVAL',index:'INP_EVAL', width:200},
		   		{name:'INP_TYPE',index:'INP_TYPE', hidden: true},
		   		{name:'INP_ENCODE',index:'INP_ENCODE', hidden: true},
		   		{name:'PRM_TYPE',index:'PRM_TYPE', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:250,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "입력값"
		});
		
		tabRunInp.jqGrid('setGridParam', 
				{gridComplete: gridCompleteRunInp()});
		tabRunInp.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_inpValRowId = rowId;
					fn_setRunInpPro(rowId);
				}});
		
		/*** Source Add Button Click ***/
		$("#goSrcNew").on("click", function(e){
			e.preventDefault();
			//
			fn_newSrcPro();
			$("#spanSrcProMsg").text("");
			$("#divSrcProMsg").css("display", "none");
			$( "#divSrcProPop" ).dialog( "open" );
		});
		
		/*** Source Del Button Click ***/
		$("#goSrcDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteSrcInfo');
		});
		
		/*** Source Copy Button Click ***/
		$("#goSrcCopy").on("click", function(e){
			e.preventDefault();
			//
			fn_selectCopySrcList();
		});		
		
		/*** API Input Add Button Click ***/
		$("#goInpNew").on("click", function(e){
			e.preventDefault();
			//
			var tabSrc = $("#tabSource");
			var srcId = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ID');
			fn_newInpPro(srcId);
			$("#spanInpProMsg").text("");
			$("#divInpProMsg").css("display", "none");
			$( "#divInpProPop" ).dialog( "open" );
		});	
		
		/*** API Input Del Button Click ***/
		$("#goInpDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteApiInputInfo');
		});
		
		/*** API Output Add Button Click ***/
		$("#goOupNew").on("click", function(e){
			e.preventDefault();
			//
			var tabSrc = $("#tabSource");
			var srcId = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ID');
			fn_newOupPro(srcId);
			$("#spanOupProMsg").text("");
			$("#divOupProMsg").css("display", "none");
			$( "#divOupProPop" ).dialog( "open" );
		});	
		
		/*** API Output Del Button Click ***/
		$("#goOupDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteApiOutputInfo');
		});
		
		/*** Select Project ***/
		$("#goProjPop").on("click", function(e){
			e.preventDefault();
			//
			$("#divProjPop" ).dialog( "open" );
		});

		/*** Select Job ***/
		$("#goJobPop").on("click", function(e){
			e.preventDefault();
			//
			$("#divJobPop" ).dialog( "open" );
		});
		
		$("#goTempJobPop").on("click", function(e){
			e.preventDefault();
			//
			/*** Template Job List ***/
			fn_selectTempJobList();
		});
		
		$("#goInpList").on("click", function(e){ //url
			e.preventDefault();
			//
			$("#divTempInpValPop" ).dialog( "open" );
		});
		$("#goApply").on("click", function(e){ //url
			e.preventDefault();
			//
			fn_GoApply();
		});
		$("#txtInputVal").keydown(function (key) {
			 
	        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	        	fn_GoApply();
	        }
	 
	    });
		
		$("#goApi").on("click", function(e){ //url
			e.preventDefault();
			//
			fn_GoApi(0);
		});	
		
		$("#goApiView").on("click", function(e){ //url
			e.preventDefault();
			//
			fn_GoApi(1);
		});
		
		$("#goRunApiSave").on("click", function(e){
			e.preventDefault();
			//
			fn_RunApiSave();
		});		

		$("#exportFileBtn").on("click", function(e){
			e.preventDefault();
			//
			var isConfirmed = confirm("설정된 정보를 다운로드하시겠습니까?");
			
			if (isConfirmed) {
				var gridDataSrc = tabSrc.jqGrid("getRowData"); // 소스 Grid
				var gridDataInp = tabInp.jqGrid("getRowData"); // 입력항목 Grid
				var gridDataOup = tabOup.jqGrid("getRowData"); // 출력항목 Grid
				
			    var jsonData = {
			        source: gridDataSrc,
			        input: gridDataInp,
			        output: gridDataOup
			    };
	
			    var jsonString = JSON.stringify(jsonData, null, 2);
	
			    var blob = new Blob([jsonString], { type: "application/json" });
				
			    /* 파일명 날짜 설정용도 */
			    var today = new Date();
			    var year = today.getFullYear();
			    var month = String(today.getMonth() + 1).padStart(2, '0');
			    var day = String(today.getDate()).padStart(2, '0');
			    var date = year + month + day;
	
			    var fileName = date + "_KOSIS데이터.json";
			    
			    if (window.navigator.msSaveOrOpenBlob) {
			        // IE 지원 (Internet Explorer에서는 msSaveBlob 사용)
			        window.navigator.msSaveOrOpenBlob(blob, fileName);
			    } else {
			        // 다른 브라우저 (Chrome, Edge, Firefox 등)
			        var url = URL.createObjectURL(blob);
			        var a = document.createElement("a");
			        a.href = url;
			        a.download = fileName;
			        a.style.display = "none"; // 화면에서 안 보이게
			        document.body.appendChild(a);
			        a.click();
			        document.body.removeChild(a);
			        URL.revokeObjectURL(url); // 메모리 정리
			    }
			}
		});		
		
		fn_init(0);
		
		/*** Select Project List ***/
		fn_selectProjList();
		
	});	
	
	function viewHtml(cellvalue, options, rowObject) {
        return "<input type='text' value='" + cellvalue + "' spellcheck='false' style='width:100%' />";
    }
	
	function viewUnHtml(cellvalue, options, cell) {
        //return $('input', cell).attr('value');
		return $('input', cell).attr('value');
    }
	
	/*** Select Target Complete ***/
	function gridCompleteProj(){
		//
	}
	
	/*** Select Job Complete ***/
	function gridCompleteJob(){
		
	}
	
	/*** Select Template Job Complete ***/
	function gridCompleteTempJob(){
		
	}	
	
	function gridCompleteCopySrc(){
		
	}
	
	/*** Select Source Complete ***/
	function gridCompleteSrc(){
		//
	}
	
	/*** Select Source View Complete ***/
	function gridCompleteSrcView(){
		//
	}	
	
	function fn_setProjPro(rowId){
		var tabProj = $("#tabProject");
		_projId = tabProj.jqGrid ('getCell', (gfn_isNull(rowId)?_projRowId:rowId), 'PROJ_ID');
		var projNm = tabProj.jqGrid ('getCell', (gfn_isNull(rowId)?_projRowId:rowId), 'PROJ_NM');

		_projRowId = rowId;
		
		$("#txtProjId").val(_projId);
		$("#txtProjNm").val(projNm);
		
		// Select Job List
		fn_selectJobList();
	}
	
	function fn_setJobPro(rowId){
		var tabJob= $("#tabJob");
		_jobId = tabJob.jqGrid ('getCell', (gfn_isNull(rowId)?_jobRowId:rowId), 'JOB_ID');
		var jobNm = tabJob.jqGrid ('getCell', (gfn_isNull(rowId)?_jobRowId:rowId), 'JOB_NM');
		
		_jobRowId = rowId;
		
		$("#txtJobId").val(_jobId);
		$("#txtJobNm").val(jobNm);
		
		/*** Select Source List ***/		
		fn_selectSrcList();
	}
	
	function fn_setTempInpValPro(rowId){
		var tabTempInpVal= $("#tabTempInpVal");
		var inpVal = tabTempInpVal.jqGrid ('getCell', (gfn_isNull(rowId)?_tempInpValRowId:rowId), 'INP_VAL');
		
		_tempInpValRowId = rowId;
		
		fn_applyTempInpval(rowId);
	}
	
	function fn_setTempJobPro(rowId){
		var tabTempJob= $("#tabTempJob");
		_tempUsrId = tabTempJob.jqGrid ('getCell', (gfn_isNull(rowId)?_tempJobRowId:rowId), 'USR_ID');
		_tempProjId = tabTempJob.jqGrid ('getCell', (gfn_isNull(rowId)?_tempJobRowId:rowId), 'PROJ_ID');
		_tempJobId = tabTempJob.jqGrid ('getCell', (gfn_isNull(rowId)?_tempJobRowId:rowId), 'JOB_ID');
		var jobNm = tabTempJob.jqGrid ('getCell', (gfn_isNull(rowId)?_tempJobRowId:rowId), 'JOB_NM');
		
		_tempJobRowId = rowId;
		
		/*** Template job apply ***/		
		fn_applyTempJob();
	}
	
	function fn_setCopySrcPro(rowId){
		var tabCopySrc= $("#tabCopySrc");
		_tempUsrId = tabCopySrc.jqGrid ('getCell', (gfn_isNull(rowId)?_copySrcRowId:rowId), 'USR_ID');
		_tempProjId = tabCopySrc.jqGrid ('getCell', (gfn_isNull(rowId)?_copySrcRowId:rowId), 'PROJ_ID');
		_tempJobId = tabCopySrc.jqGrid ('getCell', (gfn_isNull(rowId)?_copySrcRowId:rowId), 'JOB_ID');
		_tempSrcId = tabCopySrc.jqGrid ('getCell', (gfn_isNull(rowId)?_copySrcRowId:rowId), 'SRC_ID');
		
		_copySrcRowId = rowId;
		
		/*** Apply job apply ***/		
		fn_applyCopySrc();
	}
	
	/*** Setting Update Source Properties ***/
	function fn_setSrcPro(rowId){
		
		var tabSrc = $("#tabSource");
		
		var projId = tabSrc.jqGrid ('getCell', rowId, 'PROJ_ID');
		var jobId = tabSrc.jqGrid ('getCell', rowId, 'JOB_ID');
        var srcId = tabSrc.jqGrid ('getCell', rowId, 'SRC_ID');
        _srcId = srcId;
        var srcNm = tabSrc.jqGrid ('getCell', rowId, 'SRC_NM');
        var srcVal = tabSrc.jqGrid ('getCell', rowId, 'SRC_VAL');
        var srcDivCd = tabSrc.jqGrid ('getCell', rowId, 'SRC_DIV_CD');
        var srcTypCd = tabSrc.jqGrid ('getCell', rowId, 'SRC_TYP_CD');
        var srcEncode = tabSrc.jqGrid ('getCell', rowId, 'SRC_ENCODE');
        var srcValPosition = tabSrc.jqGrid ('getCell', rowId, 'SRC_VAL_POSITION');
        
        var method = tabSrc.jqGrid ('getCell', rowId, 'METHOD');
        var authYn = tabSrc.jqGrid ('getCell', rowId, 'AUTH_YN');
        var outFmt = tabSrc.jqGrid ('getCell', rowId, 'OUT_FMT');
        var xmlPrefix = tabSrc.jqGrid ('getCell', rowId, 'XML_PREFIX');
        var xmlNamespaceuri = tabSrc.jqGrid ('getCell', rowId, 'XML_NAMESPACEURI');
        var delayTime = tabSrc.jqGrid ('getCell', rowId, 'DELAY_TIME');
        
        var dispOrd = tabSrc.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtSrcProProjId").val(projId);
        $("#txtSrcProJobId").val(jobId);
        $("#txtSrcProSrcId").val(srcId);
        $("#txtSrcProSrcNm").val(srcNm);			        
        $("#txtSrcProSrcVal").val(srcVal);
        $("#selSrcProSrcDivCd").val(srcDivCd);
        $("#selSrcProSrcTypCd").val(srcTypCd);
        $("#txtSrcProSrcEncode").val(srcEncode);
        //$("#txtSrcProSrcValPosition").val(srcValPosition);
        
        $("#selSrcProMethod").val(method);
        $("#selSrcProAuthYn").val(authYn);
        $("#selSrcProOutFmt").val(outFmt);
        $("#txtSrcProXmlPrefix").val(xmlPrefix);
        $("#txtSrcProXmlNamespaceuri").val(xmlNamespaceuri);
        $("#txtSrcProDelayTime").val(delayTime);        
        
        $("#txtSrcProDispOrd").val(dispOrd);

        $("#txtInputValOrg").val('');
        $("#txtInputVal").val('');
      	$("#txtUrl").val('');
        fn_selectExeItemVal(srcTypCd, srcVal, -1);
        $("#txtPageSource").val('');
        $("#txtRegexResult").val('');
        
	}	
	
	/*** Setting New Source Properties ***/
	function fn_newSrcPro(){
        
		_srcRowId = '';
		
		$("#txtSrcProProjId").val(_projId);
        $("#txtSrcProJobId").val(_jobId);
        $("#txtSrcProSrcId").val("New");
        $("#txtSrcProSrcNm").val('');			        
        $("#txtSrcProSrcVal").val('');
        $("#selSrcProSrcDivCd").val('SURL');
        $("#selSrcProSrcTypCd").val('INPUT');
        $("#txtSrcProSrcEncode").val('UTF-8');
        //$("#txtSrcProSrcValPosition").val(srcValPosition);
        $("#selSrcProMethod").val('GET');
        $("#selSrcProAuthYn").val('N');
        $("#selSrcProOutFmt").val('XML');
        $("#txtSrcProXmlPrefix").val('');
        $("#txtSrcProXmlNamespaceuri").val('');
        $("#txtSrcProDelayTime").val('0');
        $("#txtSrcProDispOrd").val('');        
	}	
	
	/*** Setting Source View Properties ***/
	function fn_setSrcViewPro(rowId){
		var tabSrcView = $("#tabSourceView");
		var itemVal = tabSrcView.jqGrid ('getCell', (gfn_isNull(rowId)?_srcViewRowId:rowId), 'ITEM_VAL');
		
		$("#txtUrl").val(itemVal);
	}	
	
	/*** Setting Update API Input Properties ***/
	function fn_setInpPro(rowId){
		var tabInp = $("#tabInput");
		
		var projId = tabInp.jqGrid ('getCell', rowId, 'PROJ_ID');
		var jobId = tabInp.jqGrid ('getCell', rowId, 'JOB_ID');
        var srcId = tabInp.jqGrid ('getCell', rowId, 'SRC_ID');
        var inpId = tabInp.jqGrid ('getCell', rowId, 'INP_ID');
        var inpNm = tabInp.jqGrid ('getCell', rowId, 'INP_NM');
        var inpKey = tabInp.jqGrid ('getCell', rowId, 'INP_KEY');
        var inpVal = tabInp.jqGrid ('getCell', rowId, 'INP_VAL');
        var prmType = tabInp.jqGrid ('getCell', rowId, 'PRM_TYPE');
        var prmDlm = tabInp.jqGrid ('getCell', rowId, 'PRM_DLM'); 
        var strNum = tabInp.jqGrid ('getCell', rowId, 'STR_NUM');
        var incNum = tabInp.jqGrid ('getCell', rowId, 'INC_NUM');        
        var inpType = tabInp.jqGrid ('getCell', rowId, 'INP_TYPE');
        var inpEncode = tabInp.jqGrid ('getCell', rowId, 'INP_ENCODE');
        var useYn = tabInp.jqGrid ('getCell', rowId, 'USE_YN');
        var dispOrd = tabInp.jqGrid ('getCell', rowId, 'DISP_ORD');
        
		$("#txtInpProProjId").val(projId);
		$("#txtInpProJobId").val(jobId);
		$("#txtInpProSrcId").val(srcId);
		$("#txtInpProInpId").val(inpId);
		$("#txtInpProInpNm").val(inpNm);
		$("#txtInpProInpKey").val(inpKey);
		$("#txtInpProInpVal").val(inpVal);
		
		$("#selInpProPrmType").val(prmType);
		$("#txtInpProPrmDlm").val(prmDlm);
		$("#txtInpProStrNum").val(strNum);
		$("#txtInpProIncNum").val(incNum);
		
		//$("#txtInpProInpType").val(inpType);
		$("#selInpProInpType").val(inpType);
		
		$("#txtInpProInpEncode").val(inpEncode);
		$("#selInpProUseYn").val(useYn);
		$("#txtInpProDispOrd").val(dispOrd);
	}
	
	/*** Setting Update API Run Input Properties ***/
	function fn_setRunInpPro(rowId){		
		var tabRunInp = $("#tabRunInput");
		
		var inpVal = tabRunInp.jqGrid ('getCell', rowId, 'INP_VAL');
		var inpEVal = tabRunInp.jqGrid ('getCell', rowId, 'INP_EVAL');
		var prmType = tabRunInp.jqGrid ('getCell', rowId, 'PRM_TYPE');
		
		if(prmType == 'DB_MULT'){
			$("#txtInputValOrg").val(inpVal);
			if(inpVal == inpEVal)
			{
				fn_selectTempInpValList();
			}else{
				$("#txtInputVal").val(inpEVal);
				$("#txtInputVal").focus();
				$("#txtInputVal").select();
			}
		}else{
			$("#txtInputValOrg").val(inpVal);
			$("#txtInputVal").val(inpVal);
			$("#txtInputVal").focus();
			$("#txtInputVal").select();
		}
	}
	
	/*** Setting New API Input Properties ***/
	function fn_newInpPro(srcId){
		
		_inpRowId = '';
		
		$("#txtInpProProjId").val(_projId);
		$("#txtInpProJobId").val(_jobId);
		$("#txtInpProSrcId").val(srcId);
		$("#txtInpProInpId").val("New");
		$("#txtInpProInpNm").val('');
		$("#txtInpProInpKey").val('');
		$("#txtInpProInpVal").val('');
		$("#selInpProPrmType").val("FIX_SING");
		$("#txtInpProPrmDlm").val('');
		$("#txtInpProStrNum").val('');
		$("#txtInpProIncNum").val('');
		
		//$("#txtInpProInpType").val('URL');
		$("#selInpProInpType").val("URL");
		
		$("#txtInpProInpEncode").val('');
		$("#selInpProUseYn").val('Y');
		$("#txtInpProDispOrd").val('');
	}
	
	
	/*** Setting Update API Output Properties ***/
	function fn_setOupPro(rowId){
		var tabOup = $("#tabOutput");
		
		var projId = tabOup.jqGrid ('getCell', rowId, 'PROJ_ID');
		var jobId = tabOup.jqGrid ('getCell', rowId, 'JOB_ID');
        var srcId = tabOup.jqGrid ('getCell', rowId, 'SRC_ID');
        var oupId = tabOup.jqGrid ('getCell', rowId, 'OUP_ID');
        var oupNm = tabOup.jqGrid ('getCell', rowId, 'OUP_NM');
        var oupKey = tabOup.jqGrid ('getCell', rowId, 'OUP_KEY');
        var oupDiv = tabOup.jqGrid ('getCell', rowId, 'OUP_DIV');
        var oupType = tabOup.jqGrid ('getCell', rowId, 'OUP_TYPE');
        var oupExp = tabOup.jqGrid ('getCell', rowId, 'OUP_EXP');
        var oupDesc = tabOup.jqGrid ('getCell', rowId, 'OUP_DESC');
        var useYn = tabOup.jqGrid ('getCell', rowId, 'USE_YN');
        var dispOrd = tabOup.jqGrid ('getCell', rowId, 'DISP_ORD');
        
		$("#txtOupProProjId").val(projId);
		$("#txtOupProJobId").val(jobId);
		$("#txtOupProSrcId").val(srcId);
		$("#txtOupProOupId").val(oupId);
		$("#txtOupProOupNm").val(oupNm);
		$("#txtOupProOupKey").val(oupKey);
		$("#selOupProOupDiv").val(oupDiv);
		$("#selOupProOupType").val(oupType);
		$("#txtOupProOupExp").val(oupExp);
		$("#txtOupProOupDesc").val(oupDesc);
		$("#selOupProUseYn").val(useYn);
		$("#txtOupProDispOrd").val(dispOrd);
	}
	
	/*** Setting New API Output Properties ***/
	function fn_newOupPro(srcId){
		
		_oupRowId = '';
		
		$("#txtOupProProjId").val(_projId);
		$("#txtOupProJobId").val(_jobId);
		$("#txtOupProSrcId").val(srcId);
		$("#txtOupProOupId").val("New");
		$("#txtOupProOupNm").val('');
		$("#txtOupProOupKey").val('');
		$("#selOupProOupDiv").val('ITEMKEY');
		$("#selOupProOupType").val('STRING');
		$("#txtOupProOupExp").val('');
		$("#txtOupProOupDesc").val('');
		$("#selOupProUseYn").val('Y');
		$("#txtOupProDispOrd").val('');
	}	
	
	function fn_setRegexViewF1Pro(rowId){
		var tabRegexViewF1 = $("#tabRegexViewF1");
		var regexVal = tabRegexViewF1.jqGrid ('getCell', (gfn_isNull(rowId)?_regexViewF1RowId:rowId), 'REGEX_VAL');

		_regexViewF1RowId = rowId;
		
		$("#txtRegex").val(regexVal);
	}
	
	function fn_setRegexViewR1Pro(rowId){
		var tabRegexViewR1 = $("#tabRegexViewR1");
		var regexVal = tabRegexViewR1.jqGrid ('getCell', (gfn_isNull(rowId)?_regexViewR1RowId:rowId), 'REGEX_VAL');

		_regexViewR1RowId = rowId;
		
		$("#txtReplaceRegex").val(regexVal);
	}	
	
	/*** Select Project Ajax Call ***/
	function fn_selectProjList(){
		
		fn_init(1);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsProjectList.do' />");
		comAjax.setCallback("fn_selectProjectListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("COLECT_TYP_CD","API");	// API 대상
		comAjax.ajax();
	}	
	/*** Select Project Ajax Callback ***/
	function fn_selectProjectListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabProject").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabProject").jqGrid('setSelection','1');
			fn_setProjPro('1');
		}
	}
	
	/*** Select API Job Ajax Call ***/
	function fn_selectJobList(){
		
		fn_init(2);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsApiJobList.do' />");
		comAjax.setCallback("fn_selectDsApiJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.ajax();
	}	
	/*** Select API Job Ajax Callback ***/
	function fn_selectDsApiJobListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabJob").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabJob").jqGrid('setSelection','1');
			fn_setJobPro('1');
		}
	}
	
	/*** Select Template Multi InpVal Ajax Call ***/
	function fn_selectTempInpValList(){
		
		$("#tabTempInpVal").jqGrid("clearGridData", true);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsTempApiInpValList.do' />");
		comAjax.setCallback("fn_selectDsTempApiInpValListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("INP_COND",$("#txtInputValOrg").val());
		comAjax.ajax();
	}	
	/*** Select Template Multi InpVal Ajax Callback ***/
	function fn_selectDsTempApiInpValListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabTempInpVal").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabTempInpVal").jqGrid('setSelection','1');
		}
		
		var inpVal = $("#tabTempInpVal").jqGrid ('getCell', _tempInpValRowId, 'INP_VAL'); 
		$("#txtInputVal").val(inpVal);
		$("#txtInputVal").focus();
		$("#txtInputVal").select();
	}
	
	/*** Select Template API Job Ajax Call ***/
	function fn_selectTempJobList(){
		
		$("#tabTempJob").jqGrid("clearGridData", true);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsTempApiJobList.do' />");
		comAjax.setCallback("fn_selectDsTempApiJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}	
	/*** Select Template API Job Ajax Callback ***/
	function fn_selectDsTempApiJobListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabTempJob").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabTempJob").jqGrid('setSelection','1');
		}
		
		$("#divTempJobPop" ).dialog( "open" );
	}
	
	/*** Select API Copy Source Ajax Call ***/
	function fn_selectCopySrcList(){
		
		$("#tabCopySrc").jqGrid("clearGridData", true);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsTempApiSrcList.do' />");
		comAjax.setCallback("fn_selectDsTempApiSrcListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		comAjax.ajax();
	}	
	/*** Select API Copy Source Ajax Callback ***/
	function fn_selectDsTempApiSrcListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabCopySrc").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabCopySrc").jqGrid('setSelection','1');
		}
		
		$("#divCopySrcPop" ).dialog( "open" );
	}
	
	function fn_applyTempInpval(rowId){
		var tabTempInpVal = $("#tabTempInpVal");
		var itemVal = tabTempInpVal.jqGrid ('getCell', (gfn_isNull(rowId)?_tempInpValRowId:rowId), 'INP_VAL');
		
		$("#txtInputVal").val(itemVal);
	}
	
	/*** Apply Template API Job Ajax Call ***/
	function fn_applyTempJob(){
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/applyDsTempApiJob.do' />");
		comAjax.setCallback("fn_applyDsTempApiJobCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("TEMP_USR_ID",_tempUsrId);
		comAjax.addParam("TEMP_PROJ_ID",_tempProjId);
		comAjax.addParam("TEMP_JOB_ID",_tempJobId);
		comAjax.ajax();
	}	
	/*** apply  Template API Job Ajax Callback ***/
	function fn_applyDsTempApiJobCallback(data){
		_alert('info','Success!!!','fn_selectSrcList');		
	}
	
	/*** Apply Template API Job Ajax Call ***/
	function fn_applyCopySrc(){
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/applyDsTempApiSrc.do' />");
		comAjax.setCallback("fn_applyCopySrcCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		comAjax.addParam("TEMP_USR_ID",_tempUsrId);
		comAjax.addParam("TEMP_PROJ_ID",_tempProjId);
		comAjax.addParam("TEMP_JOB_ID",_tempJobId);
		comAjax.addParam("TEMP_SRC_ID",_tempSrcId);
		comAjax.ajax();
	}	
	/*** apply  Template API Job Ajax Callback ***/
	function fn_applyCopySrcCallback(data){
		_alert('info','Success!!!','fn_selectInpOupList');
	}
	
	function fn_selectInpOupList(){
		fn_setSrcPro(_srcRowId);
		fn_selectInpList();
        fn_selectOupList();
	}
	
	/*** Select API Source Ajax Call ***/
	function fn_selectSrcList(){
		
		fn_init(3);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsApiSourceList.do' />");
		comAjax.setCallback("fn_selectDsApiSourceListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}
	
	/*** Select API Source Ajax Callback ***/
	function fn_selectDsApiSourceListCallback(data){

		if(data==null){return;}
		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabSource").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_srcRowId)
			$("#tabSource").jqGrid('setSelection',_srcRowId);
		else if(mydata.length>0)
			$("#tabSource").jqGrid('setSelection','1');		
	}
	
	/*** Select ExeItemValue Ajax Call ***/
	function fn_selectExeItemVal(srcTypCd, srcVal, rowNum){
		
		$("#tabSourceView").jqGrid("clearGridData", true);
		if(srcTypCd == 'TABLE'){
			var comAjax = new ComAjax();
			comAjax.setAsyncFlag(false);
			comAjax.setUrl("<c:url value='/datasearch/selectDsExeApiItemVal.do' />");
			comAjax.setCallback("fn_selectDsExeApiItemValCallback");
			comAjax.addParam("EXE_NUM","0");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("SRC_VAL",srcVal);
			comAjax.addParam("ROW_NUM",rowNum);
			comAjax.ajax();
		}else if (srcTypCd == 'INPUT'){
			$("#txtUrl").val(srcVal);
		}
	}	
	/*** Select ExeItemValue Ajax Callback ***/
	function fn_selectDsExeApiItemValCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabSourceView").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0){
			$("#tabSourceView").jqGrid('setSelection','1');
			
			fn_setSrcViewPro(1);
		}
	}
	
	/*** Select API Input Complete ***/
	function gridCompleteInp(){
		//
	}
	
	/*** Select API Output Complete ***/
	function gridCompleteOup(){
		//
	}	
	
	/*** Select API Run Input Complete ***/
	function gridCompleteRunInp(){
		//
	}
	
	/*** Select API Input Ajax Call ***/
	function fn_selectInpList(){
		
		fn_init(4);

		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsApiInputList.do' />");
		comAjax.setCallback("fn_selectDsApiInputListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		comAjax.ajax();
	}
	
	/*** Select API Input Ajax Callback ***/
	function fn_selectDsApiInputListCallback(data){

		if(data == null){return;}
		var mydata = data.rows;

		var inpType = "";
		var useYn = "";
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				$("#tabInput").jqGrid('addRowData', i+1, mydata[i]);
				
				inpType = mydata[i].INP_TYPE;
				useYn = mydata[i].USE_YN;
				if("URL" == inpType && "Y" == useYn){
					$("#tabRunInput").jqGrid('addRowData', i+1, mydata[i]);	
				}
			}
		}		
		
		if(mydata.length>=_inpRowId)
		{
			$("#tabInput").jqGrid('setSelection',_inpRowId);
		}
		else if(mydata.length>0){
			$("#tabInput").jqGrid('setSelection','1');
		}
		if(mydata.length>0){
			$("#tabRunInput").jqGrid('setSelection','1');
		}
	}
	
	/*** Select API Output Ajax Call ***/
	function fn_selectOupList(){
		
		fn_init(5);

		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsApiOutputList.do' />");
		comAjax.setCallback("fn_selectDsApiOutputListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		comAjax.ajax();
	}
	
	/*** Select API Output Ajax Callback ***/
	function fn_selectDsApiOutputListCallback(data){

		if(data == null){return;}
		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabOutput").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_oupRowId)
			$("#tabOutput").jqGrid('setSelection',_oupRowId);
		else if(mydata.length>0)
			$("#tabOutput").jqGrid('setSelection','1');		
	}	

	/*** Save API Source Ajax Call ***/
	function fn_saveSrcInfo(){
		
		var srcId = $("#txtSrcProSrcId").val();
		var srcNm = $("#txtSrcProSrcNm").val();
		var srcVal = $("#txtSrcProSrcVal").val();
		var srcDivCd = $("#selSrcProSrcDivCd option:selected").val();
		var srcTypCd = $("#selSrcProSrcTypCd option:selected").val();
		var srcEncode = $("#txtSrcProSrcEncode").val();
		var srcValPosition = '';
		var dispOrd =  $("#txtSrcProDispOrd").val();
		var method = $("#selSrcProMethod option:selected").val();
		var authYn = $("#selSrcProAuthYn option:selected").val();
		var outFmt = $("#selSrcProOutFmt option:selected").val();
		var xmlPrefix = $("#txtSrcProXmlPrefix").val();
		var xmlNamespaceuri = $("#txtSrcProXmlNamespaceuri").val();
		var delayTime = $("#txtSrcProDelayTime").val();
		
		if(gfn_isNull(srcNm)){
			$("#spanSrcProMsg").text("유효값을 입력하세요.");
			$("#divSrcProMsg").css("display", "block");
			$("#txtSrcProSrcNm").focus();
			return false;
		}
		if(gfn_isNull(srcEncode)){
			$("#spanSrcProMsg").text("유효값을 입력하세요.");
			$("#divSrcProMsg").css("display", "block");
			$("#txtSrcProSrcEncode").focus();
			return false;
		}
		if(gfn_isNull(srcVal)){
			$("#spanSrcProMsg").text("유효값을 입력하세요.");
			$("#divSrcProMsg").css("display", "block");
			$("#txtSrcProSrcVal").focus();
			return false;
		}
		if(gfn_isNull(dispOrd)){
			$("#spanSrcProMsg").text("유효값을 입력하세요.");
			$("#divSrcProMsg").css("display", "block");
			$("#txtSrcProDispOrd").focus();
			return false;
		}
		
		
		var comAjax = new ComAjax();
		
		if(srcId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsApiSourceInfo.do' />");
			comAjax.setCallback("fn_insDsApiSourceInfoCallback");
			comAjax.addParam("SRC_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsApiSourceInfo.do' />");
			comAjax.setCallback("fn_saveDsApiSourceInfoCallback");
			comAjax.addParam("SRC_ID",srcId);
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_NM",srcNm);
		comAjax.addParam("SRC_VAL",srcVal);
		
		comAjax.addParam("SRC_DIV_CD",srcDivCd);
		comAjax.addParam("SRC_TYP_CD",srcTypCd);
		comAjax.addParam("SRC_ENCODE",srcEncode);
		comAjax.addParam("SRC_VAL_POSITION",srcValPosition);
		//comAjax.addParam("SRC_VAL_POSITION",$("#txtSrcProSrcValPosition").val());
		comAjax.addParam("METHOD",method);
		comAjax.addParam("AUTH_YN",authYn);
		comAjax.addParam("OUT_FMT",outFmt);
		comAjax.addParam("XML_PREFIX",xmlPrefix);
		comAjax.addParam("XML_NAMESPACEURI",xmlNamespaceuri);
		comAjax.addParam("DELAY_TIME",delayTime);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete API Source Ajax Call ***/
	function fn_deleteSrcInfo(){
		var tabSrc = $("#tabSource");
		var srcId = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsApiSourceInfo.do' />");
		comAjax.setCallback("fn_delDsApiSourceInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.ajax();
	}
	
	/*** Insert API Source Ajax Callback ***/
	function fn_insDsApiSourceInfoCallback(data){
		$("#divSrcProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');
	}
	
	/*** Delete Source Ajax Callback ***/
	function fn_delDsApiSourceInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');
	}
	
	/*** Update Source Ajax Callback ***/
	function fn_saveDsApiSourceInfoCallback(data){
		$("#divSrcProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');;
	}
	
	/*** Save API Input Ajax Call ***/
	function fn_saveInpInfo(){
		
		var projId = $("#txtInpProProjId").val();
		var jobId = $("#txtInpProJobId").val();
		var srcId = $("#txtInpProSrcId").val();
		var inpId = $("#txtInpProInpId").val();
		var inpNm = $("#txtInpProInpNm").val();
		var inpKey = $("#txtInpProInpKey").val();
		var inpVal = $("#txtInpProInpVal").val();
		var prmType = $("#selInpProPrmType option:selected").val();
		var prmDlm = $("#txtInpProPrmDlm").val();
		var strNum = $("#txtInpProStrNum").val();
		var incNum = $("#txtInpProIncNum").val();
		
		//var inpType = $("#txtInpProInpType").val();
		var inpType = $("#selInpProInpType option:selected").val();
		
		var inpEncode = $("#txtInpProInpEncode").val();
		var useYn = $("#selInpProUseYn option:selected").val();
		var dispOrd = $("#txtInpProDispOrd").val();
		
		if(gfn_isNull(inpNm)){
			$("#spanInpProMsg").text("유효값을 입력하세요.");
			$("#divInpProMsg").css("display", "block");
			$("#txtInpProInpNm").focus();
			return false;
		}
		if(gfn_isNull(inpKey)){
			$("#spanInpProMsg").text("유효값을 입력하세요.");
			$("#divInpProMsg").css("display", "block");
			$("#txtInpProInpKey").focus();
			return false;
		}
		
		if(gfn_isNull(inpType)){
			$("#spanInpProMsg").text("유효값을 입력하세요.");
			$("#divInpProMsg").css("display", "block");
			$("#selInpProInpType").focus();
			return false;
		}		

		var comAjax = new ComAjax();
		if(inpId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsApiInputInfo.do' />");
			comAjax.setCallback("fn_insDsApiInputInfoCallback");
			comAjax.addParam("INP_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsApiInputInfo.do' />");
			comAjax.setCallback("fn_saveDsApiInputInfoCallback");
			comAjax.addParam("INP_ID",inpId);
		}
		
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("INP_NM",inpNm);
		comAjax.addParam("INP_KEY",inpKey);
		comAjax.addParam("INP_VAL",inpVal);
		comAjax.addParam("PRM_TYPE",prmType);
		comAjax.addParam("PRM_DLM",prmDlm);
		comAjax.addParam("STR_NUM",strNum);
		comAjax.addParam("INC_NUM",incNum);
		comAjax.addParam("INP_TYPE",inpType);
		comAjax.addParam("INP_ENCODE",inpEncode);
		comAjax.addParam("USE_YN",useYn);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete API Input Ajax Call ***/
	function fn_deleteApiInputInfo(){
		var tabInp = $("#tabInput");
		var srcId = tabInp.jqGrid ('getCell', _inpRowId, 'SRC_ID');
		var inpId = tabInp.jqGrid ('getCell', _inpRowId, 'INP_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsApiInputInfo.do' />");
		comAjax.setCallback("fn_delDsApiInputInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("INP_ID",inpId);
		comAjax.ajax();
	}	
	
	/*** Insert API Input Ajax Callback ***/
	function fn_insDsApiInputInfoCallback(data){
		$("#divInpProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectInpList');;
	}
	
	/*** Delete API Input Ajax Callback ***/
	function fn_delDsApiInputInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectInpList');;
	}
	
	/*** Update API Input Ajax Callback ***/
	function fn_saveDsApiInputInfoCallback(data){
		$("#divInpProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectInpList');;
	}	
	
	
	/*** Save API Output Ajax Call ***/
	function fn_saveOupInfo(){
		
		var projId = $("#txtOupProProjId").val();
		var jobId = $("#txtOupProJobId").val();
		var srcId = $("#txtOupProSrcId").val();
		var oupId = $("#txtOupProOupId").val();
		var oupNm = $("#txtOupProOupNm").val();
		var oupKey = $("#txtOupProOupKey").val();
		var oupDiv = $("#selOupProOupDiv option:selected").val();
		var oupType = $("#selOupProOupType option:selected").val();
		var oupExp = $("#txtOupProOupExp").val();
		var oupDesc = $("#txtOupProOupDesc").val();
		var useYn = $("#selOupProUseYn option:selected").val();
		var dispOrd = $("#txtOupProDispOrd").val();
		
		if(gfn_isNull(oupNm)){
			$("#spanOupProMsg").text("유효값을 입력하세요.");
			$("#divOupProMsg").css("display", "block");
			$("#txtOupProOupNm").focus();
			return false;
		}
		if(gfn_isNull(oupKey)){
			$("#spanOupProMsg").text("유효값을 입력하세요.");
			$("#divOupProMsg").css("display", "block");
			$("#txtOupProOupKey").focus();
			return false;
		}
		if(gfn_isNull(oupDiv)){
			$("#spanOupProMsg").text("유효값을 입력하세요.");
			$("#divOupProMsg").css("display", "block");
			$("#selOupProOupDiv").focus();
			return false;
		}
		if(gfn_isNull(oupType)){
			$("#spanOupProMsg").text("유효값을 입력하세요.");
			$("#divOupProMsg").css("display", "block");
			$("#selOupProOupType").focus();
			return false;
		}

		var comAjax = new ComAjax();
		if(oupId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsApiOutputInfo.do' />");
			comAjax.setCallback("fn_insDsApiOutputInfoCallback");
			comAjax.addParam("OUP_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsApiOutputInfo.do' />");
			comAjax.setCallback("fn_saveDsApiOutputInfoCallback");
			comAjax.addParam("OUP_ID",oupId);
		}
		
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("OUP_NM",oupNm);
		comAjax.addParam("OUP_KEY",oupKey);
		comAjax.addParam("OUP_DIV",oupDiv);
		comAjax.addParam("OUP_TYPE",oupType);
		comAjax.addParam("OUP_EXP",oupExp);
		comAjax.addParam("OUP_DESC",oupDesc);
		comAjax.addParam("USE_YN",useYn);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete API Output Ajax Call ***/
	function fn_deleteApiOutputInfo(){
		var tabOup = $("#tabOutput");
		var srcId = tabOup.jqGrid ('getCell', _oupRowId, 'SRC_ID');
		var oupId = tabOup.jqGrid ('getCell', _oupRowId, 'OUP_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsApiOutputInfo.do' />");
		comAjax.setCallback("fn_delDsApiOutputInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("OUP_ID",oupId);
		comAjax.ajax();
	}	
	
	/*** Insert API Output Ajax Callback ***/
	function fn_insDsApiOutputInfoCallback(data){
		$("#divOupProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectOupList');;
	}
	
	/*** Delete API Output Ajax Callback ***/
	function fn_delDsApiOutputInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectOupList');;
	}
	
	/*** Update API Output Ajax Callback ***/
	function fn_saveDsApiOutputInfoCallback(data){
		$("#divOupProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectOupList');;
	}	
	
	// 	
	function fn_GoApply(){
		
		var tabRunInp = $("#tabRunInput");
		var gridId = tabRunInp.getDataIDs();
		var inpType = "";
		var inpEncode = "";
		var inpKey = "";
		var inpVal = "";
		var urlParam = "";
		var rowId = "";
		
		inpVal = $("#txtInputVal").val();
		tabRunInp.jqGrid('setCell', _inpValRowId, 'INP_EVAL', inpVal);
		
	    for (var countRow = 0; countRow < gridId .length; countRow ++) 
	    {
	        rowId = gridId [countRow ];
	        
	        inpKey = tabRunInp.jqGrid ('getCell', rowId, 'INP_KEY');
	        inpVal = tabRunInp.jqGrid ('getCell', rowId, 'INP_EVAL');
	        inpEncode = tabRunInp.jqGrid ('getCell', rowId, 'INP_ENCODE');
	        if(inpEncode.length>0){
	        	inpVal = encodeURIComponent(inpVal);
	        }
	        inpType = tabRunInp.jqGrid ('getCell', rowId, 'INP_TYPE');
	        if(inpType == "URL"){
		        if(urlParam==""){
		        	urlParam += inpKey + "=" + inpVal;
		        }else{
		        	urlParam += "&" + inpKey + "=" + inpVal;
		        }
	        }
	    }
		
		var tabSrc = $("#tabSource");
        var srcVal = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_VAL');
		//$("#txtUrl").val(srcVal + urlParam);
		

    	var rowId = (_inpValRowId * 1) + 1; 
    	
    	var maxRow = tabRunInp.getGridParam("reccount");
    	
    	if(rowId <= maxRow){
        	$("#tabRunInput").jqGrid('setSelection',rowId+'');
    	}else{
    		$("#tabRunInput").jqGrid('setSelection',maxRow+'');
    	}
    	
    	return urlParam;
	}	
	
	// API 서비스 AJAX 호출 		
	function fn_GoApi(flag){
		
		$("#txtPageSource").val("");
		var tabSrc = $("#tabSource");
		var srcEncode = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ENCODE');
		var method = tabSrc.jqGrid ('getCell', _srcRowId, 'METHOD');
		var outFmt = tabSrc.jqGrid ('getCell', _srcRowId, 'OUT_FMT');
		var xmlPrefix = tabSrc.jqGrid ('getCell', _srcRowId, 'XML_PREFIX');
		var xmlNamespaceuri = tabSrc.jqGrid ('getCell', _srcRowId, 'XML_NAMESPACEURI');
		
		var urlParam = fn_GoApply();
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/runApi.do' />");
		comAjax.setCallback("fn_runApiCallback_"+flag);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		
		comAjax.addParam("URL",$("#txtUrl").val());
		comAjax.addParam("URL_PARAM",urlParam);
		
		comAjax.addParam("METHOD",method);
		comAjax.addParam("OUT_FMT",outFmt);
		comAjax.addParam("XML_PREFIX",xmlPrefix);
		comAjax.addParam("XML_NAMESPACEURI",xmlNamespaceuri);
		comAjax.addParam("USE_YN","Y");
		comAjax.ajax();
	}
	
	function fn_runApiCallback_0(data){
		if(data == null||data.itemRoot==null||data.itemRoot.length<=0){return;}
		if(data == null||data.itemList==null||data.itemList.length<=0){return;}
		var sVal = "";
		sVal += "[Root Items]====================================\n";
		$.each(data.itemRoot, function(key, value){
			$.each(value, function(key2, value2){
				sVal += "[" + key2 + "]" + value2 + "\n";
			});
			sVal += "\n";
		});
		sVal += "[List Items]====================================\n";
		$.each(data.itemList, function(key, value){
			$.each(value, function(key2, value2){
				sVal += "[" + key2 + "]" + value2 + "\n";
			});
			sVal += "\n";
		});
		$("#txtPageSource").val(sVal);
	}
	
	function fn_runApiCallback_1(data){
		if(data == null||data.result==null||data.result.length<=0){return;}
		
		// XML 전체 문장
		$("#txtPageSource").val(data.result);
	}
	
	/*** Crawling Result Save Ajax Call ***/
	function fn_RunApiSave()
	{
		$("#txtPageSource").val("");
		var tabSrc = $("#tabSource");
		var srcEncode = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ENCODE');
		var method = tabSrc.jqGrid ('getCell', _srcRowId, 'METHOD');
		var outFmt = tabSrc.jqGrid ('getCell', _srcRowId, 'OUT_FMT');
		var xmlPrefix = tabSrc.jqGrid ('getCell', _srcRowId, 'XML_PREFIX');
		var xmlNamespaceuri = tabSrc.jqGrid ('getCell', _srcRowId, 'XML_NAMESPACEURI');
		
		var urlParam = fn_GoApply();
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/runApiSave.do' />");
		comAjax.setCallback("fn_RunApiSaveCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		
		comAjax.addParam("URL",$("#txtUrl").val());
		comAjax.addParam("URL_PARAM",urlParam);
		comAjax.addParam("METHOD",method);
		comAjax.addParam("OUT_FMT",outFmt);
		comAjax.addParam("XML_PREFIX",xmlPrefix);
		comAjax.addParam("XML_NAMESPACEURI",xmlNamespaceuri);
		comAjax.addParam("USE_YN","Y");
		comAjax.ajax();
	}
	
	/*** Crawling Result Save Ajax Callback ***/
	function fn_RunApiSaveCallback(data){
		if(data == null){return;}
		$("#txtPageSource").val(data.result);
		
		_alert('info','Success!!!','');
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Job), 3 (Source), 4(Target)
	*/	
	function fn_init(step){
		if(step<=0){
			_srcRowId = '1';
			_inpRowId = '1';
			_inpValRowId = '1';
			_oupRowId = '1';
		}
			
		if(step<=1){
						
			$("#txtProjId").val('');
			$("#txtProjNm").val('');
			
			$("#tabProject").jqGrid("clearGridData", true);
		}
		
		if(step<=2){
			_srcRowId = '1';
			_inpRowId = '1';
			_inpValRowId = '1';
			_oupRowId = '1';
			$("#txtJobId").val('');
			$("#txtJobNm").val('');
			
			$("#tabJob").jqGrid("clearGridData", true);
		}
		
		if(step<=3){
			$("#tabSource").jqGrid("clearGridData", true);
			$("#tabSourceView").jqGrid("clearGridData", true);
			$("#txtInputValOrg").val('');
			$("#txtInputVal").val('');
			$("#txtUrl").val('');
		}
		
		if(step<=4){
			$("#tabInput").jqGrid("clearGridData", true);
			$("#tabRunInput").jqGrid("clearGridData", true);
		}
		if(step!=4 && step<=5){
			$("#tabOutput").jqGrid("clearGridData", true);
		}
		
	}
</script>
</body>
</html>