package {{.GroupId}}.common.utils;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.LongSerializationPolicy;
import com.google.gson.internal.LinkedTreeMap;

/**
 * 描述：SON格式化工具类(对象转JSON，JSON转对象)
 * 作者：{{.Author}}
 * 日期: {{.CreateTime}}
 */
public class JsonUtils {

	/**
	 * 私有构造器
	 * @author {{.Author}}
	 * @date {{.CreateTime}}
	 */
	private JsonUtils() {

	}

	/**
	 * 对象转换成json字符串 
	 * @param obj 对象
	 * @return String
	 * @author：{{.Author}}
	 * @date：{{.CreateTime}}
	 */
	public static String toJson(Object obj) {
		if (obj == null) {
			return null;
		}
		if (obj instanceof String && StringUtils.isBlank(obj.toString())) {
			return null;
		}
		// disableHtmlEscaping:特殊字符不转义,统一日期格式
		Gson gson = new GsonBuilder().disableHtmlEscaping().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(obj);
	}

	/**
	 * json字符串转成对象
	 * @param str  json串
	 * @param type 泛型
	 * @return t
	 * @author：{{.Author}}
	 * @date：{{.CreateTime}}
	 */
	public static <T> T fromJson(String str, Class<T> type) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		Gson gson = new GsonBuilder().disableHtmlEscaping().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成对象
	 * @param str  json串
	 * @param type 泛型
	 * @return t
	 * @author：{{.Author}}
	 * @date：{{.CreateTime}}
	 */
	public static <T> T fromJson(String str, Type type) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		Gson gson = (new GsonBuilder()).disableHtmlEscaping().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成对象
	 * @param str  json串
	 * @param type 泛型
	 * @return t
	 * @author：{{.Author}}
	 * @date：{{.CreateTime}}
	 */
	public static <T> T fromJson(String str, Type type, String format) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		Gson gson = (new GsonBuilder()).disableHtmlEscaping().setDateFormat(format).create();
		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成对象
	 * @param str  json串
	 * @param type 泛型
	 * @return t
	 * @author：{{.Author}}
	 * @date：{{.CreateTime}}
	 */
	public static <T> T fromJsonAsPrimitive(String str, Type type, String format) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		GsonBuilder builder = new GsonBuilder();
		// Register an adapter to manage the date types as long values
		builder.registerTypeAdapter(Date.class, new JsonDeserializer<Date>() {
		    @Override
			public Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
					throws JsonParseException {
				return new Date(json.getAsJsonPrimitive().getAsLong());
			}
		});
		Gson gson = builder.disableHtmlEscaping().setDateFormat(format).create();
		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成对象（解决科学计数问题）
	 * @param str json串
	 * @param type 泛型
	 * @return T
	 * @author {{.Author}}
	 * @date {{.CreateTime}}
	 */
	public static <T> T fromJsonAsFigures(String str, Type type) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		Gson gson = new GsonBuilder().registerTypeAdapter(Map.class, new JsonDeserializer<Map>() {
		    @Override
			public Map deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
					throws JsonParseException {
				HashMap<String, Object> resultMap = new HashMap<>();
				Set<Map.Entry<String, JsonElement>> entrySet = json.getAsJsonObject().entrySet();
				for (Map.Entry<String, JsonElement> entry : entrySet) {
					resultMap.put(entry.getKey(), entry.getValue());
				}
				return resultMap;
			}
		}).setLongSerializationPolicy(LongSerializationPolicy.STRING).create();
		return gson.fromJson(str, type);
	}

	/**
	 * json字符串转成Map对象（解决int变成double的问题）
	 * @param str JSON串
	 * @param type MAP对象
	 * @return T
	 * @author {{.Author}}
	 * @date {{.CreateTime}}
	 */
	public static <T> T fromJsonMapDeserializer(String str, Type type) {
		if (StringUtils.isBlank(str)) {
			return null;
		}
		Gson gson = new GsonBuilder().registerTypeAdapter(Map.class, new JsonDeserializer<Map>() {
		    @Override
			public Map deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
					throws JsonParseException {
				return (Map<String, Object>) MapDeserializerDoubleAsIntFix(json);
			}
		}).setLongSerializationPolicy(LongSerializationPolicy.STRING).create();
		return gson.fromJson(str, type);
	}

	/**
	 * 解决int变成double的问题
	 * @param in JSON串
	 * @return Object
	 * @author {{.Author}}
	 * @date {{.CreateTime}}
	 */
	private static Object MapDeserializerDoubleAsIntFix(JsonElement in) {
		if (in.isJsonArray()) {
			List<Object> list = new ArrayList<>();
			JsonArray arr = in.getAsJsonArray();
			for (JsonElement anArr : arr) {
				list.add(MapDeserializerDoubleAsIntFix(anArr));
			}
			return list;
		} else if (in.isJsonObject()) {
			Map<String, Object> map = new LinkedTreeMap<String, Object>();
			JsonObject obj = in.getAsJsonObject();
			Set<Map.Entry<String, JsonElement>> entitySet = obj.entrySet();
			for (Map.Entry<String, JsonElement> entry : entitySet) {
				map.put(entry.getKey(), MapDeserializerDoubleAsIntFix(entry.getValue()));
			}
			return map;
		} else if (in.isJsonPrimitive()) {
			JsonPrimitive prim = in.getAsJsonPrimitive();
			if (prim.isBoolean()) {
				return prim.getAsBoolean();
			} else if (prim.isString()) {
				return prim.getAsString();
			} else if (prim.isNumber()) {
				return prim.getAsBigDecimal();
			}
		}
		return null;
	}
}
