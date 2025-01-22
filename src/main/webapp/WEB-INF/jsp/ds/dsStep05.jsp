<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 설정하기(크롤링) -->
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
      
  #divTgtProPop{
  	display:none;
  }
  #divTgtProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divTgtProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }  
  
  #divTgtProPop .inputText{
  	height:20px;
  }  
  
  #selSrcProSrcDivCd-button{
  	width:160px !important;
  }
  #selSrcProSrcTypCd-button{
  	width:160px !important;
  }
  #selSrcProLoopYn-button{
  	width:160px !important;
  }
  #selSrcProLoopBlockCntAuto-button{
  	width:40px !important;
  }
  #selSrcProLoopCntAuto-button{
  	width:40px !important;
  }
  #selSrcProSrcSaveType-button{
  	width:160px !important;
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
					<div><span class="inputLabel">프로젝트ID</span><input id="txtProjId" type="text" class="text" style="width:100px;margin-left:10px;text-align: center;margin-top:2px;" disabled="disabled" spellcheck='false' ><input id="txtProjNm" type="text" class="text" style="width:300px;margin-left:5px;margin-top:2px;" disabled="disabled" spellcheck='false' ><button id="goProjPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">...</button></div>
				</div>
			</td>
			<td></td>
			<td class="tdContent">
				<div id="divJobPro">
					<h3>작업</h3>
					<div><span class="inputLabel">작업ID</span><input id="txtJobId" type="text" class="text" style="width:100px;margin-left:10px;text-align: center;margin-top:0px;" disabled="disabled" spellcheck='false' ><input id="txtJobNm" type="text" class="text" style="width:280px;margin-left:5px;margin-top:2px;" disabled="disabled" spellcheck='false' ><button id="goJobPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">...</button><button id="goTempJobPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">복제</button></div>
				</div>
			</td>
		</tr>	
		<tr>
			<td class="tdContent">
				<table id="tabSource"></table>
			</td>
			<td></td>
			<td class="tdContent">
				<table id="tabTarget"></table>
			</td>			
		</tr>
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goSrcNew" class="button" style="width:70px;">등록</button>
				<button id="goSrcDel" class="button" style="width:70px;">삭제</button>
			</td>
			<td></td>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goTgtNew" class="button" style="width:70px;">등록</button>
				<button id="goTgtDel" class="button" style="width:70px;">삭제</button>
			</td>			
		</tr>		
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<input id="txtSource" type="text" class="text" style="width:545px;" spellcheck='false' ></input><button id="goView" class="button" style="width:50px;">목록</button>
				<br/>
				<input id="txtUrl" type="text" class="text" style="width:545px;" spellcheck='false' ></input><button id="goUrl" class="button" style="width:50px;">실행</button>
			</td>
			<td></td>
			<td class="tdContent" style="line-height:2.8;">
				<input id="txtRegex" type="text" class="text" style="width:350px;" spellcheck='false' ></input>
				<button id="goRegex1" class="button" style="width:60px;">점검1</button>
				<button id="goRegex2" class="button" style="width:60px;">점검2</button>
				<button id="goRegex3" class="button" style="width:60px;">점검3</button>
				<button id="goRegExam1" class="button">?</button>
				<br/>
				<input id="txtReplaceRegex" type="text" class="text" style="width:350px;" spellcheck='false' ></input>
				<button id="goApplyTgt" class="button" style="width:60px;">적용</button>
				<button id="goRepExam1" class="button">?</button>
				<button id="goRunRegexSave" class="button" style="width:80px;">수집하기</button>
			</td>
		</tr>
		<tr>
			<td class="tdContent">
				<textarea id="txtPageSource" spellcheck='false' class="textarea"></textarea>
			</td>
			<td></td>
			<td class="tdContent">
				<textarea id="txtRegexResult" spellcheck='false' class="textarea" readonly="readonly"></textarea>
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
<div id="divTempJobPop" title="복제 대상작업 선택" >
	<table id="tabTempJob"></table>
</div>
<div id="divSrcViewPop" title="소스 선택" >
	<table id="tabSourceView"></table>
</div>
<div id="divRegexViewF1Pop" title="정규표현식 예제" >
	<table id="tabRegexViewF1"></table>
</div>

<div id="divRegexViewR1Pop" title="정규치환식 예제" >
	<table id="tabRegexViewR1"></table>
</div>

<div id="divSrcProPop" title="소스 속성정보" style="line-height:2.8;">
<span class="inputLabel">프로젝트ID(*)</span><input id="txtSrcProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">작업ID(*)</span><input id="txtSrcProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스ID(*)</span><input id="txtSrcProSrcId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스명(*)</span><input id="txtSrcProSrcNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">단일소스여부(*)</span><select id="selSrcProSrcDivCd" style="width:350px;"><option value="SURL">단일소스</option><option value="MURL">복수소스</option></select>
<br/><span class="inputLabel">소스출처(*)</span><select id="selSrcProSrcTypCd" style="width:350px;"><option value="INPUT">직접입력</option><option value="TABLE">크롤링 수집DB</option><option value="OTHER">API 수집DB</option></select>
<br/><span class="inputLabel">인코딩유형(*)</span><input id="txtSrcProSrcEncode" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">UTF-8,EUC-KR</span>
<br/><span class="inputLabel">소스(*)</span><input id="txtSrcProSrcVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">저장영역(*)</span><select id="selSrcProSrcSaveType"><option value="HTML">HTML소스</option><option value="TEXT">본문텍스트</option></select>
<br/><span class="inputLabel">지연시간</span><input id="txtSrcProDelayTime" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">1000=1초</span>
<br/><span class="inputLabel">출력순서(*)</span><input id="txtSrcProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수를 입력하세요.</span>
<br/><span class="inputLabel">반복여부</span><select id="selSrcProLoopYn"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">반복블럭수.</span><input id="txtSrcProLoopBlockCnt" type="text" class="inputText" style="width:180px;" spellcheck='false' ></input>
<span class="inputLabel" style="margin-left:33px;width:70px;">자동여부</span><select id="selSrcProLoopBlockCntAuto" style="width:60px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">반복횟수</span><input id="txtSrcProLoopCnt" type="text" class="inputText" style="width:180px;" spellcheck='false' ></input>
<span class="inputLabel" style="margin-left:33px;width:70px;">자동여부</span><select id="selSrcProLoopCntAuto" style="width:60px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">동적파라미터 정보</span><span class="inputLabel2" style="width:115px;" >항목키</span><span class="inputLabel2" style="width:85px;" >항목유형</span><span class="inputLabel2" style="width:80px;" >항목값</span><span class="inputLabel2" style="width:75px;" >증가값</span>
<br/><span class="inputLabel">파라미터 1</span><input id="txtSrcProPrm1Key" type="text" class="inputText" style="width:110px;" spellcheck='false' ></input>
<input id="txtSrcProPrm1Typ" type="text" class="inputText" style="width:79px;" spellcheck='false' ></input>
<input id="txtSrcProPrm1Val" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>
<input id="txtSrcProPrm1Inc" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input><span class="inputDesc">항목키: 파라미터 키값</span>

<br/><span class="inputLabel">파라미터 2</span><input id="txtSrcProPrm2Key" type="text" class="inputText" style="width:110px;" spellcheck='false' ></input>
<input id="txtSrcProPrm2Typ" type="text" class="inputText" style="width:79px;" spellcheck='false' ></input>
<input id="txtSrcProPrm2Val" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>
<input id="txtSrcProPrm2Inc" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input><span class="inputDesc">항목유형: FIX or ADJ</span>

<br/><span class="inputLabel">파라미터 3</span><input id="txtSrcProPrm3Key" type="text" class="inputText" style="width:110px;" spellcheck='false' ></input>
<input id="txtSrcProPrm3Typ" type="text" class="inputText" style="width:79px;" spellcheck='false' ></input>
<input id="txtSrcProPrm3Val" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>
<input id="txtSrcProPrm3Inc" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input><span class="inputDesc">항목값: 파라미터 값 or 시작값</span>

<br/><span class="inputLabel">파라미터 4</span><input id="txtSrcProPrm4Key" type="text" class="inputText" style="width:110px;" spellcheck='false' ></input>
<input id="txtSrcProPrm4Typ" type="text" class="inputText" style="width:79px;" spellcheck='false' ></input>
<input id="txtSrcProPrm4Val" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>
<input id="txtSrcProPrm4Inc" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input><span class="inputDesc">증가값: 반복일때 증가값</span>

<br/><span class="inputLabel">파라미터 5</span><input id="txtSrcProPrm5Key" type="text" class="inputText" style="width:110px;" spellcheck='false' ></input>
<input id="txtSrcProPrm5Typ" type="text" class="inputText" style="width:79px;" spellcheck='false' ></input>
<input id="txtSrcProPrm5Val" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>
<input id="txtSrcProPrm5Inc" type="text" class="inputText" style="width:70px;" spellcheck='false' ></input>

<div id="divSrcProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanSrcProMsg"></span></p>
	</div>
</div>
</div>
</div>

<div id="divTgtProPop" title="타깃 속성정보" style="line-height:2.8;">
<span class="inputLabel">프로젝트ID(*)</span><input id="txtTgtProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">작업ID(*)</span><input id="txtTgtProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">소스ID(*)</span><input id="txtTgtProSrcId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">타깃ID(*)</span><input id="txtTgtProTgtId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">타깃명(*)</span><input id="txtTgtProTgtNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">타깃추출방법(*)</span><input id="txtTgtProTgtFindType" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">REG:정규표현식</span>
<br/><span class="inputLabel">정규표현식(*)</span><input id="txtTgtProTgtFindVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">치환표현식</span><input id="txtTgtProTgtRepVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">NULL값 표현식</span><input id="txtTgtProTgtSaveVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc"><$Group>$SRCURL$<$/Group></span>
<br/><span class="inputLabel">저장유형</span><input id="txtTgtProTgtSaveType" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">TABLE, TEXT</span>
<br/><span class="inputLabel">출력순서</span><input id="txtTgtProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수를 입력하세요.</span>
<div id="divTgtProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanTgtProMsg"></span></p>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
	var rowNum = 10;
	var _projRowId = '';
	var _jobRowId = '';
	var _srcRowId = '';
	var _tgtRowId = '';
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
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#goSrcNew" ).button();
		$( "#goSrcDel" ).button();
		$( "#goTgtNew" ).button();
		$( "#goTgtDel" ).button();
		
		$("#goProjPop").button();
		$("#goJobPop").button();
		$("#goTempJobPop").button();
		
		$( "#goView" ).button();
		$( "#goUrl" ).button();
		$( "#goRegex1" ).button();
		$( "#goRegex2" ).button();
		$( "#goRegex3" ).button();
		$( "#goRegExam1" ).button();
		$( "#goApplyTgt").button();
		$( "#goRepExam1" ).button();
		$( "#goRunRegexSave" ).button();

		$( "#divProjectPro" ).accordion();
		$( "#divJobPro" ).accordion();

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
				
				var loopYn = 'N';
				if(_srcRowId != ''){loopYn = $("#tabSource").jqGrid ('getCell', _srcRowId, 'LOOP_YN');}
				$("#selSrcProLoopYn").selectmenu();
				$("#selSrcProLoopYn").val(loopYn);
				$('#selSrcProLoopYn').selectmenu('refresh', true);
				
				var loopBlockCntAuto = 'N';
				if(_srcRowId != ''){loopBlockCntAuto = $("#tabSource").jqGrid ('getCell', _srcRowId, 'LOOP_BLOCK_CNT_AUTO');}
				$("#selSrcProLoopBlockCntAuto").selectmenu();
				$("#selSrcProLoopBlockCntAuto").val(loopBlockCntAuto);
				$('#selSrcProLoopBlockCntAuto').selectmenu('refresh', true);
				
				var loopCntAuto = 'N';
				if(_srcRowId != ''){loopCntAuto = $("#tabSource").jqGrid ('getCell', _srcRowId, 'LOOP_CNT_AUTO');}
				$("#selSrcProLoopCntAuto").selectmenu();
				$("#selSrcProLoopCntAuto").val(loopCntAuto);
				$('#selSrcProLoopCntAuto').selectmenu('refresh', true);
				
				var srcSaveType = 'HTML';
				if(_srcRowId != ''){srcSaveType = $("#tabSource").jqGrid ('getCell', _srcRowId, 'SRC_SAVE_TYPE');}
				$("#selSrcProSrcSaveType").selectmenu();
				$("#selSrcProSrcSaveType").val(srcSaveType);
				$('#selSrcProSrcSaveType').selectmenu('refresh', true);
			}
		});	
		
		/*** Target properties Poupup ***/
		$( "#divTgtProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveTgtInfo();
						//$( this ).dialog( "close" );
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
		
		/*** Selected Source VIew Poupup ***/
		$( "#divSrcViewPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "확인",
					click: function() {
						fn_setSrcViewPro();
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
		
		/*** Selected RegexView Poupup ***/
		$( "#divRegexViewF1Pop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "확인",
					click: function() {
						fn_setRegexViewF1Pro();
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
		
		/*** Selected RegexView Poupup ***/
		$( "#divRegexViewR1Pop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 475,
			buttons: [
				{
					text: "확인",
					click: function() {
						fn_setRegexViewR1Pro();
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
		$("#divTempJobPop" ).dialog( "close" );
		$("#divSrcViewPop" ).dialog( "close" );
		$("#divRegexViewF1Pop" ).dialog( "close" );
		$("#divRegexViewR1Pop" ).dialog( "close" );
		
		$( "#divSrcProPop" ).dialog( "close" );
		$( "#divTgtProPop" ).dialog( "close" );
		
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
			height:500,//"100%",
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
		   	colNames:['Proj.Id','Proj.Name','작업ID','작업명','User Id'],
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
		
		/*** Source Grid ***/
		var tabSrc = $("#tabSource");
		tabSrc.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['소스ID','소스명', 'ProjId', 'JobId', 'Source', 'SrcDivCd', 'SrcTypCd', 'SrcEncode', 'SrcValPostion', 'Save Type','Delay Time', 'LoopYn', 'LoopBlockCnt', 'LoopBlockCntAuto', 'LoopCnt', 'LoopCntAuto', 'DispOrd', 'Prm1Key', 'Prm1Typ', 'Prm1Val', 'Prm1Inc', 'Prm2Key', 'Prm2Typ', 'Prm2Val', 'Prm2Inc', 'Prm3Key', 'Prm3Typ', 'Prm3Val', 'Prm3Inc', 'Prm4Key', 'Prm4Typ', 'Prm4Val', 'Prm4Inc', 'Prm5Key', 'Prm5Typ', 'Prm5Val', 'Prm5Inc'],
		   	colModel:[
		   		{name:'SRC_ID',index:'SRC_ID', width:30, align:'center'},
		   		{name:'SRC_NM',index:'SRC_NM', width:150},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'JOB_ID',index:'JOB_ID', hidden: true},
		   		{name:'SRC_VAL',index:'SRC_VAL', hidden: true},	
		   		{name:'SRC_DIV_CD',index:'SRC_DIV_CD', hidden: true},	
		   		{name:'SRC_TYP_CD',index:'SRC_TYP_CD', hidden: true},
		   		{name:'SRC_ENCODE',index:'SRC_ENCODE', hidden: true},
		   		{name:'SRC_VAL_POSITION',index:'SRC_VAL_POSITION', hidden: true},
		   		{name:'SRC_SAVE_TYPE',index:'SRC_SAVE_TYPE', hidden: true},
		   		{name:'DELAY_TIME',index:'DELAY_TIME', hidden: true},
		   		{name:'LOOP_YN',index:'LOOP_YN', hidden: true},	
		   		{name:'LOOP_BLOCK_CNT',index:'LOOP_BLOCK_CNT', hidden: true},	
		   		{name:'LOOP_BLOCK_CNT_AUTO',index:'LOOP_BLOCK_CNT_AUTO', hidden: true},	
		   		{name:'LOOP_CNT',index:'LOOP_CNT', hidden: true},	
		   		{name:'LOOP_CNT_AUTO',index:'LOOP_CNT_AUTO', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true},
		   		{name:'PRM1_KEY',index:'PRM1_KEY', hidden: true},	
		   		{name:'PRM1_TYP',index:'PRM1_TYP', hidden: true},	
		   		{name:'PRM1_VAL',index:'PRM1_VAL', hidden: true},	
		   		{name:'PRM1_INC',index:'PRM1_INC', hidden: true},	
		   		{name:'PRM2_KEY',index:'PRM2_KEY', hidden: true},	
		   		{name:'PRM2_TYP',index:'PRM2_TYP', hidden: true},	
		   		{name:'PRM2_VAL',index:'PRM2_VAL', hidden: true},	
		   		{name:'PRM2_INC',index:'PRM2_INC', hidden: true},	
		   		{name:'PRM3_KEY',index:'PRM3_KEY', hidden: true},	
		   		{name:'PRM3_TYP',index:'PRM3_TYP', hidden: true},	
		   		{name:'PRM3_VAL',index:'PRM3_VAL', hidden: true},	
		   		{name:'PRM3_INC',index:'PRM3_INC', hidden: true},	
		   		{name:'PRM4_KEY',index:'PRM4_KEY', hidden: true},	
		   		{name:'PRM4_TYP',index:'PRM4_TYP', hidden: true},	
		   		{name:'PRM4_VAL',index:'PRM4_VAL', hidden: true},	
		   		{name:'PRM4_INC',index:'PRM4_INC', hidden: true},	
		   		{name:'PRM5_KEY',index:'PRM5_KEY', hidden: true},	
		   		{name:'PRM5_TYP',index:'PRM5_TYP', hidden: true},	
		   		{name:'PRM5_VAL',index:'PRM5_VAL', hidden: true},	
		   		{name:'PRM5_INC',index:'PRM5_INC', hidden: true}		   		
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:150,//"100%",
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
			        fn_selectTgtList();
				}});
		
		tabSrc.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
			        $("#spanSrcProMsg").text("");
					$("#divSrcProMsg").css("display", "none");
			        $( "#divSrcProPop" ).dialog( "open" );
					event.preventDefault();
				}});
		
		/*** Source View Grid ***/
		var tabSrcView = $("#tabSourceView");
		tabSrcView.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['순번','소스'],
		   	colModel:[
		   		{name:'RNK',index:'RNK', width:30, align:'center'},
		   		{name:'ITEM_VAL',index:'ITEM_VAL', width:170}		   		
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
		   	caption: "소스 선택"
		});
		
		tabSrcView.jqGrid('setGridParam', 
				{gridComplete: gridCompleteSrcView()});
		tabSrcView.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_srcViewRowId = rowId;
				}});
		tabSrcView.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_setSrcViewPro(rowId);
					$( "#divSrcViewPop" ).dialog( "close" );
					event.preventDefault();					
				}});		
	
		/*** Target Grid ***/
		var tabTgt = $("#tabTarget");	
		tabTgt.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['타깃ID','타깃명', 'ProjId', 'JobId', 'SrcId', 'TgtFindType', 'TgtFindVal', 'TgtRepVal', 'TgtSaveType', 'TgtSaveVal','DispOrd'],
		   	colModel:[
		   		{name:'TGT_ID',index:'TGT_ID', width:30, align:'center'},
		   		{name:'TGT_NM',index:'TGT_NM', width:150},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'JOB_ID',index:'JOB_ID', hidden: true},
		   		{name:'SRC_ID',index:'SRC_ID', hidden: true},
		   		{name:'TGT_FIND_TYPE',index:'TGT_FIND_TYPE',editable:true, hidden: true},
		   		{name:'TGT_FIND_VAL',index:'TGT_FIND_VAL',editable:true,formatter : viewHtml, unformat:viewUnHtml, hidden: true},
		   		{name:'TGT_REP_VAL',index:'TGT_REP_VAL',editable:true, formatter : viewHtml, unformat:viewUnHtml, hidden: true},
		   		{name:'TGT_SAVE_TYPE',index:'TGT_SAVE_TYPE',editable:true, hidden: true},
		   		{name:'TGT_SAVE_VAL',index:'TGT_SAVE_VAL',editable:true, formatter : viewHtml, unformat:viewUnHtml, hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "타깃"
		});
		
		tabTgt.jqGrid('setGridParam', 
				{gridComplete: gridCompleteTgt()});
		
		tabTgt.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_tgtRowId = rowId;
					fn_setTgtPro(rowId);
				}});
		tabTgt.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanTgtProMsg").text("");
					$("#divTgtProMsg").css("display", "none");					
					$( "#divTgtProPop" ).dialog( "open" );
					event.preventDefault();
				}});

		/*** tabRegexView Grid ***/
		var tabRegexViewF1 = $("#tabRegexViewF1");
		tabRegexViewF1.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['표현식ID','표현식명','Value'],
		   	colModel:[
		   		{name:'REGEX_ID',index:'REGEX_ID', width:30, align:'center'},
		   		{name:'REGEX_NM',index:'REGEX_NM', width:150},
		   		{name:'REGEX_VAL',index:'REGEX_VAL',formatter : viewHtml, unformat:viewUnHtml, hidden: true}
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
		   	caption: "정규표현식 예제"
		});
		
		tabRegexViewF1.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_regexViewF1RowId = rowId;
				}});
		tabRegexViewF1.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_setRegexViewF1Pro(rowId);
					$( "#divRegexViewF1Pop" ).dialog( "close" );
					event.preventDefault();					
				}});
		
		/*** tabRegexView Grid ***/
		var tabRegexViewR1 = $("#tabRegexViewR1");
		tabRegexViewR1.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['치환식ID','치환식명','Value'],
		   	colModel:[
		   		{name:'REGEX_ID',index:'REGEX_ID', width:50, align:'center'},
		   		{name:'REGEX_NM',index:'REGEX_NM', width:150},
		   		{name:'REGEX_VAL',index:'REGEX_VAL',formatter : viewHtml, unformat:viewUnHtml, hidden: true}
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
		   	caption: "정규치환식 예제"
		});
		
		tabRegexViewR1.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_regexViewR1RowId = rowId;
				}});
		tabRegexViewR1.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					fn_setRegexViewR1Pro(rowId);
					$( "#divRegexViewR1Pop" ).dialog( "close" );
					event.preventDefault();					
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
		
		/*** Target Add Button Click ***/
		$("#goTgtNew").on("click", function(e){
			e.preventDefault();
			//
			var tabSrc = $("#tabSource");
			var srcId = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ID');
			fn_newTgtPro(srcId);
			$("#spanTgtProMsg").text("");
			$("#divTgtProMsg").css("display", "none");
			$( "#divTgtProPop" ).dialog( "open" );
		});	
		
		/*** Target Del Button Click ***/
		$("#goTgtDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteTgtInfo');
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
		
		$("#goView").on("click", function(e){ //url
			e.preventDefault();
			//
			fn_GoView();
		});
		
		$("#goUrl").on("click", function(e){ //url
			e.preventDefault();
			//
			fn_GoUrl();
		});	
		
		$("#goRegex1").on("click", function(e){ //url
			e.preventDefault();
			//
			var tabTgt = $("#tabTarget");
			var tgtFindType = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_FIND_TYPE');
			var tgtSaveVal = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_SAVE_VAL');
			fn_RunRegex(tgtFindType,'MCH_GNM', tgtSaveVal);
		});	
		$("#goRegex2").on("click", function(e){ //url
			e.preventDefault();
			//
			var tabTgt = $("#tabTarget");
			var tgtFindType = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_FIND_TYPE');
			var tgtSaveVal = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_SAVE_VAL');
			fn_RunRegex(tgtFindType,'MCH_GNO', tgtSaveVal);
		});	
		$("#goRegex3").on("click", function(e){ //url
			e.preventDefault();
			//
			var tabTgt = $("#tabTarget");
			var tgtFindType = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_FIND_TYPE');
			var tgtSaveVal = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_SAVE_VAL');
			fn_RunRegex(tgtFindType,'MCH_ALL', tgtSaveVal);
		});			
		
		$("#goRegExam1").on("click", function(e){
			e.preventDefault();
			//
			$("#divRegexViewF1Pop" ).dialog( "open" );
		});
		
		$("#goApplyTgt").on("click", function(e){
			e.preventDefault();
			//
			fn_ApplyTgt();
		});	
		
		$("#goRepExam1").on("click", function(e){
			e.preventDefault();
			//
			$("#divRegexViewR1Pop" ).dialog( "open" );			
		});
		
		$("#goRunRegexSave").on("click", function(e){
			e.preventDefault();
			//
			fn_RunRegexSave();
		});		
		
		fn_init(0);
		
		/*** RegexView List ***/
		fn_selectRegexView('F1');
		fn_selectRegexView('R1');
		
		/*** Select Project List ***/
		fn_selectProjList();
		
	});	
	
	function viewHtml(cellvalue, options, rowObject) {
        return "<input type='text' value='" + (gfn_isNull(cellvalue)?'':escape(cellvalue.trim())) + "' style='width:100%' />";
    }
	
	function viewUnHtml(cellvalue, options, cell) {
        return unescape($('input', cell).attr('value'));
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
        var srcSaveType = tabSrc.jqGrid ('getCell', rowId, 'SRC_SAVE_TYPE');
        var delayTime = tabSrc.jqGrid ('getCell', rowId, 'DELAY_TIME');
        var loopYn = tabSrc.jqGrid ('getCell', rowId, 'LOOP_YN');
        var loopBlockCnt = tabSrc.jqGrid ('getCell', rowId, 'LOOP_BLOCK_CNT');
        var loopBlockCntAuto = tabSrc.jqGrid ('getCell', rowId, 'LOOP_BLOCK_CNT_AUTO');
        var loopCnt = tabSrc.jqGrid ('getCell', rowId, 'LOOP_CNT');
        var loopCntAuto = tabSrc.jqGrid ('getCell', rowId, 'LOOP_CNT_AUTO');
        var dispOrd = tabSrc.jqGrid ('getCell', rowId, 'DISP_ORD');
        var prm1Key = tabSrc.jqGrid ('getCell', rowId, 'PRM1_KEY');
        var prm1Typ = tabSrc.jqGrid ('getCell', rowId, 'PRM1_TYP');
        var prm1Val = tabSrc.jqGrid ('getCell', rowId, 'PRM1_VAL');
        var prm1Inc = tabSrc.jqGrid ('getCell', rowId, 'PRM1_INC');
        var prm2Key = tabSrc.jqGrid ('getCell', rowId, 'PRM2_KEY');
        var prm2Typ = tabSrc.jqGrid ('getCell', rowId, 'PRM2_TYP');
        var prm2Val = tabSrc.jqGrid ('getCell', rowId, 'PRM2_VAL');
        var prm2Inc = tabSrc.jqGrid ('getCell', rowId, 'PRM2_INC');
        var prm3Key = tabSrc.jqGrid ('getCell', rowId, 'PRM3_KEY');
        var prm3Typ = tabSrc.jqGrid ('getCell', rowId, 'PRM3_TYP');
        var prm3Val = tabSrc.jqGrid ('getCell', rowId, 'PRM3_VAL');
        var prm3Inc = tabSrc.jqGrid ('getCell', rowId, 'PRM3_INC');
        var prm4Key = tabSrc.jqGrid ('getCell', rowId, 'PRM4_KEY');
        var prm4Typ = tabSrc.jqGrid ('getCell', rowId, 'PRM4_TYP');
        var prm4Val = tabSrc.jqGrid ('getCell', rowId, 'PRM4_VAL');
        var prm4Inc = tabSrc.jqGrid ('getCell', rowId, 'PRM4_INC');
        var prm5Key = tabSrc.jqGrid ('getCell', rowId, 'PRM5_KEY');
        var prm5Typ = tabSrc.jqGrid ('getCell', rowId, 'PRM5_TYP');
        var prm5Val = tabSrc.jqGrid ('getCell', rowId, 'PRM5_VAL');
        var prm5Inc = tabSrc.jqGrid ('getCell', rowId, 'PRM5_INC');	
        
        $("#txtSrcProProjId").val(projId);
        $("#txtSrcProJobId").val(jobId);
        $("#txtSrcProSrcId").val(srcId);
        $("#txtSrcProSrcNm").val(srcNm);			        
        $("#txtSrcProSrcVal").val(srcVal);
        $("#selSrcProSrcDivCd").val(srcDivCd);
        $("#selSrcProSrcTypCd").val(srcTypCd);
        $("#txtSrcProSrcEncode").val(srcEncode);
        $("#selSrcProSrcSaveType").val(srcSaveType);
        $("#txtSrcProDelayTime").val(delayTime);
        //$("#txtSrcProSrcValPosition").val(srcValPosition);
        $("#selSrcProLoopYn").val(loopYn);
        $("#txtSrcProLoopBlockCnt").val(loopBlockCnt);
        $("#selSrcProLoopBlockCntAuto").val(loopBlockCntAuto);
        $("#txtSrcProLoopCnt").val(loopCnt);
        $("#selSrcProLoopCntAuto").val(loopCntAuto);
        $("#txtSrcProDispOrd").val(dispOrd);
        $("#txtSrcProPrm1Key").val(prm1Key);
        $("#txtSrcProPrm1Typ").val(prm1Typ);
        $("#txtSrcProPrm1Val").val(prm1Val);
        $("#txtSrcProPrm1Inc").val(prm1Inc);
        $("#txtSrcProPrm2Key").val(prm2Key);
        $("#txtSrcProPrm2Typ").val(prm2Typ);
        $("#txtSrcProPrm2Val").val(prm2Val);
        $("#txtSrcProPrm2Inc").val(prm2Inc);
        $("#txtSrcProPrm3Key").val(prm3Key);
        $("#txtSrcProPrm3Typ").val(prm3Typ);
        $("#txtSrcProPrm3Val").val(prm3Val);
        $("#txtSrcProPrm3Inc").val(prm3Inc);
        $("#txtSrcProPrm4Key").val(prm4Key);
        $("#txtSrcProPrm4Typ").val(prm4Typ);
        $("#txtSrcProPrm4Val").val(prm4Val);
        $("#txtSrcProPrm4Inc").val(prm4Inc);
        $("#txtSrcProPrm5Key").val(prm5Key);
        $("#txtSrcProPrm5Typ").val(prm5Typ);
        $("#txtSrcProPrm5Val").val(prm5Val);
        $("#txtSrcProPrm5Inc").val(prm5Inc);

        $("#txtSource").val(srcVal);
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
        $("#selSrcProSrcSaveType").val("HTML");
        $("#txtSrcProDelayTime").val('0');
        $("#selSrcProLoopYn").val('N');
        $("#txtSrcProLoopBlockCnt").val('');
        $("#selSrcProLoopBlockCntAuto").val('N');
        $("#txtSrcProLoopCnt").val('');
        $("#selSrcProLoopCntAuto").val('N');
        $("#txtSrcProDispOrd").val('');
        $("#txtSrcProPrm1Key").val('');
        $("#txtSrcProPrm1Typ").val('');
        $("#txtSrcProPrm1Val").val('');
        $("#txtSrcProPrm1Inc").val('');
        $("#txtSrcProPrm2Key").val('');
        $("#txtSrcProPrm2Typ").val('');
        $("#txtSrcProPrm2Val").val('');
        $("#txtSrcProPrm2Inc").val('');
        $("#txtSrcProPrm3Key").val('');
        $("#txtSrcProPrm3Typ").val('');
        $("#txtSrcProPrm3Val").val('');
        $("#txtSrcProPrm3Inc").val('');
        $("#txtSrcProPrm4Key").val('');
        $("#txtSrcProPrm4Typ").val('');
        $("#txtSrcProPrm4Val").val('');
        $("#txtSrcProPrm4Inc").val('');
        $("#txtSrcProPrm5Key").val('');
        $("#txtSrcProPrm5Typ").val('');
        $("#txtSrcProPrm5Val").val('');
        $("#txtSrcProPrm5Inc").val('');		
	}	
	
	/*** Setting Source View Properties ***/
	function fn_setSrcViewPro(rowId){
		var tabSrcView = $("#tabSourceView");
		var itemVal = tabSrcView.jqGrid ('getCell', (gfn_isNull(rowId)?_srcViewRowId:rowId), 'ITEM_VAL');
		
		$("#txtUrl").val(itemVal);
	}	
	
	/*** Setting Update Target Properties ***/
	function fn_setTgtPro(rowId){
		var tabTgt = $("#tabTarget");
		
		var projId = tabTgt.jqGrid ('getCell', rowId, 'PROJ_ID');
		var jobId = tabTgt.jqGrid ('getCell', rowId, 'JOB_ID');
        var srcId = tabTgt.jqGrid ('getCell', rowId, 'SRC_ID');
        var tgtId = tabTgt.jqGrid ('getCell', rowId, 'TGT_ID');
        var tgtNm = tabTgt.jqGrid ('getCell', rowId, 'TGT_NM');
        var tgtFindType = tabTgt.jqGrid ('getCell', rowId, 'TGT_FIND_TYPE');
        var tgtFindVal = tabTgt.jqGrid ('getCell', rowId, 'TGT_FIND_VAL');
        var tgtRepVal = tabTgt.jqGrid ('getCell', rowId, 'TGT_REP_VAL');
        var tgtSaveType = tabTgt.jqGrid ('getCell', rowId, 'TGT_SAVE_TYPE');
        var tgtSaveVal = tabTgt.jqGrid ('getCell', rowId, 'TGT_SAVE_VAL');
        var dispOrd = tabTgt.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtRegex").val(tgtFindVal);
		$("#txtReplaceRegex").val(tgtRepVal);
		$("#txtRegexResult").val('');
		
		$("#txtTgtProProjId").val(projId);
		$("#txtTgtProJobId").val(jobId);
		$("#txtTgtProSrcId").val(srcId);
		$("#txtTgtProTgtId").val(tgtId);
		$("#txtTgtProTgtNm").val(tgtNm);
		$("#txtTgtProTgtFindType").val(tgtFindType);
		$("#txtTgtProTgtFindVal").val(tgtFindVal);
		$("#txtTgtProTgtRepVal").val(tgtRepVal);
		$("#txtTgtProTgtSaveType").val(tgtSaveType);
		$("#txtTgtProTgtSaveVal").val(tgtSaveVal);
		$("#txtTgtProDispOrd").val(dispOrd);
	}
	
	/*** Setting New Target Properties ***/
	function fn_newTgtPro(srcId){
		$("#txtTgtProProjId").val(_projId);
		$("#txtTgtProJobId").val(_jobId);
		$("#txtTgtProSrcId").val(srcId);
		$("#txtTgtProTgtId").val("New");
		$("#txtTgtProTgtNm").val('');
		$("#txtTgtProTgtFindType").val('REG');
		$("#txtTgtProTgtFindVal").val('');
		$("#txtTgtProTgtRepVal").val('');
		$("#txtTgtProTgtSaveType").val('TABLE');
		$("#txtTgtProTgtSaveVal").val('');
		$("#txtTgtProDispOrd").val('');
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
	
	function fn_ApplyTgt()
	{
		var tabTgt = $("#tabTarget");
		
		tabTgt.jqGrid('setCell', _tgtRowId, 'TGT_FIND_VAL', $("#txtRegex").val()+' ');
		tabTgt.jqGrid('setCell', _tgtRowId, 'TGT_REP_VAL',  $("#txtReplaceRegex").val()+' ');
		
		fn_setTgtPro(_tgtRowId);
		
		_alert('cfm','','fn_saveTgtInfo');
	}
	
	/*** Select Project Ajax Call ***/
	function fn_selectProjList(){
		
		fn_init(1);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsProjectList.do' />");
		comAjax.setCallback("fn_selectProjectListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("COLECT_TYP_CD","CRW");	// Crawling 대상
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
	
	/*** Select Job Ajax Call ***/
	function fn_selectJobList(){
		
		fn_init(2);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsJobList.do' />");
		comAjax.setCallback("fn_selectJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.ajax();
	}	
	/*** Select Job Ajax Callback ***/
	function fn_selectJobListCallback(data){

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
	
	/*** Select Template Job Ajax Call ***/
	function fn_selectTempJobList(){
		
		$("#tabTempJob").jqGrid("clearGridData", true);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsTempJobList.do' />");
		comAjax.setCallback("fn_selectTempJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}	
	/*** Select Template Job Ajax Callback ***/
	function fn_selectTempJobListCallback(data){

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
	
	/*** Apply Template Job Ajax Call ***/
	function fn_applyTempJob(){
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/applyDsTempJob.do' />");
		comAjax.setCallback("fn_applyTempJobCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("TEMP_USR_ID",_tempUsrId);
		comAjax.addParam("TEMP_PROJ_ID",_tempProjId);
		comAjax.addParam("TEMP_JOB_ID",_tempJobId);
		comAjax.ajax();
	}	
	/*** apply  Template Job Ajax Callback ***/
	function fn_applyTempJobCallback(data){
		_alert('info','Success!!!','fn_selectSrcList');		
	}
	
	/*** Select Source Ajax Call ***/
	function fn_selectSrcList(){
		
		fn_init(3);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsSourceList.do' />");
		comAjax.setCallback("fn_selectSrcListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}
	
	/*** Select Source Ajax Callback ***/
	function fn_selectSrcListCallback(data){

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
			comAjax.setUrl("<c:url value='/datasearch/selectDsExeItemVal.do' />");
			comAjax.setCallback("fn_selectDsExeItemValCallback");
			comAjax.addParam("EXE_NUM","0");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("SRC_VAL",srcVal);
			comAjax.addParam("ROW_NUM",rowNum);
			comAjax.ajax();
		}else if(srcTypCd == 'OTHER'){
			var comAjax = new ComAjax();
			comAjax.setAsyncFlag(false);
			comAjax.setUrl("<c:url value='/datasearch/selectDsExeItemValForApi.do' />");
			comAjax.setCallback("fn_selectDsExeItemValCallback");
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
	function fn_selectDsExeItemValCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabSourceView").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0){
			$("#tabSourceView").jqGrid('setSelection','1');
			
			fn_setSrcViewPro(1);
		}
	}
	
	/*** Select Target Complete ***/
	function gridCompleteTgt(){
		//
	}
	
	/*** Select Target Ajax Call ***/
	function fn_selectTgtList(){
		
		fn_init(4);

		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsTargetList.do' />");
		comAjax.setCallback("fn_selectTgtListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",_srcId);
		comAjax.ajax();
	}
	
	/*** Select Target Ajax Callback ***/
	function fn_selectTgtListCallback(data){

		if(data == null){return;}
		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabTarget").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_tgtRowId)
			$("#tabTarget").jqGrid('setSelection',_tgtRowId);
		else if(mydata.length>0)
			$("#tabTarget").jqGrid('setSelection','1');		
	}
	
	/*** Select RegexView Ajax Call ***/
	function fn_selectRegexView(regexDiv){
		
		$("#tabRegexView"+regexDiv).jqGrid("clearGridData", true);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsRegexView.do' />");
		if(regexDiv == "F1"){
			comAjax.setCallback("fn_selectRegexViewF1Callback");
		}else if(regexDiv == "R1"){
			comAjax.setCallback("fn_selectRegexViewR1Callback");
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("REGEX_DIV",regexDiv);
		comAjax.ajax();
	}	
	/*** Select RegexView Ajax Callback ***/
	function fn_selectRegexViewF1Callback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabRegexViewF1").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabRegexViewF1").jqGrid('setSelection','1');
		}
	}
	/*** Select RegexView Ajax Callback ***/
	function fn_selectRegexViewR1Callback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabRegexViewR1").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabRegexViewR1").jqGrid('setSelection','1');
		}
	}	

	/*** Save Source Ajax Call ***/
	function fn_saveSrcInfo(){
		
		var srcId = $("#txtSrcProSrcId").val();
		var srcNm = $("#txtSrcProSrcNm").val();
		var srcVal = $("#txtSrcProSrcVal").val();
		var srcDivCd = $("#selSrcProSrcDivCd option:selected").val();
		var srcTypCd = $("#selSrcProSrcTypCd option:selected").val();
		var srcEncode = $("#txtSrcProSrcEncode").val();
		var srcValPosition = '';
		var srcSaveType = $("#selSrcProSrcSaveType option:selected").val();
		var delayTime = $("#txtSrcProDelayTime").val();
		var loopYn = $("#selSrcProLoopYn option:selected").val();
		var loopBlockCnt = $("#txtSrcProLoopBlockCnt").val();
		var loopBlockCntAuto = $("#selSrcProLoopBlockCntAuto option:selected").val();
		var loopCnt = $("#txtSrcProLoopCnt").val();
		var loopCntAuto = $("#selSrcProLoopCntAuto option:selected").val();
		var dispOrd = $("#txtSrcProDispOrd").val();
		var prm1Key = $("#txtSrcProPrm1Key").val();
		var prm1Typ = $("#txtSrcProPrm1Typ").val();
		var prm1Val = $("#txtSrcProPrm1Val").val();
		var prm1Inc = $("#txtSrcProPrm1Inc").val();
		var prm2Key = $("#txtSrcProPrm2Key").val();
		var prm2Typ = $("#txtSrcProPrm2Typ").val();
		var prm2Val = $("#txtSrcProPrm2Val").val();
		var prm2Inc = $("#txtSrcProPrm2Inc").val();
		var prm3Key = $("#txtSrcProPrm3Key").val();
		var prm3Typ = $("#txtSrcProPrm3Typ").val();
		var prm3Val = $("#txtSrcProPrm3Val").val();
		var prm3Inc = $("#txtSrcProPrm3Inc").val();
		var prm4Key = $("#txtSrcProPrm4Key").val();
		var prm4Typ = $("#txtSrcProPrm4Typ").val();
		var prm4Val = $("#txtSrcProPrm4Val").val();
		var prm4Inc = $("#txtSrcProPrm4Inc").val();
		var prm5Key = $("#txtSrcProPrm5Key").val();
		var prm5Typ = $("#txtSrcProPrm5Typ").val();
		var prm5Val = $("#txtSrcProPrm5Val").val();
		var prm5Inc = $("#txtSrcProPrm5Inc").val();
		
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
			comAjax.setUrl("<c:url value='/datasearch/insDsSourceInfo.do' />");
			comAjax.setCallback("fn_insSourceInfoCallback");
			comAjax.addParam("SRC_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsSourceInfo.do' />");
			comAjax.setCallback("fn_saveSourceInfoCallback");
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
		comAjax.addParam("SRC_SAVE_TYPE",srcSaveType);
		comAjax.addParam("DELAY_TIME",delayTime);		
		
		//comAjax.addParam("SRC_VAL_POSITION",$("#txtSrcProSrcValPosition").val());
		
		comAjax.addParam("LOOP_YN",loopYn);
		comAjax.addParam("LOOP_BLOCK_CNT",loopBlockCnt);
		comAjax.addParam("LOOP_BLOCK_CNT_AUTO",loopBlockCntAuto);
		comAjax.addParam("LOOP_CNT",loopCnt);
		comAjax.addParam("LOOP_CNT_AUTO",loopCntAuto);
		comAjax.addParam("DISP_ORD",dispOrd);
		comAjax.addParam("PRM1_KEY",prm1Key);
		comAjax.addParam("PRM1_TYP",prm1Typ);
		comAjax.addParam("PRM1_VAL",prm1Val);
		comAjax.addParam("PRM1_INC",prm1Inc);
		comAjax.addParam("PRM2_KEY",prm2Key);
		comAjax.addParam("PRM2_TYP",prm2Typ);
		comAjax.addParam("PRM2_VAL",prm2Val);
		comAjax.addParam("PRM2_INC",prm2Inc);
		comAjax.addParam("PRM3_KEY",prm3Key);
		comAjax.addParam("PRM3_TYP",prm3Typ);
		comAjax.addParam("PRM3_VAL",prm3Val);
		comAjax.addParam("PRM3_INC",prm3Inc);
		comAjax.addParam("PRM4_KEY",prm4Key);
		comAjax.addParam("PRM4_TYP",prm4Typ);
		comAjax.addParam("PRM4_VAL",prm4Val);
		comAjax.addParam("PRM4_INC",prm4Inc);
		comAjax.addParam("PRM5_KEY",prm5Key);
		comAjax.addParam("PRM5_TYP",prm5Typ);
		comAjax.addParam("PRM5_VAL",prm5Val);
		comAjax.addParam("PRM5_INC",prm5Inc);
		
		comAjax.ajax();
	}
	
	/*** Delete Source Ajax Call ***/
	function fn_deleteSrcInfo(){
		var tabSrc = $("#tabSource");
		var srcId = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsSourceInfo.do' />");
		comAjax.setCallback("fn_delSourceInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.ajax();
	}
	
	/*** Insert Source Ajax Callback ***/
	function fn_insSourceInfoCallback(data){
		$("#divSrcProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');
	}
	
	/*** Delete Source Ajax Callback ***/
	function fn_delSourceInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');
	}
	
	/*** Update Source Ajax Callback ***/
	function fn_saveSourceInfoCallback(data){
		$("#divSrcProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectSrcList');;
	}
	
	/*** Save Target Ajax Call ***/
	function fn_saveTgtInfo(){
		
		var projId = $("#txtTgtProProjId").val();
		var jobId = $("#txtTgtProJobId").val();
		var srcId = $("#txtTgtProSrcId").val();
		var tgtId = $("#txtTgtProTgtId").val();
		var tgtNm = $("#txtTgtProTgtNm").val();
		var tgtFindType = $("#txtTgtProTgtFindType").val();
		var tgtFindVal = $("#txtTgtProTgtFindVal").val();
		var tgtRepVal = $("#txtTgtProTgtRepVal").val();
		var tgtSaveType = $("#txtTgtProTgtSaveType").val();
		var tgtSaveVal = $("#txtTgtProTgtSaveVal").val();
		var dispOrd = $("#txtTgtProDispOrd").val();
		
		if(gfn_isNull(tgtNm)){
			$("#spanTgtProMsg").text("유효값을 입력하세요.");
			$("#divTgtProMsg").css("display", "block");
			$("#txtTgtProTgtNm").focus();
			return false;
		}
		if(gfn_isNull(tgtFindType)){
			$("#spanTgtProMsg").text("유효값을 입력하세요.");
			$("#divTgtProMsg").css("display", "block");
			$("#txtTgtProTgtFindType").focus();
			return false;
		}
		if(gfn_isNull(tgtFindVal)){
			$("#spanTgtProMsg").text("유효값을 입력하세요.");
			$("#divTgtProMsg").css("display", "block");
			$("#txtTgtProTgtFindVal").focus();
			return false;
		}		

		var comAjax = new ComAjax();
		if(tgtId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsTargetInfo.do' />");
			comAjax.setCallback("fn_insTargetInfoCallback");
			comAjax.addParam("TGT_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsTargetInfo.do' />");
			comAjax.setCallback("fn_saveTargetInfoCallback");
			comAjax.addParam("TGT_ID",tgtId);
		}
		
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("TGT_NM",tgtNm);
		comAjax.addParam("TGT_FIND_TYPE",tgtFindType);
		comAjax.addParam("TGT_FIND_VAL",tgtFindVal);
		comAjax.addParam("TGT_REP_VAL",tgtRepVal);
		comAjax.addParam("TGT_SAVE_TYPE",tgtSaveType);
		comAjax.addParam("TGT_SAVE_VAL",tgtSaveVal);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete Target Ajax Call ***/
	function fn_deleteTgtInfo(){
		var tabTgt = $("#tabTarget");
		var srcId = tabTgt.jqGrid ('getCell', _tgtRowId, 'SRC_ID');
		var tgtId = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsTargetInfo.do' />");
		comAjax.setCallback("fn_delTargetInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("TGT_ID",tgtId);
		comAjax.ajax();
	}	
	
	/*** Insert Target Ajax Callback ***/
	function fn_insTargetInfoCallback(data){
		$("#divTgtProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectTgtList');;
	}
	
	/*** Delete Target Ajax Callback ***/
	function fn_delTargetInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectTgtList');;
	}
	
	/*** Update Target Ajax Callback ***/
	function fn_saveTargetInfoCallback(data){
		$("#divTgtProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectTgtList');;
	}	
	
	// 	
	function fn_GoView(){
		$( "#divSrcViewPop" ).dialog( "open" );
	}	
	
	// AJAX 호출 예제		
	function fn_GoUrl(){
		
		$("#txtPageSource").val("");
		var tabSrc = $("#tabSource");
		var srcEncode = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ENCODE');
		var srcSaveType= tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_SAVE_TYPE');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/goUrl.do' />");
		comAjax.setCallback("fn_getUrlCallback");
		comAjax.addParam("URL",$("#txtUrl").val());
		comAjax.addParam("SRC_ENCODE",srcEncode);
		comAjax.addParam("SRC_SAVE_TYPE",srcSaveType);
		comAjax.ajax();
	}
	
	function fn_getUrlCallback(data){
		if(data == null){return;}
		$("#txtPageSource").val(data.result);
	}
	
	function fn_RunRegex(tgtFindType,disptype, tgtSaveVal){
		
		$("#txtRegexResult").val("");
		
		var comAjax = new ComAjax();
		
		comAjax.setUrl("<c:url value='/datasearch/runRegex.do' />");
		comAjax.setCallback("fn_RunRegexCallback");
		comAjax.addParam2("CONTENT",$("#txtPageSource").val());
		comAjax.addParam("URL",$("#txtUrl").val());
		comAjax.addParam("REGEX",$("#txtRegex").val());		
		comAjax.addParam("REPLACEREGEX",$("#txtReplaceRegex").val());
		comAjax.addParam("TGT_FIND_TYPE",tgtFindType);
		comAjax.addParam("DISPTYPE",disptype);
		comAjax.addParam("TGT_SAVE_VAL",tgtSaveVal);
		comAjax.ajax();
	}
	
	function fn_RunRegexCallback(data){
		if(data == null||data.result==null||data.result.length<=0){return;}
		var sVal = "";
		$.each(data.result, function(key, value){
			$.each(value, function(key2, value2){
				if(key2 == "REGEX"){
					sVal += value2 + "\n";
				}else{
					sVal += "[" + key2 + "]" + value2 + "\n";
				}
			});
			sVal += "\n";
		});
		$("#txtRegexResult").val(sVal);
	}
	
	/*** Crawling Result Save Ajax Call ***/
	function fn_RunRegexSave()
	{
		var tabTgt = $("#tabTarget");
		var srcId = tabTgt.jqGrid ('getCell', _tgtRowId, 'SRC_ID');
		var tgtId = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_ID');
		var tgtFindType = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_FIND_TYPE');
		var tgtSaveVal = tabTgt.jqGrid ('getCell', _tgtRowId, 'TGT_SAVE_VAL');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/runRegexSave.do' />");
		comAjax.setCallback("fn_RunRegexSaveCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("TGT_ID",tgtId);
		comAjax.addParam("URL",$("#txtUrl").val());
		comAjax.addParam2("CONTENT",$("#txtPageSource").val());
		comAjax.addParam("REGEX",$("#txtRegex").val());		
		comAjax.addParam("REPLACEREGEX",$("#txtReplaceRegex").val());	
		comAjax.addParam("TGT_FIND_TYPE",tgtFindType);
		comAjax.addParam("TGT_SAVE_VAL",tgtSaveVal);
		comAjax.ajax();
	}
	
	/*** Crawling Result Save Ajax Callback ***/
	function fn_RunRegexSaveCallback(data){
		
		if(data == null||data.result==null||data.result.length<=0){return;}
		var sVal = "";
		$.each(data.result, function(key, value){
			$.each(value, function(key2, value2){
				if(key2 == "REGEX"){
					sVal += value2 + "\n";
				}else{
					sVal += "[" + key2 + "]" + value2 + "\n";
				}
			});
			sVal += "\n";
		});
		$("#txtRegexResult").val(sVal);
		
		_alert('info','Success!!!','');
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Job), 3 (Source), 4(Target)
	*/	
	function fn_init(step){
		if(step<=0){
			_srcRowId = '1';
			_tgtRowId = '1';
		}
			
		if(step<=1){
						
			$("#txtProjId").val('');
			$("#txtProjNm").val('');
			
			$("#tabProject").jqGrid("clearGridData", true);
		}
		
		if(step<=2){
			_srcRowId = '1';
			_tgtRowId = '1';
			$("#txtJobId").val('');
			$("#txtJobNm").val('');
			
			$("#tabJob").jqGrid("clearGridData", true);
		}
		
		if(step<=3){
			$("#tabSource").jqGrid("clearGridData", true);
			$("#tabSourceView").jqGrid("clearGridData", true);
			$("#txtSource").val('');
			$("#txtUrl").val('');
		}
		
		if(step<=4){
			$("#tabTarget").jqGrid("clearGridData", true);
			$("#txtRegex").val('');
			$("#txtReplaceRegex").val('');
		}
		
	}
</script>
</body>
</html>