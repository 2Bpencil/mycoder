var grid_selector = "#myTab";
var pager_selector = "#pager";

jQuery(function($) {
	
	$("#search-form").bind("submit", function(e){  //取消搜索表单的回车提交
	    return false;  
	});
	
	$(window).on('resize.jqGrid', function() {
		var mainHeight = $(window).height();
		var tableHeight;
		/* 条件搜索 */
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
	$(window).on('resize.jqGrid', function() {
        $(grid_selector).jqGrid('setGridWidth', $(".list_jqgrid").width()-2);
    });

	jQuery(grid_selector).jqGrid(
			{
				datatype : "json",
				mtype:"POST",
				url : basePath+'${entityNameLower}/getPages',
			    height : 'auto',
				colNames : [<#if propertyMapList?exists ><#list propertyMapList as value>'${value.comment}',</#list></#if>],
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
    
    
    
    $("#btn_search").click(function(){ //条件查询
    jQuery(grid_selector).jqGrid('setGridParam', {
		datetype : "JSON",
		mtype : "POST",
		url : basePath + '${entityNameLower}/getPages',
		postData : {
			'search#EQ#idcard' : $("#idcard").val(),
			'search#LIKE#compellation' : $("#name").val(),
		}, // 发送数据
		page : 1,
		pager : pager_selector,
		altRows : true,
		multiselect : true,
		multiboxonly : true,
	}).trigger("reloadGrid");
    });
});

