<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 수집하기(API) -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<style>

  #body .button {
  	vertical-align: top;
  }
  #body .textarea {
  	width:1226px;
  	height:150px;
  	font-size:1em;
  	font-family: Verdana,Arial,sans-serif;
  	color:#222222;
  }
  #body .tdContent{
  	width:600px;
  	vertical-align: top;
  }  
  
  #divApiPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }    
  
  #divApiPro .inputLabel{
  	display:inline-block;
  	width:70px;
  }
  #divApiPro .inputLabel2{
  	display:inline-block;
  	width:100px;
  }

  #divApiExe{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }    
  
  #divApiExe .inputLabel{
  	display:inline-block;
  	width:80px;
  }
  #divApiExe .inputLabel2{
  	display:inline-block;
  	width:150px;
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
  
  #divProjProPop{
  	display:none;
  }
  #divProjProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divProjProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divProjProPop .inputLabel2{
  	display:inline-block;
  	text-align:center;
  } 
  #divProjProPop .inputText{
  	height:20px;
  }
   
  #divJobProPop{
  	display:none;
  }   
  #divJobProPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divJobProPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divJobProPop .inputText{
  	height:20px;
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
				<table id="tabProject"></table>
			</td>
			<td></td>
			<td class="tdContent">
				<table id="tabJob"></table>
			</td>			
		</tr>
		<tr>
			<td class="tdContent" colspan="3">
				<table id="tabSource"></table>
			</td>	
		</tr>		
		<tr>
			<td class="tdContent">			
				<div id="divApiPro">
					<h3>수집결과 조회</h3>
					<div><span class="inputLabel">수집기간</span>
					<input id="txtFromExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;~&nbsp;
					<input id="txtToExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;
					<button id="selectResult" class="button" style="width:70px;">조회</button>
					</div>
				</div>
			</td>
			<td></td>
			<td class="tdContent">			
				<div id="divApiExe">
					<h3>수집실행 조건</h3>
					<div><span class="inputLabel">수집기준일자</span>
					<input id="txtExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;
					<span class="inputLabel2">수집범위(총페이지수)</span>
					<input id="txtLoopCnt" type="text" class="text" style="width:50px;" spellcheck='false' ></input>&nbsp;
					<button id="startApi" class="button" style="width:70px;">수집시작</button>
					<button id="stopApi" class="button" style="width:70px;">수집중지</button>
					</div>
				</div>
			</td>
		</tr>	
		<tr>
			<td class="tdContent" colspan="3">
				<table id="tabResult"></table>
			</td>
		</tr>
	</tbody>
	
</table>


<!-- 본문영역 (끝) -->		
<%@ include file="/WEB-INF/include/include-bodyBottom.jspf" %>
<!-- 팝업DIV영역(시작) -->
<div id="divOupProPop" title="수집결과 상세">
	<table id="tabResultDetail"></table>
</div>
<script type="text/javascript">
	var rowNum = 10;
	var _projRowId = '1';
	var _jobRowId = '1';
	var _srcRowId = '1';
	var _inpRowId = '1';
	var _resRowId = '1';
	var _projId = '';
	var _jobId = '';
	var _srcId = '';
	
	var _timerId = 0;
	var _idsResult = null;
	var _srcChkRowIdx = -1;
	var _timerState = 0;	// 1:start, 0:stop
	
	$(document).ready(function(){
		$( "#divOupProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 930,
			buttons: [
						{
							text: "닫기",
							click: function() {
								$( this ).dialog( "close" );
							}
						}
					]
		});
			
		
		/*** Button Style ***/
		$( "#selectResult" ).button();
		$( "#startApi" ).button();
		$( "#stopApi" ).button();
		
		$( "#divApiPro" ).accordion();
		$( "#divApiExe" ).accordion();
		
		$("#txtFromExeNum").val(gfn_NowDate('yyyy')+'0101');
		$("#txtToExeNum").val(gfn_NowDate('yyyymmdd'));
		$("#txtExeNum").val(gfn_NowDate('yyyymmdd'));
		
		$("#txtLoopCnt").val(1);		
		
		/*** Project Grid ***/
		var tabProj = $("#tabProject");
		tabProj.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['프로젝트ID','프로젝트명', 'Desc', 'Url', 'DispOrd', 'UsrId'],
		   	colModel:[
		   		{name:'PROJ_ID',index:'PROJ_ID', width:30, align:'center'},
		   		{name:'PROJ_NM',index:'PROJ_NM', width:150},
		   		{name:'PROJ_DESC',index:'PROJ_DESC', hidden: true},
		   		{name:'SITE_URL',index:'SITE_URL', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true},
		   		{name:'USR_ID',index:'USR_ID', hidden: true}
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
		   	caption: "프로젝트"
		});
		
		tabProj.jqGrid('setGridParam', 
				{gridComplete: gridCompleteProj()});
		
		tabProj.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_projRowId = rowId;
					fn_setProjPro(rowId);			        
			        fn_selectJobList(_projId);
				}});
	
		/*** Job Grid ***/
		var tabJob = $("#tabJob");	
		tabJob.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['작업ID','작업명', 'ProjId', 'DispOrd'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:150},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
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
		   	caption: "작업"
		});
		
		tabJob.jqGrid('setGridParam', 
				{gridComplete: gridCompleteJob()});
		
		tabJob.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_jobRowId = rowId;
					fn_setJobPro(rowId);
					fn_selectSrcList();
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
		   		{name:'METHOD',index:'METHOD', width:50, align:'center'},	
		   		{name:'AUTH_YN',index:'AUTH_YN', width:50, align:'center'},	
		   		{name:'OUT_FMT',index:'OUT_FMT', width:50, align:'center'},
		   		{name:'DELAY_TIME',index:'DELAY_TIME', width:50, align:'right'},
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
			height:150,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: true,
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
			        //fn_selectResultList();
				}});
		
		/*** Source & Target Grid ***/
		var tabResult = $("#tabResult");
		tabResult.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['수집일자','소스ID','소스명','진행상태','전체요청수','전체응답수','수집항목수', '시작시간','종료시간'],
		   	colModel:[
				{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'SRC_ID',index:'SRC_ID', width:30, align:'center'},
		   		{name:'SRC_NM',index:'SRC_NM', width:60},		   		
		   		{name:'EXE_STATE',index:'EXE_STATE', width:30, align:'center', editable:true},
		   		{name:'SRC_CNT',index:'SRC_CNT', width:30, align:'right', editable:true},
		   		{name:'EXE_SRC_CNT',index:'EXE_SRC_CNT', width:30, align:'right', editable:true},
		   		{name:'SUCCESS_OUP_CNT',index:'SUCCESS_OUP_CNT', width:30, align:'right', editable:true},
		   		{name:'SRC_STR_TIME',index:'SRC_STR_TIME', width:40, align:'center', editable:true},
		   		{name:'SRC_END_TIME',index:'SRC_END_TIME', width:40, align:'center', editable:true}
		   	],
		   	//rowNum:rowNum,
			width:1230,
			height:210,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,		   	
		   	loadtext:"<img src=\"<c:url value='/jqGrid/css/smoothness/images/ui-anim_basic_16x16.gif'/>\" />",
		   	caption: "수집결과"
		});
		
		tabResult.jqGrid('setGridParam', 
				{gridComplete: gridCompleteResult()});
		
		tabResult.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_resRowId = rowId;
					fn_setResultPro(rowId);
				}});
		
		tabResult.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
			        fn_openDetailResult(rowId,iRow,iCol);
					event.preventDefault();
				}});		
		
		
/* 		$("#txtInputVal").keydown(function (key) {
			 
	        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
	        	fn_GoApply();
	        }
	 
	    }); */
		
		/*** Button Click ***/
		$("#selectResult").on("click", function(e){
			e.preventDefault();
			//
			fn_selectResultList();
		});
		
		$("#startApi").on("click", function(e){
			e.preventDefault();
			//
			var exeNum = $("#txtExeNum").val();
			var loopCnt = $("#txtLoopCnt").val();
			
			if(!$.isNumeric(exeNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');$("#txtExeNum").focus();return false;}
			if(!$.isNumeric(loopCnt)){_alert('info','숫자타입만 입력가능합니다.','');$("#txtLoopCnt").focus();return false;}
			
			var ids = $("#tabSource").jqGrid('getGridParam','selarrrow');
			if(ids.length <=0){_alert('info','Source를 한 개 이상 선택하십시요.','');return false;}
			
			_alert('cfm','','fn_startApi');
		});
		
		$("#stopApi").on("click", function(e){
			e.preventDefault();
			//
			
			var ids = $("#tabSource").jqGrid('getGridParam','selarrrow');
			if(ids.length <=0){_alert('info','Source를 한 개 이상 선택하십시요.','');return false;}
			
			_alert('cfm','','fn_stopApi');
		});		

		fn_init(0);
		
		/*** Select Project List ***/
		fn_selectProjList();
		
	});		
	
	/*** Select Project Complete ***/
	function gridCompleteProj(){
		//
	}
	

	/*** Setting Update Project Properties ***/
	function fn_setProjPro(rowId){
		var tabProj = $("#tabProject");
		
		_projId = tabProj.jqGrid ('getCell', (gfn_isNull(rowId)?_projRowId:rowId), 'PROJ_ID');
		var projNm = tabProj.jqGrid ('getCell', rowId, 'PROJ_NM');
		var projDesc = tabProj.jqGrid ('getCell', rowId, 'PROJ_DESC');
		var siteUrl = tabProj.jqGrid ('getCell', rowId, 'SITE_URL');
        var dispOrd = tabProj.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtProjProProjId").val(_projId);
        $("#txtProjProProjNm").val(projNm);
        $("#txtProjProProjDesc").val(projDesc);
        $("#txtProjProSiteUrl").val(siteUrl);
        $("#txtProjProDispOrd").val(dispOrd);		
	}

	/*** Setting Update Job Properties ***/
	function fn_setJobPro(rowId){
		var tabJob = $("#tabJob");
		
		var projId = tabJob.jqGrid ('getCell', rowId, 'PROJ_ID');
		_jobId = tabJob.jqGrid ('getCell', (gfn_isNull(rowId)?_jobRowId:rowId), 'JOB_ID');
		var jobNm = tabJob.jqGrid ('getCell', rowId, 'JOB_NM');
	    var dispOrd = tabJob.jqGrid ('getCell', rowId, 'DISP_ORD');
	    
	    $("#txtJobProProjId").val(projId);
	    $("#txtJobProJobId").val(_jobId);
	    $("#txtJobProJobNm").val(jobNm);
	    $("#txtJobProDispOrd").val(dispOrd);
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
        
        var dispOrd = tabSrc.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtSrcProProjId").val(projId);
        $("#txtSrcProJobId").val(jobId);
        $("#txtSrcProSrcId").val(srcId);
        $("#txtSrcProSrcNm").val(srcNm);			        
        $("#txtSrcProSrcVal").val(srcVal);
        $("#txtSrcProSrcDivCd").val(srcDivCd);
        $("#txtSrcProSrcTypCd").val(srcTypCd);
        $("#txtSrcProSrcEncode").val(srcEncode);
        //$("#txtSrcProSrcValPosition").val(srcValPosition);
        
        $("#txtSrcProMethod").val(method);
        $("#txtSrcProAuthYn").val(authYn);
        $("#txtSrcProOutFmt").val(outFmt);
        
        $("#txtSrcProDispOrd").val(dispOrd);

        //$("#txtInputVal").val('');
      	//$("#txtUrl").val('');
        fn_selectExeItemVal(srcTypCd, srcVal, -1);
        $("#txtPageSource").val('');
        $("#txtRegexResult").val('');
        
	}
	
	function fn_setResultPro(rowId){
		//	
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

		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				$("#tabProject").jqGrid('addRowData', i+1, mydata[i]);
			}
			
			if(mydata.length>=_projRowId)
				$("#tabProject").jqGrid('setSelection',_projRowId);
			else if(mydata.length>0)
				$("#tabProject").jqGrid('setSelection','1');
		}
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
			//$("#txtUrl").val(srcVal);
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
	
	/*** Setting Source View Properties ***/
	function fn_setSrcViewPro(rowId){
		var tabSrcView = $("#tabSourceView");
		var itemVal = tabSrcView.jqGrid ('getCell', (gfn_isNull(rowId)?_srcViewRowId:rowId), 'ITEM_VAL');
		
		//$("#txtUrl").val(itemVal);
	}	
	
	/*** Select Job Complete ***/
	function gridCompleteJob(){
		//
	}
	
	
	/*** Select Source Complete ***/
	function gridCompleteSrc(){
		//
	}
	
	/*** Select Job Ajax Call ***/
	function fn_selectJobList(prjId){
		
		fn_init(2);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsApiJobList.do' />");
		comAjax.setCallback("fn_selectJobListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",prjId);
		comAjax.ajax();
	}
	
	/*** Select Job Ajax Callback ***/
	function fn_selectJobListCallback(data){

		var mydata = data.rows;

		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				$("#tabJob").jqGrid('addRowData', i+1, mydata[i]);
			}
			
			if(mydata.length>=_jobRowId)
				$("#tabJob").jqGrid('setSelection',_jobRowId);
			else if(mydata.length>0)
				$("#tabJob").jqGrid('setSelection','1');
		}
		
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
			$("#tabSource").jqGrid('setSelection',(i+1));	// 전체선택
		}
		
		/* if(mydata.length>=_srcRowId)
			$("#tabSource").jqGrid('setSelection',_srcRowId);
		else if(mydata.length>0)
			$("#tabSource").jqGrid('setSelection','1'); */		
	}
	
	/*** Select Source&Target Complete ***/
	function gridCompleteResult(){
		//
	}
	
	
	/*** Select Api Result Ajax Call ***/
	function fn_selectResultList(){
		
		fn_init(5);
		
		var exeFromNum = $("#txtFromExeNum").val();
		var exeToNum = $("#txtToExeNum").val();
		
		if(!$.isNumeric(exeFromNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		if(!$.isNumeric(exeToNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		
		var ids = $("#tabSource").jqGrid('getGridParam','selarrrow');
		if(ids.length <=0){_alert('info','Source를 한 개 이상 선택하십시요.','');return false;}
		var srcIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				srcIdLst += "'" + $("#tabSource").jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}else{
				srcIdLst += ",'" + $("#tabSource").jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}
		}
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsExeApiResultList.do' />");
		comAjax.setCallback("fn_selectDsExeApiResultListCallback");
		comAjax.addParam("EXE_FROM_NUM",exeFromNum);
		comAjax.addParam("EXE_TO_NUM",exeToNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID_LST",srcIdLst);
		comAjax.ajax();
	}
	
	/*** Select Api Result Ajax Callback ***/
	function fn_selectDsExeApiResultListCallback(data){

		var mydata = data.rows;

		var rowKey;
		var firstKey;
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				rowKey = _projId + '.' + _jobId + '.' + mydata[i].SRC_ID + '.' + mydata[i].EXE_NUM;
				if(i==0){firstKey = rowKey;}
				//$("#tabResult").jqGrid('addRowData', i+1, mydata[i]);
				$("#tabResult").jqGrid('addRowData', rowKey, mydata[i]);
			}
			
			if(mydata.length>0){
				//$("#tabResult").jqGrid('setSelection','1');
				$("#tabResult").jqGrid('setSelection',firstKey);
			}
		}		
	}
	
	/*** Select Source&Target Ajax Call ***/
	function fn_selectResultList2(){
		
		fn_init(5);
		
		var exeFromNum = $("#txtFromExeNum").val();
		var exeToNum = $("#txtToExeNum").val();
		
		if(!$.isNumeric(exeFromNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		if(!$.isNumeric(exeToNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		
		var comAjax = new ComAjax();
		comAjax.setAsyncFlag(true);	// 비동기
		comAjax.setUrl("<c:url value='/datasearch/selectDsResultList.do' />");
		comAjax.setCallback("fn_selectDsResultList2Callback");
		comAjax.addParam("EXE_FROM_NUM",exeFromNum);
		comAjax.addParam("EXE_TO_NUM",exeToNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}
	
	/*** Select Source&Target Ajax Callback ***/
	function fn_selectDsResultList2Callback(data){

		var mydata = data.rows;

		var rowKey;
		var firstKey;
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				rowKey = _projId + '.' + _jobId + '.' + mydata[i].SRC_ID + '.' + mydata[i].EXE_NUM;
				if(i==0){firstKey = rowKey;}
				//$("#tabResult").jqGrid('addRowData', i+1, mydata[i]);
				$("#tabResult").jqGrid('addRowData', rowKey, mydata[i]);
			}
			
			if(mydata.length>0){
				//$("#tabResult").jqGrid('setSelection','1');
				$("#tabResult").jqGrid('setSelection',firstKey);
			}
		}
		
// 		if(_timerState==1){
// 			clearTimeout(_timerId);
// 			_timerId = setTimeout("fn_selectResultList2()", 5000);
// 		}
		
	}	
	
	/*** Start Api Ajax Call ***/
	function fn_startApi(){
		var exeNum = $("#txtExeNum").val();
		var loopCnt = $("#txtLoopCnt").val();
		
		var tabSrc = $("#tabSource");
		var srcEncode = tabSrc.jqGrid ('getCell', _srcRowId, 'SRC_ENCODE');
		var method = tabSrc.jqGrid ('getCell', _srcRowId, 'METHOD');
		var outFmt = tabSrc.jqGrid ('getCell', _srcRowId, 'OUT_FMT');
		var ids = tabSrc.jqGrid('getGridParam','selarrrow');
		var srcIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				srcIdLst += "'" + tabSrc.jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}else{
				srcIdLst += ",'" + tabSrc.jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}
		}
		
		// Input Value 를 저장하자!!!
		//fn_GoApply();
		//var url = $("#txtUrl").val();
		
		var comAjax = new ComAjax('apiForm');
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/cbap/openapi/startApi.do' />");
		comAjax.setCallback("fn_startApiCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		//comAjax.addParam("SRC_ID",_srcId);
		comAjax.addParam("SRC_ID_LST",srcIdLst);		
		comAjax.addParam("METHOD",method);
		comAjax.addParam("OUT_FMT",outFmt);		
		comAjax.addParam("LOOP_CNT",loopCnt);
		comAjax.addParam("USE_YN","Y");
		comAjax.ajax();
		
		// 진행상태체크 타이머 시작
		//_timerState = 1;	// 1:start, 0:stop
		//_timerId = setInterval("fn_selectCrawlingState()", 5000);
		//clearTimeout(_timerId);
		//_timerId = setTimeout("fn_selectResultList2()", 5000);
		
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		//$("#load_tabResult").show();
		//$("#load_tabResult").css('display','block');
	}
	
	/*** Start Api Ajax Callback ***/
	function fn_startApiCallback(data){
		$("#load_tabResult").hide();
		$("#load_tabResult").css('display','none');
		
		// 타이머 중지
		_timerState = 0;	// 1:start, 0:stop
		//clearInterval(_timerId);
		clearTimeout(_timerId);
		
		var state = data.state;
		if(state == 'Processing'){
			_alert('info', '이미 실행중인 작업입니다.', '');
		}else{
			_alert('info','Success!!!','fn_selectResultList');
		}
	}
	
	function fn_stopApi(){
		// 타이머 중지
		//clearInterval(_timerId);
		clearTimeout(_timerId);
		_srcChkRowIdx = -1;
		_timerId = 0;
		_timerState = 0;	// 1:start, 0:stop
		
		var exeNum = $("#txtExeNum").val();
		var tabSrc = $("#tabSource");
		var ids = tabSrc.jqGrid('getGridParam','selarrrow');
		var srcIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				srcIdLst += "'" + tabSrc.jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}else{
				srcIdLst += ",'" + tabSrc.jqGrid ('getCell', ids[i], 'SRC_ID') + "'";
			}
		}
		
		var comAjax = new ComAjax('apiForm');
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/cbap/openapi/stopApi.do' />");
		comAjax.setCallback("fn_stopApiCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("SRC_ID_LST",srcIdLst);
		comAjax.ajax();
		
		$("#load_tabResult").show();
		$("#load_tabResult").css('display','block');
	}	
	
	/*** Stop Api Ajax Callback ***/
	function fn_stopApiCallback(data){
		$("#load_tabResult").hide();
		$("#load_tabResult").css('display','none');
		
		// 타이머 중지
		_timerState = 0;	// 1:start, 0:stop
		//clearInterval(_timerId);
		clearTimeout(_timerId);
		
		var state = data.state;
		if(state == 'Processing'){
			_alert('info', '이미 실행중인 작업입니다.', '');
		}else{
			_alert('info','Success!!!','fn_selectResultList');
		}
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Job), 3(Source), 4(Exe Input),  5(Result)
	*/	
	function fn_init(step){
		if(step<=0){
			_projRowId = '1';
			_jobRowId = '1';
			_srcRowId = '1';
			_projId = '';
			_jobId = '';
			_srcId = '';
			_idsResult = null;
			_timerId = 0;
			_timerState = 0;	// 1:start, 0:stop
			_srcChkRowIdx = -1;
			
			$("#txtExeNum").focus();
		}
			
		if(step<=1){
						
			$("#tabProject").jqGrid("clearGridData", true);
		}
		
		if(step<=2){
			$("#tabJob").jqGrid("clearGridData", true);
		}
		if(step<=3){
			$("#tabSource").jqGrid("clearGridData", true);
		}
		if(step<=4){
			//
		}
		
		if(step<=5){
			$("#tabResult").jqGrid("clearGridData", true);
		}
	}	
	function fn_openDetailResult(rowId,iRow,iCol){
		$("#tabResultDetail").GridUnload();
		
		var exeNum = $("#tabResult").jqGrid ('getCell', rowId, 'EXE_NUM');
		var colData = rowId.split(".");console.log('colData', colData);
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/openDrawDatasetAPI.do' />");
		comAjax.setCallback("fn_openDetailResultCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		
		comAjax.addParam("PROJ_ID",colData[0]);
		comAjax.addParam("JOB_ID",colData[1]);
		comAjax.addParam("SRC_ID",colData[2]);
		
		comAjax.ajax();
		
	}	
	function fn_openDetailResultCallback(data){
		var colNames = [];
		var colModels = [];
		
		for(key in data.headerList){
			var name = data.headerList[key]["OUP_KEY2"];
			var name2 = name.split("_");
			colNames.push(name2[name2.length-1]);
			if(data.headerList[key]["OUP_TYPE"] == "TIME_URL" | data.headerList[key]["OUP_TYPE"] == "BASE_URL"){
				colModels.push({name:name,index:name,formatter : viewHtml});
			} else {
				colModels.push({name:name,index:name});
			}
		}
		
		var tabResultDetail = $("#tabResultDetail");
		
		tabResultDetail.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:colNames,
		   	colModel:colModels,
		   	rowNum:rowNum,
			width:910,
			height:350,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	shrinkToFit:false,
		   	loadtext:"Loading...",
		   	rownumbers : true
		   	
		});	
		
		var mydata = data.data;
		
		for(var i=0; i<mydata.length; i++){
			$("#tabResultDetail").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		
		$("#divOupProPop").dialog("open");
	}
	function viewHtml(cellvalue, options, rowObject) {
		return "<a href='#' onclick=openSite('"+cellvalue+"','" + options.rowId + "')>" + cellvalue + "<a/>";
    }
	function openSite(cellvalue,rowId){
		$("#tabResultDetail").jqGrid("setSelection", rowId);
		window.open(cellvalue,'_blank');
	}
</script>
</body>
</html>