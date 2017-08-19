package com.pb.modult.quartz.job;

public class TestTask {

	public void exec(){
		System.out.println("定时任务执行启动............");
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("定时任务执行成功............");
	}
}
