package com.pb.modult.quartz.listener;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.listeners.TriggerListenerSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.pb.base.dao.BaseDao;
import com.pb.base.exception.BusinessException;
import com.pb.base.log.ErrorLog;
import com.pb.modult.quartz.dto.ScheduleJobDetail;
import com.pb.modult.quartz.dto.ScheduleJobLog;
import com.pb.modult.quartz.util.QuartzConstants;

/**
 * 触发器监听器
 * @author Administrator
 *
 */
public class SimpleTriggerListener extends TriggerListenerSupport {

	private Logger logger = LoggerFactory
			.getLogger(SimpleTriggerListener.class);

	private BaseDao baseDao;

	@Override
	public String getName() {
		return "SimpleTriggerListener";
	}

	/**
	 * 任务依赖，每一个trigger解发时，需要检查所依赖的任务是否完成，即查询最新一次任务是否完成
	 */
	@Override
	@SuppressWarnings({"rawtypes"})
	public boolean vetoJobExecution(Trigger trigger, JobExecutionContext context) {
		ApplicationContext applicationContext;
		try {
			applicationContext = (ApplicationContext) context.getScheduler()
					.getContext().get("applicationContext");
		} catch (SchedulerException e) {
			ErrorLog.log(
					logger,
					"SimpleTriggerListener",
					null,
					"Quartz SimpleTriggerListener can't get Spring ApplicationContext",
					e);
			throw new BusinessException(e);
		}

		baseDao = (BaseDao) applicationContext.getBean("baseDao");

		//获取scheduleJobDetail
		ScheduleJobDetail scheduleJobDetail = (ScheduleJobDetail) context
				.getMergedJobDataMap().get("scheduleJobDetail");
		//根据JobId获取依赖任务
		String dependJobIds = (String) baseDao.queryForObject("getJobDependency",
				scheduleJobDetail.getJobId());
		
		String[] dependJobIdSet = null;
		if (null != dependJobIds) {
			//依赖任务有可能为多个
			dependJobIdSet = dependJobIds.split("\\|");
			for (String tempJobId : dependJobIdSet) {
				//查询未完成的Job数，状态为R或E
				List unCompletedJobLogs = baseDao.queryForList("getJobLogsUnCompleted", tempJobId);
				if (null != unCompletedJobLogs && unCompletedJobLogs.size() > 0) {
					return true;
				}
			}
			//初始化定时任务日志信息
			initializeJobLog(scheduleJobDetail,context);
		}else{
			//初始化定时任务日志信息
			initializeJobLog(scheduleJobDetail,context);
		}
		return false;
	}
	
	/**
	 * 初始化定时任务日志信息
	 * @param scheduleJobDetail
	 */
	private void initializeJobLog(ScheduleJobDetail scheduleJobDetail,JobExecutionContext context) {
		ScheduleJobLog scheduleJobLog = new ScheduleJobLog();
		String idJobLog = (String) baseDao.queryForObject("getJobLogPrimaryKey", null);
		scheduleJobLog.setIdJobLog(idJobLog);
		scheduleJobLog.setJobId(scheduleJobDetail.getJobId());
		scheduleJobLog.setJobName(scheduleJobDetail.getBeanName());
		InetAddress inetAddress;
		try {
			inetAddress = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			ErrorLog.log(
					logger,
					null,
					null,
					"SimpleTriggerListener.vetoJobExecution acquire current ip error",
					e);
			throw new BusinessException(e);
		}
		String runIp = inetAddress.getHostAddress();
		scheduleJobLog.setRunIp(runIp);
		scheduleJobLog.setTaskStatus(QuartzConstants.QUARTZ_JOB_STATE_RUNNING);
		scheduleJobLog.setRunErrMsg("运行中");
		baseDao.insert("insertJobLog", scheduleJobLog);
		
		context.getMergedJobDataMap().put("scheduleJobLog",
				scheduleJobLog);
	}

}
