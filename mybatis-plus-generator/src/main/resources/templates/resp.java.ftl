package ${package.Resp};

import java.io.Serializable;
<#if swagger2>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>

/**
 * <p>
    * ${table.comment!} 响应类
    * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if swagger2>
@ApiModel(value="${entity}Resp响应对象", description="${table.comment!}")
</#if>
public class ${entity}Resp implements Serializable {
    private static final long serialVersionUID = 1L;

}
