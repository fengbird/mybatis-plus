package ${package.Mapper};

import ${package.Entity}.${entity};
import ${superMapperClassPackage};
<#if enableMultiplyTables>
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import ${package.Req}.${entity}Req;
import ${package.Resp}.${entity}Resp;
</#if>
/**
 * <p>
 * ${table.comment!} Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
public interface ${table.mapperName} extends ${superMapperClass}<${entity}> {
    <#if enableMultiplyTables>
    /**
     * @author ${author}
     * @since ${date}
     * @description 分页查询${table.comment!}列表
     */
    List<${entity}Resp> select${entity}Vos(Pagination page,
        @Param("${entity?uncap_first}Req") ${entity}Req ${entity?uncap_first}Req);

    /**
    * @author ${author}
    * @since ${date}
    * @description 查询${table.comment!}列表
    */
    List<${entity}Resp> select${entity}Vos(@Param("${entity?uncap_first}Req") ${entity}Req ${entity?uncap_first}Req);
    </#if>
}
