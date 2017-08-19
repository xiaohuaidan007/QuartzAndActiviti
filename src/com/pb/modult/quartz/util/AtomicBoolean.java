package com.pb.modult.quartz.util;
/**
 * 任务执行标记
 * @author Administrator
 *
 */
public class AtomicBoolean {

	private boolean flag;
	
	public AtomicBoolean(boolean flag){
		this.flag = flag;
	}
	
	public void set(boolean flag){
		this.flag = flag;
	}
	
	public boolean get(){
		return flag;
	}
}
