package test.service;

import javax.annotation.Resource;

import org.junit.Test;

import com.pb.modult.admin.biz.service.AdminService;

import test.BaseTest;

public class TestAdminService extends BaseTest{
	@Resource
	AdminService adminService;
	
	@Test
	public void testLogin(){
		System.out.println("开始输出");
		adminService.login();
	}

}
