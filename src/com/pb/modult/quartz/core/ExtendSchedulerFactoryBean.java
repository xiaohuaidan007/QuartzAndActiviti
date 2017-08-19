package com.pb.modult.quartz.core;

import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.SchedulingException;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

public class ExtendSchedulerFactoryBean extends SchedulerFactoryBean{

	private Logger logger = LoggerFactory.getLogger(ExtendSchedulerFactoryBean.class);
	
	@Override
	public void afterPropertiesSet() throws Exception {
		logger.info("[Quartz]->定时作业容器初始化开始...");
		super.afterPropertiesSet();
		logger.info("[Quartz]->定时作业容器初始化成功...");
	}
	
	@Override
	public void start() throws SchedulingException {
		logger.info("[Quartz]->定时作业调度开始启动...");
		super.start();
		logger.info("[Quartz]->定时作业调度启动成功...");
	}
	
	@Override
	public void destroy() throws SchedulerException {
		logger.info("[Quartz]->定时作业开始停止...");
		super.destroy();
		logger.info("[Quartz]->定时作业停止成功...");
	}
}
