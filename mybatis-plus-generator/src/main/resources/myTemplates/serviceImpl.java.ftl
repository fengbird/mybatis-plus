package ${package.ServiceImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Service}.${table.serviceName};
import ${superServiceImplClassPackage};
import org.springframework.stereotype.Service;
<#if enableMultiplyTables>
import com.baomidou.mybatisplus.plugins.Page;
import ${package.Req}.${entity}Req;
import ${package.Resp}.${entity}Resp;
</#if>

/**
 * <p>
 * ${table.comment!} 服务实现类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
@Service
public class ${table.serviceImplName} extends ${superServiceImplClass}<${table.mapperName}, ${entity}> implements ${table.serviceName} {
    <#if enableMultiplyTables>
    Page<${entity}Resp> query${entity}PageVos(${entity}Req ${entity?uncap_first}Req) {
        Page<${entity}Req> ${entity?uncap_first}VoPage = new Page<>(${entity?uncap_first}Req.getCurrentPage(),
        ${entity?uncap_first}Req.getPageSize());
        ${entity?uncap_first}VoPage.setRecords(baseMapper.select${entity}Vos(${entity?uncap_first}VoPage, ${entity?uncap_first}Req));
        return ${entity?uncap_first}VoPage;
    }

    List<${entity}Resp> query${entity}Vos(${entity}Req ${entity?uncap_first}Req) {
        return baseMapper.select${entity}Vos(${entity?uncap_first}Req);
    }
    </#if>
}
