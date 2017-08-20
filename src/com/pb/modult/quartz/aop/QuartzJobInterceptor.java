package com.pb.modult.quartz.aop;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.pb.base.dao.BaseDao;

//@Component
//@Aspect
public class QuartzJobInterceptor {
	
	@Resource
	private BaseDao baseDao;

	//@Pointcut("target(com.paic.loanplus.creditcard.base.quartz.job.QuartzJob)")
	public void performance(){
		
	}
	
	//@Around("performance()")
	public void proceed(ProceedingJoinPoint proceedingJoinPoint){
		//判断该任务是否有任务依赖，若有，需要查看依赖任务是否执行完毕，执行完比后才可执行
		
		//若无任务依赖，则向定时任务日志表中插入记录
		
		//执行完毕后更新定时任务日志表
	}
	
	//@AfterThrowing(pointcut="performance()")
	public void doAfterThrow(){
		//若发生异常 ，则更新定时任务日志表任务状态为异常
	}                    
}
