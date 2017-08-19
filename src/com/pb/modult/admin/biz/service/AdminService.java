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
	
	Logger logger = Logger.getLogger(AdminService.class);
	
	org.slf4j.Logger logger2 = org.slf4j.LoggerFactory.getLogger("InfoFile");
	
	public void login(){
		logger.info("info日志");
		logger.error("error日志");
		logger2.debug("debug日志，主键{}", "主键值");
	}
}
