<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
    <h2>게시판 목록</h2>
    <table id="board"></table>
	<br/>
	<br/>
	<a href="#this" class="btn" id="write">글쓰기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$("#write").on("click", function(e){ //글쓰기 버튼
				e.preventDefault();
				fn_openBoardWrite();
			});	
			
			$("a[name='title']").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openBoardDetail($(this));
			});

			// jqGrid board
			var jqBoader = $("#board");	
			var rowNum = 15;
			jqBoader.jqGrid({
/*				url:"<c:url value='/sample/selectBoardList.do' />",
				datatype: "json",
  				jsonReader : { 
					total: "total", 
					page:"page",
					root: "rows", // data list 
					//records: function(obj){return obj.length;},
					records: "records",
					repeatitems: true, 
					id: "id"
				}, */
/* 				postData: {
					PAGE_INDEX: 10,
					PAGE_ROW: rowNum
			    }, */				
				datatype: "local",
				mtype:"POST",
			   	colNames:['No','Title', 'Count', 'Date'],
			   	colModel:[
			   		{name:'IDX',index:'IDX', width:30, align:"center",sorttype:"int"},
			   		{name:'TITLE',index:'TITLE', width:250},
			   		{name:'HIT_CNT',index:'HIT_CNT', width:100, align:"center"},
			   		{name:'CREA_DTM',index:'CREA_DTM', width:100, align:"center"}	
			   	],
			   	rowNum:rowNum,
				width:580,
				height:'100%',
			   	viewrecords: true,
			   	multiselect: false,
			   	toolbar:true,
			   	caption: "Project"
			});
			
			jqBoader.jqGrid('setGridParam', 
					{gridComplete: gridComplete()});
/* 			jqBoader.jqGrid('setGridParam', 
					{loadComplete:initPage("jqGrid", "paginate", true, "TOT")});
			jqBoader.jqGrid('setGridParam', 
					{loadError:function(xhr, status, error) {
				        alert(error); 
					}});
			jqBoader.jqGrid('setGridParam', 
					{ondblClickRow: function(rowid,iRow,iCol,e){
						alert('double clicked');
					}});
			jqBoader.jqGrid('setGridParam', 
					{onCellSelect: function(rowId,indexColumn,cellContent,eventObject){
				        alert('onCellSelect'); 
					}});
			jqBoader.jqGrid('setGridParam', 
					{onSelectRow: function(rowId,status,eventObject){
				        alert('onSelectRow'); 
					}});			
 */
		});		
		
		function gridComplete(){
			fn_selectBoardList(1);
		}
		
		// AJAX 호출 예제		
		function fn_selectBoardList(pageNo){
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/sample/selectBoardList.do' />");
			comAjax.setCallback("fn_selectBoardListCallback");
			comAjax.addParam("PAGE_INDEX",pageNo);
			comAjax.addParam("PAGE_ROW", 15);
			comAjax.addParam("IDX_FE", $("#IDX_FE").val());
			comAjax.ajax();
		}
		
		function fn_selectBoardListCallback(data){
			var total = data.records;
			if(total == 0){
				var str = "aaaa";
			}
			else{
				var str = "";

/* 				var rows = data.rows;
				alert(rows.length);
				for(var i=0; i<=rows.length; i++){
					alert(rows[i].TITLE);
					$("#board").jqGrid('addRowData', i+1, rows[i]);
				} */
				
/* 				var mydata = [
							{IDX:"1",TITLE:"name1",HIT_CNT:"1",CREA_DTM:"val1"}
						   ,{IDX:"2",TITLE:"name1",HIT_CNT:"2",CREA_DTM:"val1"}
						   ,{IDX:"3",TITLE:"name1",HIT_CNT:"3",CREA_DTM:"val1"}
						]; */
						
				var mydata = data.rows;

				for(var i=0; i<=mydata.length; i++){
					$("#board").jqGrid('addRowData', i+1, mydata[i]);
				}
				
				/* 				$.each(data.rows, function(key, value){
 					str += "<tr>" + 
								"<td>" + value.IDX + "</td>" + 
								"<td class='title'>" +
									"<a href='#this' name='title'>" + value.TITLE + "</a>" +
									"<input type='hidden' name='title' value=" + value.IDX + ">" + 
								"</td>" +
								"<td>" + value.HIT_CNT + "</td>" + 
								"<td>" + value.CREA_DTM + "</td>" + 
							"</tr>";
				}); */
			}
		}		
		
		function fn_openBoardWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		


		
		function fn_selectBoardListCallback2(data){
			var total = data.records;
			var body = $("table>tbody");
			body.empty();
			if(total == 0){
				var str = "<tr>" + 
								"<td colspan='4'>조회된 결과가 없습니다.</td>" + 
							"</tr>";
				body.append(str);
			}
			else{
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectBoardList"
				};
				gfn_renderPaging(params);
				
				var str = "";
				$.each(data.list, function(key, value){
					str += "<tr>" + 
								"<td>" + value.IDX + "</td>" + 
								"<td class='title'>" +
									"<a href='#this' name='title'>" + value.TITLE + "</a>" +
									"<input type='hidden' name='title' value=" + value.IDX + ">" + 
								"</td>" +
								"<td>" + value.HIT_CNT + "</td>" + 
								"<td>" + value.CREA_DTM + "</td>" + 
							"</tr>";
				});
				body.append(str);
				
				$("a[name='title']").on("click", function(e){ //제목 
					e.preventDefault();
					fn_openBoardDetail($(this));
				});
			}
		}
	</script>
</body>
</html>