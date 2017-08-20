package com.pb.modult.quartz.dto;

import com.pb.base.dto.BaseDTO;

public class ScheduleJobDetail extends BaseDTO{

	private static final long serialVersionUID = 8822667876113265644L;
	
	//任务ID
	private String jobId;
	// 任务名称
	private String jobName;
	// 任务分组
	private String jobGroup;
	// 触发器名称
	private String triggerName;
	//触发器组
	private String triggerGroup;
	//运行时ip
	private String runIp;
	//任务执行类
	private String beanName;
	//任务执行方法
	private String methodName;
	//任务描述
	private String description;
	//任务依赖
	private String dependency;
	/**启动参数*/
	private String startParam;
	
	public String getJobId() {
		return jobId;
	}
	public void setJobId(String jobId) {
		this.jobId = jobId;
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
	public String getRunIp() {
		return runIp;
	}
	public void setRunIp(String runIp) {
		this.runIp = runIp;
	}
	public String getBeanName() {
		return beanName;
	}
	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDependency() {
		return dependency;
	}
	public void setDependency(String dependency) {
		this.dependency = dependency;
	}
	public String getStartParam() {
		return startParam;
	}
	public void setStartParam(String startParam) {
		this.startParam = startParam;
	}
	
}
