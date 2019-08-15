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
			/*xxxxx:{//判重需要时
				required : true,
				remote : {
					url : basePath+"${entityNameLower}/checkxxxxx", // 后台处理程序
					type : "post", // 数据发送方式
					dataType : "json", // 接受数据格式
					data : {
						id : function(){return $('#form-id').val();}
					}
				},
				maxlength:50
			},*/
			<#if propertyMapList?exists >
			<#list propertyMapList as value>
			${value.colName}:{
				required : true,
				maxlength : 50,
			},
			</#list>
			</#if>
		},
		messages : {
			/*xxxxx:{
				required : '请输入编号',
				remote : 'XX已存在',
				maxlength:	"不能超过50个字符"
			},*/
			<#if propertyMapList?exists >
			<#list propertyMapList as value>
			${value.colName}:{
				required : '请输入${value.comment}',
				maxlength : '不能超过...个字符',
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
			$.ajax({
			    url : basePath+'${entityNameLower}/saveOrUpdate',
			    type:'post',
			    data : $('#${entityNameLower}_form').serialize(),//需要传递的数据 json格式
			    dataType : 'json',
			    success : function(result) {
			           if(result==0){
			       		   showAlert('保存成功！');
			       		   closeDialog('${entityNameLower}_modal');
			       		   reload();
			       		   
			           }else{
			       		   showAlert('保存失败！');
			           }
			    },
			    error : function(result) {
			    		showAlert('保存失败！');
			    }
			});
		},
		invalidHandler : function(form) {
			
		}
	});
	//******************************************************(⊙_⊙;)表单验证*******end***************************************************************************************************************
	
	//******************************************************(→_→)条件搜索******start***************************************************************************************************************
	$("#search-form").bind("submit", function(e){  //取消搜索表单的回车提交
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
	
	
	
	//******************************************************列表展示*******end*********************************************************************************************************************
	$(window).on('resize.jqGrid', function() {
        $(grid_selector).jqGrid('setGridWidth', $(".list_jqgrid").width()-2);
    });

	jQuery(grid_selector).jqGrid(
			{
				datatype : "json",
				mtype:"POST",
				url : basePath+'${entityNameLower}/getPages',
			    height : 'auto',
				colNames : [ <#if propertyMapList?exists ><#list propertyMapList as value>'${value.col}',</#list></#if>],
				/**
				*hidden : true,
				*hidedlg : true
				*/
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
				rowList : [ 10, 20, 30 ],
				pager : pager_selector,
				altRows : true,
				multiselect : true,
				multiboxonly : true,
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
		"overflow-x" : "hidden"
	});
	$(window).triggerHandler('resize.jqGrid');// trigger window resize to make
	
	function updatePagerIcons(table) {
		var replacement = {
			'ui-icon-seek-first' : 'icon iconfont icon-first',
			'ui-icon-seek-prev' : 'icon iconfont icon-pre',
			'ui-icon-seek-next' : 'icon iconfont icon-next',
			'ui-icon-seek-end' : 'icon iconfont icon-last'
		};
	$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
				.each(
						function() {
							var icon = $(this);
							var $class = $.trim(icon.attr('class').replace(
									'ui-icon', ''));

							if ($class in replacement)
								icon.attr('class', 'ui-icon '
										+ replacement[$class]);
						})
	}

	$(document).on('ajaxloadstart', function(e) {
		$(grid_selector).jqGrid('GridUnload');
		$('.ui-jqdialog').remove();
	});
	//配置表格列
    var lefts = $(".list_jqgrid").width()-199;
    var options = {
        caption: "<span>显示&nbsp;/&nbsp;隐藏列</span><input type='checkbox' style='vertical-align: middle;margin:0 10px 0 20px;' id='allCheckbox'>全选",
        bSubmit: "确&nbsp;定",
        bCancel: "",
        top: -5,
        left: lefts,
        width: 200,
        drag: false,
        colnameview: false,//设置为false，将不会显示colModel配置的name值（只显示列标题）
        shrinkToFit: false,//设置为true，grid自动调整列宽以便显示所有列
        recreateForm: true,//设置为true，对话框每次激活时表单都会从colModel（如果被修改过）中重新创建
        /*updateAfterCheck: true,*///设置为ture，当点击对话框中的checkbox时立即显示或者隐藏对应的列。设置为true后会隐藏提交按钮
        afterShowForm:function(formid){
            $(".ui-widget-overlay").css('display','none');
            $("#eData").css('display','none');
        },
        afterSubmitForm: function(formid) {
            $(window).triggerHandler('resize.jqGrid');
            var ww = $("#myTab").width();
            var ws = $("#gview_myTab").width();
            if(ww<ws){
                $("#gview_myTab .ui-jqgrid-htable").width(ws-20);
                $("#myTab").width(ws-20);
            }
        }
    };
    jQuery("#listsetCol").unbind("click");
    jQuery("#listsetCol").click(function() {
        jQuery(grid_selector).setColumns(options);
        $("#allCheckbox").attr("checked",true);
        $("#allCheckbox").unbind("click");
        $("#allCheckbox").click(function() {
            if($(this).is(":checked")){
                $("#ColTbl_myTab table tr td .cbox").prop("checked",true);
            }else{
                $("#ColTbl_myTab table tr td .cbox").prop("checked",false);
            }
        });
        return false;
    });
    //******************************************************列表展示*******end****************************************************************************************************************
});

//刷新列表
function reload(){
	$(grid_selector).jqGrid('setGridParam',{ 
    	datetype: "JSON",
    	mtype:"POST",
    	url : basePath+"${entityNameLower}/getPages", // 这是数据的请求地址
		postData:{
			
		},
        page:1,
        pager : pager_selector,
		altRows : true,
		multiselect : true,
		multiboxonly : true,
    }).trigger("reloadGrid");
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
			$.ajax({
				url:basePath+'${entityNameLower}/deleteEntity',
				type:'post',
				data:{'ids':sels},
				dataType:'json',
				success:function(result){
					if(result==0){
						showAlert('删除成功！');
						reload();
					}else{
						showAlert('删除失败！');
					}
				},
				error:function(){
					showAlert('删除失败！');
				}
			});
		});
	}
}
//******************************************************(~>__<~)删除*******end****************************************************************************************************************





//******************************************************(→_→)新增编辑*******start**************************************************************************************************************
//新增
function add${entityName}(){//新增
	showModal("${entityNameLower}_modal");
	$("#from-id").val("");
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
			$.ajax({
				url:basePath+'${entityNameLower}/getEntityById',
				type:'post',
				data:{'id':id},
				dataType:'json',
				success:function(result){
					<#if propertyMapList?exists >
					<#list propertyMapList as value>
					    
					    $('#form-${value.colName}').val(result.${value.colName});
					    
					</#list>
					</#if>
					showModal("${entityNameLower}_modal");
				    $('.modal-title').html("编辑XXX");
				},
				error:function(){
					showAlert('获取信息失败！');
				}
			});
		}
	}

}
//******************************************************(→_→)新增编辑*******end****************************************************************************************************************


/**
 * 关闭窗口
 * @param modalId
 */
function closeDialog(modalId) {
	$('#'+modalId).modal('hide');
	$('#${entityNameLower}-form').validate().resetForm();
	$('#${entityNameLower}-form .form-group').removeClass('has-error');
	$('#from-id').val('');
}


