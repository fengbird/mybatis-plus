package ${package.ProviderImpl};

import ${package.Entity}.${entity};
import ${package.Mapper}.${table.mapperName};
import ${package.Provider}.${table.providerName};
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.baomidou.mybatisplus.plugins.Page;
import java.util.List;
import java.util.ArrayList;
import org.springframework.beans.BeanUtils;
import ${package.Req}.${entity}Req;
import ${package.Resp}.${entity}Resp;
<#if (enableSave || enableDelete || enableImport)>
import org.ice.jee.commons.core.exception.IllegalParameterException;
</#if>
<#if (enableSave || enableImport)>
import org.vz.finance.integration.util.ToolForID;
import java.util.Date;
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
public class ${table.providerImplName} implements ${table.providerName} {

    @Autowired
    private ${table.serviceName} ${table.serviceName?substring(1)?uncap_first};

    @Override
    public Page<${entity}Resp> query${entity}ListPage(${entity}Req ${entity?uncap_first}Req) {
        //TODO 需要进行模糊查询的参数处理 如下示例
        //whiteListParamDto.setCompanyName(ToolForID.wrapperKeywordForSearch(whiteListParamDto.getCompanyName()));
        <#if enableMultiplyTables>
        Page<${entity}Resp> ${entity?uncap_first}RespPageVos = ${table.serviceName?substring(1)?uncap_first}
                .query${entity}PageVos(${entity?uncap_first}Req);
        //TODO 若需对查询出的数据进行二次处理请在此处进行

        return ${entity?uncap_first}RespPageVos;
        </#if>
        <#if enableSingleTable>
        Page<${entity}Req> page = new Page<>(${entity?uncap_first}Req.getCurrentPage(), ${entity?uncap_first}Req.getPageSize());
        EntityWrapper<WhiteList> ew = new EntityWrapper<>();
        //TODO 查询参数处理 如下示例:(这三行提示在代码补充完毕后注意删除)
        //ew.like(StringUtils.isNotEmpty(companyName), "COMPANY_NAME", companyName);
        //ew.eq(StringUtils.isNotEmpty(globalId), "GLOBAL_ID", globalId);
        Page<${entity}> ${entity?uncap_first}ListPage = ${table.serviceName?substring(1)?uncap_first}.selectPage(page,ew);
        List<${entity}> records = ${entity?uncap_first}ListPage.getRecords();
        List<${entity}Resp> ${entity?uncap_first}Resps = new ArrayList<>(records.size());
        records.forEach(record -> {
            ${entity}Resp tmp = new ${entity}Resp();
            BeanUtils.copyProperties(record, tmp);
            ${entity?uncap_first}Resps.add(tmp);
        });
        Page<${entity}Resp> rtn = new Page<>();
        BeanUtils.copyProperties(${entity?uncap_first}ListPage, rtn);
        rtn.setRecords(${entity?uncap_first}Resps);
        return rtn;
        </#if>
    }

    <#if enableExport>
    @Override
    public List<${entity}Resp> query${entity}List(${entity}Req ${entity?uncap_first}Req) {
        <#if enableMultiplyTables>
        List<${entity?uncap_first}Resp> ${entity?uncap_first}RespVos = ${table.serviceName?substring(1)?uncap_first}
                .query${entity}Vos(${entity?uncap_first}Req);
        //TODO 若需对查询出的数据进行二次处理请在此处进行

        return ${entity?uncap_first}RespVos;
        </#if>
        <#if enableSingleTable>
        EntityWrapper<${entity}> ew = new EntityWrapper<>();
        //TODO 模糊查询参数处理
        List<${entity}> ${entity?uncap_first}Lists = ${table.serviceName?substring(1)?uncap_first}.selectList(ew);
        List<${entity}Resp> rtn = new ArrayList<>(${entity?uncap_first}Lists.size());
        ${entity?uncap_first}Lists.forEach(record -> {
            ${entity}Resp tmp = new ${entity}Resp();
            BeanUtils.copyProperties(record, tmp);
            rtn.add(tmp);
        });
        return rtn;
        </#if>
    }
    </#if>

    <#if enableSave>
    @Override
    public int save${entity}(${entity}AddReq ${entity?uncap_first}AddReq) {
        if (null == ${entity?uncap_first}AddReq) {
            throw new IllegalParameterException("保存${table.comment!}失败,参数为空,请检查");
        }
        ${entity} ${entity?uncap_first} = new ${entity}();
        ${entity} ${entity?uncap_first}Req = new ${entity}Req();
        BeanUtils.copyProperties(${entity?uncap_first}AddReq, ${entity?uncap_first}Req);
        EntityWrapper<${entity}> ew = new EntityWrapper<>();
        //TODO 查询条件设置
        List<${entity}> ${entity?uncap_first}Lists = ${table.serviceName?substring(1)?uncap_first}.selectList(ew);
        if (!${entity?uncap_first}Lists.isEmpty()) {
            //TODO 需在注释中添加详细的参数提示
            throw new IllegalParameterException(String.format("${table.comment!}已存在,保存失败!"));
        }
        BeanUtils.copyProperties(${entity?uncap_first}AddReq, ${entity?uncap_first});
        ${entity?uncap_first}.setCreateTime(new Date());
        ${entity?uncap_first}.setEnable(1);
        ${entity?uncap_first}.setId(ToolForID.get${entity}ID());
        return ${table.serviceName?substring(1)?uncap_first}.insert${entity}(${entity?uncap_first});
    }
    </#if>

    <#if enableDelete>
    @Override
    public int deleteBatchIds(List<String> ${entity?uncap_first}Ids) {
        if (${entity?uncap_first}Ids == null || ${entity?uncap_first}Ids.isEmpty()) {
            throw new IllegalParameterException("删除${table.comment!}失败,参数为空");
        }
        return ${table.serviceName?substring(1)?uncap_first}.deleteBatchIds(whiteListIds);
    }
    </#if>

    <#if enableImport>
    @Override
    public int saveBatch${entity}s(List<${entity}AddReq> ${entity?uncap_first}AddReqs) {
        if (${entity?uncap_first}AddReqs.isEmpty()) {
            throw new IllegalParameterException("批量保存${table.comment!}失败,导入数据为空");
        }
        // 删除数据库所有数据
        ${table.serviceName?substring(1)?uncap_first}.delete(new EntityWrapper<>());
        // 批量新增白名单数据
        List<${entity}> ${entity?uncap_first}s = new ArrayList<>(${entity?uncap_first}AddReqs.size());
        ${entity?uncap_first}AddReqs.forEach(${entity?uncap_first}AddReq -> {
            ${entity} tmp = new ${entity}();
            BeanUtils.copyProperties(${entity?uncap_first}AddReq, tmp);
            tmp.setCreateTime(new Date());
            tmp.setEnable(1);
            tmp.setId(ToolForID.get${entity}ID());
            ${entity?uncap_first}s.add(tmp);
        });
        return ${table.serviceName?substring(1)?uncap_first}.insertBatch(${entity?uncap_first}s) ? 1 : 0;
    }
    </#if>
}
