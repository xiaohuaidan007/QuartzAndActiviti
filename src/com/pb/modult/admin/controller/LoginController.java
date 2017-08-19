package com.pb.modult.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pb.modult.admin.biz.service.AdminService;


/**
 * 登录控制器
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/")
public class LoginController {
	@Autowired
	private AdminService adminService;
	
	@RequestMapping("login")
	public String login(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "index";
	}
}
