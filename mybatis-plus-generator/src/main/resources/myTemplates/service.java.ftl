package ${package.Service};

import ${package.Entity}.${entity};
import ${superServiceClassPackage};
<#if enableMultiplyTables>
import com.baomidou.mybatisplus.plugins.Page;
import ${package.Req}.${entity}Req;
import ${package.Resp}.${entity}Resp;
</#if>

/**
 * <p>
 * ${table.comment!} 服务类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
public interface ${table.serviceName} extends ${superServiceClass}<${entity}> {
    <#if enableMultiplyTables>
    /**
     * @author ${author}
     * @since ${date}
     * @description ${table.comment!}分页查询接口
     */
    Page<${entity}Resp> query${entity}PageVos(${entity}Req ${entity?uncap_first}Req);

    /**
    * @author ${author}
    * @since ${date}
    * @description ${table.comment!}查询接口
    */
    List<${entity}Resp> query${entity}Vos(${entity}Req ${entity?uncap_first}Req);
    </#if>
}
