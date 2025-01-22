<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 배치결과 -->
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
				<div id="divApiPro">
					<h3>배치결과 조회</h3>
					<div><span class="inputLabel">배치기간</span>
					<input id="txtFromExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;~&nbsp;
					<input id="txtToExeNum" type="text" class="text" style="width:70px;" maxlength="8" spellcheck='false' ></input>&nbsp;
					<button id="selectResult" class="button" style="width:70px;">조회</button>
					</div>
				</div>
			</td>
			<td></td>
			<td class="tdContent">			
				
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

<script type="text/javascript">
	var rowNum = 10;
	var _resRowId = '1';
	
	var _timerId = 0;
	var _idsResult = null;
	var _srcChkRowIdx = -1;
	var _timerState = 0;	// 1:start, 0:stop
	
	$(document).ready(function(){
		
		/*** Button Style ***/
		$( "#selectResult" ).button();
		
		$( "#divApiPro" ).accordion();
		$( "#divApiExe" ).accordion();
		
		$("#txtFromExeNum").val(gfn_NowDate('yyyy')+'0101');
		$("#txtToExeNum").val(gfn_NowDate('yyyymmdd'));
		$("#txtExeNum").val(gfn_NowDate('yyyymmdd'));
		

		/*** Source & Target Grid ***/
		var tabResult = $("#tabResult");
		tabResult.jqGrid({
			datatype: "json",
			mtype:"POST",
		   	colNames:['배치순번','배치ID','프로그램명','예약일시','진행상태','시작시간','종료시간'],
		   	colModel:[
				{name:'EXE_NUM',index:'EXE_NUM', width:30, align:'center'},
		   		{name:'BAT_ID',index:'BAT_ID', width:30, align:'center'},
		   		{name:'CAL_PRGM',index:'CAL_PRGM', width:80},		   		
		   		{name:'RSV_DT',index:'RSV_DT', width:50, align:'center'},
		   		{name:'EXE_STATE',index:'EXE_STATE', width:30, align:'center'},
		   		{name:'STR_TIME',index:'STR_TIME', width:40, align:'center'},
		   		{name:'END_TIME',index:'END_TIME', width:40, align:'center'}
		   	],
		   	//rowNum:rowNum,
			width:1230,
			height:600,//"100%",
			hidegrid : false,
		   	viewrecords: true,
		   	multiselect: false,
		   	cmTemplate: {sortable:false},
		   	toolbar:true,		   	
		   	loadtext:"<img src=\"<c:url value='/jqGrid/css/smoothness/images/ui-anim_basic_16x16.gif'/>\" />",
		   	caption: "배치결과"
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
			        //
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


		fn_init(0);
		
		
	});		
	
	/*** Select Project Complete ***/
	function gridCompleteProj(){
		//
	}
	
	function fn_setResultPro(rowId){
		//	
	}
		
	/*** Select Job Complete ***/
	function gridCompleteJob(){
		//
	}
	
	
	/*** Select Source Complete ***/
	function gridCompleteSrc(){
		//
	}
	
	
	/*** Select Source&Target Complete ***/
	function gridCompleteResult(){
		//
	}
	
	
	/*** Select Api Result Ajax Call ***/
	function fn_selectResultList(){
		
		fn_init(1);
		
		var exeFromNum = $("#txtFromExeNum").val();
		var exeToNum = $("#txtToExeNum").val();
		
		if(!$.isNumeric(exeFromNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		if(!$.isNumeric(exeToNum)){_alert('info','날짜형식 또는 숫자타입만 입력가능합니다.','');return;}
		
		var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/selectDsBatResultList.do' />");
		comAjax.setCallback("fn_selectDsExeApiResultListCallback");
		comAjax.addParam("EXE_FROM_NUM",exeFromNum);
		comAjax.addParam("EXE_TO_NUM",exeToNum);
		comAjax.addParam("USR_ID",g_usrId);
		comAjax.ajax();
	}
	
	/*** Select Api Result Ajax Callback ***/
	function fn_selectDsExeApiResultListCallback(data){

		var mydata = data.rows;

		var rowKey;
		var firstKey;
		if(mydata!=null){
			for(var i=0; i<mydata.length; i++){
				//rowKey = _projId + '.' + _jobId + '.' + mydata[i].SRC_ID + '.' + mydata[i].EXE_NUM;
				rowKey = mydata[i].EXE_NUM;
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
	
	/*
	step : 0 (init),  1 (Project), 2 (Job), 3(Source), 4(Exe Input),  5(Result)
	*/	
	function fn_init(step){
		if(step<=0){
			_idsResult = null;
			_timerId = 0;
			_timerState = 0;	// 1:start, 0:stop
			_srcChkRowIdx = -1;
			
		}
			
		if(step<=1){
						
			$("#tabResult").jqGrid("clearGridData", true);
		}
	}	
</script>
</body>
</html>