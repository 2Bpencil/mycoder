package com.${project}.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.sf.json.JSONObject;
import com.${project}.base.page.Page;
import com.${project}.base.page.SearchFilter;
import com.${project}.dao.${entityName}Dao;
import com.${project}.entity.${entityName};

@Service
@Transactional
public class ${entityName}Service {

	@Autowired
	private ${entityName}Dao ${entityNameLower}Dao;

    /**
    *
    * @Description: 获取实体列表
    * @param  pages
    * @param  filterlist
    * @return Page<${entityName}>
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	public String getPages(Page<${entityName}> pages, List<SearchFilter> filterList){
		pages = ${entityNameLower}Dao.getPage(pages, filterList);
		return pages.getPageJson();
	}

    /**
    *
    * @Description: 保存实体
    * @param  ${entityNameLower}
    * @return ${entityName}
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	public ${entityName} saveOrUpdate(${entityName} ${entityNameLower}){
		return ${entityNameLower}Dao.save(${entityNameLower});
	}

    /**
    *
    * @Description: 删除实体
    * @param  ids
    * @return void
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	public void deleteEntity(String ids){
		String[] id = ids.split(",");
		${entityNameLower}Dao.delete(id);
	}
    /**
    *
    * @Description: 根据id获取实体
    * @param  id
    * @return ${entityName}
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	public ${entityName} getEntityById(Integer id){
		return ${entityNameLower}Dao.getEntityById(id);
	}
    /**
    *
    * @Description: 根据id获取实体JSON
    * @param  id
    * @return String
    * @throws
    * @author tyf
    * @date ${datetime}
    */
	public String getEntityDetailById(Integer id){//获取实体详细信息
		${entityName} ${entityNameLower} = ${entityNameLower}Dao.getEntityById(id);
		String json =JSONObject.fromObject(${entityNameLower}).toString(); 
		return json;
	}

    /**
    *
    * @Description: 验证实体名称是否重复
    * @param  name
    * @param  id
    * @return boolean
    * @throws
    * @author tyf
    * @date ${datetime}
    */
    public boolean verifyTheRepeat(String name,String id){
    	Integer num = ${entityNameLower}Dao.getEntityNumByIdAndName(name, id);
    	return num > 0?false:true;
    }
	
}