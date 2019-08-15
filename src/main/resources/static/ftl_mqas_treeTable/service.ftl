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
     * 获取所有菜单
     * @return
     */
    public String getAll${entityName}s(){
        List<${entityName}> list = ${entityNameLower}Repository.findAllBySort();
    List<TreeTable> treeTables = new ArrayList<TreeTable>();
        list.forEach(${entityNameLower} -> {
        TreeTable treeTable = new TreeTable();
        treeTable.setId(${entityNameLower}.getId()+"");
        treeTable.setpId(${entityNameLower}.getPid()==0?"":${entityNameLower}.getPid().toString());
        treeTable.setName(${entityNameLower}.getName());
        String[] td = {${entityNameLower}.getCode(),${entityNameLower}.getUrl(),${entityNameLower}.getType()==0?"父级菜单":"叶子菜单",${entityNameLower}.getIcon()==null?"":${entityNameLower}.getIcon(),${entityNameLower}.getSort()==null?"":${entityNameLower}.getSort().toString()};
        treeTable.setTd(td);
        treeTables.add(treeTable);
        });
        return JSONArray.toJSONString(treeTables);
        }

    /**
     * 保存
     * @param ${entityNameLower}
     * @return
     */
    public ${entityName} saveEntity(${entityName} ${entityNameLower}){
        return ${entityNameLower}Repository.save(${entityNameLower});
    }

    /**
    * 删除菜单
    * @param ids
    */
    public void delete${entityName}(String ids){
        Stream.of(ids.split(",")).forEach(id->{
            ${entityNameLower}Repository.deleteById(Integer.parseInt(id));
        });
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

    /**
    * 判断菜单是否被使用
    * @param ids
    * @return
    */
    public Boolean check${entityName}Used(String ids){
        //for (String id : ids.split(",")) {
        //    Integer num = ${entityNameLower}Repository.getRsRoleMenuNumByMenuId(Integer.parseInt(id));
        //    if(num > 0){
        //        return false;
        //    }
        //}
        return true;
    }

}