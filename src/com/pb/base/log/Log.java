package com.pb.base.log;

import java.util.HashMap;
import java.util.Map;

import com.pb.base.bean.PrintMsgBean;

/**
 * Log日志父类
 * @author Administrator
 *
 */
public abstract class Log {
	
	/**
	 * 创建JSON格式消息
	 * @param businessKey 主键
	 * @param methodStackData 运行参数
	 * @param message 消息
	 * @return
	 */
	protected static String buildJsonMessage(String businessKey,
			Object methodStackData,String message){
		Map<String,Object> output = new HashMap<String,Object>();
		if(businessKey!=null){
			output.put("businessKey", businessKey);
		}
		if(methodStackData!=null){
			output.put("methodStackData", methodStackData);
		}
		if(message!=null){
			output.put("message", message);
		}
		String jsonStr = null;
		try {
			jsonStr = PrintMsgBean.convert2JsonStr(output);
		} catch (Throwable t) {
			jsonStr = "{}";
		}
		return jsonStr;
	}
	
	/**
	 * 日志级别
	 * @author Administrator
	 *
	 */
	public static enum Level{
		
		INFO("info"),DEBUG("debug");
		
		private String level;
		
		private Level(String level){
			this.level = level;
		}

		public String getLevel() {
			return level;
		}
	}
	
}
