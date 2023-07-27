package {{.GroupId}}.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 描述：统一返回枚举
 * 作者：{{.Author}}
 * 日期: {{.CreateTime}}
 */
@Getter
@AllArgsConstructor
public enum ResponseExceptionEnum {

    SUCCESS("000000", "成功!"),
    INTERNAL_SERVER_ERROR("111111", "服务器内部错误!");

    private final String code;
    private final String msg;
}
