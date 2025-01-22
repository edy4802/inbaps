function gfn_isNull(str) {
    if (str == null) return true;
    if (str == "NaN") return true;
    if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}
 
function ComSubmit(opt_formId) {
    this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
    this.url = "";
     
    if(this.formId == "commonForm"){
        $("#commonForm")[0].reset();
    }
     
    this.setUrl = function setUrl(url){
        this.url = url;
    };
     
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='' >"));
        $("#"+this.formId).find("[id=" + key+"]").val(value);
    };
     
    this.submit = function submit(){
        var frm = $("#"+this.formId)[0];
        frm.action = this.url;
        frm.method = "post";
        frm.submit();   
    };
}

var gfv_ajaxCallback = "";
function ComAjax(opt_formId){
    this.url = "";      
    this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
    this.param = "";
    this.repType = "K";	// N:Normal, K:한글깨짐
    this.asyncFlag = false;	// true:비동기, false:동기
     
    var frm = $("#" + this.formId);
    if(frm.length > 0){
        frm.remove();
    }
    var str = "<form id='" + this.formId + "' name='" + this.formId + "'></form>";
    $('body').append(str);
    
    this.setAsyncFlag = function setAsyncFlag(val){
        this.asyncFlag = val;
    };
    
    this.setUrl = function setUrl(url){
        this.url = url;
    };
    
    this.setRepType = function setRepType(val){
        this.repType = val;
    };    
     
    this.setCallback = function setCallback(callBack){
        fv_ajaxCallback = callBack;
    };
 
    this.setErrCallback = function setErrCallback(callBack){
        fv_ajaxErrCallback = callBack;
    };
    
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='' >"));
        $("#"+this.formId).find("[id=" + key+"]").val(value);
    };
    
    this.addParam2 = function addParam(key, value){
        $("#"+this.formId).append($("<textarea style='display:none;' name='"+key+"' id='"+key+"'>"));
        $("#"+this.formId).find("[id=" + key+"]").val(value);
    };    
    
    /*
    this.addParam = function addParam(key,value){ 
        this.param = this.param + "&" + key + "=" + value; 
    };
    */	 
     
    this.ajax = function ajax(){
        /*
        if(this.formId != "commonForm"){
            this.param += "&" + $("#" + this.formId).serialize();
        }*/
    	this.param = $("#" + this.formId).serialize();
    	
    	// 한글깨짐 방지
    	if(this.repType == "K")
    		this.param = this.param.replace(/%/g,'%25');
    	
        $.ajax({
            url : this.url,    
            type : "POST",   
            data : this.param,
            dataType:"json",
            async : this.asyncFlag,
            success : function(data, status) {
                if(typeof(fv_ajaxCallback) == "function"){
                    fv_ajaxCallback(data);
                }
                else {
                    eval(fv_ajaxCallback + "(data);");
                }
            },
            error:function(request,status,error){
            	if(typeof(fv_ajaxErrCallback) == "function"){
            		fv_ajaxErrCallback(request,error);
                }
            	else {
            		//_alert('err',"[code]:"+request.status+"<br/><br/>"+"[message]:"+request.responseText+"<br/><br/>"+"[error]<br/>"+error,'');
            		_alert('err',"[error]<br/>"+error,'');
                }
            }
        });
    };
}

/*
divId : 페이징 태그가 그려질 div
pageIndx : 현재 페이지 위치가 저장될 input 태그 id
recordCount : 페이지당 레코드 수
totalCount : 전체 조회 건수 
eventName : 페이징 하단의 숫자 등의 버튼이 클릭되었을 때 호출될 함수 이름
*/
var gfv_pageIndex = null;
var gfv_eventName = null;
function gfn_renderPaging(params){
	var divId = params.divId; //페이징이 그려질 div id
	gfv_pageIndex = params.pageIndex; //현재 위치가 저장될 input 태그
	var totalCount = params.totalCount; //전체 조회 건수
	var currentIndex = $("#"+params.pageIndex).val(); //현재 위치
	if($("#"+params.pageIndex).length == 0 || gfn_isNull(currentIndex) == true){
		currentIndex = 1;
	}
	
	var recordCount = params.recordCount; //페이지당 레코드 수
	if(gfn_isNull(recordCount) == true){
		recordCount = 20;
	}
	var totalIndexCount = Math.ceil(totalCount / recordCount); // 전체 인덱스 수
	gfv_eventName = params.eventName;
	
	$("#"+divId).empty();
	var preStr = "";
	var postStr = "";
	var str = "";
	
	var first = (parseInt((currentIndex-1) / 10) * 10) + 1;
	var last = (parseInt(totalIndexCount/10) == parseInt(currentIndex/10)) ? totalIndexCount%10 : 10;
	var prev = (parseInt((currentIndex-1)/10)*10) - 9 > 0 ? (parseInt((currentIndex-1)/10)*10) - 9 : 1; 
	var next = (parseInt((currentIndex-1)/10)+1) * 10 + 1 < totalIndexCount ? (parseInt((currentIndex-1)/10)+1) * 10 + 1 : totalIndexCount;
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨앞, 앞 태그 작성
		preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>" +
				"<a href='#this' class='pad_5' onclick='_movePage("+prev+")'>[<]</a>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨앞 태그 작성
		preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>";
	}
	
	if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨뒤, 뒤 태그 작성
		postStr += "<a href='#this' class='pad_5' onclick='_movePage("+next+")'>[>]</a>" +
					"<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
	}
	else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨뒤 태그 작성
		postStr += "<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
	}
	
	for(var i=first; i<(first+last); i++){
		if(i != currentIndex){
			str += "<a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a>";
		}
		else{
			str += "<strong><a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a></strong>";
		}
	}
	$("#"+divId).append(preStr + str + postStr);
}

function _movePage(value){
	$("#"+gfv_pageIndex).val(value);
	if(typeof(gfv_eventName) == "function"){
		gfv_eventName(value);
	}
	else {
		eval(gfv_eventName + "(value);");
	}
}

var fv_alertCallback = null;
function _alert(type, msg, actionFunc){
	
	fv_alertCallback = actionFunc;
	
	if(type=="info"){
		$( "#divInfoMsg" ).html("<p style='font-size:110%'>"+msg+"</p>");
		$( "#divInfoMsg" ).dialog( "open" );
	}else if(type == "err"){
		$( "#divErrMsg" ).html("<p style='font-size:110%'>"+msg+"</p>");
		$( "#divErrMsg" ).dialog( "open" );
	}else if(type == "cfm"){
		$( "#divConfirm" ).text("Are you sure you want to run?");
		$( "#divConfirm" ).dialog( "open" );
	}
}


function jgGrid_CaptionBarHide(grid){
    var cDiv = grid[0].grid.cDiv;
    grid.setCaption("");
	$("a.ui-jqgrid-titlebar-close",cDiv).unbind();
	$(cDiv).hide();
} 


function getQuerystring(paramName){

	var _tempUrl = window.location.search.substring(1); //url에서 처음부터 '?'까지 삭제
	var _tempArray = _tempUrl.split('&'); // '&'을 기준으로 분리하기
	
	for(var i = 0; _tempArray.length; i++) {
		if( _tempArray[i]!=null){
			var _keyValuePair = _tempArray[i].split('='); // '=' 을 기준으로 분리하기
			
			if(_keyValuePair[0] == paramName){ // _keyValuePair[0] : 파라미터 명
				// _keyValuePair[1] : 파라미터 값
				return _keyValuePair[1];
			}
		}else{
			return "";
		}
	}
}

/*
현재날짜를 YYYYMMDD 형태로 리턴
*/
function gfn_NowDate(format)
{
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 
	var rtn = "";
	if(format == "yyyymmdd"){
		rtn = year + month + day;
	}else if(format == "yyyy"){
		rtn = year;
	}else if(format == "yyyymm"){
		rtn = year + month;
	}
	
    return rtn;
}