package com.pb.base.log;

import org.slf4j.Logger;

/**
 * 消息日志
 * 
 * @author xuguofeng
 * 
 */
public class InfoLog extends Log {
	
	/**
	 * 日志
	 * @param logger 采用LoggerHelp生成
	 * @param businessKey 主键（可为空）
	 * @param message 日志信息
	 */
	public static void log(Logger logger,
			String businessKey, String message){
		InfoLog.log(logger, businessKey, message, new Object[]{});
	}
	
	
	/**
	 * 日志
	 * @param logger 采用LoggerHelp生成
	 * @param businessKey 主键
	 * @param placeHolderedMessage
	 * @param placeHolderValueArray
	 */
	public static void log(Logger logger,
			String businessKey, String placeHolderedMessage,
			Object... placeHolderValueArray) {
		Object[] aobj = null;
		if (placeHolderValueArray != null && placeHolderValueArray.length > 0) {
			aobj = new Object[1 + placeHolderValueArray.length];
		} else {
			aobj = new Object[1];
		}
		if (aobj != null) {
			for (int i = 0; i < aobj.length; i++) {
				if (i == 0) {
					aobj[i] = (businessKey != null ? businessKey : "");
				} else if (i > 0) {
					aobj[i] = placeHolderValueArray[i - 1];
				}
			}
		}
		logger.info("[businessKey:{}]" + placeHolderedMessage, aobj);
	}
	
	/**
	 * 带具体请求数据的日志记录
	 * @param logger 采用LoggerHelp生成
	 * @param businessKey 主键
	 * @param message 消息
	 * @param methodStackData 当前数据（比如DTO）
	 */
	public static void log(Logger logger,String businessKey,String message,
			Object methodStackData) {
		String jsonStr = Log.buildJsonMessage(businessKey, methodStackData, null);
		if(jsonStr!=null){
			logger.info("{}->\r\n{}",message,jsonStr);
		}else{
			logger.info("[businessKey:{}][message:{}]->\r\n", 
					businessKey);
		}
	}

}
