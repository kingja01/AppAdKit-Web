function submitFunction(controller){
	var flag = false;
	var err_msg = "提交失败！请先选择APP，并检查表单内容。";
	var tempVar;
	var action = $("#action").val();		
	
	tempVar = "bundleIdentifier";
	if($("#"+tempVar).val() == ""){
		flag = true;		
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "appleId";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "appName";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "appAlertTitle";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "appAlertDescription";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "appAlertButtonText";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "deviceType";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "showType";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	if(flag){		
		alert(err_msg);
		return;
	}else{
		//submit
		$.ajax({
		   type: "post",
		   url: controller,
		   data: "action="+action+"&id="+$("#id").val()+"&bundleIdentifier="+$("#bundleIdentifier").val()+"&appleId="+$("#appleId").val()+"&appName="+$("#appName").val()
		   					+"&appAlertTitle="+$("#appAlertTitle").val()+"&appAlertDescription="+$("#appAlertDescription").val()+"&appAlertButtonText="+$("#appAlertButtonText").val()
		   					+"&deviceType="+$("#deviceType").val()+"&showType="+$("#showType").val()+"&actionType="+$("#actionType").val()+"&actionInfo1="+$("#actionInfo1").val()
		   					+"&messageTitle="+$("#messageTitle").val()+"&messageBody="+$("#messageBody").val()+"&buttonYesText="+$("#buttonYesText").val()+"&buttonNoText="+$("#buttonNoText").val()
		   					+"&showAgain="+$("#showAgain").val()+"&forcePush="+$("#forcePush").val(),
		   success: function(data){			 
			 var returnData = $.parseJSON(data);
			 if(returnData.status == "true"){
			 	alert("操作成功！");			 	
			 	$("#query").submit();				
			 }else{
				 
				alert("操作失败！" + returnData.errorList);									
			 }
		   }
		});
	}
}

function editEntity(id, alertId, appleId, appName, appAlertTitle, appAlertDescription, appAlertButtonText, deviceType, showType, actionType, actionInfo1, 
		messageTitle, messageBody, buttonYesText, buttonNoText, showAgain, forcePush,
		createDate, modifyDate) {
	$("#action").attr("value", "update");
	$("#id").attr("value", id);
	$("#alertId").html("Alert Id:&nbsp;&nbsp;" + alertId);	
	$("#appleId").attr("value", appleId);
	$("#appName").attr("value", appName);
	$("#appAlertTitle").attr("value", appAlertTitle);
	$("#appAlertDescription").attr("value", appAlertDescription);
	$("#appAlertButtonText").attr("value", appAlertButtonText);	
	$("#deviceType").attr("value", deviceType);
	$("#showType").attr("value", showType);
	$("#actionType").attr("value", actionType);
	$("#actionInfo1").attr("value", actionInfo1);
	$("#messageTitle").attr("value", messageTitle);
	$("#messageBody").attr("value", messageBody);
	$("#buttonYesText").attr("value", buttonYesText);
	$("#buttonNoText").attr("value", buttonNoText);
	$("#showAgain").attr("value", showAgain);
	$("#forcePush").attr("value", forcePush);		
	$("#createDate").html("创建日期:&nbsp;&nbsp;" + createDate);
	$("#modifyDate").html("修改日期:&nbsp;&nbsp;" + modifyDate);
}


function resetAlertId(id, controller) {	
	var flag = true;
	if(id.length == 0 || id.length > 50){
		flag = false;
		alert("没有找到要重置对象的ID。\n");
	}			
	if(flag) {
		$.ajax({
		   type: "post",
		   url: controller,
		   data: "action=resetAlertId&id="+ id,
		   success: function(data){
			 var returnData = $.parseJSON(data);
			 if(returnData.status == "true"){
				alert("重置成功！");
				$("#query").submit();				
			 }else{
				 alert("操作失败！\n该对象不存在或请使用管理员账号重新登陆。");
			 }
		   }
		});
	}	
}


function deleteEntity(id, controller) {
	if (confirm("确认要删除本条信息？")) {
		var flag = true;
		if(id.length == 0 || id.length > 50){
			flag = false;
			alert("没有找到要删除对象的ID。\n");
		}			
		if(flag) {
			$.ajax({
			   type: "post",
			   url: controller,
			   data: "action=delete&id="+ id,
			   success: function(data){				 
				 var returnData = $.parseJSON(data);
				 if(returnData.status == "true"){
					alert("删除成功！");
					$("#query").submit();
				 }else{
					alert("操作失败！\n该对象不存在或请使用管理员账号重新登陆。");
				 }
			   }
			});
		}
		return false;
	}	
}