<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 수집하기(크롤링) -->
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
  
  #divCrawlingPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }    
  #divCrawlingPro .inputLabel{
  	display:inline-block;
  	width:70px;
  }
  #divCrawlingPro .inputLabel2{
  	display:inline-block;
  	width:100px;
  }
  
  #divCrawlingExe{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }    
  
  #divCrawlingExe .inputLabel{
  	display:inline-block;
  	width:90px;
  }
  #divCrawlingExe .inputLabel2{
  	display:inline-block;
  	width:80px;
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
			<td class="tdContent">			
				<div id="divCrawlingPro">
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
				<div id="divCrawlingExe">
					<h3>수집실행 조건</h3>
					<div><span class="inputLabel">수집기준일자</span>
					<input id="txtExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;
					<button id="startCrawling" class="button" style="width:70px;">수집시작</button>
					<button id="stopCrawling" class="button" style="width:70px;">수집종료</button>
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
<div id="divPreviewPop" title="수집결과 상세">
	<table id="tabPreview"></table>
</div>
<div id='divPreviewImgPop'>
	<img id="previewImg" src="" alt="" />
</div>
<!-- 팝업DIV영역(끝) -->

<script type="text/javascript">
	var rowNum = 10;
	var _projRowId = '1';
	var _jobRowId = '1';
	var _projId = '';
	var _jobId = '';
	var _timerId = 0;
	var _idsSrcTgt = null;
	var _srcChkRowIdx = -1;
	var _timerState = 0;	// 1:start, 0:stop
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#selectResult" ).button();
		$( "#startCrawling" ).button();
		$( "#stopCrawling" ).button();
		
		$( "#divCrawlingPro" ).accordion();
		$( "#divCrawlingExe" ).accordion();
		
		$("#txtFromExeNum").val(gfn_NowDate('yyyy')+'0101');
		$("#txtToExeNum").val(gfn_NowDate('yyyymmdd'));
		$("#txtExeNum").val(gfn_NowDate('yyyymmdd'));
		
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
			height:300,//"100%",
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
			height:300,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: true,
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
					//fn_selectResultList();
				}});
		
		/*** Source & Target Grid ***/
		var tabResult = $("#tabResult");
		tabResult.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['수집일자','작업ID','작업명','진행상태','대상URL수','수집URL수','수집타깃수','수집항목수','시작시간','종료시간'],
		   	colModel:[
		   		{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:100},		   		
		   		{name:'EXE_STATE',index:'EXE_STATE', width:30, align:'center', editable:true},
		   		{name:'SRC_CNT',index:'SRC_CNT', width:30, align:'right', editable:true},
		   		{name:'EXE_SRC_CNT',index:'EXE_SRC_CNT', width:30, align:'right', editable:true},
		   		{name:'TGT_CNT',index:'TGT_CNT', width:30, align:'right', editable:true},
		   		{name:'SUCCESS_ITM_CNT',index:'SUCCESS_ITM_CNT', width:30, align:'right', editable:true},
		   		{name:'SRC_STR_TIME',index:'SRC_STR_TIME', width:50, align:'center', editable:true},
		   		{name:'SRC_END_TIME',index:'SRC_END_TIME', width:50, align:'center', editable:true}
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
				{gridComplete: gridCompleteSrcTgt()});
		
		tabResult.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					fn_setSrcTgtPro(rowId);
				}});
		
		tabResult.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					event.preventDefault();
					fn_selectPreview(rowId)
					$("#divPreviewPop").dialog( "open" );
				}});	
		
		/*** Preview Grid ***/
		var tabPreview = $('#tabPreview');
		tabPreview.jqGrid({
			colNames:['PROJ_ID','EXE_NUM','JOB_ID','No','ROW_NUM','SUBJECTTITLE','URL','IMG'],
			colModel:[
	            {name:'PROJ_ID',index:'PROJ_ID',width:30, align:'center', hidden:true},
		   		{name:'EXE_NUM',index:'EXE_NUM',width:30, align:'center', hidden:true},
		   		{name:'JOB_ID',index:'JOB_ID',width:30, align:'center', hidden:true},
	            {name:'SRC_NUM',index:'SRC_NUM',width:15, align:'center'},
		   		{name:'ROW_NUM',index:'ROW_NUM',width:30, align:'center', hidden:true},
		   		{name:'SUBJECTTITLE',index:'SUBJECTTITLE'},		   		
		   		{name:'SRC_URL',index:'SRC_URL',width:15, align:'center',formatter : viewHtml},
		   		{name:'SRC_SNP_URL_PATH',index:'SRC_SNP_URL_PATH',width:15 ,align:'center',formatter : viewHtml_img}
	   		],
			datatype: "json",
			mtype:"POST",
			width:910,
			height:350,
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,		   	
		   	caption: ""
		});
		
		/*** Preview Poupup ***/
		$("#divPreviewPop").dialog({
			autoOpen: false,
			modal: true,
			width:  930,
			buttons: [
				{
					text: "닫기",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			],
			caption: "수집결과상세"
		});
		/*** PreviewImg Poupup ***/
		$("#divPreviewImgPop").dialog({
			autoOpen: false,
			modal: true,
			width:  1024,
			height: 768,
			buttons: [
				{
					text: "닫기",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		/*** Button Click ***/
		$("#selectResult").on("click", function(e){
			e.preventDefault();
			//
			fn_selectResultList();
		});
		
		$("#startCrawling").on("click", function(e){
			e.preventDefault();
			//
			var exeNum = $("#txtExeNum").val();
			
			if(!$.isNumeric(exeNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');$("#txtExeNum").focus();return false;}
			
			var ids = $("#tabJob").jqGrid('getGridParam','selarrrow');
			if(ids.length <=0){_alert('info','Job을 한 개 이상 선택하십시요.','');return false;}
			
			_alert('cfm','','fn_startCrawling');
		});
		
		$("#stopCrawling").on("click", function(e){
			e.preventDefault();
			//
			
			var ids = $("#tabJob").jqGrid('getGridParam','selarrrow');
			if(ids.length <=0){_alert('info','Job을 한 개 이상 선택하십시요.','');return false;}
			
			_alert('cfm','','fn_stopCrawling');
		});		

		fn_init(0);
		
		/*** Select Project List ***/
		fn_selectProjList();
		
	});		
	
	/*** Select Preview data ***/
	function fn_selectPreview(rowId){
		
		var rowIdArr =  rowId.split(".");
		var projId = rowIdArr[0];
		var jobId = rowIdArr[1];
		var exeNum = rowIdArr[2];
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDScrwPreview.do' />");
		comAjax.setCallback("fn_selectPreviewCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.ajax();
	}
	function fn_selectPreviewCallback(data){
		var mydata = data.rows;
		
		$("#tabPreview").jqGrid("clearGridData", true);	
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				$("#tabPreview").jqGrid('addRowData', i+1, mydata[i]);
			}
		}
		
	}
	
	/*** select previewImg ***/
	function fn_selectPreviewImg(rowId){
		var comAjax = new ComAjax();
		
		var tabPreview = $("#tabPreview");
		var projId = tabPreview.jqGrid ('getCell', rowId, 'PROJ_ID');
		var exeNum = tabPreview.jqGrid ('getCell', rowId, 'EXE_NUM');
		var jobId = tabPreview.jqGrid ('getCell', rowId, 'JOB_ID');
        var srcId = tabPreview.jqGrid ('getCell', rowId, 'SRC_ID');
        var srcNum = tabPreview.jqGrid ('getCell', rowId, 'SRC_NUM');
		
		comAjax.setUrl("<c:url value='/datasearch/selectDScrwImgPreview.do'/>");
		comAjax.setCallback("fn_selectPreviewImgCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.addParam("SRC_NUM",srcNum);
		comAjax.ajax();
	}
	function fn_selectPreviewImgCallback(data){
		var path = data.IMG_PATH;
		$('#previewImg').attr('src',path);
		
	}
	
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
	
	function fn_setSrcTgtPro(rowId){
		//	
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
	
	/*** Select Job Complete ***/
	function gridCompleteJob(){
		//
	}
	
	/*** Select Job Ajax Call ***/
	function fn_selectJobList(prjId){
		
		fn_init(2);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsJobList.do' />");
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
				$("#tabJob").jqGrid('setSelection',(i+1));	// 전체선택
			}
			
			/*if(mydata.length>=_jobRowId)
				$("#tabJob").jqGrid('setSelection',_jobRowId);
			else if(mydata.length>0)
				$("#tabJob").jqGrid('setSelection','1');*/
		}
		
	}
	
	/*** Select Source&Target Complete ***/
	function gridCompleteSrcTgt(){
		//
	}
	
	/*** Select Source&Target Ajax Call ***/
	function fn_selectResultList(){
		
		fn_init(3);
		
		var exeFromNum = $("#txtFromExeNum").val();
		var exeToNum = $("#txtToExeNum").val();
		
		if(!$.isNumeric(exeFromNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		if(!$.isNumeric(exeToNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		
		var ids = $("#tabJob").jqGrid('getGridParam','selarrrow');
		if(ids.length <=0){_alert('info','Job을 한 개 이상 선택하십시요.','');return false;}
		var jobIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				jobIdLst += "'" + $("#tabJob").jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}else{
				jobIdLst += ",'" + $("#tabJob").jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}
		}
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsSrcTgtList.do' />");
		comAjax.setCallback("fn_selectDsSrcTgtListCallback");
		comAjax.addParam("EXE_FROM_NUM",exeFromNum);
		comAjax.addParam("EXE_TO_NUM",exeToNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		//comAjax.addParam("JOB_ID",_jobId);
		comAjax.addParam("JOB_ID_LST",jobIdLst);
		comAjax.ajax();
	}
	
	/*** Select Source&Target Ajax Callback ***/
	function fn_selectDsSrcTgtListCallback(data){

		var mydata = data.rows;

		var rowKey;
		var firstKey;
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				rowKey = _projId + '.' + mydata[i].JOB_ID + '.' + mydata[i].EXE_NUM;
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
		
		fn_init(3);
		
		var exeFromNum = $("#txtFromExeNum").val();
		var exeToNum = $("#txtToExeNum").val();
		
		if(!$.isNumeric(exeFromNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		if(!$.isNumeric(exeToNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		
		var comAjax = new ComAjax();
		comAjax.setAsyncFlag(true);	// 비동기
		comAjax.setUrl("<c:url value='/datasearch/selectDsSrcTgtList.do' />");
		comAjax.setCallback("fn_selectDsSrcTgtList2Callback");
		comAjax.addParam("EXE_FROM_NUM",exeFromNum);
		comAjax.addParam("EXE_TO_NUM",exeToNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.addParam("JOB_ID",_jobId);
		comAjax.ajax();
	}
	
	/*** Select Source&Target Ajax Callback ***/
	function fn_selectDsSrcTgtList2Callback(data){

		var mydata = data.rows;

		var rowKey;
		var firstKey;
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				rowKey = _projId + '.' + mydata[i].JOB_ID + '.' + mydata[i].EXE_NUM;
				if(i==0){firstKey = rowKey;}
				//$("#tabResult").jqGrid('addRowData', i+1, mydata[i]);
				$("#tabResult").jqGrid('addRowData', rowKey, mydata[i]);
			}
			
			if(mydata.length>0){
				//$("#tabResult").jqGrid('setSelection','1');
				$("#tabResult").jqGrid('setSelection',firstKey);
			}
		}
		
		//if(_timerState==1){
		//	clearTimeout(_timerId);
		//	_timerId = setTimeout("fn_selectResultList2()", 5000);
		//}
		
	}	
	
	/*** Start Crawling Ajax Call ***/
	function fn_startCrawling(){
		var tabJob = $("#tabJob");
		
		var exeNum = $("#txtExeNum").val();
		var projId = tabJob.jqGrid ('getCell', _jobRowId, 'PROJ_ID');
		//var jobId = tabJob.jqGrid ('getCell', _jobRowId, 'JOB_ID');
		var ids = tabJob.jqGrid('getGridParam','selarrrow');
		var jobIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				jobIdLst += "'" + tabJob.jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}else{
				jobIdLst += ",'" + tabJob.jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}
		}
		
		var comAjax = new ComAjax('crawlingForm');
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/cbap/spider/startCrawling.do' />");
		comAjax.setCallback("fn_startCrawlingCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		//comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("JOB_ID_LST",jobIdLst);
		comAjax.ajax();
		
		// 진행상태체크 타이머 시작
		//_timerState = 1;	// 1:start, 0:stop
		//_timerId = setInterval("fn_selectCrawlingState()", 5000);
		//clearTimeout(_timerId);
		//_timerId = setTimeout("fn_selectResultList2()", 5000);
		
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabResult").show();
		$("#load_tabResult").css('display','block');
	}
	
	/*** Start Crawling Ajax Callback ***/
	function fn_startCrawlingCallback(data){
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
		
	function fn_stopCrawling(){
		// 타이머 중지
		//clearInterval(_timerId);
		clearTimeout(_timerId);
		_srcChkRowIdx = -1;
		_timerId = 0;
		_timerState = 0;	// 1:start, 0:stop
		
		var tabJob = $("#tabJob");
		
		var exeNum = $("#txtExeNum").val();
		var projId = tabJob.jqGrid ('getCell', _jobRowId, 'PROJ_ID');
		var ids = tabJob.jqGrid('getGridParam','selarrrow');
		var jobIdLst= "";
		
		for(var i=0; i<ids.length; i++){
			if(i==0){
				jobIdLst += "'" + tabJob.jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}else{
				jobIdLst += ",'" + tabJob.jqGrid ('getCell', ids[i], 'JOB_ID') + "'";
			}
		}
		
		var comAjax = new ComAjax('crawlingForm');
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/cbap/spider/stopCrawling.do' />");
		comAjax.setCallback("fn_stopCrawlingCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID_LST",jobIdLst);
		comAjax.ajax();
		
		$("#load_tabResult").show();
		$("#load_tabResult").css('display','block');
	}	
	
	/*** Start Crawling Ajax Callback ***/
	function fn_stopCrawlingCallback(data){
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
	
	function fn_selectCrawlingState(){
		var tabJob = $("#tabJob");
		
		var exeNum = $("#txtExeNum").val();
		var projId = tabJob.jqGrid ('getCell', _jobRowId, 'PROJ_ID');
		var jobId = tabJob.jqGrid ('getCell', _jobRowId, 'JOB_ID');
		var srcId = "";
		if(_srcChkRowIdx>=0 && _srcChkRowIdx < _idsSrcTgt.length){
			srcId = $("#tabResult").jqGrid('getCell', _idsSrcTgt[_srcChkRowIdx], 'SRC_ID');
		}
		
		var comAjax = new ComAjax('stateForm');
		comAjax.setAsyncFlag(false);	// 비동기 호출
		comAjax.setUrl("<c:url value='/datasearch/selectCrawlingState.do' />");
		comAjax.setCallback("fn_selectCrawlingStateCallback");
		comAjax.addParam("EXE_NUM",exeNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_ID",jobId);
		comAjax.addParam("SRC_ID",srcId);
		comAjax.ajax();
	}
	
	function fn_selectCrawlingStateCallback(data){

		var mydata = data.rows;

		var rowkey = "";
		var exeState = "";

		if(mydata!= null && mydata.length > 0){
			rowKey = mydata[0].PROJ_ID + '.' + mydata[0].JOB_ID + '.' + mydata[0].SRC_ID;
			exeState = mydata[0].EXE_STATE;
			
			$("#tabResult").jqGrid('setCell',rowkey, 'EXE_STATE', exeState);
			$("#tabResult").jqGrid('setSelection',rowkey);
			if(exeState == "Completed"){
				_srcChkRowIdx++;
			}
		}
	}
	
	function viewHtml(cellvalue, options, rowObject) {
        return "<a href='#' onclick=openSite('"+cellvalue+"','"+options.rowId+"')>...<a/>";
    }
	function openSite(cellvalue,rowId){
		$("#tabPreview").jqGrid("setSelection", rowId);
		window.open(cellvalue,'_blank');
	}
	
	function viewHtml_img(cellvalue, options, rowObject) {
        return "<a href='#' onclick=openSite2('"+cellvalue+"','"+options.rowId+"')>...<a/>";
    }
	function openSite2(cellvalue,rowId){
	    $("#tabPreview").jqGrid("setSelection", rowId);
		window.open('/inbaps/datasearch/getImage.do?IMG='+'http://112.217.204.26:18080'+cellvalue,'_blank');
	} 
	
	/*
	step : 0 (init),  1 (Project), 2 (Job), 3(Source&Target)
	*/	
	function fn_init(step){
		if(step<=0){
			_projRowId = '1';
			_jobRowId = '1';
			_projId = '';
			_jobId = '';
			_idsSrcTgt = null;
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
			$("#tabResult").jqGrid("clearGridData", true);
		}
	}	
</script>
</body>
</html>