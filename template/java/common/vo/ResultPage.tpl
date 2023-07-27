package {{.GroupId}}.common.vo;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 描述：分页数据返回
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ResultPage<T> implements Serializable {

	private List<T> list;
	private Integer pageNum;
	private Integer pageSize;
	private long total;

}
