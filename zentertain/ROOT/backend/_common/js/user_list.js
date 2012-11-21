function submitFunction(controller){
	var flag = false;
	var err_msg = "提交失败！请您检查表单内容。";
	var tempVar;
	var action = $("#action").val();		
	
	tempVar = "userName";
	if($("#"+tempVar).val() == ""){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "password";
	if($("#"+tempVar).val() == "" && action == "insert"){
		flag = true;
		$("#"+tempVar).parent().parent().addClass("error");
	}else{
		$("#"+tempVar).parent().parent().removeClass("error");
	}
	
	tempVar = "name";
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
		   data: "action="+action+"&type=0&id="+$("#id").val()+"&userName="+$("#userName").val()+"&password="+$("#password").val()+"&name="+$("#name").val(),
		   success: function(data){			 
			 var returnData = $.parseJSON(data);
			 if(returnData.status == "true"){
			 	alert("操作成功！");
			 	$("#nameKeyWord").attr("value","");
			 	$("#query").submit();
			 }else{
				alert("操作失败！" + returnData.errorList);									
			 }
		   }
		});
	}
}

function editEntity(id, userName, name, type, createDate) {
	$("#action").attr("value", "update");
	$("#id").attr("value", id);
	$("#userName").attr("value", userName);
	$("#name").attr("value", name);
	if(type == "1") {
		$("#type").html("用户类型:&nbsp;管理员");
	} else {
		$("#type").html("用户类型:&nbsp;普通用户");
	}
	
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
					$("#nameKeyWord").attr("value","");
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

function clearForm() {	
	$("#action").attr("value", "insert");
	$("#id").attr("value", "");
	$("#userName").attr("value", "");
	$("#password").attr("value", "");
	$("#name").attr("value", "");
	$("#type").html("用户类型:&nbsp;");
	$("#createDate").html("创建日期:&nbsp;");
}