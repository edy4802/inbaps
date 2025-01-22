<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<script type="text/javascript">
	$.jgrid.no_legacy_api = true;
	$.jgrid.useJSON = true;
</script>
</head>
<body>
    <h2>전자정부프레임워크 게시판 목록</h2>
    <table class="board_list">
        <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="15%"/>
            <col width="20%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col">글번호</th>
                <th scope="col">제목</th>
                <th scope="col">조회수</th>
                <th scope="col">작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${fn:length(list) > 0}">
                    <c:forEach var="row" items="${list}" varStatus="status">
                        <tr>
                            <td>${row.IDX }</td>
                            <td class="title">
                                <a href="#this" name="title">${row.TITLE }</a>
                                <input type="hidden" id="IDX" value="${row.IDX }">
                            </td>
                            <td>${row.HIT_CNT }</td>
                            <td>${row.CREA_DTM }</td>
                        </tr>
                    </c:forEach>  
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4">조회된 결과가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>   
        </tbody>
    </table>
    <table id="board"></table>
    <c:if test="${not empty paginationInfo}">
        <ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="fn_search"/>
    </c:if>
    <input type="hidden" id="currentPageNo" name="currentPageNo"/>
     
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
        });
         
         
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
         
        function fn_search(pageNo){
            var comSubmit = new ComSubmit();
            comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
            comSubmit.addParam("currentPageNo", pageNo);
            comSubmit.submit();
        }
    </script>
    <script type="text/javascript">
		jQuery(document).ready(function(){
		//////////////////////////////
		jQuery("#board").jqGrid({
			datatype: "local",
			width:580,
			height: 380,
		   	colNames:['No','Title', 'Count', 'date'],
		   	colModel:[
		   		{name:'NO',index:'NO', width:30, align:"center",sorttype:"int"},
		   		{name:'TITLE',index:'TITLE', width:250},
		   		{name:'COUNT',index:'COUNT', width:100},
		   		{name:'DATE',index:'DATE', width:100}	
		   	],
		   	multiselect: false,
		   	caption: "title1"
		});

		var mydata = null;
		var cnt = '${fn:length(list)}';
        
		mydata = [
			{NO:"1",TITLE:"name1",COUNT:"bnd1",DATE:"val1",DISP_ORD:"1",USE_YN:"y"}
		   ,{NO:"1",TITLE:"name1",COUNT:"bnd1",DATE:"val1",DISP_ORD:"1",USE_YN:"y"}
		   ,{NO:"1",TITLE:"name1",COUNT:"bnd1",DATE:"val1",DISP_ORD:"1",USE_YN:"y"}
		];
		
		for(var i=0;i<=mydata.length;i++)
			jQuery("#board").jqGrid('addRowData',i+1,mydata[i]);
	
	});
	</script>
</body>
</html>