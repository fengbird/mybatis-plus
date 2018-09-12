<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

<#if enableCache>
    <!-- 开启二级缓存 -->
    <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

</#if>
<#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
<#list table.fields as field>
<#if field.keyFlag><#--生成主键排在第一位-->
        <id column="${field.name?upper_case}" property="${field.propertyName}" />
</#if>
</#list>
<#list table.commonFields as field><#--生成公共字段 -->
    <result column="${field.name?upper_case}" property="${field.propertyName}" />
</#list>
<#list table.fields as field>
<#if !field.keyFlag><#--生成普通字段 -->
        <result column="${field.name?upper_case}" property="${field.propertyName}" />
</#if>
</#list>
    </resultMap>

</#if>
<#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
<#list table.commonFields as field>
        ${field.name?upper_case},
</#list>
        ${table.fieldNames}
    </sql>

</#if>
<#if enableMultiplyTables>
<select id="select${entity}Vos"
        resultType="${package.Resp}.${entity?uncap_first}Resp">
    SELECT
<#list table.fields as field>
    <#if field.keyFlag><#--生成主键排在第一位-->
        c.${field.name?upper_case} AS ${field.propertyName},
    </#if>
</#list>
<#list table.commonFields as field><#--生成公共字段 -->
        c.${field.name?upper_case} AS ${field.propertyName},
</#list>
<#list table.fields as field>
    <#if !field.keyFlag><#--生成普通字段 -->
        c.${field.name?upper_case} AS ${field.propertyName},
    </#if>
</#list>
        FROM ${table.name?upper_case} c
        JOIN xxx(待填写) p ON c.ID_ = p.xxx(待填写) WHERE xxx
<#list table.fields as field>
    <#if field.keyFlag><#--生成主键排在第一位-->
    <if test="${entity?uncap_first}Req.${field.propertyName} != null and ${entity?uncap_first}Req.${field.propertyName} != ''">
        AND c.${field.name?upper_case} eq ${r'#{'}${entity?uncap_first}Req.${field.propertyName}}
    </if>
    </#if>
</#list>
<#list table.commonFields as field><#--生成公共字段 -->
    <if test="${entity?uncap_first}Req.${field.propertyName} != null and ${entity?uncap_first}Req.${field.propertyName} != ''">
        AND c.${field.name?upper_case} like ${r'#{'}${entity?uncap_first}Req.${field.propertyName}}
    </if>
</#list>
<#list table.fields as field>
    <#if !field.keyFlag><#--生成普通字段 -->
    <if test="${entity?uncap_first}Req.${field.propertyName} != null and ${entity?uncap_first}Req.${field.propertyName} != ''">
        AND c.${field.name?upper_case} like ${r'#{'}${entity?uncap_first}Req.${field.propertyName}}
    </if>
    </#if>
</#list>
        ORDER BY c.CREATE_TIME DESC
</select>
</#if>
</mapper>
