<%@ page session="false" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

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
  
  #divLoginPop .ui-dialog-titlebar-close{
    display: none;
    visibility: hidden;
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
		<td style="width:100%;vertical-align: top;padding-left:15px;padding-top:15px;">

<!-- 본문영역 (시작) -->
	
	<div id="divLoginPop" title="IN-BAPS 로그인" style="line-height:3;">
		<span class="inputLabel">아이디(*)</span><input id="txtUsrId" name="txtUsrId" type="text" class="inputText" style="width:180px;" spellcheck='false' ></input><span class="inputDesc"></span>
		<br/><span class="inputLabel">비밀번호(*)</span><input id="txtUsrPw" name="txtUsrPw" type="password" class="inputText" style="width:180px;" spellcheck='false' ></input><span class="inputDesc"></span>
		<div id="divLoginProMsg" style="display:none;"> 
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong>메시지:</strong> <span id="spanLoginProMsg"></span></p>
			</div>
		</div>
		</div>
	</div>
	

<!-- 본문영역 (끝) -->

		</td>
	</tr>
</tbody>
</table>
<%@ include file="/WEB-INF/include/include-bodyMsg.jspf" %>
<%@ include file="/WEB-INF/include/include-body.jspf" %>

<script type="text/javascript">

	var logYn = getQuerystring('loginYn');

    $(document).ready(function(){
		//    	
		/*** Source properties Poupup ***/
		$( "#divLoginPop" ).dialog({
			autoOpen: true,
			modal: false,
			width: 400,
			closeOnEscape: false,
			dialogClass: "no-close",
			buttons: [
				{
					text: "로그인",
					click: function() {
						fn_login();
						//$( this ).dialog( "close" );
					}
				}
			]
		});	
		$(".ui-dialog-titlebar-close").hide();
		$( "#divLoginPop" ).dialog( "open" );
		
		$("#txtUsrId").focus();
		
		if(logYn == 'N'){
			fn_LoginMsg('로그인정보가 일치하지 않습니다.');
		}
		
		$('#txtUsrId').keyup(function(e){
		    if(e.keyCode == 13)
		    {
		    	$('#txtUsrPw').focus();
		    }
		});
		
		$('#txtUsrPw').keyup(function(e){
		    if(e.keyCode == 13)
		    {
		    	fn_login();
		    }
		});
    });
    
	function fn_login(){
    	
    	var usrId = $("#txtUsrId").val();
    	var usrPw = $("#txtUsrPw").val();
    	
    	if(gfn_isNull(usrId)){
    		fn_LoginMsg("유효값을 입력하세요.");
			$("#txtUsrId").focus();
			return false;
		}
    	if(gfn_isNull(usrPw)){
    		fn_LoginMsg("유효값을 입력하세요.");
			$("#txtUsrPw").focus();
			return false;
		}
    	
    	var comSubmit = new ComSubmit();
    	comSubmit.setUrl("<c:url value='/datasearch/loginProcess.do' />");
    	comSubmit.addParam("txtUsrId",usrId);
    	comSubmit.addParam("txtUsrPw",usrPw);		
    	comSubmit.submit();
    }
	
	function fn_LoginMsg(msg){
		$("#spanLoginProMsg").text(msg);
		$("#divLoginProMsg").css("display", "block");
	}
</script>
</body>
</html>
