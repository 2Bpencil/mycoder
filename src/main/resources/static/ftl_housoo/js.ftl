var grid_selector = "#myTab";
var pager_selector = "#pager";


jQuery(function($) {
	
	//******************************************************(⊙_⊙;)表单验证******start**************************************************************************************************************
	/*jQuery.validator.addMethod("phoneCheck", function(value, element) {
		return this.optional(element) || /^((1[3578]\d{1}\d{4}\d{4}(x\d{1,6})?)|(\d{2,5}-\d{7,8})|(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,8})$/.test(value);
	}, "请输入有效的号码.");*/
	$('#${entityNameLower}_form').validate({
		errorElement : 'div',
		errorClass : 'help-block',
		focusInvalid : false,
		rules : {
			<#if propertyMapList?exists >
			<#list propertyMapList as value>
			${value.colName}:{
				required : true,
				digits: true,
			},
			</#list>
			</#if>
		},
		messages : {
			<#if propertyMapList?exists >
			<#list propertyMapList as value>
			${value.colName}:{
				required : '请输入${value.comment}',
				digits : "请输入整数!",
			},
			</#list>
			</#if>
		},
		highlight : function(e) {
			$(e).closest('.form-group').removeClass('has-info')
					.addClass('has-error');
		},

		success : function(e) {
			$(e).closest('.form-group')
					.removeClass('has-error');// .addClass('has-info');
			$(e).remove();
		},

		errorPlacement : function(error, element) {
			if (element.is('input[type=checkbox]')
					|| element.is('input[type=radio]')) {
				var controls = element
						.closest('div[class*="col-"]');
				if (controls.find(':checkbox,:radio').length > 1)
					controls.append(error);
				else
					error.insertAfter(element.nextAll(
							'.lbl:eq(0)').eq(0));
			}
			/*
			 * else if(element.is('.select2')) {
			 * error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)')); }
			 */
			else if (element.is('.chosen-select')) {
				error
						.insertAfter(element
								.siblings('[class*="chosen-container"]:eq(0)'));
			} else if (element.is('.date-picker')) {
				error.insertAfter(element.parent().parent());
	       } else
				error.insertAfter(element.parent());
		},
		submitHandler : function(form) {

            $.post(basePath+"${entityNameLower}/saveOrUpdate",$('#${entityNameLower}Form').serialize(),function(result){
                if(result == 1){
						showAlert('保存成功！');
						closeAndClearModal('${entityNameLower}_modal');
						reload();
					}else{
						showAlert('保存失败！');
					}
            },"json")


		},
		invalidHandler : function(form) {
			
		}
	});
	//******************************************************(⊙_⊙;)表单验证*******end***************************************************************************************************************
	
	//******************************************************(→_→)条件搜索******start***************************************************************************************************************
	$("#search_form").bind("submit", function(e){  //取消搜索表单的回车提交
	    return false;  
	});
    $(window).on('resize.jqGrid', function() {
		var mainHeight = $(window).height();
		var tableHeight;
		var flag = true;
		$("#searchIcon").click(function(){
			if(flag){
				$("#searchDiv").show();
				flag = false;
			}else{
				$("#searchDiv").hide();
				flag = true;
			}
		});
	})
    $("#btn_search").click(function(){ 
    jQuery(grid_selector).jqGrid('setGridParam', {
		datetype : "JSON",
		mtype : "POST",
		url : basePath + '${entityNameLower}/getPages',
		postData : {
			'search#EQ#xxxxx' : $("#xxxx").val(),
			'search#LIKE#xxxxx' : $("#xxxx").val(),
		}, // 发送数据
		page : 1,
		pager : pager_selector,
		altRows : true,
		multiselect : true,
		multiboxonly : true,
	}).trigger("reloadGrid");
    });
	//******************************************************(→_→)条件搜索*******end****************************************************************************************************************
	
	
	
	//******************************************************列表展示*******start*********************************************************************************************************************
	$(window).on('resize.jqGrid', function() {
        //$(grid_selector).jqGrid('setGridWidth', $(".list_jqgrid").width()-2);
    });
	initPage();
    //******************************************************列表展示*******end****************************************************************************************************************
});

/**
 * 初始化列表
 */
function initPage(){
	jQuery(grid_selector).jqGrid(
			{
				datatype : "json",
				mtype : "POST",
				url : basePath + '${entityNameLower}/getPages',
				height : '90%',
				colNames : [<#if propertyMapList?exists ><#list propertyMapList as value>'${value.comment}',</#list></#if>],
				colModel : [
							<#if propertyMapList?exists >
								<#list propertyMapList as value>
											 {
												name : '${value.col}',
												index : '${value.col}',
											},
								</#list>
							</#if>
							],
					shrinkToFit : true,
		            viewrecords : true,// 是否显示总记录数
		            rowNum : 10,
		            rowList : [ 5, 10, 15 ],
		            pager : pager_selector,
		            altRows : true,
		            multiselect : true,
		            multiboxonly : false,
		            loadComplete : function() {
		                var table = this;
		                setTimeout(function() {
		                    updatePagerIcons(table);
		                }, 0);
		            },
		            sortable:true,
		            sortname:'id',
		            sortorder:'desc',
		            pagerpos:'right',
		            recordpos:'left',
		            autowidth:true
			});
		jQuery(grid_selector).closest(".ui-jqgrid-bdiv").css({
	        "overflow-x" : "hidden",
	        "overflow-y" : "auto"
	    });
	    $(window).triggerHandler('resize.jqGrid');
	    function updatePagerIcons(table)
	    {
	        var replacement = {
	            'ui-icon-seek-first' : 'iconfont icon-first',
	            'ui-icon-seek-prev' : ' iconfont icon-pre',
	            'ui-icon-seek-next' : 'iconfont icon-next',
	            'ui-icon-seek-end' : ' iconfont icon-last'
	        };
	        $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function() {
	            var icon = $(this);
	            var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
	            if ($class in replacement)
	                icon.attr('class', 'ui-icon ' + replacement[$class]);
	        });
	    }
}



/**
 * 刷新
 */
function reload(){
	$(grid_selector).jqGrid('setGridParam', {
		url : basePath+'${entityNameLower}/getPages'
	}).trigger('reloadGrid');
}
//******************************************************(~>__<~)删除******start***************************************************************************************************************
function delete${entityName}(){
	var sels = "";
	var selr = jQuery(grid_selector).jqGrid('getGridParam', 'selarrrow');
	if (selr.length) {
		for (var i = 0; i < selr.length; i++) {
			var id = jQuery(grid_selector).jqGrid('getCell', selr[i], 'id');
			if (i == selr.length - 1) {
				sels += id;
			} else {
				sels += id + ",";
			}
		}
	}
	if (sels == "") {
		showAlert('请选择要删除的项！');
	}else{
		showConfirm('您是否确认删除所选项？', function() {
			$.post(basePath+'${entityNameLower}/deleteEntity',{'ids':sels},function(result){
				if(result==1){
                    showAlert('删除成功！');
                    reload();
                }else{
                    showAlert('删除失败！');
                }
			},"json")
			.success(function() { })
			.error(function() { showAlert('删除失败！'); })
			.complete(function() { });
		});
	}
}
//******************************************************(~>__<~)删除*******end****************************************************************************************************************





//******************************************************(→_→)新增编辑*******start**************************************************************************************************************
//新增
function add${entityName}(){//新增
	showModal("${entityNameLower}_modal");
	$("#from_id").val("");
    $('.modal-title').html("新建XXX");
}
//编辑
function edit${entityName}(){
	var selr = jQuery(grid_selector).jqGrid('getGridParam', 'selarrrow');
	if(selr.length>1){
		showAlert('选择编辑的项只能是一个！');
	}else if (selr.length<1) {
		showAlert('请选择要编辑的项！');
	}else{
		if (selr.length) {
			id = jQuery(grid_selector).jqGrid('getCell', selr[0], 'id');

            $.post(basePath+'${entityNameLower}/getEntityById',{'ids':id},function(result){
                <#if propertyMapList?exists >
                    <#list propertyMapList as value>
                        $('#form_${value.colName}').val(result.${value.colName});
                    </#list>
                </#if>
                showModal("${entityNameLower}Modal");
                $('.modal-title').html("编辑XXX");
			},"json")
			.success(function() { })
			.error(function() { showAlert('获取信息失败！'); })
			.complete(function() { });
		}
	}

}
//******************************************************(→_→)新增编辑*******end****************************************************************************************************************


/**
 * 关闭窗口
 * @param modalId
 */
function closeAndClearModal(modalId) {
    closeModal("${entityNameLower}_modal");
	$('#${entityNameLower}_form').validate().resetForm();
	$('#${entityNameLower}_form .form-group').removeClass('has-error');
	$('#from_id').val(null);
}


