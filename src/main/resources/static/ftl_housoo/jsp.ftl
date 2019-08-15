<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="security" uri="/WEB-INF/tlds/security"%>
<c:set var="ctx" value="${contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<link rel="stylesheet" href="${ctx}/assets/css/modal.css">
<script src="${ctx}/assets/plugins/jQuery/jquery.validate.min.js"></script>
<script src="${ctx}/assets/js/${entityNameLower}.js"></script>
</head>
<body>
	
    <div class="main">
        <div class="col-xs-12">
            <div class="mainTop">
                <div class="tip"></div>
                数据上报-XXXXXXXXXXXXXXXXXXXXXX
            </div>
        </div>
        <div class="col-xs-12">
            <div class="mainCenter">
                <div class="ConWhite">
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="conTop fl">列表展示</div>
                            <ul class="user_menu fr">
                            	<li class="fl"  onclick="add${entityName}()" ><i class="icon iconfont icon-font07" ></i>&nbsp;新增</li>
	                            <li class="fl" onclick="edit${entityName}()"><i class="icon iconfont icon-bianji"></i>&nbsp;编辑</li>
	                            <li class="fl" onclick="delete${entityName}()"><i class="icon iconfont icon-shanchu"></i>&nbsp;删除</li>
                                <li class="fl">
									<div class="no-border">
										<div id="searchIcon">
											<i class="icon iconfont icon-sousuo"></i>条件搜索
										</div>
										<div class="searchBg" id="searchDiv" tabIndex="-1">
											<div class="col-sm-12">
												<form class="form-horizontal" id="" method="post">
													<div class="form-group">
														<label class="col-sm-4 control-label no-padding-right" for="form-field-1" style="padding-right: 0;padding-top:0">XXXX：</label>
															<div class="col-sm-8 form-search">
																<input type="text" id="XXXX"  class="col-xs-12 col-sm-12 searInput form-control">
															</div>
													</div>
													<div class="form-group">
														<label class="col-sm-4 control-label no-padding-right" for="form-field-1" style="padding-right: 0;padding-top:0">XXXX：</label>
															<div class="col-sm-8 form-search">
																<input type="text" id="XXXX"  class="col-xs-12 col-sm-12 searInput form-control">
															</div>
													</div>
													<div class="modal-footer tex" style="margin-top:0">
														<button class="btn btn-primary" type="button" id="btn_search">搜  索</button>
														<button class="btn btn-default" type="reset" id="btn_s_reset">清空</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</li>
								<li class="fl" id="listsetCol">
                                	<i class="icon iconfont icon-yuzhiguanli"></i>配置表格列
                            	</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="row conHeight">
                            <div class="list_jqgrid" style="height:100%;overflow:hidden">
                                <table id="myTab" class="scroll" cellpadding="0" cellspacing="0"></table>
                                <div id="pager" class="scroll"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="${entityNameLower}_modal" tabindex="-1" role="dialog"
		data-backdrop="static" aria-hidden="true" style="dis play:block;opacity:1">
		<form class="form-horizontal" id="${entityNameLower}_form" method="post"
			action="">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="reset" class="close" onclick="closeDialog('${entityNameLower}_modal')"
							aria-hidden="true">×</button>
						<span class="modalHeaderTip pull-left"></span>
		        		<span class="modal-title blue pull-left">新增XXXX</span>
					</div>
					<div class="modal-body">
						<div class="height300">
							<div id="edit-basic" class="tab-pane in active">
							  <div class="row">
								<div class="col-sm-12">
									<span for="" class="pull-left modalBodyTip">常规</span>
									<div class="col-sm-10">
										<span class="space"></span>
									</div>
								</div>
							  </div>
								<div class="row">
									<#if propertyMapList?exists >
									<#list propertyMapList as value>
									    
									    <div class="space-4"></div>
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right"
												for="form-field-username">${value.comment}：</label>
											<div class="col-sm-6">
												<input type="text" id="form-${value.colName}" name="${value.colName}" class="col-sm-12" /> 
											</div>
										</div>
									</#list>
									</#if>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="reset" class="btn btn-default" data-dismiss="modal"  onclick="closeDialog('${entityNameLower}_modal')">取消</button>
		        		<button type="submit" class="btn btn-primary" id="">提交</button>
					</div>
				</div>
			</div>
		</form>
	</div>
        
</body>
</html>
