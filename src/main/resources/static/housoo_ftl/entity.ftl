package com.${project}.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Table;
import javax.persistence.Id;
<#if importList?exists >
<#list importList as value>
${value}	
</#list>
</#if>

@Entity
@Table(name = "${tableName}")
public class ${entityName} {
<#if propertyMapList?exists >
<#list propertyMapList as value>
    @Column(name = "${value.col}")
    private ${value.colType} ${value.colName};
</#list>
</#if>
<#if methodMapList?exists >
<#list methodMapList as value>
    public ${value.colType} get${value.colNameUp}(){
        return ${value.colName};
    }
    public void set${value.colNameUp} (${value.colType} ${value.colName}){
        this.${value.colName} = ${value.colName};
    }
</#list>
</#if>
}