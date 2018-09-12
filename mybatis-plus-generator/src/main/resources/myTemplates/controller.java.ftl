package ${package.Controller};


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.vz.finance.integration.model.SysUser;
import java.util.List;

<#if restControllerStyle>
import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if swagger2>
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
</#if>
<#if enableExport>
import org.vz.finance.integration.net.quanzhou.ui.core.utils.ExcelReportHelper;
</#if>
<#if enableShiro>
import org.apache.shiro.authz.annotation.RequiresPermissions;
</#if>
<#if enableImport>
import org.springframework.web.multipart.MultipartFile;
import org.vz.finance.integration.net.quanzhou.ui.core.utils.ExcelImportHelper;
import org.ice.jee.commons.core.exception.IllegalParameterException;
</#if>
<#if enableSysLog>
import org.vz.finance.integration.net.quanzhou.ui.core.annotation.SysLogAp;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 * <p>
 * ${table.comment!} 前端控制器
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if swagger2>
@Api(description = "${table.comment!}")
</#if>
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>

    @Autowired
    private ${table.providerName} ${table.providerName?substring(1)?uncap_first};

    @RequestMapping("")
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:list")
    </#if>
    public ModelAndView view() {
        //TODO 需要在此处填写视图页面的路径
        return new ModelAndView("");
    }

    <#--分页查询功能-->
    @PostMapping("/list")
    <#if swagger2>
    @ApiOperation("查询${table.comment!}列表")
    </#if>
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:list")
    </#if>
    public Object query${entity}List(@RequestBody ${entity}Req ${entity?uncap_first}Req) {
        logger.info("用户{}查询${table.comment!}列表", ((SysUser) super.getCurrUser()).getId());
        Page<${entity}Resp> result = ${table.providerName?substring(1)?uncap_first}.query${entity}ListPage(${entity?uncap_first}Req);
        logger.info("用户{}查询${table.comment!}列表,返回结果:{}", ((SysUser) super.getCurrUser()).getId(), JSON.toJSON(result));
        return setSuccessModelMap(result);
    }

    <#--Excel导出功能-->
    <#if enableExport>
    @GetMapping("/exportExcel")
    <#if swagger2>
    @ApiOperation("导出${table.comment!}列表")
    </#if>
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:list")
    </#if>
    <#if enableSysLog>
    @SysLogAp("导出${table.comment!}")
    </#if>
    public void exportExcel(${entity}Req ${entity?uncap_first}Req, HttpServletResponse response) {
        logger.info("用户{}导出${table.comment!}excel", ((SysUser) super.getCurrUser()).getId());
        List<${entity}Resp> ${entity?uncap_first}List = ${table.providerName?substring(1)?uncap_first}.query${entity}List(${entity?uncap_first}Req);
        logger.info("用户{}查询${table.comment!}列表,返回结果:{}", ((SysUser) super.getCurrUser()).getId(), JSON.toJSON(${entity?uncap_first}List));
        ExcelReportHelper.exportExcel(response, "${table.comment!}", ${entity}Resp.class, ${entity?uncap_first}List);
    }
    </#if>

    <#--保存功能-->
    <#if enableSave>
    @PostMapping("/save")
    <#if swagger2>
    @ApiOperation("保存${table.comment!}")
    </#if>
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:save")
    </#if>
    <#if enableSysLog>
    @SysLogAp("保存${table.comment!}")
    </#if>
    public Object save(@RequestBody ${entity}Req ${entity?uncap_first}Req) {
        String userId = ((SysUser) super.getCurrUser()).getId();
        logger.info("用户{}保存${table.comment!}信息", userId);
        int result = ${table.providerName?substring(1)?uncap_first}.save${entity}List(${entity?uncap_first}Req);
        logger.info("用户{}保存${table.comment!}信息,返回数据:{}", userId, JSON.toJSON(result));
        return setSuccessModelMap(1);
    }
    </#if>

    <#--删除功能-->
    <#if enableDelete>
    @DeleteMapping("/batch/delete")
    <#if swagger2>
    @ApiOperation("批量删除${table.comment!}信息")
    </#if>
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:delete")
    </#if>
    <#if enableSysLog>
    @SysLogAp("批量删除${table.comment!}")
    </#if>
    public Object delete(@RequestBody List<String> ${entity?uncap_first}Ids) {
        String userId = ((SysUser) super.getCurrUser()).getId();
        logger.info("用户{}批量删除${table.comment!}信息", userId);
        int result = ${table.providerName?substring(1)?uncap_first}.deleteBatchIds(${entity?uncap_first}Ids);
        logger.info("用户{}批量删除${table.comment!}信息,返回数据:{}", userId, JSON.toJSON(result));
        return setSuccessModelMap(1);
    }
    </#if>

    <#--导入功能-->
    <#if enableImport>
    @PostMapping(value = "/import")
    <#if swagger2>
    @ApiOperation("导入${table.comment!}")
    </#if>
    <#if enableShiro>
    @RequiresPermissions("${entity?uncap_first}:save")
    </#if>
    public Object upload(MultipartFile file) throws Exception {
    String userId = ((SysUser) super.getCurrUser()).getId();
    logger.info("用户{}批量导入${table.comment!}信息", userId);
    try {
        List<${entity}AddReq> ${entity?uncap_first}AddDtos = ExcelImportHelper.importExcel(${entity}AddReq.class,
        file.getInputStream());
        int result = ${table.providerName?substring(1)?uncap_first}.saveBatch${entity}s(${entity?uncap_first}AddReqs);
        logger.info("用户{}批量导入${table.comment!}信息,返回数据:{}", userId, JSON.toJSON(result));
        } catch (Exception e) {
            throw new IllegalParameterException("请按照excel模板导入");
        }
        return setSuccessModelMap(true);
    }
    </#if>
}
