/*$(document).ready(function(){
	
	
	
	
	
	
	
});*/
function createFiles(){
	var tables = '';
	if($('.filter-option').eq(0).html()){
		tables =$('.filter-option').eq(0).html();
	}
	if(tables=='Nothing selected'||tables==''){
		alert('选择数据表！');
		return;
	}
	var project = $('#project').val();
	if(project=='' || project == null){
        alert('请填写项目名称！');
        return;
    }
    var savedir = $('#savedir').val();
    if(savedir=='' || savedir == null){
        alert('请填写保存路径！');
        return;
    }
	var fileTypes = '';
	$('input:checkbox[name="fileType"]:checked').each(function(){
		if(fileTypes==''){
			fileTypes += $(this).val();
		}else{
			fileTypes += ','+$(this).val();
		}
	});
	
	$.ajax({
		url : basepath + 'codemaker/createFiles',
		type : 'post',
		data : {
			'tables':tables,
			'fileTypes':fileTypes,
            'project':project,
            'savedir':savedir
		},
		dataType : 'json',
		success : function(result) {
			if(result == 1){
				alert('生成成功！');
			}else{
                alert('生成失败！');
			}
		},
		error : function () {
            alert('生成失败！');
        }
	});
}

function saveDatabaseSet(){
	
	var databaseType = $('input:radio[name="databaseType"]:checked').val(); 
	if(!databaseType){
		alert('选择数据库类型！');
		return;
	}
	if(databaseType==1){
		alert('暂时只做了mysql！');
		return;
	}
	var databaseIp = $('#database_ip').val();
	if(!databaseIp){
		alert('填写ip地址！');
		return;
	}
	var databaseName = $('#database_name').val();
	if(!databaseName){
		alert('填写数据库名称！');
		return;
	}
	var username = $('#username').val();
	if(!username){
		alert('填写用户名！');
		return;
	}
	var password = $('#password').val();
	if(!password){
		alert('填写密码！');
		return;
	}
	
	$.ajax({
		url : basepath + 'codemaker/codemakeFunction',
		type : 'post',
		data : {
			'databaseType':databaseType,
			'databaseIp':databaseIp,
			'databaseName':databaseName,
			'username':username,
			'password':password
		},
		dataType : 'json',
		success : function(result) {
			var options = '';
			$('#select_div').html(null);
			var select = '<p>选择数据表</p><select id="select_tables" class="select" multiple></select> ';
			$('#select_div').append(select);
			for (var i = 0; i < result.length; i++) {
				var array_element = result[i];
				options += '<option>'+array_element+'</option>';
			}
			$('#select_tables').append(options);
			$('.select').selectpicker();
		}
	});
}

