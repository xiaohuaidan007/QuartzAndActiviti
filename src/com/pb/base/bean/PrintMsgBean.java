package com.pb.base.bean;

import java.text.SimpleDateFormat;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * 打印消息Bean
 * @author Administrator
 *
 */
public class PrintMsgBean {

	protected static ObjectMapper objectMapper = null;
	
	static{
		objectMapper = new ObjectMapper();
		objectMapper.configure(SerializationFeature.FAIL_ON_UNWRAPPED_TYPE_IDENTIFIERS, false);
		objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		//序列化对象时，对象属性字段为null，不会映射到报文中
		objectMapper.setSerializationInclusion(Include.NON_NULL);
		/**
		 * FAQ:具有驼峰符号且字段为大写的字段要映射，需在类上加上注解：@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY,getterVisibility=JsonAutoDetect.Visibility.NONE)
		 */
		objectMapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY) // 任何级别的字段都可以自动识别
					.setVisibility(PropertyAccessor.GETTER, JsonAutoDetect.Visibility.NONE) // but only public getters  
					.setVisibility(PropertyAccessor.IS_GETTER, JsonAutoDetect.Visibility.PUBLIC_ONLY) // and none of "is-setters" ;
					.setVisibility(PropertyAccessor.SETTER, JsonAutoDetect.Visibility.PUBLIC_ONLY);
		/**
		 * 该特性决定了当遇到未知属性（没有映射到属性，没有任何setter或者任何可以处理它的handler），是否应该抛出一个
         * JsonMappingException异常。这个特性一般式所有其他处理方法对未知属性处理都无效后才被尝试，属性保留未处理状态。
		 */
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
//		objectMapper.setPropertyNamingStrategy(noneHandleCaseStrategy);
		objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
		//是否缩放排列输出
		objectMapper.configure(SerializationFeature.INDENT_OUTPUT,true); 
	}
	
	public static String convert2JsonStr(Object obj) throws JsonProcessingException{
		return objectMapper.writeValueAsString(obj);
	}
	
}
