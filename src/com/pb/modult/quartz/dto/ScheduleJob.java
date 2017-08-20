package com.pb.modult.quartz.dto;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.pb.base.dto.BaseDTO;


/**
 * 定时任务DTO
 * @author WANGRENFENG041
 *
 */
public class ScheduleJob extends BaseDTO{

	private static final long serialVersionUID = 2256490938849843067L;
	/** 任务id */
	private String jobId;
	/** 任务名称 */
	private String jobName;
	/** 任务分组 */
	private String jobGroup;
	/** 触发器名称 */
	private String triggerName;
	/** 触发器组 */
	private String triggerGroup;
	/** 任务状态 */
	private String jobStatus;
	/** 任务运行时间表达式 */
	private String cronExpression;
	/** 任务描述 */
	private String description;
	/** 运行时ip */
	private String runIp;
	/**下次任务运行时间*/
	private Date nextFireTime;
	/**上次任务运行时间*/
	private Date previousFireTime;
	/**定时任务执行方法*/
	private String methodName;
	/**定时任务类*/
	private String beanName;
	/**定时任务依赖*/
	private String dependency;
	/**启动参数*/
	private String startParam;
	
	//启动参数
	private Map<String, String> startParamMap = new HashMap<String, String>();
//	private String startParamString;

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

	public String getJobStatus() {
		return jobStatus;
	}

	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}

	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRunIp() {
		return runIp;
	}

	public void setRunIp(String runIp) {
		this.runIp = runIp;
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

	public String getMethodName() {
		return methodName;
	}

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getBeanName() {
		return beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
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

	public String getDependency() {
		return dependency;
	}

	public void setDependency(String dependency) {
		this.dependency = dependency;
	}

	public Map<String, String> getStartParamMap() {
		return startParamMap;
	}

	public void addStartParam(String key, String value) {
		this.startParamMap.put(key, value);
	}

	public String getStartParam() {
		return startParam;
	}

	public void setStartParam(String startParam) {
		this.startParam = startParam;
	}
	
}
