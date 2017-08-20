package com.pb.modult.admin.biz.service;

import org.apache.log4j.Logger;
import org.apache.log4j.spi.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pb.modult.admin.biz.bo.AdminBO;
/**
 * 管理员
 * @author Administrator
 *
 */
@Service
public class AdminService {
	@Autowired
	private AdminBO adminBO;
	
	public void login(){
		System.out.println("开始执行bo");
		adminBO.init();
		System.out.println("bo执行结束");
	}
}
