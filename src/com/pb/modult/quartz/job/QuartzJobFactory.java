package com.pb.modult.quartz.job;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.InterruptableJob;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerException;
import org.quartz.UnableToInterruptJobException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.pb.base.exception.BusinessException;
import com.pb.base.log.ErrorLog;
import com.pb.base.log.InfoLog;
import com.pb.modult.quartz.action.QuartzAction;
import com.pb.modult.quartz.dto.ScheduleJobDetail;
import com.pb.modult.quartz.util.AtomicBoolean;


/**
 * 定时任务工厂类，用以匹配各定时任务实现类
 * 
 * @author WANGRENFENG041
 * 
 */
@DisallowConcurrentExecution
public class QuartzJobFactory implements InterruptableJob {
	
	private AtomicBoolean isInterrupt = new AtomicBoolean(false);
	
	private Logger logger = LoggerFactory.getLogger(QuartzJobFactory.class);

	@Override
	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		//获取scheduleJobDetail
		ScheduleJobDetail scheduleJobDetail = (ScheduleJobDetail) context
				.getMergedJobDataMap().get("scheduleJobDetail");
		//获取Spring上下文
		ApplicationContext applicationContext = null;
		try {
			applicationContext = (ApplicationContext) context.getScheduler()
					.getContext().get("applicationContext");
		} catch (SchedulerException e) {
			ErrorLog.log(
					logger,
					scheduleJobDetail.getBeanName(),
					null,
					"Quartz SchedulerFactoryBean can't get Spring ApplicationContext",
					e);
			throw new BusinessException(e);
		}
		String beanName = scheduleJobDetail.getBeanName();
		String description = scheduleJobDetail.getDescription();
		InfoLog.log(logger, null, "Quartz Job start:[beanName:"+beanName+"][description:"+description+"]");
		//获取定时任务执行Bean
		QuartzAction quartzAction = (QuartzAction) applicationContext
				.getBean(scheduleJobDetail.getBeanName());
		try{
			//执行定时任务
			long startTime = System.currentTimeMillis();
			quartzAction.execute(isInterrupt);
			long endTime = System.currentTimeMillis();
			InfoLog.log(logger, null, "Quartz job execute sucessfully:[beanName:"+beanName+"][description:"+description+"][execute time:"+(endTime-startTime)+" ms]");
		}catch(Exception e){
			ErrorLog.log(logger, null, null, "Quartz job execute failed:[beanName:"+beanName+"][description:"+description+"]", e);
			throw new BusinessException(e);
		}	
	}

	@Override
	public void interrupt() throws UnableToInterruptJobException {
		logger.info("[QuartzJobFactory]->定时作业停止，Job开始interrupt");
		isInterrupt.set(true);
	}

}
