package com.tyf.mqas.code.dao;

import com.tyf.mqas.base.repository.ExpandJpaRepository;
import com.tyf.mqas.code.entity.${entityName};
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import javax.transaction.Transactional;
import java.util.List;

@Repository
@SuppressWarnings({ "unchecked", "rawtypes" })
public interface ${entityName}Repository extends ExpandJpaRepository<${entityName},Integer>{

    @Query(value = "select count(*) from ${tableName} where authority = ?2 and id != ?1", nativeQuery = true)
    Integer get${entityName}NumByIdAndAuthority(Integer id,String authority);

    @Query(value = "select count(*) from ${tableName} where authority = ?1", nativeQuery = true)
    Integer get${entityName}NumByAuthority(String authority);


}