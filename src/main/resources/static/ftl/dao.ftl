package com.${project}.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.${project}.base.dao.AbstractBaseDao;
import com.${project}.base.page.Page;
import com.${project}.base.page.SearchFilter;
import com.${project}.entity.${entityName};

@Repository
@SuppressWarnings({ "unchecked", "rawtypes" })
public class ${entityName}Dao extends AbstractBaseDao<${entityName}> {


	public Page<${entityName}> getPage(Page<${entityName}> pages, List<SearchFilter> filterList) {
		String sql = "select * from ${tableName}";
		return getPage(pages,sql,filterList);
	}

    /**
    *
    * @Description: 根据名称获取该实体的数量
    * @return Integer
    * @throws
    * @author tyf
    * @date ${datetime}
    */
    public Integer getEntityNumByIdAndName(String name,String id){
    	String sql = "select count(*) from ${tableName} where name = ? ";
    	Object[] args = {name};
    	if(StringUtils.isNotBlank(id)){
    		sql = "select count(*) from ${tableName} where name = ? and id != ?";
    		args = new Object[]{name,id};
    	}
    	return jdbcTemplate.queryForObject(sql,args,Integer.class);
    }


}