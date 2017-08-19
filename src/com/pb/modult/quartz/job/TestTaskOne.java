package com.pb.modult.quartz.job;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.pb.base.dao.BaseDao;
import com.pb.modult.quartz.util.AtomicBoolean;


@Service
public class TestTaskOne{

	@Resource
	private BaseDao baseDao;
	
	public void execute(AtomicBoolean isInterrupt) {
		/*Map map = (Map) baseDsDao.queryForObject("selectQzDetail", "testTask-3");
		RouteDTO routeDTO = new RouteDTO();
		routeDTO.setCurrDsKey(RouteUtil.BIZ_DS_01);
		List list = (List) bizDsDao.queryForList("queryAppInfoByPartyNo", "660000342981",routeDTO);
		try {
			for(int i=0;i<10;i++){
				System.out.println("start testTaskOne");
				Thread.sleep(7000);
				System.out.println("end testTaskOne");
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("list.size:"+list.size());*/
		//throw new BusinessException("Just throw a  exception look look ",new Exception());
		
		while(true&&!isInterrupt.get()){
			System.out.println("定时任务启动.........................");
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

}
