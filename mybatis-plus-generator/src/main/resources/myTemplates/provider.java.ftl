package ${package.Provider};

import ${package.Entity}.${entity};
import java.util.List;
import ${package.Req}.${entity}Req;
import ${package.Resp}.${entity}Resp;

/**
 * <p>
    * ${table.comment!} 服务类
    * </p>
 *
 * @author ${author}
 * @since ${date}
 */
public interface ${table.providerName} {
    /**
     * @author ${author}
     * @since ${date}
     * @description 查询${table.comment!}分页接口
     */
    Page<${entity}Resp> query${entity}ListPage(${entity}Req ${entity?uncap_first}Req);

    <#if enableExport>
    /**
     * @author ${author}
     * @since ${date}
     * @description 查询${table.comment!}列表接口
     */
    List<${entity}Resp> query${entity}List(${entity}Req ${entity?uncap_first}Req);
    </#if>

    <#if enableSave>
    /**
     * @author ${author}
     * @since ${date}
     * @description 增加${table.comment!}
     */
    int save${entity}(${entity}AddReq ${entity?uncap_first}AddReq);
    </#if>

    <#if enableDelete>
    /**
    * @author ${author}
    * @since ${date}
    * @description 批量删除${table.comment!}
    */
    int deleteBatchIds(List<String> ${entity?uncap_first}Ids);
    </#if>

    <#if enableImport>
     /**
     * @author ${author}
     * @since ${date}
     * @description 批量保存${table.comment!}
     */
    int saveBatch${entity}s(List<${entity}AddReq> ${entity?uncap_first}AddReqs);
    </#if>
}
