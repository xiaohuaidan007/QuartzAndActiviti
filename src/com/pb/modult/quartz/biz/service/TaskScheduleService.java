package com.pb.modult.quartz.biz.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.JobListener;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.TriggerListener;
import org.quartz.impl.matchers.GroupMatcher;
import org.slf4j.Logger;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageInfo;
import com.pb.base.exception.BusinessException;
import com.pb.base.log.LoggerHelp;
import com.pb.modult.quartz.biz.bo.TaskScheduleBo;
import com.pb.modult.quartz.dto.ScheduleJob;
import com.pb.modult.quartz.dto.ScheduleJobDetail;
import com.pb.modult.quartz.dto.ScheduleTrigger;
import com.pb.modult.quartz.job.QuartzJobFactory;
import com.pb.modult.quartz.listener.SimpleJobListener;
import com.pb.modult.quartz.listener.SimpleTriggerListener;


@Service
public class TaskScheduleService {

	// @Resource(name = "&schedulerFactoryBean")
	// private SchedulerFactoryBean schedulerFactoryBean;
	@Resource
	private Scheduler scheduler;
	@Resource
	private TaskScheduleBo taskScheduleBo;

	private Logger errorLogger = LoggerHelp.getErrorLogger();

	/**
	 * shceduler通过内存操作，容器起动时加载所有定时任务
	 * 
	 * @throws SchedulerException
	 */
	/*@PostConstruct
	public void buildQuartzTask() {
		// 容器启动时加载所有定时任务，后面改成连接数据库
		// List<ScheduleJob> jobList = null;
		List<ScheduleJobDetail> scheduleJobDetailList = null;
		try {
			// jobList = taskScheduleBo.getAllScheduleJobs();
			scheduleJobDetailList = taskScheduleBo.getScheduleJobDetails();
		} catch (DaoException ex) {
			errorLogger.error(
					"quartz jobs init error and stop quartz schedule job", ex);
			return;
		}
		InetAddress inetAddress;
		String localIp = "";
		try {
			inetAddress = InetAddress.getLocalHost();
			// 获取本地ip
			localIp = inetAddress.getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		// 遍历所有任务
		for (ScheduleJobDetail scheduleJobDetail : scheduleJobDetailList) {
			// 如果当前任务指定运行ip为本地ip，则在此服务器上运行，否则continue，继续下一个任务
			if (scheduleJobDetail.getRunIp().equals(localIp)) {
				JobDetail jobDetail = JobBuilder
						.newJob(QuartzJobFactory.class)
						.storeDurably(true)//添加任务时若没有关联的trigger，该job需要持久化
						.withIdentity(scheduleJobDetail.getJobName(),
								scheduleJobDetail.getJobGroup()).build();
				jobDetail.getJobDataMap().put("scheduleJobDetail",
						scheduleJobDetail);
				try {
					scheduler.addJob(jobDetail, true);
				} catch (SchedulerException e1) {
					e1.printStackTrace();
				}
				List<ScheduleTrigger> scheduleTriggerList = taskScheduleBo
						.getTriggerByJK(scheduleJobDetail.getJobName(),
								scheduleJobDetail.getJobGroup());

				for (ScheduleTrigger scheduleTrigger : scheduleTriggerList) {
					TriggerKey triggerKey = TriggerKey.triggerKey(
							scheduleTrigger.getTriggerName(),
							scheduleTrigger.getTriggerGroup());
					// 获取trigger，即在spring配置文件中定义的 bean id="myTrigger"
					CronTrigger trigger = null;
					try {
						trigger = (CronTrigger) scheduler
								.getTrigger(triggerKey);
					} catch (SchedulerException e) {
						e.printStackTrace();
					}

					if (null == trigger) {
						// 表达试调度构建器
						CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
								.cronSchedule(scheduleTrigger
										.getCronExpression());
						// 按新的cronExpression表达式构建一个trigger
						trigger = TriggerBuilder
								.newTrigger()
								.forJob(jobDetail)
								.withIdentity(scheduleTrigger.getTriggerName(),
										scheduleTrigger.getTriggerGroup())
								.withSchedule(cronScheduleBuilder).build();
						try {
							scheduler.scheduleJob(trigger);
						} catch (SchedulerException e) {
							e.printStackTrace();
						}
					} else {
						// Trigger已存在，那么更新相应的定时设置
						// 表达试调度构建器
						CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
								.cronSchedule(scheduleTrigger
										.getCronExpression());
						// 按新的cronExpression表达式构建一个trigger
						trigger = TriggerBuilder.newTrigger()
								.withIdentity(triggerKey)
								.withSchedule(cronScheduleBuilder).build();
						// 按新的trigger重新构建trigger
						try {
							scheduler.rescheduleJob(triggerKey, trigger);
						} catch (SchedulerException e) {
							e.printStackTrace();
						}
					}
				}
				try {
					scheduler.start();
				} catch (SchedulerException e) {
					e.printStackTrace();
				}
			} else {
				continue;
			}
		}
	}*/
	
	/**
	 * scheduler通过数据库进行操作，启动时加载定时任务参数表
	 */
	@PostConstruct
	public void buildQuartzTask(){
		try {
			TriggerListener triggerListener = new SimpleTriggerListener();
			JobListener jobListener = new SimpleJobListener();
			scheduler.getListenerManager().addTriggerListener(triggerListener);
			scheduler.getListenerManager().addJobListener(jobListener);
			//scheduler.start();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 立刻执行该job
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	public void triggerJob(String jobName, String jobGroup) {
		JobKey jobKey = JobKey.jobKey(jobName,jobGroup);
		try {
			scheduler.triggerJob(jobKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
			errorLogger.error("triggerJob jobName: " + jobName
					+ ",jobGroup:" + jobGroup + " trigger job error"+e.getMessage());
			throw new BusinessException(e);
		}
	}
	
	/**
	 * 添加触发器定时执行任务
	 * 
	 * @param scheduleTrigger
	 * @throws SchedulerException
	 */
	public void addTrigger(ScheduleJob scheduleJob){
		// 创建triggerKey
		TriggerKey triggerKey = new TriggerKey("TRIGGER-"
				+ UUID.randomUUID().toString(), Scheduler.DEFAULT_GROUP);

		// 根据表达式创建作业调度构建器
		CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
				.cronSchedule(scheduleJob.getCronExpression())
				.withMisfireHandlingInstructionDoNothing();

		// 创建作业触发器
		CronTrigger cronTrigger = TriggerBuilder.newTrigger()
				.withIdentity(triggerKey).withSchedule(cronScheduleBuilder)
				.build();
		
        //生成jobName
		String jobName = "JOB-"+UUID.randomUUID().toString();
		// 创建作业detail
		JobDetail jobDetail = JobBuilder
				.newJob(QuartzJobFactory.class)
				.storeDurably(false)
				.withIdentity(jobName,
						scheduleJob.getJobGroup()).build();
		
		ScheduleJobDetail scheduleJobDetail = new ScheduleJobDetail();
		scheduleJobDetail.setJobId(scheduleJob.getJobId());
		scheduleJobDetail.setJobName(jobName);
		scheduleJobDetail.setJobGroup(scheduleJob.getJobGroup());
		scheduleJobDetail.setBeanName(scheduleJob.getBeanName());
		scheduleJobDetail.setDescription(scheduleJob.getDescription());
		scheduleJobDetail.setDependency(scheduleJob.getDependency());
		
		jobDetail.getJobDataMap().put("scheduleJobDetail", scheduleJobDetail);
		
		taskScheduleBo.addJobDetailsExt(scheduleJobDetail);
		// 将作业与对应的触发器存入调度器
		try {
			scheduler.scheduleJob(jobDetail, cronTrigger);
		} catch (SchedulerException e) {
			errorLogger.error("add job error"+e.getMessage());
			throw new BusinessException(e);
		}
	}
	
	/**
	 * 修改指定任务的trigger（表达式）
	 * 
	 * @param scheduleTrigger
	 * @throws SchedulerException
	 */
	public void modifyJobTrigger(ScheduleJob scheduleJob) {
		try {
			// 生成当前待修改的trigger的triggerKey
			TriggerKey triggerKey = new TriggerKey(
					scheduleJob.getTriggerName(), scheduleJob.getTriggerGroup());
			//scheduler.unscheduleJob(triggerKey);
			// 重新构建任务执行表达式
			CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
					.cronSchedule(scheduleJob.getCronExpression())
					.withMisfireHandlingInstructionDoNothing();
			// 重新构建trigger
			
			// 更新schedule中指定的trigger
			JobKey jobKey = new JobKey(scheduleJob.getJobName(),
					scheduleJob.getJobGroup());
			JobDetail jobDetail = scheduler.getJobDetail(jobKey);
			
			if(null == jobDetail){
				CronTrigger cronTrigger = TriggerBuilder.newTrigger()
						.withIdentity(triggerKey)
						.withSchedule(cronScheduleBuilder).build();
				// 创建作业detail
				jobDetail = JobBuilder
						.newJob(QuartzJobFactory.class)
						.storeDurably(false)
						.withIdentity("JOB-"+UUID.randomUUID().toString(),
								scheduleJob.getJobGroup()).build();
				scheduler.scheduleJob(jobDetail, cronTrigger);
			}else{
				CronTrigger cronTrigger = TriggerBuilder.newTrigger()
						.forJob(jobDetail).withIdentity(triggerKey)
						.withSchedule(cronScheduleBuilder).build();
				
				ScheduleJobDetail scheduleJobDetail = new ScheduleJobDetail();
				scheduleJobDetail.setJobName(scheduleJob.getJobName());
				scheduleJobDetail.setJobGroup(scheduleJob.getJobGroup());
				scheduleJobDetail.setBeanName(scheduleJob.getBeanName());
				scheduleJobDetail.setDependency(scheduleJob.getDependency());
				jobDetail.getJobDataMap().put("scheduleJobDetail",
						scheduleJobDetail);
				scheduler.rescheduleJob(triggerKey, cronTrigger);
			}
			
			taskScheduleBo.updateJobDetailsExtAndDependency(scheduleJob);
		} catch (Exception e) {
			e.printStackTrace();
			errorLogger.error("modifyJobTrigger Error," + "task triggerName: "
					+ scheduleJob.getTriggerName() + ",triggerGroup:"
					+ scheduleJob.getTriggerGroup() + e.getMessage());
			throw new BusinessException(e);
		} 

	}

	/**
	 * 删除指定任务的trigger
	 * 
	 * @param scheduleTrigger
	 * @throws SchedulerException
	 */
	public void deleteJobTrigger(String triggerName, String triggerGroup) {
		TriggerKey triggerKey = new TriggerKey(triggerName, triggerGroup);
		try {
			scheduler.unscheduleJob(triggerKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
			errorLogger.error("deleteJobTrigger Error,"+"task triggerName: " + triggerName + ",triggerGroup:"
					+ triggerGroup + e.getMessage());
			throw new BusinessException(e);
		}
	}

	/**
	 * 暂停指定的trigger
	 * 
	 * @param scheduleTrigger
	 * @throws SchedulerException
	 */
	public void pauseJobTrigger(String triggerName, String triggerGroup) {
		TriggerKey triggerKey = new TriggerKey(triggerName, triggerGroup);
		try {
			scheduler.pauseTrigger(triggerKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
			errorLogger.error("pauseJobTrigger Error: triggerName: " + triggerName
					+ ",triggerGroup:" + triggerGroup + e.getMessage());
			throw new BusinessException(e);
		}
	}

	/**
	 * 恢复指定触发器对应的任务
	 * 
	 * @param triggerName
	 * @param triggerGroup
	 */
	public void resumeJobTrigger(String triggerName, String triggerGroup) {
		TriggerKey triggerKey = new TriggerKey(triggerName, triggerGroup);
		try {
			scheduler.resumeTrigger(triggerKey);
		} catch (SchedulerException e) {
			e.printStackTrace();
			errorLogger.error("resumeJobTrigger Error: triggerName: "+ triggerName
					+ ",triggerGroup:" + triggerGroup + e.getMessage());
			throw new BusinessException(e);
		}
	}

	/**
	 * 获取调度器中加载的所有任务
	 * 
	 * @throws SchedulerException
	 */
	@SuppressWarnings("rawtypes")
	public List<ScheduleJob> getAllScheduleJobs() throws SchedulerException {
		// 获取调度器内所有任务组名
		List<String> groupNames = scheduler.getJobGroupNames();
		// 创建任务列表用以存储获取到的任务列表
		List<ScheduleJob> jobList = new ArrayList<ScheduleJob>();
		for (String groupName : groupNames) {
			GroupMatcher<JobKey> groupMatcher = GroupMatcher
					.groupEquals(groupName);
			// 获取任务组内所有job key值
			Set<JobKey> jobKeys = scheduler.getJobKeys(groupMatcher);
			for (JobKey jobKey : jobKeys) {
				// 通过job key得到trigger列表
				List<? extends Trigger> triggerList = scheduler
						.getTriggersOfJob(jobKey);
				for (Trigger trigger : triggerList) {
					ScheduleJob scheduleJob = new ScheduleJob();
					scheduleJob.setJobName(jobKey.getName());
					scheduleJob.setJobGroup(jobKey.getGroup());
					scheduleJob.setTriggerName(trigger.getKey().getName());
					scheduleJob.setTriggerGroup(trigger.getKey().getGroup());
					scheduleJob.setDescription("触发器:" + trigger.getKey());
					scheduleJob.setPreviousFireTime(trigger.getPreviousFireTime());
					scheduleJob.setNextFireTime(trigger.getNextFireTime());
					Map jobDetailExt = taskScheduleBo.getJobDetailExtByJK(
							jobKey.getName(), jobKey.getGroup());
					scheduleJob.setBeanName((String)jobDetailExt.get("BEAN_NAME"));
					scheduleJob.setJobId((String)jobDetailExt.get("JOB_ID"));
					scheduleJob.setDescription((String)jobDetailExt.get("DESCRIPTION"));
					String dependency = taskScheduleBo.getJobDependencyById((String)jobDetailExt.get("JOB_ID"));
					scheduleJob.setDependency(dependency);
					Trigger.TriggerState triggerState = scheduler
							.getTriggerState(trigger.getKey());
					scheduleJob.setJobStatus(triggerState.name());
					if (trigger instanceof CronTrigger) {
						CronTrigger cronTrigger = (CronTrigger) trigger;
						if (null != cronTrigger) {
							scheduleJob.setCronExpression(cronTrigger
									.getCronExpression());
						}
						jobList.add(scheduleJob);
					}
				}
			}
		}
		return jobList;
	}

	/**
	 * 获取所有运行中的job
	 * 
	 * @return
	 * @throws SchedulerException
	 */
	public List<ScheduleJob> getAllRunSchedJobs() {

		List<ScheduleJob> jobList = new ArrayList<ScheduleJob>();
		try {
			// 获取当前shceduler中运行的任务
			List<JobExecutionContext> execJobList = scheduler
					.getCurrentlyExecutingJobs();
			// 初始化所有任务
			for (JobExecutionContext jc : execJobList) {
				ScheduleJob scheduleJob = new ScheduleJob();
				JobKey jobKey = jc.getJobDetail().getKey();
				scheduleJob.setJobName(jobKey.getName());
				scheduleJob.setJobGroup(jobKey.getGroup());
				Trigger.TriggerState triggerState = scheduler
						.getTriggerState(jc.getTrigger().getKey());
				scheduleJob.setJobStatus(triggerState.name());
				scheduleJob.setDescription("触发器:"
						+ jc.getTrigger().getKey().toString());
				if (jc.getTrigger() instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger) jc.getTrigger();
					scheduleJob.setCronExpression(cronTrigger
							.getCronExpression());
				}
				jobList.add(scheduleJob);
			}
		} catch (Exception e) {
			e.printStackTrace();
			errorLogger.error("getAllRunSchedJobs Error: triggerName: "+e.getMessage());
			throw new BusinessException(e);
		}
		return jobList;
	}

	/**
	 * 任务triggerKey获取指定任务
	 * 
	 * @param triggerName
	 * @param triggerGroup
	 * @return 指定任务
	 */
	public ScheduleJob getScheduleJobByTK(String triggerName,
			String triggerGroup) {
		ScheduleJob scheduleJob = taskScheduleBo.getScheduleJobByTK(
				triggerName, triggerGroup);
		return scheduleJob;
	}
	
	/**
	 * 
	 * @param jobId
	 * @param jobName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public PageInfo queryHisTaskByCondition(String jobId,String jobName,String taskStatus,Integer pageNo,Integer pageSize){
		return taskScheduleBo.queryHisTaskByCondition(jobId, jobName, taskStatus,pageNo, pageSize);
	}
	
	/**
	 * 通过主键删除历史日志
	 * @param idJobLog
	 */
    public void deleteHisTaskByPK(String idJobLog){
    	taskScheduleBo.deleteHisTaskByPK(idJobLog);
    }
    
    /**
     * 删除任务扩展信息及依赖信息
     * @param triggerName
     * @param triggerGroup
     */
    @SuppressWarnings({ "rawtypes"})
	public void deleteJobDetailExtAndDependency(String triggerName,String triggerGroup){
    	Map jobKey = taskScheduleBo.getJobKeyByTK(triggerName, triggerGroup);
    	if(null != jobKey){
    		String jobName = (String) jobKey.get("JOB_NAME");
        	String jobGroup = (String) jobKey.get("JOB_GROUP");
        	String jobId = taskScheduleBo.getJobIdByJK(jobName, jobGroup);
        	taskScheduleBo.deleteJobDetailExtByJK(jobName, jobGroup);
        	taskScheduleBo.deleteJobDependencyByJobId(jobId);
    	}
    }

}
