package com.pb.modult.quartz.util;

/**
 * 任务状态
 * @author Administrator
 *
 */
public class QuartzConstants {

	/** 定时任务运行状态-R-运行中 */
	public static final String QUARTZ_JOB_STATE_RUNNING = "R";
	
	/** 定时任务运行状态-E-运行失败*/
	public static final String QUARTZ_JOB_STATE_ERROR = "E";
	
	/** 定时任务运行状态-F-运行结束*/
	public static final String QUARTZ_JOB_STATE_FINAL = "F";
	
}
