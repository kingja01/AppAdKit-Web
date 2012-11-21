function submitFunction(controller){
	var flag = false;
	var err_msg = "提交失败！请您检查表单内容。";
	var tempVar;
	var action = $("#action").val();		
	
	tempVar = "name";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
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
		
	if(flag){		
		alert(err_msg);
		return;
	}else{
		//submit
		$.ajax({
		   type: "post",
		   url: controller,
		   data: "action="+action+"&id="+$("#id").val()+"&name="+$("#name").val()+"&bundleIdentifier="+$("#bundleIdentifier").val()+"&appleId="+$("#appleId").val(),
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

function clearForm() {	
	$("#action").attr("value", "insert");
	$("#id").attr("value", "");
	$("#name").attr("value", "");
	$("#bundleIdentifier").attr("value", "");
	$("#appleId").attr("value", "");	
	$("#createDate").html("创建日期:&nbsp;");
}

function editEntity(id, name, bundleIdentifier, appleId, createDate) {
	$("#action").attr("value", "update");
	$("#id").attr("value", id);
	$("#name").attr("value", name);
	$("#bundleIdentifier").attr("value", bundleIdentifier);
	$("#appleId").attr("value", appleId);
	$("#createDate").html("创建日期:&nbsp;" + createDate);
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
					$("#" + id).remove();
					clearForm();
				 }else{
					 alert("操作失败！\n该对象不存在或请使用管理员账号重新登陆。");
				 }
			   }
			});
		}
		return false;
	}	
}