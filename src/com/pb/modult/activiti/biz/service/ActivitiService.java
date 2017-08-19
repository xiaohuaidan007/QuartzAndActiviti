package com.pb.modult.activiti.biz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pb.modult.activiti.biz.bo.ActivitiBO;
/**
 * 工作流service层
 * @author Administrator
 *
 */
@Service
public class ActivitiService {
	@Autowired
	private ActivitiBO activitiBO;
	
	public void login(){
	}
}
