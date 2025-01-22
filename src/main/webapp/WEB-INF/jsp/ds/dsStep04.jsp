<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 점검하기(API) -->
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
  
  #divProjectPro{
  	width:100%;
  	height:100%;
  	vertical-align: top;
  }  
  
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/include-bodyTopDS.jspf" %>
<!-- 본문영역 (시작) -->
<table style="width:1230px;margin:0px;padding:0px;" border="0">
	<tbody>
		<tr>
			<td class="tdContent" colspan="3">			
				<div id="divProjectPro">
					<h3>프로젝트</h3>
					<div><span class="inputLabel">프로젝트ID</span><input id="txtProjId" type="text" class="text" style="width:100px;margin-left:10px;text-align: center;margin-top:2px;" disabled="disabled" spellcheck='false' ><input id="txtProjNm" type="text" class="text" style="width:500px;margin-left:5px;margin-top:2px;" disabled="disabled" spellcheck='false' ><button id="goProjPop" class="button" style="width:50px;margin-left:5px;margin-top:2px;">...</button><button id="goSelect" class="button" style="width:70px;margin-left:5px;margin-top:2px;">조회</button></div>
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdContent" colspan="3">			
				<div id="tabsReport">
					<ul>
						<li><a href="#tabs-1">일별 작업현황</a></li>
						<li><a href="#tabs-2">작업별 소스현황</a></li>
						<li><a href="#tabs-3">소스별 수집현황</a></li>
					</ul>
					<div id="tabs-1"><table id="tabReport1"></table></div>
					<div id="tabs-2"><table id="tabReport2"></table></div>
					<div id="tabs-3"><table id="tabReport3"></table></div>
				</div>
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

<script type="text/javascript">
	var _projRowId = '';
	var _projId = '';
	var _report1RowId = '';
	var _report2RowId = '';
	var _report3RowId = '';
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$("#goProjPop").button();
		$("#goSelect").button();
		
		$( "#divProjectPro" ).accordion();
		
		$( "#tabsReport" ).tabs(2);
		
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
		
		$("#divProjPop" ).dialog( "close" );
		
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
		
		/*** Report1 Grid ***/
		var tabReport1 = $("#tabReport1");
		tabReport1.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['Id','Name', 'ExeNum', 'State', 'Start Time', 'End Time', 'Source', 'Execute', 'Ok Target', 'Fail Target', 'Target', 'Ok Item', 'Fail Item'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:100},
		   		{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'EXE_STATE',index:'EXE_STATE', width:50, align:'center'},
		   		{name:'JOB_STR_TIME',index:'JOB_STR_TIME', width:60, align:'center'},
		   		{name:'JOB_END_TIME',index:'JOB_END_TIME', width:60, align:'center'},
		   		{name:'SRC_CNT',index:'SRC_CNT', width:30, align:'right'},
		   		{name:'EXE_SRC_CNT',index:'EXE_SRC_CNT', width:30, align:'right'},
		   		{name:'SUCCESS_TGT_CNT',index:'SUCCESS_TGT_CNT', width:30, align:'right'},
		   		{name:'FAIL_TGT_CNT',index:'FAIL_TGT_CNT', width:30, align:'right'},
		   		{name:'TGT_CNT',index:'TGT_CNT', width:30, align:'right', hidden:true},
		   		{name:'SUCCESS_ITM_CNT',index:'SUCCESS_ITM_CNT', width:30, align:'right'},
		   		{name:'FAIL_ITM_CNT',index:'FAIL_ITM_CNT', width:30, align:'right'}
		   	],
		   	//rowNum:rowNum,
			width:1200,
			height:500,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"<img src=\"<c:url value='/jqGrid/css/smoothness/images/ui-anim_basic_16x16.gif'/>\" />",
		   	caption: "일별 작업현황"
		});
		
		tabReport1.jqGrid('setGridParam', 
				{gridComplete: gridCompleteReport1()});
		
		tabReport1.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_report1RowId = rowId;
				}});
		
		/*** Report2 Grid ***/
		var tabReport2 = $("#tabReport2");
		tabReport2.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['Id','Name', 'ExeNum', 'State', 'Start Time', 'End Time', 'Source', 'Execute', 'Ok Target', 'Fail Target', 'Target', 'Ok Item', 'Fail Item'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:100},
		   		{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'EXE_STATE',index:'EXE_STATE', width:50, align:'center'},
		   		{name:'JOB_STR_TIME',index:'JOB_STR_TIME', width:60, align:'center'},
		   		{name:'JOB_END_TIME',index:'JOB_END_TIME', width:60, align:'center'},
		   		{name:'SRC_CNT',index:'SRC_CNT', width:30, align:'right'},
		   		{name:'EXE_SRC_CNT',index:'EXE_SRC_CNT', width:30, align:'right'},
		   		{name:'SUCCESS_TGT_CNT',index:'SUCCESS_TGT_CNT', width:30, align:'right'},
		   		{name:'FAIL_TGT_CNT',index:'FAIL_TGT_CNT', width:30, align:'right'},
		   		{name:'TGT_CNT',index:'TGT_CNT', width:30, align:'right', hidden:true},
		   		{name:'SUCCESS_ITM_CNT',index:'SUCCESS_ITM_CNT', width:30, align:'right'},
		   		{name:'FAIL_ITM_CNT',index:'FAIL_ITM_CNT', width:30, align:'right'}
		   	],
		   	//rowNum:rowNum,
			width:1200,
			height:500,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"<img src=\"<c:url value='/jqGrid/css/smoothness/images/ui-anim_basic_16x16.gif'/>\" />",
		   	caption: "작업별 소스현황"
		});
		
		tabReport2.jqGrid('setGridParam', 
				{gridComplete: gridCompleteReport2()});
		
		tabReport2.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_report2RowId = rowId;
				}});
	
		/*** Report3 Grid ***/
		var tabReport3 = $("#tabReport3");
		tabReport3.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['Id','Name', 'ExeNum', 'State', 'Start Time', 'End Time', 'Source', 'Execute', 'Ok Target', 'Fail Target', 'Target', 'Ok Item', 'Fail Item'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:100},
		   		{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'EXE_STATE',index:'EXE_STATE', width:50, align:'center'},
		   		{name:'JOB_STR_TIME',index:'JOB_STR_TIME', width:60, align:'center'},
		   		{name:'JOB_END_TIME',index:'JOB_END_TIME', width:60, align:'center'},
		   		{name:'SRC_CNT',index:'SRC_CNT', width:30, align:'right'},
		   		{name:'EXE_SRC_CNT',index:'EXE_SRC_CNT', width:30, align:'right'},
		   		{name:'SUCCESS_TGT_CNT',index:'SUCCESS_TGT_CNT', width:30, align:'right'},
		   		{name:'FAIL_TGT_CNT',index:'FAIL_TGT_CNT', width:30, align:'right'},
		   		{name:'TGT_CNT',index:'TGT_CNT', width:30, align:'right', hidden:true},
		   		{name:'SUCCESS_ITM_CNT',index:'SUCCESS_ITM_CNT', width:30, align:'right'},
		   		{name:'FAIL_ITM_CNT',index:'FAIL_ITM_CNT', width:30, align:'right'}
		   	],
		   	//rowNum:rowNum,
			width:1200,
			height:500,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,
		   	loadtext:"<img src=\"<c:url value='/jqGrid/css/smoothness/images/ui-anim_basic_16x16.gif'/>\" />",
		   	caption: "소스별 수집현황"
		});
		
		tabReport3.jqGrid('setGridParam', 
				{gridComplete: gridCompleteReport3()});
		
		tabReport3.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_report3RowId = rowId;
				}});

		/*** Select Project ***/
		$("#goProjPop").on("click", function(e){
			e.preventDefault();
			//
			$("#divProjPop" ).dialog( "open" );
		});
		
		$("#goSelect").on("click", function(e){
			e.preventDefault();
			//
			
			var tab = $('#tabsReport').tabs();
			// jquery ui 1.8
			var selected = tab.tabs('option', 'selected');
			// jquery ui 1.9+
			var active = tab.tabs('option', 'active');
			
			switch(active) {
				case 0:
					fn_selectDsReport1();
					break;
				case 1:
					fn_selectDsReport2();
					break;
				case 2:
					fn_selectDsReport3();
					break;
				default :
					
			}	
		});
		
		fn_init(0);
		
		/*** Select Project List ***/
		fn_selectProjList();
		
	});	
	
	function viewHtml(cellvalue, options, rowObject) {
        return "<input type='text' value='" + (gfn_isNull(cellvalue)?'':escape(cellvalue.trim())) + "' style='width:100%' />";
    }
	
	function viewUnHtml(cellvalue, options, cell) {
        return unescape($('input', cell).attr('value'));
    }
	
	/*** Select Project Complete ***/
	function gridCompleteProj(){
		//
	}
	
	/*** Select Report1 Complete ***/
	function gridCompleteReport1(){
		//
	}
	
	/*** Select Report2 Complete ***/
	function gridCompleteReport2(){
		//
	}
	
	/*** Select Report3 Complete ***/
	function gridCompleteReport3(){
		//
	}
	
	function fn_setProjPro(rowId){
		var tabProj = $("#tabProject");
		_projId = tabProj.jqGrid ('getCell', (gfn_isNull(rowId)?_projRowId:rowId), 'PROJ_ID');
		var projNm = tabProj.jqGrid ('getCell', (gfn_isNull(rowId)?_projRowId:rowId), 'PROJ_NM');

		_projRowId = rowId;
		
		$("#txtProjId").val(_projId);
		$("#txtProjNm").val(projNm);
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
	
	/*** Select Report1 Ajax Call ***/
	function fn_selectDsReport1(){
		
		fn_init(2);
		
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport1").show();
		$("#load_tabReport1").css('display','block');
		
		var comAjax = new ComAjax();
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/datasearch/selectDsReport1.do' />");
		comAjax.setCallback("fn_selectDsReport1Callback");
		//comAjax.addParam("EXE_NUM","");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.ajax();
	}	
	/*** Select Report1 Ajax Callback ***/
	function fn_selectDsReport1Callback(data){
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport1").hide();
		$("#load_tabReport1").css('display','none');

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabReport1").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabReport1").jqGrid('setSelection','1');
		}
	}	
	
	/*** Select Report2 Ajax Call ***/
	function fn_selectDsReport2(){
		
		fn_init(3);
		
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport2").show();
		$("#load_tabReport2").css('display','block');
		
		var comAjax = new ComAjax();
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/datasearch/selectDsReport2.do' />");
		comAjax.setCallback("fn_selectDsReport2Callback");
		//comAjax.addParam("EXE_NUM","");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.ajax();
	}	
	/*** Select Report2 Ajax Callback ***/
	function fn_selectDsReport2Callback(data){
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport2").hide();
		$("#load_tabReport2").css('display','none');

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabReport2").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabReport2").jqGrid('setSelection','1');
		}
	}
	
	/*** Select Report3 Ajax Call ***/
	function fn_selectDsReport3(){
		
		fn_init(4);
		
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport3").show();
		$("#load_tabReport3").css('display','block');
		
		var comAjax = new ComAjax();
		comAjax.setAsyncFlag(true);	// 비동기 호출
		comAjax.setUrl("<c:url value='/datasearch/selectDsReport3.do' />");
		comAjax.setCallback("fn_selectDsReport3Callback");
		//comAjax.addParam("EXE_NUM","");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",_projId);
		comAjax.ajax();
	}	
	/*** Select Report3 Ajax Callback ***/
	function fn_selectDsReport3Callback(data){
		// Source & Target 그리드에 로딩바 표시하기 (jqGrid 로딩바는 "load_그리드ID" id로 생성된다. ==> jquery.jgGrid.js 참조)
		$("#load_tabReport3").hide();
		$("#load_tabReport3").css('display','none');

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabReport3").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>0)
		{
			$("#tabReport3").jqGrid('setSelection','1');
		}
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Tab1), 3 (Tab2), 4(Tab3)
	*/	
	function fn_init(step){

		if(step<=1){
						
			$("#txtProjId").val('');
			$("#txtProjNm").val('');
			
			$("#tabProject").jqGrid("clearGridData", true);
		}
		
		if(step<=1 || step==2){
			//
			$("#tabReport1").jqGrid("clearGridData", true);
		}
		
		if(step<=1 || step==3){
			//
			$("#tabReport2").jqGrid("clearGridData", true);
		}
		
		if(step<=1 || step==4){
			//
			$("#tabReport3").jqGrid("clearGridData", true);
		}
		
	}
</script>
</body>
</html>