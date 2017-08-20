package com.pb.modult.quartz.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pb.base.dao.BaseDao;
import com.pb.modult.quartz.util.AtomicBoolean;

@Service
public class BatchAddTestData implements QuartzAction{
	@Resource
	BaseDao baseDao;

	@Override
	public void execute(AtomicBoolean isInterrupt) {
		baseDao.insert("addAdmin", "坏蛋");
	}

}
