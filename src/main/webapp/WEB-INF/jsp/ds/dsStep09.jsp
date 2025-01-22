<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 배치관리 -->
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
    
  #divProjPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }  
  
  #divJobPro{
  	width:100%;
  	vertical-align: top;
  }
  
  #divBatJobProPop{
  	display:none;
  }  
  #divBatJobProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divBatJobProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divBatJobProPop .inputLabel2{
  	display:inline-block;
  	text-align:center;
  } 
  #divBatJobProPop .inputText{
  	height:20px;
  }
   
  #divBatJobPrmProPop{
  	display:none;
  }   
  #divBatJobPrmProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divBatJobPrmProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divBatJobPrmProPop .inputText{
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
				<table id="tabBatJob"></table>
				<!-- <div id="pagerid"></div> -->
			</td>
		</tr>
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goBatJobNew" class="button" style="width:70px;">등록</button>
				<button id="goBatJobDel" class="button" style="width:70px;">삭제</button>
			</td>
		</tr>		
		<tr>
			<td class="tdContent">
				<table id="tabBatJobPrm"></table>
			</td>			
		</tr>
		<tr>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goBatJobPrmNew" class="button" style="width:70px;">등록</button>
				<button id="goBatJobPrmDel" class="button" style="width:70px;">삭제</button>
			</td>			
		</tr>		
	</tbody>
</table>

<!-- 본문영역 (끝) -->		
<%@ include file="/WEB-INF/include/include-bodyBottom.jspf" %>
<!-- 팝업DIV영역(시작) -->

<div id="divBatJobProPop" title="배치작업 속성정보" style="line-height:2.8;">
<span class="inputLabel">배치ID(*)</span><input id="txtBatJobProBatId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">배치명(*)</span><input id="txtBatJobProBatNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">호출유형(*)</span><select id="selBatJobProCalType" style="width:350px;"><option value="JAVA">자바</option><option value="PRC">프로시저</option><option value="EXE">실행파일</option><option value="SVC">웹서비스</option></select>
<br/><span class="inputLabel">호출프로그램명(*)</span><input id="txtBatJobProCalPrgm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">호출파일경로</span><input id="txtBatJobProCalFilePath" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">배치유형(*)</span><select id="selBatJobProBatType" style="width:350px;"><option value="UNT">단일배치</option><option value="FST">최초배치(그룹배치)</option><option value="LST">최종배치(그룹배치)</option></select>
<br/><span class="inputLabel">배치월기준(*)</span><input id="txtBatJobProBatSchMm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">*:해당없음, 01~12:해당월</span>
<br/><span class="inputLabel">배치일기준(*)</span><input id="txtBatJobProBatSchDd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">*:해당없음, 01~31:해당일</span>
<br/><span class="inputLabel">배치시기준(*)</span><input id="txtBatJobProBatSchHh" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">*:해당없음, 00~23:해당시</span>
<br/><span class="inputLabel">배치분기준(*)</span><input id="txtBatJobProBatSchMi" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">*:해당없음, 00~59:해당분</span>
<br/><span class="inputLabel">선행배치ID</span><input id="txtBatJobProLedBatId" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc"></span>
<br/><span class="inputLabel">그룹배치ID</span><input id="txtBatJobProGrpBatId" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc"></span>
<br/><span class="inputLabel">사용여부(*)</span><select id="selBatJobProUseYn" style="width:350px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">출력순서(*)</span><input id="txtBatJobProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수로 입력하세요.</span>
<div id="divBatJobProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanBatJobProMsg"></span></p>
	</div>
</div>
</div>
</div>

<div id="divBatJobPrmProPop" title="배치파라미터 속성정보" style="line-height:2.8;">
<span class="inputLabel">배치ID(*)</span><input id="txtBatJobPrmProBatId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">파라미터순번(*)</span><input id="txtBatJobPrmProPrmId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input>
<br/><span class="inputLabel">파라미터명(*)</span><input id="txtBatJobPrmProPrmNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">파라미터키(*)</span><input id="txtBatJobPrmProPrmKey" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">파라미터값(*)</span><input id="txtBatJobPrmProPrmVal" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">고정값여부(*)</span><select id="selBatJobPrmProPrmFixYn" style="width:350px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">파라미터유형(*)</span><select id="selBatJobPrmProPrmType" style="width:350px;"><option value="STR">문자</option><option value="NUM">숫자</option></select>
<br/><span class="inputLabel">사용여부(*)</span><select id="selBatJobPrmProUseYn" style="width:350px;"><option value="Y">Y</option><option value="N">N</option></select>
<br/><span class="inputLabel">출력순서(*)</span><input id="txtBatJobPrmProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">정수로 입력하세요.</span>
<div id="divBatJobPrmProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>메시지:</strong> <span id="spanBatJobPrmProMsg"></span></p>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
	var rowNum = 10;
	var _batjobRowId = '1';
	var _batjobprmRowId = '1';
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#goBatJobNew" ).button();
		$( "#goBatJobDel" ).button();
		$( "#goBatJobPrmNew" ).button();
		$( "#goBatJobPrmDel" ).button();
		
		/*** Project properties Poupup ***/
		$( "#divBatJobProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveBatJobInfo();
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
				var calType = 'JAVA';
				if(_batjobRowId != ''){calType = $("#tabBatJob").jqGrid ('getCell', _batjobRowId, 'CAL_TYPE');}
				$("#selBatJobProCalType").selectmenu();
				$("#selBatJobProCalType").val(calType);
				$('#selBatJobProCalType').selectmenu('refresh', true);
				
				var batType = 'UNT';
				if(_batjobRowId != ''){batType = $("#tabBatJob").jqGrid ('getCell', _batjobRowId, 'BAT_TYPE');}
				$("#selBatJobProBatType").selectmenu();
				$("#selBatJobProBatType").val(batType);
				$('#selBatJobProBatType').selectmenu('refresh', true);
				
				var useYn = 'Y';
				if(_batjobRowId != ''){useYn = $("#tabBatJob").jqGrid ('getCell', _batjobRowId, 'USE_YN');}
				$("#selBatJobProUseYn").selectmenu();
				$("#selBatJobProUseYn").val(useYn);
				$('#selBatJobProUseYn').selectmenu('refresh', true);
			}
		});	
		
		/*** Job properties Poupup ***/
		$( "#divBatJobPrmProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "저장",
					click: function() {
						fn_saveBatJobPrmInfo();
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
				var prmFixYn = 'Y';
				if(_batjobprmRowId != ''){prmFixYn = $("#tabBatJobPrm").jqGrid ('getCell', _batjobprmRowId, 'PRM_FIX_YN');}
				$("#selBatJobPrmProPrmFixYn").selectmenu();
				$("#selBatJobPrmProPrmFixYn").val(prmFixYn);
				$('#selBatJobPrmProPrmFixYn').selectmenu('refresh', true);
				
				var prmType = 'STR';
				if(_batjobprmRowId != ''){prmType = $("#tabBatJobPrm").jqGrid ('getCell', _batjobprmRowId, 'PRM_TYPE');}
				$("#selBatJobPrmProPrmType").selectmenu();
				$("#selBatJobPrmProPrmType").val(prmType);
				$('#selBatJobPrmProPrmType').selectmenu('refresh', true);
				
				var useYn = 'Y';
				if(_batjobprmRowId != ''){useYn = $("#tabBatJobPrm").jqGrid ('getCell', _batjobprmRowId, 'USE_YN');}
				$("#selBatJobPrmProUseYn").selectmenu();
				$("#selBatJobPrmProUseYn").val(useYn);
				$('#selBatJobPrmProUseYn').selectmenu('refresh', true);
			}
		});	
		
		$( "#divBatJobProPop" ).dialog( "close" );
		$( "#divBatJobPrmProPop" ).dialog( "close" );
		
		/*** 배치작업 Grid ***/
		var tabBatJob = $("#tabBatJob");
		tabBatJob.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['배치ID','배치명', '호출유형', '호출프로그램명', '호출파일경로', '배치유형', '배치기준', '선행배치ID', '그룹배치ID','사용여부', '월기준', '일기준', '시기준', '분기준', '출력순서', '사용자ID'],
		   	colModel:[
		   		{name:'BAT_ID',index:'BAT_ID', width:50, align:'center'},
		   		{name:'BAT_NM',index:'BAT_NM', width:150},
		   		{name:'CAL_TYPE',index:'CAL_TYPE', width:50, align:'center'},
		   		{name:'CAL_PRGM',index:'CAL_PRGM', width:150},
		   		{name:'CAL_FILE_PATH',index:'CAL_FILE_PATH', width:50},
		   		{name:'BAT_TYPE',index:'BAT_TYPE', width:50, align:'center'},
		   		{name:'BAT_SCH',index:'BAT_SCH', width:70, align:'center'},
		   		{name:'LED_BAT_ID',index:'LED_BAT_ID', width:50, align:'center'},
		   		{name:'GRP_BAT_ID',index:'GRP_BAT_ID', width:50, align:'center'},
		   		{name:'USE_YN',index:'USE_YN', width:30, align:'center'},
		   		{name:'BAT_SCH_MM',index:'BAT_SCH_MM', hidden: true},
		   		{name:'BAT_SCH_DD',index:'BAT_SCH_DD', hidden: true},
		   		{name:'BAT_SCH_HH',index:'BAT_SCH_HH', hidden: true},
		   		{name:'BAT_SCH_MI',index:'BAT_SCH_MI', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true},
		   		{name:'USR_ID',index:'USR_ID', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:1230,
			height:200,//"100%",
			hidegrid : false, 
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		    /* pager : $("#pagerid"), */ 
		   	caption: "배치작업"
		});
		
		tabBatJob.jqGrid('setGridParam', 
				{gridComplete: gridCompleteBatJob()});
		
		tabBatJob.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_batjobRowId = rowId;
					var batId = tabBatJob.jqGrid ('getCell', rowId, 'BAT_ID');
					fn_setBatJobPro(rowId);			        
			        fn_selectBatJobPrmList(batId);
				}});
		
		tabBatJob.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanBatJobProMsg").text("");
					$("#divBatJobProMsg").css("display", "none");
			        $( "#divBatJobProPop" ).dialog( "open" );
					event.preventDefault();
				}});		
	
		/*** Job Grid ***/
		var tabBatJobPrm = $("#tabBatJobPrm");	
		tabBatJobPrm.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['파라미터ID','파라미터명','파라미터키','파라미터값','고정값여부','파라미터유형','사용여부','배치ID' ,'출력순서'],
		   	colModel:[
		   		{name:'PRM_ID',index:'PRM_ID', width:50, align:'center'},
		   		{name:'PRM_NM',index:'PRM_NM', width:150},
		   		{name:'PRM_KEY',index:'PRM_KEY', width:120},
		   		{name:'PRM_VAL',index:'PRM_VAL', width:100},
		   		{name:'PRM_FIX_YN',index:'PRM_FIX_YN', width:50, align:'center'},
		   		{name:'PRM_TYPE',index:'PRM_TYPE', width:50, align:'center'},
		   		{name:'USE_YN',index:'USE_YN', width:30, align:'center'},
		   		{name:'BAT_ID',index:'BAT_ID', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:1230,
			height:400,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "배치파라미터"
		});
		
		tabBatJobPrm.jqGrid('setGridParam', 
				{gridComplete: gridCompleteBatJobPrm()});
		
		tabBatJobPrm.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_batjobprmRowId = rowId;
					fn_setBatJobPrmPro(rowId);
				}});
		
		tabBatJobPrm.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanBatJobPrmProMsg").text("");
					$("#divBatJobPrmProMsg").css("display", "none");
					$( "#divBatJobPrmProPop" ).dialog( "open" );
					event.preventDefault();
				}});
		
		/*** Project Add Button Click ***/
		$("#goBatJobNew").on("click", function(e){
			e.preventDefault();
			//
			fn_newBatJobPro();
			$("#spanBatJobProMsg").text("");
			$("#divBatJobProMsg").css("display", "none");
			$( "#divBatJobProPop" ).dialog( "open" );
		});
		
		/*** Project Del Button Click ***/
		$("#goBatJobDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteBatJobInfo');
		});		
		
		/*** Job Add Button Click ***/
		$("#goBatJobPrmNew").on("click", function(e){
			e.preventDefault();
			//
			var tabBatJob = $("#tabBatJob");
			var batId = tabBatJob.jqGrid ('getCell', _batjobRowId, 'BAT_ID');
			fn_newBatJobPrmPro(batId);
			$("#spanBatJobPrmProMsg").text("");
			$("#divBatJobPrmProMsg").css("display", "none");
			$( "#divBatJobPrmProPop" ).dialog( "open" );
		});	
		
		/*** Job Del Button Click ***/
		$("#goBatJobPrmDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteBatJobPrmInfo');
		});			

		fn_init(0);
		
		/*** Select Project List ***/
		fn_selectBatJobList();
		
	});		
	
	/*** Select Project Complete ***/
	function gridCompleteBatJob(){
		//
	}
	
	/*** Setting Update Project Properties ***/
	function fn_setBatJobPro(rowId){
		var tabBatJob = $("#tabBatJob");
		
		var batId = tabBatJob.jqGrid ('getCell', rowId, 'BAT_ID');
		var batNm = tabBatJob.jqGrid ('getCell', rowId, 'BAT_NM');
		var calType = tabBatJob.jqGrid ('getCell', rowId, 'CAL_TYPE');
		var calPrgm = tabBatJob.jqGrid ('getCell', rowId, 'CAL_PRGM');
		var calFilePath = tabBatJob.jqGrid ('getCell', rowId, 'CAL_FILE_PATH');
		var batType = tabBatJob.jqGrid ('getCell', rowId, 'BAT_TYPE');
		var batSchMm = tabBatJob.jqGrid ('getCell', rowId, 'BAT_SCH_MM');
		var batSchDd = tabBatJob.jqGrid ('getCell', rowId, 'BAT_SCH_DD');
		var batSchHh = tabBatJob.jqGrid ('getCell', rowId, 'BAT_SCH_HH');
		var batSchMi = tabBatJob.jqGrid ('getCell', rowId, 'BAT_SCH_MI');
		var ledBatId = tabBatJob.jqGrid ('getCell', rowId, 'LED_BAT_ID');
		var grpBatId = tabBatJob.jqGrid ('getCell', rowId, 'GRP_BAT_ID');
		var useYn = tabBatJob.jqGrid ('getCell', rowId, 'USE_YN');
		var dispOrd = tabBatJob.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtBatJobProBatId").val(batId);
        $("#txtBatJobProBatNm").val(batNm);
        $("#selBatJobProCalType").val(calType);
        $("#txtBatJobProCalPrgm").val(calPrgm);
        $("#txtBatJobProCalFilePath").val(calFilePath);        
        $("#selBatJobProBatType").val(batType);
        $("#txtBatJobProBatSchMm").val(batSchMm);
        $("#txtBatJobProBatSchDd").val(batSchDd);
        $("#txtBatJobProBatSchHh").val(batSchHh);
        $("#txtBatJobProBatSchMi").val(batSchMi);
        $("#txtBatJobProLedBatId").val(ledBatId);
        $("#txtBatJobProGrpBatId").val(grpBatId);
        $("#selBatJobProUseYn").val(useYn);
        $("#txtBatJobProDispOrd").val(dispOrd);

	}
	
	/*** Setting New Project Properties ***/
	function fn_newBatJobPro(){
		
		_batjobRowId = '';
        
        $("#txtBatJobProBatId").val("New");
        $("#txtBatJobProBatNm").val('');
        $("#selBatJobProCalType").val('JAVA');
        $("#txtBatJobProCalPrgm").val('');
        $("#txtBatJobProCalFilePath").val('');        
        $("#selBatJobProBatType").val('UNT');
        $("#txtBatJobProBatSchMm").val('*');
        $("#txtBatJobProBatSchDd").val('*');
        $("#txtBatJobProBatSchHh").val('*');
        $("#txtBatJobProBatSchMi").val('*');
        $("#txtBatJobProLedBatId").val('');
        $("#txtBatJobProGrpBatId").val('');
        $("#selBatJobProUseYn").val('Y');
        $("#txtBatJobProDispOrd").val('');		
	}	
	
	/*** Setting Update Job Properties ***/
	function fn_setBatJobPrmPro(rowId){
		var tabBatJobPrm = $("#tabBatJobPrm");
		
		var batId = tabBatJobPrm.jqGrid ('getCell', rowId, 'BAT_ID');
		var prmId = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_ID');
		var prmNm = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_NM');
		var prmKey = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_KEY');
		var prmVal = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_VAL');
		var prmFixYn = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_FIX_YN');
		var prmType = tabBatJobPrm.jqGrid ('getCell', rowId, 'PRM_TYPE');
		var useYn = tabBatJobPrm.jqGrid ('getCell', rowId, 'USE_YN');
	    var dispOrd = tabBatJobPrm.jqGrid ('getCell', rowId, 'DISP_ORD');
	    
	    $("#txtBatJobPrmProBatId").val(batId);
	    $("#txtBatJobPrmProPrmId").val(prmId);
	    $("#txtBatJobPrmProPrmNm").val(prmNm);
	    $("#txtBatJobPrmProPrmKey").val(prmKey);
	    $("#txtBatJobPrmProPrmVal").val(prmVal);
	    $("#selBatJobPrmProPrmFixYn").val(prmFixYn);
	    $("#selBatJobPrmProPrmType").val(prmType);
	    $("#selBatJobPrmProUseYn").val(useYn);
	    $("#txtBatJobPrmProDispOrd").val(dispOrd);

	}
	
	/*** Setting New Batch Job Param Properties ***/
	function fn_newBatJobPrmPro(batId){
		
		_batjobprmRowId = '';
		
	    $("#txtBatJobPrmProBatId").val(batId);
	    $("#txtBatJobPrmProPrmId").val("New");
	    $("#txtBatJobPrmProPrmNm").val('');
	    $("#txtBatJobPrmProPrmKey").val('');
	    $("#txtBatJobPrmProPrmVal").val('');
	    $("#selBatJobPrmProPrmFixYn").val('Y');
	    $("#selBatJobPrmProPrmType").val('STR');
	    $("#selBatJobPrmProUseYn").val('Y');
	    $("#txtBatJobPrmProDispOrd").val('');
	}
	
	/*** Select Batch Job Ajax Call ***/
	function fn_selectBatJobList(){
		
		fn_init(1);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsBatJobList.do' />");
		comAjax.setCallback("fn_selectBatJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.ajax();
	}
	
	/*** Select Project Ajax Callback ***/
	function fn_selectBatJobListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabBatJob").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_batjobRowId)
			$("#tabBatJob").jqGrid('setSelection',_batjobRowId);
		else if(mydata.length>0)
			$("#tabBatJob").jqGrid('setSelection','1');
	}
	
	/*** Select Job Complete ***/
	function gridCompleteBatJobPrm(){
		//
	}
	
	/*** Select Job Ajax Call ***/
	function fn_selectBatJobPrmList(batId){
		
		fn_init(2);
		
		var tabBatJob = $("#tabBatJob");
		var colectTypCd = tabBatJob.jqGrid ('getCell', _batjobRowId, 'COLECT_TYP_CD');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsBatJobPrmList.do' />");
		comAjax.setCallback("fn_selectDsBatJobPrmListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("BAT_ID",batId);
		comAjax.ajax();
	}
	
	/*** Select Job Ajax Callback ***/
	function fn_selectDsBatJobPrmListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabBatJobPrm").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_batjobprmRowId)
			$("#tabBatJobPrm").jqGrid('setSelection',_batjobprmRowId);
		else if(mydata.length>0)
			$("#tabBatJobPrm").jqGrid('setSelection','1');
		
	}
	
	/*** Save Project Ajax Call ***/
	function fn_saveBatJobInfo(){
		
		var batId = $("#txtBatJobProBatId").val();
        var batNm = $("#txtBatJobProBatNm").val();
        var calType = $("#selBatJobProCalType option:selected").val();
        var calPrgm = $("#txtBatJobProCalPrgm").val();
        var calFilePath = $("#txtBatJobProCalFilePath").val();        
        var batType = $("#selBatJobProBatType option:selected").val();
        var batSchMm = $("#txtBatJobProBatSchMm").val();
        var batSchDd = $("#txtBatJobProBatSchDd").val();
        var batSchHh = $("#txtBatJobProBatSchHh").val();
        var batSchMi = $("#txtBatJobProBatSchMi").val();
        var ledBatId = $("#txtBatJobProLedBatId").val();
        var grpBatId = $("#txtBatJobProGrpBatId").val();
        var useYn = $("#selBatJobProUseYn option:selected").val();
        var dispOrd = $("#txtBatJobProDispOrd").val();
		
		if(gfn_isNull(batNm)){
			$("#spanBatJobProMsg").text("배치명을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProBatNm").focus();
			return false;
		}
		if(gfn_isNull(calPrgm)){
			$("#spanBatJobProMsg").text("호출프로그램명을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProCalPrgm").focus();
			return false;
		}
		if(gfn_isNull(batSchMm)){
			$("#spanBatJobProMsg").text("배치월기준을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProBatSchMm").focus();
			return false;
		}
		if(gfn_isNull(batSchDd)){
			$("#spanBatJobProMsg").text("배치일기준을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProBatSchDd").focus();
			return false;
		}
		if(gfn_isNull(batSchHh)){
			$("#spanBatJobProMsg").text("배치시기준을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProBatSchHh").focus();
			return false;
		}
		if(gfn_isNull(batSchMi)){
			$("#spanBatJobProMsg").text("배치분기준을 입력하세요.");
			$("#divBatJobProMsg").css("display", "block");
			$("#txtBatJobProBatSchMi").focus();
			return false;
		}
		
		var comAjax = new ComAjax();
		if(batId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsBatJobInfo.do' />");
			comAjax.setCallback("fn_insBatJobInfoCallback");
			comAjax.addParam("BAT_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsBatJobInfo.do' />");
			comAjax.setCallback("fn_saveBatJobInfoCallback");
			comAjax.addParam("BAT_ID",batId);
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("BAT_NM",batNm);
		comAjax.addParam("CAL_TYPE",calType);
		comAjax.addParam("CAL_PRGM",calPrgm);
		comAjax.addParam("CAL_FILE_PATH",calFilePath);
		comAjax.addParam("BAT_TYPE",batType);
		comAjax.addParam("BAT_SCH_MM",batSchMm);
		comAjax.addParam("BAT_SCH_DD",batSchDd);
		comAjax.addParam("BAT_SCH_HH",batSchHh);
		comAjax.addParam("BAT_SCH_MI",batSchMi);
		comAjax.addParam("LED_BAT_ID",ledBatId);
		comAjax.addParam("GRP_BAT_ID",grpBatId);
		comAjax.addParam("USE_YN",useYn);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete Project Ajax Call ***/
	function fn_deleteBatJobInfo(){
		var tabBatJob = $("#tabBatJob");
		var batId = tabBatJob.jqGrid ('getCell', _batjobRowId, 'BAT_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsBatJobInfo.do' />");
		comAjax.setCallback("fn_delBatJobInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("BAT_ID",batId);			
		comAjax.ajax();
	}
	
	/*** Insert Project Ajax Callback ***/
	function fn_insBatJobInfoCallback(data){
		$("#divBatJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}
	
	/*** Delete Project Ajax Callback ***/
	function fn_delBatJobInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}	
	
	/*** Update Project Ajax Callback ***/
	function fn_saveBatJobInfoCallback(data){
		$("#divBatJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}
	
	/*** Save Job Ajax Call ***/
	function fn_saveBatJobPrmInfo(){
		
		var batId = $("#txtBatJobPrmProBatId").val();
	    var prmId = $("#txtBatJobPrmProPrmId").val();
	    var prmNm = $("#txtBatJobPrmProPrmNm").val();
	    var prmKey = $("#txtBatJobPrmProPrmKey").val();
	    var prmVal = $("#txtBatJobPrmProPrmVal").val();
	    var prmFixYn = $("#selBatJobPrmProPrmFixYn option:selected").val();
	    var prmType = $("#selBatJobPrmProPrmType option:selected").val();
	    var useYn = $("#selBatJobPrmProUseYn option:selected").val();
	    var dispOrd = $("#txtBatJobPrmProDispOrd").val();
		
		if(gfn_isNull(prmNm)){
			$("#spanBatJobPrmProMsg").text("파라미터명을 입력하세요.");
			$("#divBatJobPrmProMsg").css("display", "block");
			$("#txtBatJobPrmProPrmNm").focus();
			return false;
		}
		if(gfn_isNull(prmKey)){
			$("#spanBatJobPrmProMsg").text("파라미터키를 입력하세요.");
			$("#divBatJobPrmProMsg").css("display", "block");
			$("#txtBatJobPrmProPrmKey").focus();
			return false;
		}

		var comAjax = new ComAjax();
		if(prmId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsBatJobPrmInfo.do' />");
			comAjax.setCallback("fn_insDsBatJobPrmInfoCallback");
			comAjax.addParam("PRM_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsBatJobPrmInfo.do' />");
			comAjax.setCallback("fn_saveDsBatJobPrmInfoCallback");
			comAjax.addParam("PRM_ID",prmId);
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("BAT_ID",batId);
		comAjax.addParam("PRM_NM",prmNm);
		comAjax.addParam("PRM_KEY",prmKey);
		comAjax.addParam("PRM_VAL",prmVal);
		comAjax.addParam("PRM_FIX_YN",prmFixYn);
		comAjax.addParam("PRM_TYPE",prmType);
		comAjax.addParam("USE_YN",useYn);		
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete Job Ajax Call ***/
	function fn_deleteBatJobPrmInfo(){
		var tabBatJobPrm = $("#tabBatJobPrm");
		var batId = tabBatJobPrm.jqGrid ('getCell', _batjobprmRowId, 'BAT_ID');
		var prmId = tabBatJobPrm.jqGrid ('getCell', _batjobprmRowId, 'PRM_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsBatJobPrmInfo.do' />");
		comAjax.setCallback("fn_delDsBatJobPrmInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("BAT_ID",batId);
		comAjax.addParam("PRM_ID",prmId);
		comAjax.ajax();
	}	
	
	/*** Insert Job Ajax Callback ***/
	function fn_insDsBatJobPrmInfoCallback(data){
		$("#divBatJobPrmProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}
	
	/*** Delete Job Ajax Callback ***/
	function fn_delDsBatJobPrmInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}
	
	/*** Update Job Ajax Callback ***/
	function fn_saveDsBatJobPrmInfoCallback(data){
		$("#divBatJobPrmProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectBatJobList');
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Job)
	*/	
	function fn_init(step){
		if(step<=0){
			_batjobRowId = '1';
			_batjobprmRowId = '1';
		}
			
		if(step<=1){
						
			$("#tabBatJob").jqGrid("clearGridData", true);
		}
		
		if(step<=2){
			$("#tabBatJobPrm").jqGrid("clearGridData", true);
		}
	}	
</script>
</body>
</html>