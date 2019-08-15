package com.${project}.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.validation.Valid;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.${project}.entity.User;
import com.${project}.base.util.SecurityUtils;
import com.${project}.base.page.Page;
import com.${project}.base.page.SearchFilter;
import com.${project}.base.util.SearchUtils;
import com.${project}.entity.${entityName};
import com.${project}.service.${entityName}Service;

@Controller
@RequestMapping("/${entityNameLower}")
public class ${entityName}Controller {
	private static final Logger logger = LoggerFactory.getLogger(${entityName}Controller.class);
	
	@Autowired
	private ${entityName}Service ${entityNameLower}Service;

	/**
	 *
	 * @Description:
	 * @return String
	 * @throws
	 * @author tyf
	 * @date ${datetime}
	 */
	@RequestMapping(value="to${entityName}",method=RequestMethod.GET)
	public String to${entityName}(){
		return "${entityNameLower}";
	}

	/**
	 *
	 * @Description: 获取实体列表
	 * @param request
     * @param response
	 * @return void
	 * @throws
	 * @author tyf
	 * @date ${datetime}
	 */
	@RequestMapping(value = "getPages", method = RequestMethod.POST)
	public void getPages(Page<${entityName}> pages,HttpServletRequest request, HttpServletResponse response){//列表展示
		List<SearchFilter> filterlist = SearchUtils.getParametersStartingWith(request, "search");
		String pageJson = ${entityNameLower}Service.getPages(pages, filterlist);
		try {
			response.getWriter().print(pageJson);

		} catch (IOException e) {

			e.printStackTrace();
		}
	}




	
	@RequestMapping(value="saveOrUpdate",method=RequestMethod.POST)
	public void saveOrUpdate(@Valid @ModelAttribute("${entityNameLower}")${entityName} ${entityNameLower} ,HttpServletRequest request,HttpServletResponse response){//新增、编辑
		int flag = 1;
		String str = "";
		if(${entityNameLower}.getId()==null){
			str = "新增";
			//TODO
		}else{
			str = "修改";
			//TODO
		}
		try {
			${entityNameLower}Service.saveOrUpdate(${entityNameLower});
            logger.info(opretion+"*********", SecurityUtils.getCurUserName(), "成功", "1");
		} catch (Exception e) {
			flag = 0;
            logger.info(opretion+"*********", SecurityUtils.getCurUserName(), "失败", "1");
            e.printStackTrace();
		}
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
    /**
    *
    * @Description: 删除
    * @param  request
    * @param  response
    * @return void
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	@RequestMapping(value = "deleteEntity", method = RequestMethod.POST)
	public void deleteEntity(HttpServletRequest request, HttpServletResponse response){//删除
		int flag = 1;
		String ids = request.getParameter("ids");
		try {
			${entityNameLower}Service.deleteEntity(ids);
            logger.info("执行删除", SecurityUtils.getCurUserName(), "成功", "1");
		} catch (Exception e) {
            logger.info("执行删除", SecurityUtils.getCurUserName(), "失败", "1");
            flag = 0;
			e.printStackTrace();
		}
		try {
			response.getWriter().print(flag);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
    /**
    *
    * @Description: 获取实体详细信息
    * @param  request
    * @param  response
    * @return void
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	@RequestMapping(value = "getEntityById", method = RequestMethod.POST)
	public void getEntityById(HttpServletRequest request, HttpServletResponse response){//编辑用 
		String id = request.getParameter("id");
		String json = "";
		try {
			 json = ${entityNameLower}Service.getEntityDetailById(Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

    /**
    *
    * @Description: 新增或修改时验证是否重复
    * @param  request
    * @param  response
    * @return void
    * @throws
    * @author tyf
    * @date ${datetime}
    */
    @RequestMapping(value="verifyTheRepeat",method=RequestMethod.POST)
    public void verifyTheRepeat(HttpServletRequest request,HttpServletResponse response){
        String name = request.getParameter("name");
        String id = request.getParameter("id");
        boolean isExist = ${entityNameLower}Service.verifyTheRepeat(name, id);
        try {
            response.getWriter().print(isExist);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
}
