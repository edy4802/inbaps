<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
<%@ include file="/WEB-INF/include/include-bodyTopRT.jspf" %>
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
			<td class="tdContent" style="line-height:2.8;">
				<button id="goProjNew" class="button" style="width:50px;">Add</button>
				<button id="goProjDel" class="button" style="width:70px;">Delete</button>
			</td>
			<td></td>
			<td class="tdContent" style="line-height:2.8;">
				<button id="goJobNew" class="button" style="width:50px;">Add</button>
				<button id="goJobDel" class="button" style="width:70px;">Delete</button>
			</td>			
		</tr>		
	</tbody>
</table>

<!-- 본문영역 (끝) -->		
<%@ include file="/WEB-INF/include/include-bodyBottom.jspf" %>
<!-- 팝업DIV영역(시작) -->

<div id="divProjProPop" title="Modify the project properties" style="line-height:2.8;">
<span class="inputLabel">Project Id(*)</span><input id="txtProjProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input><span class="inputDesc">"P"+Number(5)</span>
<br/><span class="inputLabel">Name(*)</span><input id="txtProjProProjNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">Description</span><input id="txtProjProProjDesc" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">Collection Type</span><input id="txtProjProColectTypCd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">API:Open API, CRW:Crawling</span>
<br/><span class="inputLabel">Disp.Ord</span><input id="txtProjProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">Enter an integer.</span>
<div id="divProjProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>Alert:</strong> <span id="spanProjProMsg"></span></p>
	</div>
</div>
</div>
</div>

<div id="divJobProPop" title="Modify the job properties" style="line-height:2.8;">
<span class="inputLabel">Project Id(*)</span><input id="txtJobProProjId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input><span class="inputDesc">"P"+Number(5)</span>
<br/><span class="inputLabel">Job Id(*)</span><input id="txtJobProJobId" type="text" class="inputText" style="width:350px;" disabled="disabled" spellcheck='false' ></input><span class="inputDesc">"J"+Number(5)</span>
<br/><span class="inputLabel">Name(*)</span><input id="txtJobProJobNm" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input>
<br/><span class="inputLabel">Disp.Ord</span><input id="txtJobProDispOrd" type="text" class="inputText" style="width:350px;" spellcheck='false' ></input><span class="inputDesc">Enter an integer.</span>
<div id="divJobProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>Alert:</strong> <span id="spanJobProMsg"></span></p>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
	var rowNum = 10;
	var _projRowId = '1';
	var _jobRowId = '1';
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#goProjNew" ).button();
		$( "#goProjDel" ).button();
		$( "#goJobNew" ).button();
		$( "#goJobDel" ).button();
		
		/*** Project properties Poupup ***/
		$( "#divProjProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "Save",
					click: function() {
						fn_saveProjInfo();
						//$( this ).dialog( "close" );
					}
				},
				{
					text: "Cancel",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});	
		
		/*** Job properties Poupup ***/
		$( "#divJobProPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 700,
			buttons: [
				{
					text: "Save",
					click: function() {
						fn_saveJobInfo();
						//$( this ).dialog( "close" );
					}
				},
				{
					text: "Cancel",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});	
		
		$( "#divProjProPop" ).dialog( "close" );
		$( "#divJobProPop" ).dialog( "close" );
		
		/*** Project Grid ***/
		var tabProj = $("#tabProject");
		tabProj.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['Id','Name', 'Desc', 'Type', 'DispOrd', 'UsrId'],
		   	colModel:[
		   		{name:'PROJ_ID',index:'PROJ_ID', width:30, align:'center'},
		   		{name:'PROJ_NM',index:'PROJ_NM', width:150},
		   		{name:'COLECT_TYP_CD',index:'COLECT_TYP_CD', width:30, align:'center'},
		   		{name:'PROJ_DESC',index:'PROJ_DESC', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true},
		   		{name:'USR_ID',index:'USR_ID', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:400,//"100%",
		   	viewrecords: true,
		   	multiselect: false,
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "Project"
		});
		
		tabProj.jqGrid('setGridParam', 
				{gridComplete: gridCompleteProj()});
		
		tabProj.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_projRowId = rowId;
					var projId = tabProj.jqGrid ('getCell', rowId, 'PROJ_ID');
					fn_setProjPro(rowId);			        
			        fn_selectJobList(projId);
				}});
		
		tabProj.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
			        var projId = tabProj.jqGrid ('getCell', rowId, 'PROJ_ID');
					$("#spanProjProMsg").text("");
					$("#divProjProMsg").css("display", "none");
			        $( "#divProjProPop" ).dialog( "open" );
					event.preventDefault();
				}});		
	
		/*** Job Grid ***/
		var tabJob = $("#tabJob");	
		tabJob.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['Id','Name', 'ProjId', 'DispOrd'],
		   	colModel:[
		   		{name:'JOB_ID',index:'JOB_ID', width:30, align:'center'},
		   		{name:'JOB_NM',index:'JOB_NM', width:150},
		   		{name:'PROJ_ID',index:'PROJ_ID', hidden: true},
		   		{name:'DISP_ORD',index:'DISP_ORD', hidden: true}
		   	],
		   	//rowNum:rowNum,
			width:600,
			height:400,//"100%",
		   	viewrecords: true,
		   	multiselect: false,
		   	toolbar:true,
		   	loadtext:"Loading...",
		   	caption: "Job"
		});
		
		tabJob.jqGrid('setGridParam', 
				{gridComplete: gridCompleteJob()});
		
		tabJob.jqGrid('setGridParam', 
				{onSelectRow: function(rowId,status,eventObject){
					_jobRowId = rowId;
					fn_setJobPro(rowId);
				}});
		
		tabJob.jqGrid('setGridParam', 
				{ondblClickRow: function(rowId, iRow,iCol){
					$("#spanJobProMsg").text("");
					$("#divJobProMsg").css("display", "none");
					$( "#divJobProPop" ).dialog( "open" );
					event.preventDefault();
				}});
		
		/*** Project Add Button Click ***/
		$("#goProjNew").on("click", function(e){
			e.preventDefault();
			//
			fn_newProjPro();
			$("#spanProjProMsg").text("");
			$("#divProjProMsg").css("display", "none");
			$( "#divProjProPop" ).dialog( "open" );
		});
		
		/*** Project Del Button Click ***/
		$("#goProjDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteProjInfo');
		});		
		
		/*** Job Add Button Click ***/
		$("#goJobNew").on("click", function(e){
			e.preventDefault();
			//
			var tabProj = $("#tabProject");
			var projId = tabProj.jqGrid ('getCell', _projRowId, 'PROJ_ID');
			fn_newJobPro(projId);
			$("#spanJobProMsg").text("");
			$("#divJobProMsg").css("display", "none");
			$( "#divJobProPop" ).dialog( "open" );
		});	
		
		/*** Job Del Button Click ***/
		$("#goJobDel").on("click", function(e){
			e.preventDefault();
			//
			_alert('cfm','','fn_deleteJobInfo');
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
		
		var projId = tabProj.jqGrid ('getCell', rowId, 'PROJ_ID');
		var projNm = tabProj.jqGrid ('getCell', rowId, 'PROJ_NM');
		var projDesc = tabProj.jqGrid ('getCell', rowId, 'PROJ_DESC');
		var colectTypCd = tabProj.jqGrid ('getCell', rowId, 'COLECT_TYP_CD');
        var dispOrd = tabProj.jqGrid ('getCell', rowId, 'DISP_ORD');
        
        $("#txtProjProProjId").val(projId);
        $("#txtProjProProjNm").val(projNm);
        $("#txtProjProProjDesc").val(projDesc);
        $("#txtProjProColectTypCd").val(colectTypCd);
        $("#txtProjProDispOrd").val(dispOrd);		
	}
	
	/*** Setting New Project Properties ***/
	function fn_newProjPro(){
        
        $("#txtProjProProjId").val("New");
        $("#txtProjProProjNm").val('');
        $("#txtProjProProjDesc").val('');
        $("#txtProjProColectTypCd").val('');
        $("#txtProjProDispOrd").val('');		
	}	
	
	/*** Setting Update Job Properties ***/
	function fn_setJobPro(rowId){
		var tabJob = $("#tabJob");
		
		var projId = tabJob.jqGrid ('getCell', rowId, 'PROJ_ID');
		var jobId = tabJob.jqGrid ('getCell', rowId, 'JOB_ID');
		var jobNm = tabJob.jqGrid ('getCell', rowId, 'JOB_NM');
	    var dispOrd = tabJob.jqGrid ('getCell', rowId, 'DISP_ORD');
	    
	    $("#txtJobProProjId").val(projId);
	    $("#txtJobProJobId").val(jobId);
	    $("#txtJobProJobNm").val(jobNm);
	    $("#txtJobProDispOrd").val(dispOrd);
	}
	
	/*** Setting New Job Properties ***/
	function fn_newJobPro(projId){
	    $("#txtJobProProjId").val(projId);
	    $("#txtJobProJobId").val("New");
	    $("#txtJobProJobNm").val('');
	    $("#txtJobProDispOrd").val('');
	}
	
	/*** Select Project Ajax Call ***/
	function fn_selectProjList(){
		
		fn_init(1);
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsProjectList.do' />");
		comAjax.setCallback("fn_selectProjectListCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.ajax();
	}
	
	/*** Select Project Ajax Callback ***/
	function fn_selectProjectListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabProject").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_projRowId)
			$("#tabProject").jqGrid('setSelection',_projRowId);
		else if(mydata.length>0)
			$("#tabProject").jqGrid('setSelection','1');
	}
	
	/*** Select Job Complete ***/
	function gridCompleteJob(){
		//
	}
	
	/*** Select Job Ajax Call ***/
	function fn_selectJobList(prjId){
		
		fn_init(2);
		
		var tabProj = $("#tabProject");
		var colectTypCd = tabProj.jqGrid ('getCell', _projRowId, 'COLECT_TYP_CD');
		
		var comAjax = new ComAjax();
		if(colectTypCd == "CRW"){
			comAjax.setUrl("<c:url value='/datasearch/selectDsJobList.do' />");
			comAjax.setCallback("fn_selectDsJobListCallback");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("PROJ_ID",prjId);
		}else if (colectTypCd == "API"){
			comAjax.setUrl("<c:url value='/datasearch/selectDsApiJobList.do' />");
			comAjax.setCallback("fn_selectDsApiJobListCallback");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("PROJ_ID",prjId);		
		}
		comAjax.ajax();
	}
	
	/*** Select Job Ajax Callback ***/
	function fn_selectDsJobListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabJob").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_jobRowId)
			$("#tabJob").jqGrid('setSelection',_jobRowId);
		else if(mydata.length>0)
			$("#tabJob").jqGrid('setSelection','1');
		
	}
	
	/*** Select API Job Ajax Callback ***/
	function fn_selectDsApiJobListCallback(data){

		var mydata = data.rows;

		for(var i=0; i<mydata.length; i++){
			$("#tabJob").jqGrid('addRowData', i+1, mydata[i]);
		}
		
		if(mydata.length>=_jobRowId)
			$("#tabJob").jqGrid('setSelection',_jobRowId);
		else if(mydata.length>0)
			$("#tabJob").jqGrid('setSelection','1');
		
	}
	
	/*** Save Project Ajax Call ***/
	function fn_saveProjInfo(){
		
		var projId = $("#txtProjProProjId").val();
		var projNm = $("#txtProjProProjNm").val();
		var projDesc = $("#txtProjProProjDesc").val();
		var colectTypCd = $("#txtProjProColectTypCd").val();
		var dispOrd = $("#txtProjProDispOrd").val();
		
		if(gfn_isNull(projNm)){
			$("#spanProjProMsg").text("Enter the name.");
			$("#divProjProMsg").css("display", "block");
			$("#txtProjProProjNm").focus();
			return false;
		}
		
		var comAjax = new ComAjax();
		if(projId == "New"){
			comAjax.setUrl("<c:url value='/datasearch/insDsProjectInfo.do' />");
			comAjax.setCallback("fn_insProjectInfoCallback");
			comAjax.addParam("PROJ_ID","NEW");
		}else{
			comAjax.setUrl("<c:url value='/datasearch/saveDsProjectInfo.do' />");
			comAjax.setCallback("fn_saveProjectInfoCallback");
			comAjax.addParam("PROJ_ID",projId);
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_NM",projNm);
		comAjax.addParam("PROJ_DESC",projDesc);
		comAjax.addParam("COLECT_TYP_CD",colectTypCd);
		comAjax.addParam("DISP_ORD",dispOrd);			
		comAjax.ajax();
	}
	
	/*** Delete Project Ajax Call ***/
	function fn_deleteProjInfo(){
		var tabProj = $("#tabProject");
		var projId = tabProj.jqGrid ('getCell', _projRowId, 'PROJ_ID');
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/delDsProjectInfo.do' />");
		comAjax.setCallback("fn_delProjectInfoCallback");
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);			
		comAjax.ajax();
	}
	
	/*** Insert Project Ajax Callback ***/
	function fn_insProjectInfoCallback(data){
		$("#divProjProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Delete Project Ajax Callback ***/
	function fn_delProjectInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}	
	
	/*** Update Project Ajax Callback ***/
	function fn_saveProjectInfoCallback(data){
		$("#divProjProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Save Job Ajax Call ***/
	function fn_saveJobInfo(){
		
		var projId = $("#txtJobProProjId").val();
		var jobId = $("#txtJobProJobId").val();
		var jobNm = $("#txtJobProJobNm").val();
		var dispOrd = $("#txtJobProDispOrd").val();
		
		var tabProj = $("#tabProject");
		var colectTypCd = tabProj.jqGrid ('getCell', _projRowId, 'COLECT_TYP_CD');
		
		if(gfn_isNull(jobNm)){
			$("#spanJobProMsg").text("Enter the name.");
			$("#divJobProMsg").css("display", "block");
			$("#txtJobProJobNm").focus();
			return false;
		}

		var comAjax = new ComAjax();
		if(jobId == "New"){
			if(colectTypCd=="CRW"){
				comAjax.setUrl("<c:url value='/datasearch/insDsJobInfo.do' />");
				comAjax.setCallback("fn_insDsJobInfoCallback");
				comAjax.addParam("JOB_ID","NEW");
			}else if(colectTypCd=="API"){
				comAjax.setUrl("<c:url value='/datasearch/insDsApiJobInfo.do' />");
				comAjax.setCallback("fn_insDsApiJobInfoCallback");
				comAjax.addParam("JOB_ID","NEW");				
			}			
		}else{
			if(colectTypCd=="CRW"){
				comAjax.setUrl("<c:url value='/datasearch/saveDsJobInfo.do' />");
				comAjax.setCallback("fn_saveDsJobInfoCallback");
				comAjax.addParam("JOB_ID",jobId);
			}else if(colectTypCd=="API"){
				comAjax.setUrl("<c:url value='/datasearch/saveDsApiJobInfo.do' />");
				comAjax.setCallback("fn_saveDsApiJobInfoCallback");
				comAjax.addParam("JOB_ID",jobId);
			}
		}
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.addParam("PROJ_ID",projId);
		comAjax.addParam("JOB_NM",jobNm);
		comAjax.addParam("DISP_ORD",dispOrd);
		
		comAjax.ajax();
	}
	
	/*** Delete Job Ajax Call ***/
	function fn_deleteJobInfo(){
		var tabJob = $("#tabJob");
		var projId = tabJob.jqGrid ('getCell', _jobRowId, 'PROJ_ID');
		var jobId = tabJob.jqGrid ('getCell', _jobRowId, 'JOB_ID');
		
		var tabProj = $("#tabProject");
		var colectTypCd = tabProj.jqGrid ('getCell', _projRowId, 'COLECT_TYP_CD');
		
		var comAjax = new ComAjax();
		if(colectTypCd=="CRW"){
			comAjax.setUrl("<c:url value='/datasearch/delDsJobInfo.do' />");
			comAjax.setCallback("fn_delDsJobInfoCallback");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("PROJ_ID",projId);
			comAjax.addParam("JOB_ID",jobId);
		}else if(colectTypCd=="API"){
			comAjax.setUrl("<c:url value='/datasearch/delDsApiJobInfo.do' />");
			comAjax.setCallback("fn_delDsApiJobInfoCallback");
			comAjax.addParam("USR_ID",g_usrId);
			comAjax.addParam("PROJ_ID",projId);
			comAjax.addParam("JOB_ID",jobId);
		}
		comAjax.ajax();
	}	
	
	/*** Insert Job Ajax Callback ***/
	function fn_insDsJobInfoCallback(data){
		$("#divJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Insert API Job Ajax Callback ***/
	function fn_insDsApiJobInfoCallback(data){
		$("#divJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Delete Job Ajax Callback ***/
	function fn_delDsJobInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Delete API Job Ajax Callback ***/
	function fn_delDsApiJobInfoCallback(data){
		$("#divConfirm").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Update Job Ajax Callback ***/
	function fn_saveDsJobInfoCallback(data){
		$("#divJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*** Update API Job Ajax Callback ***/
	function fn_saveDsApiJobInfoCallback(data){
		$("#divJobProPop").dialog( "close" );
		_alert('info','Success!!!','fn_selectProjList');
	}
	
	/*
	step : 0 (init),  1 (Project), 2 (Job)
	*/	
	function fn_init(step){
		if(step<=0){
			_projRowId = '1';
			_jobRowId = '1';
		}
			
		if(step<=1){
						
			$("#tabProject").jqGrid("clearGridData", true);
		}
		
		if(step<=2){
			$("#tabJob").jqGrid("clearGridData", true);
		}
	}	
</script>
</body>
</html>