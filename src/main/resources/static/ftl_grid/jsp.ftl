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
</body>
</html>
