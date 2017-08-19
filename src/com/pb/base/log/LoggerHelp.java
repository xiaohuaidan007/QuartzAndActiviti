package com.pb.base.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * 日志工具类
 * @author Administrator
 * @since 2016-5-7
 */
public class LoggerHelp {

	private  static Logger infoLogger ;
	
	private  static Logger errorLogger;
	
	public static Logger getInfoLogger(){
		if(null == infoLogger){
			infoLogger = LoggerFactory.getLogger("InfoFile");
		}
		return infoLogger;
	}
	
	public static Logger getErrorLogger(){
		if(null == errorLogger){
			errorLogger = LoggerFactory.getLogger("ErrorFile");
		}
		return errorLogger;
	}
}
