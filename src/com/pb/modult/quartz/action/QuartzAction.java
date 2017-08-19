package com.pb.modult.quartz.action;

import com.pb.modult.quartz.util.AtomicBoolean;

/**
 * 任务执行接口
 * @author Administrator
 *
 */
public interface QuartzAction {
	/**
	 * 执行任务
	 * @param isInterrupt
	 */
	public void execute(AtomicBoolean isInterrupt);
	
}
