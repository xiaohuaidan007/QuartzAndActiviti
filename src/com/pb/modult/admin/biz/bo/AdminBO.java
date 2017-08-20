package com.pb.modult.admin.biz.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pb.base.dao.BaseDao;

@Service
public class AdminBO {
	@Autowired
	private BaseDao baseDao;
	
	public void init(){
		System.out.println("开始执行");
		;
		System.err.println("执行结果："+baseDao.insert("addAdmin", "xiaoxiao"));
	}
	
}
