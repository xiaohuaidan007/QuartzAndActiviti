package com.pb.modult.activiti.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pb.modult.admin.biz.service.AdminService;


/**
 * 定时任务控制器
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/quartz")
public class ActivitiController {
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("login")
	public String login(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "index";
	}
}
