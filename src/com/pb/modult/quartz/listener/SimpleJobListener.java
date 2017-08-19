package com.pb.modult.quartz.listener;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerException;
import org.quartz.listeners.JobListenerSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.pb.base.dao.BaseDao;
import com.pb.base.exception.BusinessException;
import com.pb.base.log.ErrorLog;
import com.pb.modult.quartz.dto.ScheduleJobLog;
import com.pb.modult.quartz.util.QuartzConstants;


public class SimpleJobListener extends JobListenerSupport {

	private Logger logger = LoggerFactory.getLogger(SimpleJobListener.class);

	@Override
	public String getName() {
		return "SimpleJobListener";
	}

	private BaseDao baseDao;

	/**
	 * 任务依赖，每一个job触发时，需要检查所依赖的任务是否完成，即查询最新一次任务是否完成
	 */
	public void jobExecutionVetoed(JobExecutionContext context) {
	};

	/**
	 * 任务结束后所要执行的会续处理动作
	 */
	@Override
	public void jobWasExecuted(JobExecutionContext context,
			JobExecutionException jobException) {
		
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

		//获取已初始化的任务日志
		ScheduleJobLog scheduleJobLog = (ScheduleJobLog) context
				.getMergedJobDataMap().get("scheduleJobLog");
		// 如果任务执行失败
		if (null != jobException
				&& null != jobException.getUnderlyingException()) {
			scheduleJobLog
					.setTaskStatus(QuartzConstants.QUARTZ_JOB_STATE_ERROR);
			String errorMsg = jobException.getUnderlyingException().getCause().getMessage();
			errorMsg = errorMsg.length() > 300 ? errorMsg.substring(0, 300) : errorMsg;
			scheduleJobLog.setRunErrMsg(errorMsg);
		} else {
			scheduleJobLog
					.setTaskStatus(QuartzConstants.QUARTZ_JOB_STATE_FINAL);
			scheduleJobLog.setRunErrMsg("执行成功");
		}

		baseDao = (BaseDao) applicationContext.getBean("baseDsDao");
		baseDao.update("updateJobLog", scheduleJobLog);

	}

}
