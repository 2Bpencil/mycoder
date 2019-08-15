<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity5">

<head th:replace="layout/default :: head('${entityName} Page','')"></head>

<body class="">

<div id="wrapper">
    <nav th:replace="layout/default :: nav"></nav>
    <div id="page-wrapper" class="gray-bg" >
        <!--铃铛 邮件 退出-->
        <div class="row border-bottom" >
            <nav class="navbar navbar-static-top  " role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li>
                        <span class="m-r-sm text-muted welcome-message">Welcome to INSPINIA+ Admin Theme.</span>
                    </li>
                    <li>
                        <a href="javascript:;" th:onclick="'javascript:userLogOut()'">
                            <i class="fa fa-sign-out"></i> Log out
                        </a>

                    </li>
                </ul>

            </nav>
        </div >
        <!--面包屑-->
        <div class="row wrapper border-bottom white-bg page-heading" >
            <div class="col-sm-4">
                <h2>XX管理</h2>
                <ol class="breadcrumb">
                    <li>
                        <a href="#">XX管理</a>
                    </li>
                    <li class="active">
                        <strong>XX管理</strong>
                    </li>
                </ol>
            </div>
            <div class="col-sm-8">
                <div class="title-action">
                    <!--操作按钮-->
                    <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#roleModal">新增XX</a>
                    <a href="#" class="btn btn-primary" onclick="reloadTable()">刷新</a>
                </div>
            </div>
        </div>
        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>XX列表</h5>
                            <div class="ibox-tools">
                            </div>
                        </div>
                        <div class="ibox-content">

                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover dataTables-example"  id="${entityNameLower}_table">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>角色代码</th>
                                        <th>角色名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tfoot>
                                    <th>ID</th>
                                    <th>角色代码</th>
                                    <th>角色名称</th>
                                    <th>操作</th>
                                    </tfoot>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div th:replace="layout/default :: foot"></div>
    </div>
</div>
<!--表单-->
<div class="modal inmodal" id="${entityNameLower}Modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"  onclick="clearForm();"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <i class="fa fa-users modal-icon"></i>
                <h4 class="modal-title">角色表单</h4>
            </div>
            <div class="modal-body">
                <form role="form" id="${entityNameLower}Form">
                    <input type="hidden" id="form_id" name="id">

					<#if propertyMapList?exists >
						<#list propertyMapList as value>
						<div class="form-group"><label>${value.comment}</label> <input type="text" id="form_${value.colName}"  placeholder="填写${value.comment}" class="form-control" name="${value.colName}"></div>
						</#list>
					</#if>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal" onclick="clearForm();">关闭</button>
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>



<div th:replace="layout/default :: js('/js/${entityNameLower}/${entityNameLower}.js')"></div>

</body>

</html>
