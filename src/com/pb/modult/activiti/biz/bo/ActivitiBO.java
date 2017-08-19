package com.pb.modult.activiti.biz.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pb.base.dao.BaseDao;
/**
 * 工作流BO层
 * @author Administrator
 *
 */
@Service
public class ActivitiBO {
	@Autowired
	private BaseDao baseDao;
	
}
