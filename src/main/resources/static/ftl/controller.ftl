package com.tyf.mqas.code.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.tyf.mqas.base.datapage.DataPage;
import com.tyf.mqas.code.entity.${entityName};
import com.tyf.mqas.code.service.${entityName}Service;
import com.tyf.mqas.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;


/**

/**
 * @ClassName ${entityName}Controller
 * @Description: TODO
 * @Author tyf
 * @Date ${datetime}
 * @Version V1.0
 **/
@Controller
@RequestMapping("/${entityNameLower}")
public class ${entityName}Controller {

    private final static Logger logger = LoggerFactory.getLogger(${entityName}Controller.class);

    @Autowired
    private ${entityName}Service ${entityNameLower}Service;

    @RequestMapping(value = "${entityNameLower}Manage",method = RequestMethod.GET)
    public String ${entityNameLower}Manage(){
        return "/system/${entityNameLower}";
    }

    /**
     * 分页查询
     * @param request
     * @param response
     */
    @RequestMapping(value = "getTableJson",method = RequestMethod.GET)
    public void getTableJson(HttpServletRequest request, HttpServletResponse response){
        Map<String,String[]> parameterMap = request.getParameterMap();
        DataPage<${entityName}> pages = ${entityNameLower}Service.getDataPage(parameterMap);
        String json = JSONObject.toJSONString(pages);
        try {
            response.getWriter().print(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
    * 保存或者编辑实体
    */
    @RequestMapping(value = "saveOrEditEntity",method = RequestMethod.GET)
    public void saveOrEditEntity(@ModelAttribute("${entityNameLower}") ${entityName} ${entityNameLower}, HttpServletRequest request, HttpServletResponse response){
        int flag = 1;
        String oprate = "新增";
        if(${entityNameLower}.getId()!=null){
            oprate = "编辑";
        }
        try{
            ${entityNameLower}Service.saveEntity(${entityNameLower});
            logger.info(SecurityUtil.getCurUserName()+oprate+"角色成功");
        }catch (Exception e){
            flag = 0;
            logger.error(SecurityUtil.getCurUserName()+oprate+"角色失败");
        }
        try {
            response.getWriter().print(flag);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    /**
    * 获取实体信息
    * @param request
    * @param response
    */
    @RequestMapping(value = "getEntityInfo",method = RequestMethod.GET)
    public void getEntityInfo(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        ${entityName} ${entityNameLower} = ${entityNameLower}Service.get${entityName}ById(Integer.parseInt(id));
        String json = JSONObject.toJSONString(${entityNameLower});
        try {
            response.getWriter().print(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
    * 删除
    * @param request
    * @param response
    */
    @RequestMapping(value = "delete${entityName}",method = RequestMethod.GET)
    public void deleteRole(HttpServletRequest request, HttpServletResponse response){
        int flag = 1;
        String id = request.getParameter("id");
        try{
            ${entityNameLower}Service.delete${entityName}(Integer.parseInt(id));
            logger.info(SecurityUtil.getCurUserName()+"删除角色成功");
        }catch (Exception e){
            flag = 0;
            logger.error(SecurityUtil.getCurUserName()+"删除角色失败");
        }
        try {
            response.getWriter().print(flag);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }





    /**
    * 验证重复
    * @param request
    * @param response
    */
    @RequestMapping(value = "verifyTheRepeat",method = RequestMethod.GET)
    public void verifyTheRepeat(HttpServletRequest request, HttpServletResponse response){
        String authority = request.getParameter("authority");
        String id = request.getParameter("id");
        boolean isExist = ${entityNameLower}Service.verifyTheRepeat(authority, id);
        try {
            response.getWriter().print(isExist);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



 }
