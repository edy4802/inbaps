<%@ page session="true" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
<style>

  #body .button {
  	vertical-align: top;
  }
  
  #divLoginPop .inputLabel{
  	display:inline-block;
  	width:120px;
  }
  #divLoginPop .inputDesc{
  	display:inline-block;
  	margin-left:10px;
  }
  #divLoginPop .inputLabel2{
  	display:inline-block;
  	text-align:center;
  }
 
  #divLoginPop .inputText{
  	height:20px;
  }  
</style>  
</head>
<body>
<table id="body" style="width:100%;height:100%;margin:0px;padding:0px;border-spacing:0px;border-style:none;" borber="0" cellpadding="0" cellspacing="0">
<tbody>
	<tr>
		<td><%@ include file="/WEB-INF/include/include-top.jspf" %></td>
	</tr>
	<tr style="height:100%;">
		<td style="width:100%;vertical-align: top;background-color: #efefef;">

<!-- 본문영역 (시작) -->		
	<div id="parameters-table">
		<table style="width:100%;height:100%;">
			<tr>
			<td class="table-column"><img src="/inbaps/images/logo1.png" id="dsMain" />
			<h1>C-BAP</h1>
			<div><c:if test="${not empty sessionScope.userLoginInfo.cbapTit}">${sessionScope.userLoginInfo.cbapTit}</c:if></div>
			</td>
<!-- 			<td class="table-column"><img src="/inbaps/images/logo2.png" id="rtMain" /> -->
<!-- 			<h1>R-BAP</h1> -->
<%-- 			<div><c:if test="${not empty sessionScope.userLoginInfo.rbapTit}">${sessionScope.userLoginInfo.rbapTit}</c:if></div> --%>
<!-- 			</td> -->
<!-- 			<td class="table-column"><img src="/inbaps/images/logo3.png" id="vwMain" /> -->
<!-- 			<h1>V-BAP</h1> -->
<%-- 			<div><c:if test="${not empty sessionScope.userLoginInfo.vbapTit}">${sessionScope.userLoginInfo.vbapTit}</c:if></div> --%>
<!-- 			</td> -->
			</tr>
		</table>
	</div>

<!-- 본문영역 (끝) -->

		</td>
	</tr>
</tbody>
</table>
<%@ include file="/WEB-INF/include/include-bodyMsg.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

<!-- 팝업DIV영역(시작) -->
<div id="divLoginPop" title="Login" style="line-height:2.8;">
<span class="inputLabel">User Id(*)</span><input id="txtUsrId" name="txtUsrId" type="text" class="inputText" style="width:120px;" spellcheck='false' ></input><span class="inputDesc">UserId</span>
<br/><span class="inputLabel">Password(*)</span><input id="txtUsrPw" name="txtUsrPw" type="password" class="inputText" style="width:120px;" spellcheck='false' ></input><span class="inputDesc">Password</span>
<div id="divLoginProMsg" style="display:none;"> 
<div class="ui-widget">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong>Alert:</strong> <span id="spanLoginProMsg"></span></p>
	</div>
</div>
</div>
</div>

<!-- 팝업DIV영역(끝) -->



<script type="text/javascript">
var sysGubun = ''; 
    $(document).ready(function(){
    	/*** Source properties Poupup ***/
		$( "#divLoginPop" ).dialog({
			autoOpen: false,
			modal: true,
			width: 400,
			buttons: [
				{
					text: "Ok",
					click: function() {
						fn_login();
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
    	
		$( "#divLoginPop" ).dialog( "close" );
    	
        $("#dsMain").on("click", function(e){
            e.preventDefault();
            //fn_viewLogin(1);
            fn_openMain(1);
        });

        $("#rtMain").on("click", function(e){
            e.preventDefault();
            //fn_viewLogin(2);
            fn_openMain(2);
        });

        $("#vwMain").on("click", function(e){
            e.preventDefault();
            //fn_viewLogin(3);
            fn_openMain(3);
        });
        
        fn_openMain(1);
    });
    
    function fn_viewLogin(flag){
    	sysGubun = flag;
    	$("#spanLoginProMsg").text("");
		$("#divLoginProMsg").css("display", "none");
		$("#txtUsrId").val('');
		$("#txtUsrPw").val('');
    	$( "#divLoginPop" ).dialog( "open" );
    }
    
    function fn_login(){
    	
    	var usrId = $("#txtUsrId").val();
    	var usrPw = $("#txtUsrPw").val();
    	
    	if(gfn_isNull(usrId)){
			$("#spanLoginProMsg").text("Enter the value.");
			$("#divLoginProMsg").css("display", "block");
			$("#txtUsrId").focus();
			return false;
		}
    	if(gfn_isNull(usrPw)){
			$("#spanLoginProMsg").text("Enter the value.");
			$("#divLoginProMsg").css("display", "block");
			$("#txtUsrPw").focus();
			return false;
		}
    	
    	var comAjax = new ComAjax();
		comAjax.setUrl("<c:url value='/datasearch/loginProcess.do' />");
		comAjax.setAsyncFlag(true);	// ture:비동기
		comAjax.setCallback("fn_selectLoginCallback");
		comAjax.addParam("txtUsrId",usrId);
		comAjax.addParam("txtUsrPw",usrPw);
		
		comAjax.ajax();
    }
    
    function fn_selectLoginCallback(data){
    	if(data==null){return;}
		var mydata = data.rows;

		if(mydata==null){
			$("#spanLoginProMsg").text("Login failed.");
			$("#divLoginProMsg").css("display", "block");
			$("#txtUsrPw").focus();
			return;
		}
		if(mydata.length>0){
			var loginYn = mydata[0].LOGIN_YN;
			
			if(loginYn == "Y"){
				$("#divLoginPop").dialog( "close" );
				fn_openMain(sysGubun);				
			}else{
				$("#spanLoginProMsg").text("Login failed.");
				$("#divLoginProMsg").css("display", "block");
				$("#txtUsrPw").focus();
				return;
			}	
		}
	}	
    
    function fn_openMain(flag){
        var comSubmit = new ComSubmit();
        if(flag ==1 ){
        	//comSubmit.setUrl("<c:url value='/datasearch/openDataSearch.do' />");
        	comSubmit.setUrl("<c:url value='/datasearch/goPage.do?PAGE=/ds/dsStep01&MENULINK=openDsStep01' />");
        }else if(flag ==2 ){
        	comSubmit.setUrl("<c:url value='/rstudio/openRStudio.do' />");
        }else if(flag ==3 ){
        	comSubmit.setUrl("<c:url value='/visual/openVisualization.do' />");
        }
        comSubmit.submit();
    }
</script>
</body>
</html>