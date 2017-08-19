package com.pb.base.log;

import org.slf4j.Logger;

/**
 * Debug日志
 * @author Administrator
 *
 */
public class DebugLog extends Log{

	/**
	 * 记录日志
	 * 
	 * @param logger
	 *            日志源
	 * @param businessKey
	 *            业务主键->主要为申请编号 若无可为null
	 * @param message
	 *            消息
	 */
	public static void log(Logger logger,
			String businessKey, String message
			){
		DebugLog.log(logger, businessKey, message, new Object[]{});
	}
	
	/**
	 * 记录日志
	 * 
	 * @param logger
	 *            日志源
	 * @param businessKey
	 *            业务主键->主要为申请编号 若无可为null
	 * @param placeHolderedMessage
	 *            消息 -> 尽量避免使用+符号进行字符串拼装,请使用{}占位符
	 * @param placeHolderValueArray
	 *            消息占位符对应的值
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
		logger.debug("[businessKey:{}]" + placeHolderedMessage, aobj);
	}
	
	/**
	 * 记录日志
	 * 
	 * @param logger
	 *            日志源
	 * @param businessKey
	 *            业务主键->主要为申请编号 若无可为null
	 * @param message
	 *            错误消息
	 * @param methodStackData
	 *            异常时逻辑堆栈正在处理的数据->若无可为null
	 */
	public static void log(Logger logger ,
			String businessKey,String message, Object methodStackData
			) {
		String jsonStr = Log.buildJsonMessage(businessKey, methodStackData, null);
		if(jsonStr!=null){
			logger.debug("{}->\r\n{}",message,jsonStr);
		}else{
			logger.debug("[businessKey:{}][message:{}]->\r\n", 
					businessKey);
		}
	}
	
}
