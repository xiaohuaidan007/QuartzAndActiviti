package com.pb.modult.quartz.dto;

import java.util.Date;

/**
 * 定时任务运行日志表
 * @author WANGRENFENG041
 *
 */
public class ScheduleJobLog {
	
	//定时任务日志表主键
    private String idJobLog;
	//JOB ID
	private String jobId;
	//JOB 名称
	private String jobName;
	//任务开始时间
	private Date dateTaskStart;
	//任务结束时间
	private Date dateTaskEnd;
	//任务运行状态
	private String taskStatus;
	//运行错误信息
	private String runErrMsg;
	//运行IP
	private String runIp;
	//创建日期
	private Date dateCreated;
	//更新日期
	private Date dateUpdated;
	

	public String getIdJobLog() {
		return idJobLog;
	}

	public void setIdJobLog(String idJobLog) {
		this.idJobLog = idJobLog;
	}

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

	public Date getDateTaskStart() {
		return dateTaskStart;
	}

	public void setDateTaskStart(Date dateTaskStart) {
		this.dateTaskStart = dateTaskStart;
	}

	public Date getDateTaskEnd() {
		return dateTaskEnd;
	}

	public void setDateTaskEnd(Date dateTaskEnd) {
		this.dateTaskEnd = dateTaskEnd;
	}
	
	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getRunErrMsg() {
		return runErrMsg;
	}

	public void setRunErrMsg(String runErrMsg) {
		this.runErrMsg = runErrMsg;
	}

	public String getRunIp() {
		return runIp;
	}

	public void setRunIp(String runIp) {
		this.runIp = runIp;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public Date getDateUpdated() {
		return dateUpdated;
	}

	public void setDateUpdated(Date dateUpdated) {
		this.dateUpdated = dateUpdated;
	}
	
}
