package com.pb.modult.quartz.dto;

import java.util.Date;

/**
 * 定时任务触发器
 * @author WANGRENFENG041
 * @since 2016-05-16
 */
public class ScheduleTrigger {

	//触发器名称
	private String triggerName;
	// 触发器组
	private String triggerGroup;
	//任务名称
	private String jobName;
	//任务组
	private String jobGroup;
	//任务运行时间表达式
	private String cronExpression;
	//下次任务运行时间
	private Date nextFireTime;
	//上次任务运行时间
	private Date previousFireTime;
	//触发器状态
	private String triggerState;

	public String getTriggerName() {
		return triggerName;
	}

	public void setTriggerName(String triggerName) {
		this.triggerName = triggerName;
	}

	public String getTriggerGroup() {
		return triggerGroup;
	}

	public void setTriggerGroup(String triggerGroup) {
		this.triggerGroup = triggerGroup;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getJobGroup() {
		return jobGroup;
	}

	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}

	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	public Date getNextFireTime() {
		return nextFireTime;
	}

	public void setNextFireTime(Date nextFireTime) {
		this.nextFireTime = nextFireTime;
	}

	public Date getPreviousFireTime() {
		return previousFireTime;
	}

	public void setPreviousFireTime(Date previousFireTime) {
		this.previousFireTime = previousFireTime;
	}

	public String getTriggerState() {
		return triggerState;
	}

	public void setTriggerState(String triggerState) {
		this.triggerState = triggerState;
	}
	
}