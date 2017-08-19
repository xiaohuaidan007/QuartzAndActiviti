package com.pb.modult.quartz.biz.bo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.pagehelper.PageInfo;
import com.pb.base.dao.BaseDao;
import com.pb.modult.quartz.dto.ScheduleJob;
import com.pb.modult.quartz.dto.ScheduleJobDetail;
import com.pb.modult.quartz.dto.ScheduleTrigger;

@Service
public class TaskScheduleBo {

	@Resource
	private BaseDao baseDao;
	
	/**
	 * 获取所有定时任务
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ScheduleJob> getAllScheduleJobs(){
		/*List<ScheduleJob> list = new ArrayList<ScheduleJob>();
		ScheduleJob scheduleJob = new ScheduleJob();
		scheduleJob.setJobGroup("jobgroup-1");
		scheduleJob.setJobName("TestTask");
		scheduleJob.setCronExpression("0/30 * * * * ?");
		scheduleJob.setMethodName("exec");
		scheduleJob.setRunIp("10.50.123.45");
		scheduleJob.setBeanName("com.paic.loanplus.creditcard.base.quartz.job.TestTask");
		list.add(scheduleJob);*/
		List<ScheduleJob> jobList = baseDao.queryForList("queryQuartzTasks", null);
		return jobList;
	}
	
	@SuppressWarnings("unchecked")
	public List<ScheduleJobDetail> getScheduleJobDetails(){
		List<ScheduleJobDetail> scheduleJobDetailList = baseDao.queryForList("getScheduleJobDetails", null);
		return scheduleJobDetailList;
	}
	
	/**
	 * 通过TriggerKey获取所有定时任务触发器
	 * @return 定时任务调度
	 */
	public ScheduleJob getScheduleJobByTK(String triggerName, String triggerGroup){
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("triggerName", triggerName);
		paramMap.put("triggerGroup", triggerGroup);
		ScheduleJob scheduleJob = (ScheduleJob) baseDao.queryForObject("getScheduleJobByTK", paramMap);
		return scheduleJob;
	}
	
	/**
	 * 通过JobKey获取该定时任务的所有trigger
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ScheduleTrigger> getTriggerByJK(String jobName, String jobGroup){
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("jobName", jobName);
		paramMap.put("jobGroup", jobGroup);
		List<ScheduleTrigger> scheduleTriggerList = baseDao.queryForList("getTriggerByJK", paramMap);
		return scheduleTriggerList;
	}

	/**
	 * 添加任务扩展与依赖
	 * @param scheduleJobDetail
	 */
	public void addJobDetailsExt(ScheduleJobDetail scheduleJobDetail){
		baseDao.insert("addJobDetailExt", scheduleJobDetail);
		baseDao.insert("addJobDependency", scheduleJobDetail);
	}
	
	/**
	 * 更新定时任务明细扩展表
	 * @param scheduleJob
	 */
	public void updateJobDetailsExtAndDependency(ScheduleJob scheduleJob){
		baseDao.update("updateJobDetailsExt", scheduleJob);
		baseDao.update("updateJobDependency", scheduleJob);
	}
	
	/**
	 * 通过JobKey查询定时任务扩展信息，包括beanName，jobId，description
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getJobDetailExtByJK(String jobName,String jobGroup){
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("jobName", jobName);
		paramMap.put("jobGroup", jobGroup);
		Map resultMap = (Map) baseDao.queryForObject("getJobDetailExt", paramMap);
		return resultMap;
	}
	
	/**
	 * 能过JobId查询依赖任务
	 * @param jobId
	 * @return
	 */
	public String getJobDependencyById(String jobId){
		String dependency = (String) baseDao.queryForObject("getJobDependencyById", jobId);
		return dependency;
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageInfo queryHisTaskByCondition(String jobId,String jobName,String taskStatus,Integer pageNo,Integer pageSize){
		Map param = new HashMap();
		param.put("jobId", jobId);
		param.put("jobName", jobName);
		param.put("taskStatus", taskStatus);
		PageInfo pageInfo = (PageInfo) baseDao.queryForListByPage("queryJobLogByCondition", param, pageNo, pageSize);
		return pageInfo;
	}
	
	/**
	 * 通过主键删除历史日志信息
	 * @param idJobLog
	 */
	public void deleteHisTaskByPK(String idJobLog){
		baseDao.delete("deleteJobLogByPK", idJobLog);
	}
	
	/**
	 * 通过TriggerKey查询JobKey
	 * @param triggerName
	 * @param triggerGroup
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getJobKeyByTK(String triggerName,String triggerGroup){
		Map param = new HashMap();
    	param.put("triggerName", triggerName);
    	param.put("triggerGroup", triggerGroup);
		Map result = (Map) baseDao.queryForObject("getJobKeyByTK", param);
		return result;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getJobIdByJK(String jobName,String jobGroup){
		Map param = new HashMap();
    	param.put("jobName", jobName);
    	param.put("jobGroup", jobGroup);
    	Map result =  (Map) baseDao.queryForObject("getJobDetailExt", param);
    	if(null != result){
    		return (String)result.get("JOB_ID");
    	}else{
    		return null;
    	}
	}
	
	/**
	 * 通过JobKey删除Job扩展信息
	 * @param jobName
	 * @param jobGroup
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteJobDetailExtByJK(String jobName,String jobGroup){
		Map param = new HashMap();
    	param.put("jobName", jobName);
    	param.put("jobGroup", jobGroup);
		baseDao.delete("deleteJobDetailExtByJK", param);
	}
	
	/**
	 * 通过jobId删除任务依赖信息
	 * @param jobId
	 */
	public void deleteJobDependencyByJobId(String jobId){
		baseDao.delete("deleteJobDependencyByJobId", jobId);
	}
	
}
