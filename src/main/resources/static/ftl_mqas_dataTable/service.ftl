package com.tyf.mqas.code.service;

import com.alibaba.fastjson.JSONArray;
import com.tyf.mqas.base.datapage.DataPage;
import com.tyf.mqas.base.datapage.PageGetter;
import com.tyf.mqas.code.dao.${entityName}Repository;
import com.tyf.mqas.code.entity.${entityName};
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

@Service
@Transactional
public class ${entityName}Service {

    @Autowired
    private ${entityName}Repository ${entityNameLower}Repository;

    /**
     * 分页查询
     * @param parameterMap
     * @return
     */
    public DataPage<${entityName}> getDataPage(Map<String,String[]> parameterMap){
        return super.getPages(parameterMap);
    }

    /**
     * 保存角色
     * @param role
     * @return
     */
    public ${entityName} saveEntity(${entityName} ${entityNameLower}){
        return ${entityNameLower}Repository.save(${entityNameLower});
    }

    /**
     * 删除实体
     * @param id
     */
    public void delete${entityName}(Integer id){
        ${entityNameLower}Repository.deleteById(id);
    }

    /**
     * 根据id获取实体
     * @param id
     * @return
     */
    public ${entityName} get${entityName}ById(Integer id){
        return ${entityNameLower}Repository.getOne(id);
    }

    /**
     * 判断重复
     * @param authority
     * @param id
     * @return
     */
    public boolean verifyTheRepeat(String authority,String id){
        Integer num = null;
        if(StringUtils.isNotBlank(id)){
            num = ${entityNameLower}Repository.get${entityName}NumByIdAndAuthority(Integer.parseInt(id), authority);
        }else{
            num = ${entityNameLower}Repository.get${entityName}NumByAuthority( authority);
        }
        return num > 0?false:true;
    }

}