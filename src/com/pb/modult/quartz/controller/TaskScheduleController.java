package com.pb.modult.quartz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.quartz.SchedulerException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.pagehelper.PageInfo;
import com.pb.modult.quartz.biz.service.TaskScheduleService;
import com.pb.modult.quartz.dto.ScheduleJob;

@Controller
@RequestMapping (value="/job")
@SuppressWarnings({"rawtypes","unchecked"})
public class TaskScheduleController{
	@Resource
	private TaskScheduleService taskScheduleService;
	
	/**
	 * 展示任务列表
	 * @param request
	 * @param response
	 * @return
	 * @throws SchedulerException 
	 */
	@RequestMapping(value="/initTask", method = RequestMethod.GET)
	public ModelAndView initTask(HttpServletRequest request,
			HttpServletResponse response) throws SchedulerException {
		List<ScheduleJob> scheduleJobList = taskScheduleService.getAllScheduleJobs();
		ModelAndView modelAndView = new ModelAndView();
		Map<String,List<ScheduleJob>> modelMap = new HashMap<String,List<ScheduleJob>>();
		modelMap.put("scheduleJobList", scheduleJobList);
		modelAndView.addAllObjects(modelMap);
		modelAndView.setViewName("job/taskAdmin");
		return modelAndView;
	}
	
	/**
	 * 启动任务
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	@RequestMapping(value="/triggerTask", method = RequestMethod.GET)
	public String triggerTask(@RequestParam String jobName,
			@RequestParam String jobGroup){
		taskScheduleService.triggerJob(jobName,jobGroup);
		return "redirect:/job/initTask";
	}
	
	/**
	 * 暂停任务
	 */
	@RequestMapping(value="/pauseTask", method = RequestMethod.GET)
	public String pauseTask(HttpServletRequest request,
			HttpServletResponse response){
		taskScheduleService.pauseJobTrigger(request.getParameter("triggerName"),request.getParameter("triggerGroup"));
		return "forward:/job/initTask";
	}
	
	/**
	 * 删除任务
	 */
	@RequestMapping(value="/deleteTask", method = RequestMethod.GET)
	public String deleteTask(String triggerName, String triggerGroup){
		taskScheduleService.deleteJobDetailExtAndDependency(triggerName, triggerGroup);
		taskScheduleService.deleteJobTrigger(triggerName, triggerGroup);
		return "forward:/job/initTask";
	}
	
	/**
	 * 恢复任务
	 */
	@RequestMapping(value="/resumeTask", method = RequestMethod.GET)
	public String resumeTask(String triggerName, String triggerGroup){
		taskScheduleService.resumeJobTrigger(triggerName, triggerGroup);
		return "forward:/job/initTask";
	}
	
	/**
	 * 跳转到修改任务界面
	 * @param triggerName
	 * @param triggerGroup
	 * @return
	 */
	@RequestMapping(value="/updateTask", method = RequestMethod.GET)
	public ModelAndView getUpdatedTaskByTK(String triggerName,String triggerGroup){
		ScheduleJob scheduleJob = taskScheduleService.getScheduleJobByTK(triggerName, triggerGroup);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("scheduleJob", scheduleJob);
		modelAndView.setViewName("job/modifytask");
		return modelAndView;
	}
	
	/**
	 * 修改任务
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/modifyTask", method = RequestMethod.POST)
	public String modifyTask(HttpServletRequest request,
			HttpServletResponse response){
		ScheduleJob scheduleJob = new ScheduleJob();
		scheduleJob.setJobName(request.getParameter("jobName"));
		scheduleJob.setJobGroup(request.getParameter("jobGroup"));
		scheduleJob.setTriggerName(request.getParameter("triggerName"));
		scheduleJob.setTriggerGroup(request.getParameter("triggerGroup"));
		scheduleJob.setBeanName(request.getParameter("beanName"));
		scheduleJob.setCronExpression(request.getParameter("expression"));
		scheduleJob.setDescription(request.getParameter("description"));
		scheduleJob.setJobId(request.getParameter("jobId"));
		scheduleJob.setDependency(request.getParameter("dependency"));
		scheduleJob.setStartParam(request.getParameter("startParam"));
		taskScheduleService.modifyJobTrigger(scheduleJob);
		return "redirect:/job/initTask";
	}
	
	/**
	 * 跳转到添加任务界面
	 */
	@RequestMapping(value="/showAddTask", method = RequestMethod.GET)
	public String showAddTask(){
		return "job/addtask";
	}
	
	/**
	 * 添加任务
	 */
	@RequestMapping(value="/addTask", method = RequestMethod.POST)
	public String addTask(HttpServletRequest request,
			HttpServletResponse response) {
		ScheduleJob scheduleJob = new ScheduleJob();
		scheduleJob.setJobGroup(request.getParameter("jobGroup"));
		scheduleJob.setBeanName(request.getParameter("beanName"));
		scheduleJob.setCronExpression(request.getParameter("expression"));
		scheduleJob.setJobId(request.getParameter("jobId"));
		scheduleJob.setDescription(request.getParameter("description"));
		scheduleJob.setDependency(request.getParameter("dependency"));
		scheduleJob.setStartParam(request.getParameter("startParam"));
		taskScheduleService.addTrigger(scheduleJob);
		return "redirect:/job/initTask";
	}
	
	
	/**
	 * 查看当前运行任务
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getAllRunSchedJobs", method = RequestMethod.GET)
	public ModelAndView getAllRunSchedJobs(HttpServletRequest request,
			HttpServletResponse response){
		List scheduleJobList = taskScheduleService.getAllRunSchedJobs();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("scheduleJobList", scheduleJobList);
		modelAndView.setViewName("job/runtask");
		return modelAndView;
	}
	
	/**
	 * 跳转到历史任务界面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/showHisTask", method = RequestMethod.GET)
	public ModelAndView showHisTask(HttpServletRequest request,
			HttpServletResponse response){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("job/task-history");
		return modelAndView;
	}
	
	/**
	 * 通过条件查询历史任务记录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/queryHisTaskByCondition", method = RequestMethod.POST)
	@ResponseBody
	public Map queryHisTaskByCondition(HttpServletRequest request,
			HttpServletResponse response){
		String jobId = (String) request.getParameter("jobId");
		String jobName = (String) request.getParameter("jobName");
		String taskStatus = (String) request.getParameter("taskStatus");
		Integer pageNo = request.getParameter("pageNo") == null?1:Integer.valueOf((String)request.getParameter("pageNo"));
		Integer pageSize = request.getParameter("pageSize") == null?20:Integer.valueOf((String)request.getParameter("pageSize"));
		PageInfo pageInfo = taskScheduleService.queryHisTaskByCondition(jobId, jobName, taskStatus,pageNo, pageSize);
		Map result = new HashMap();
		if(null != pageInfo){
			result.put("rows", pageInfo.getList());
			result.put("total", pageInfo.getTotal());
		}
		return result;
	}
	
	/**
	 * 通过任务Id删除历史记录
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value="/deleteHisTaskByJobId", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map deleteHisTaskByJobId(HttpServletRequest request,
			HttpServletResponse response,RedirectAttributes redirectAttributes){
		Map result = new HashMap();
		try{
			taskScheduleService.deleteHisTaskByPK(request.getParameter("idJobLog"));
			redirectAttributes.addFlashAttribute("message", "PRIMARY KEY:"+request.getParameter("idJobLog")+"记录已删除");
			result.put("success", true);
			result.put("message", "操作成功");
		}catch(Exception e){
			result.put("mesage", "操作失败"+e.getMessage());
		}
		return result;
	}
}
