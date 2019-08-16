var ${entityNameLower}Table;//表格对象
var ${entityNameLower}Validator;//表单验证
var $table = "#${entityNameLower}_table";
$(document).ready(function(){
    initTable();
    validateData();
});
/**
 * 初始化表格
 */
function initTable(){
	${entityNameLower}Table = $($table).DataTable({
        dom: '<"html5buttons"B>lTfgitp',
        "serverSide": true,     // true表示使用后台分页
        "ajax": {
            "url": contextPath+"${entityNameLower}Table/getTableJson",  // 异步传输的后端接口url
            "type": "POST",      // 请求方式
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header, token);
            },
        },
        "columns": [
            { "data": "id",
                "visible": false ,
                "searchable":false,
            },
            { "data": "authority",
                render : CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,
                width: '40%'

            },
            { "data": "name",
                width: '40%'
            },
            { "data": null,
                "searchable":false,
                'orderable' : false ,
                width: '15%',
                'render':function (data, type, row, meta) {
                //data  和 row  是数据
                    var buttons = '';
                    buttons+='<button type="button" onclick="editRole('+data.id+')" class="btn btn-primary btn-xs" >编辑</button>&nbsp;&nbsp;';
                    buttons+='<button type="button" onclick="deleteRole('+data.id+')" class="btn btn-primary btn-xs" >删除</button>&nbsp;&nbsp;';
                    buttons+='<button type="button" onclick="assignmentMenu('+data.id+')" class="btn btn-primary btn-xs" >分配菜单</button>';
                    return buttons;
                }
            },
        ],
        "order": [[ 0, 'desc' ]],
        buttons: [
            { extend: 'copy'},
            {extend: 'csv'},
            {extend: 'excel', title: 'ExampleFile'},
            {extend: 'pdf', title: 'ExampleFile'},

            {extend: 'print',
                customize: function (win){
                    $(win.document.body).addClass('white-bg');
                    $(win.document.body).css('font-size', '10px');

                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            }
        ],
        language:CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
        autoWidth:false,
        processing: false,
    });
    $($table).on( 'error.dt', function ( e, settings, techNote, message ){
        //这里可以接管错误处理，也可以不做任何处理
    }).DataTable();
}
/**
 * 验证数据
 */
function validateData(){
    ${entityNameLower}Validator= $("#${entityNameLower}Form").validate({
        rules: {
            authority: {
                required: true,
                maxlength: 50,
                remote : {//远程地址只能输出"true"或"false"
                    url : contextPath + "${entityNameLower}/verifyTheRepeat",
                    type : "POST",
                    dataType : "json",//如果要在页面输出其它语句此处需要改为json
                    beforeSend : function(xhr) {
                        xhr.setRequestHeader(header, token);
                    },
                    data : {
                        id : function(){
                            return $("#form_id").val();
                        }
                    }
                },
            },
            name: {
                required: true,
                maxlength: 50
            },
        },
        messages : {
            authority : {
                required : "不能为空",
                maxlength : "不超过50个字符",
                remote : "角色名已存在",
            },
            name : {
                required: "不能为空",
                maxlength : "不超过50个字符",
            }
        },
        submitHandler : function(form) {
            save${entityName}();

        }
    });
}
/**
 * 保存
 */
function save${entityName}(){
    //保存
    $.ajax({
        type : "POST",
        data : $("#${entityNameLower}Form").serialize(),
        url : contextPath+"${entityNameLower}/saveOrEditEntity",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(result){
            if(result == 1){
                hideModal('${entityNameLower}Modal');
                clearForm();
                reloadTable();
                showAlert("保存成功",'success');
            }else{
                showAlert("保存失败",'error');
            }
        }
    });
}
/**
 * 编辑
 * @param id
 */
function edit${entityName}(id){
    $.ajax({
        type : "POST",
        data : {id:id},
        dataType:"json",
        url : contextPath+"${entityNameLower}/getEntityInfo",
        beforeSend : function(xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function(result){
            <#if propertyMapList?exists >
                <#list propertyMapList as value>
                    $('#form_${value.colName}').val(result.${value.colName});
                </#list>
            </#if>
            showModal("${entityNameLower}Modal");
        }
    });
}
/**
 * 刷新表格
 */
function reloadTable(){
    roleTable.ajax.reload();
}
/**
 * 删除角色
 * @param id
 */
function delete${entityName}(id){
    swal({
        title: "是否确定删除?",
        text: "你将会删除这条记录!",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Yes, delete it!",
        closeOnConfirm: false
    }, function () {
        $.ajax({
            type : "POST",
            data : {id:id},
            dataType:"json",
            url : contextPath+"${entityNameLower}/delete${entityName}",
            beforeSend : function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function(result){
                if(result == 1){
                    reloadTable();
                    swal("删除成功!", "", "success");
                }else{
                    swal("删除失败!", "", "error");
                }
            }
        });
    });
}

/**
 * 清空表单
 */
function clearForm(){
    $('#${entityNameLower}Form')[0].reset();
    $('#${entityNameLower}Form').validate().resetForm();
}


/*常量*/
var CONSTANT = {
    DATA_TABLES : {
        DEFAULT_OPTION : { //DataTables初始化选项
            language: {
                "sProcessing":   "处理中...",
                "sLengthMenu":   "每页 _MENU_ 项",
                "sZeroRecords":  "没有匹配结果",
                "sInfo":         "当前显示第 _START_ 至 _END_ 项，查询到 _TOTAL_ 项，共_MAX_项。",//共 _TOTAL_ 项  搜索到_TOTAL_/_MAX_条
                "sInfoEmpty":    "当前显示第 0 至 0 项，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix":  "",
                "sSearch":       "搜索:",
                "sUrl":          "",
                "sEmptyTable":     "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands":  ",",
                "oPaginate": {
                    "sFirst":    "首页",
                    "sPrevious": "上页",
                    "sNext":     "下页",
                    "sLast":     "末页",
                    "sJump":     "跳转"
                },
                "oAria": {
                    "sSortAscending":  ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            },
            autoWidth: false,	//禁用自动调整列宽
            stripeClasses: ["odd", "even"],//为奇偶行加上样式，兼容不支持CSS伪类的场合
            order: [],			//取消默认排序查询,否则复选框一列会出现小箭头
            processing: false,	//隐藏加载提示,自行处理
            serverSide: true,	//启用服务器端分页
            searching: false	//禁用原生搜索
        },
        COLUMN: {
            CHECKBOX: {	//复选框单元格
                className: "td-checkbox",
                orderable: false,
                width: "30px",
                data: null,
                render: function (data, type, row, meta) {
                    return '<input type="checkbox" class="iCheck">';
                }
            }
        },
        RENDER: {	//常用render可以抽取出来，如日期时间、头像等
            ELLIPSIS: function (data, type, row, meta) {
                data = data||"";
                return '<span title="' + data + '">' + data + '</span>';
            }
        }
    }
};