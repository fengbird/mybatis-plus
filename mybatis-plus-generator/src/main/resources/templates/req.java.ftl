package ${package.Req};

import java.io.Serializable;
<#if swagger2>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * <p>
 * ${table.comment!} 请求类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if swagger2>
@ApiModel(value="${entity}Req请求对象", description="${table.comment!}")
</#if>
public class ${entity}Req implements Serializable {
    private static final long serialVersionUID = 1L;

}
