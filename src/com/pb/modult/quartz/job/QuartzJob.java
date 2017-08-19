package com.pb.modult.quartz.job;

/**
 * 定时任务接口，所有需要quartz调度的类都需要实现该接口
 * @author wangrenfeng041
 *
 */
public interface QuartzJob {

	/**
	 * 定时任务执行逻辑
	 */
	public void execute();
}
