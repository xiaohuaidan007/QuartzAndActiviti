package com.pb.base.log;

import org.slf4j.Logger;

/**
 * 系统错误日志
 * 
 * @author xuguofeng
 * 
 */
public class ErrorLog extends Log{
	
	/**
	 * 记录日志
	 * 
	 * @param logger
	 *            日志源
	 * @param businessKey
	 *            业务主键->主要为申请编号 若无可为null
	 * @param methodStackData
	 *            异常时逻辑堆栈正在处理的数据->若无可为null
	 * @param message
	 *            错误消息
	 * @param throwable
	 *            异常
	 */
	public static void log(Logger logger ,
			String businessKey, Object methodStackData,
			String message, Throwable throwable) {
		String jsonStr = Log.buildJsonMessage(businessKey, methodStackData, message);
		if(jsonStr!=null){
			logger.error("error->\r\n{}",jsonStr,throwable);
		}else{
			logger.error("[businessKey:{}][message:{}]->\r\n", 
					businessKey,throwable.getMessage(),throwable);
		}
	}

}
