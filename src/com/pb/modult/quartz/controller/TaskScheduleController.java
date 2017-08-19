package com.pb.modult.quartz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping (value="/job")
@SuppressWarnings({"rawtypes","unchecked"})
public class TaskScheduleController{

	/*@RequestMapping(value="/initTask", method = RequestMethod.GET)
	public ModelAndView initTask(HttpServletRequest request,
			HttpServletResponse response) {
		
		ServiceRequest serviceRequest = new ServiceRequest("initTaskBizAction",null);
		ServiceResponse serviceResponse = this.dispatchService(serviceRequest);
		ModelAndView modelAndView = new ModelAndView();
		Map<String,List<ScheduleJob>> modelMap = new HashMap<String,List<ScheduleJob>>();
		modelMap.put("scheduleJobList", (List<ScheduleJob>) serviceResponse.getModel());
		modelAndView.addAllObjects(modelMap);
		modelAndView.setViewName("job/taskAdmin");
		return modelAndView;
	}
	
	@RequestMapping(value="/triggerTask", method = RequestMethod.GET)
	public String triggerTask(@RequestParam String jobName,
			@RequestParam String jobGroup){
		ServiceRequest serviceRequest = new ServiceRequest("triggerTaskBizAction",null);
		Map  paramMap= serviceRequest.getParameters();
		paramMap.put("jobName",jobName);
		paramMap.put("jobGroup",jobGroup);
		serviceRequest.setParameters(paramMap);
		this.dispatchService(serviceRequest);
		return "redirect:/view/job/initTask";
	}
	
	@RequestMapping(value="/pauseTask", method = RequestMethod.GET)
	public String pauseTask(HttpServletRequest request,
			HttpServletResponse response){
		ServiceRequest serviceRequest = new ServiceRequest("pauseTaskBizAction",null);
		Map  paramMap= serviceRequest.getParameters();
		paramMap.put("triggerName",request.getParameter("triggerName"));
		paramMap.put("triggerGroup",request.getParameter("triggerGroup"));
		serviceRequest.setParameters(paramMap);
		this.dispatchService(serviceRequest);
		return "forward:/view/job/initTask";
	}
	
	@RequestMapping(value="/deleteTask", method = RequestMethod.GET)
	public String deleteTask(String triggerName, String triggerGroup){
		ServiceRequest serviceRequest = new ServiceRequest("deleteTaskBizAction",null);
		Map  paramMap= serviceRequest.getParameters();
		paramMap.put("triggerName",triggerName);
		paramMap.put("triggerGroup",triggerGroup);
		serviceRequest.setParameters(paramMap);
		this.dispatchService(serviceRequest);
		return "forward:/view/job/initTask";
	}
	
	@RequestMapping(value="/resumeTask", method = RequestMethod.GET)
	public String resumeTask(String triggerName, String triggerGroup){
		ServiceRequest serviceRequest = new ServiceRequest("resumeTaskBizAction",null);
		Map  paramMap= serviceRequest.getParameters();
		paramMap.put("triggerName",triggerName);
		paramMap.put("triggerGroup",triggerGroup);
		serviceRequest.setParameters(paramMap);
		this.dispatchService(serviceRequest);
		return "forward:/view/job/initTask";
	}
	
	@RequestMapping(value="/modifyTask", method = RequestMethod.POST)
	public String modifyTask(HttpServletRequest request,
			HttpServletResponse response){
		ServiceRequest serviceRequest = new ServiceRequest("modifyTaskBizAction",null);
		Map  paramMap= serviceRequest.getParameters();
		paramMap.put("jobName",request.getParameter("jobName"));
		paramMap.put("jobGroup",request.getParameter("jobGroup"));
		paramMap.put("triggerName",request.getParameter("triggerName"));
		paramMap.put("triggerGroup",request.getParameter("triggerGroup"));
		paramMap.put("beanName",request.getParameter("beanName"));
		paramMap.put("description",request.getParameter("description"));
		paramMap.put("jobId",request.getParameter("jobId"));
		paramMap.put("expression",request.getParameter("expression"));
		paramMap.put("dependency",request.getParameter("dependency"));
		serviceRequest.setParameters(paramMap);
		this.dispatchService(serviceRequest);
		return "redirect:/view/job/initTask";
	}
	
	@RequestMapping(value="/showAddTask", method = RequestMethod.GET)
	public String showAddTask(){
		return "job/addtask";
	}
	
	@RequestMapping(value="/addTask", method = RequestMethod.POST)
	public String addTask(HttpServletRequest request,
			HttpServletResponse response) {
		ServiceRequest serviceRequest = new ServiceRequest("addTaskBizAction",null);
		Map param = serviceRequest.getParameters();
		param.put("jobGroup", request.getParameter("jobGroup"));
		param.put("beanName", request.getParameter("beanName"));
		param.put("expression", request.getParameter("expression"));
		param.put("jobId", request.getParameter("jobId"));
		param.put("description", request.getParameter("description"));
		param.put("dependency", request.getParameter("dependency"));
		this.dispatchService(serviceRequest);
		return "redirect:/view/job/initTask";
	}
	
	*//**
	 * 通过triggerName、triggerGroup获取指定任务信息
	 * @param triggerName
	 * @param triggerGroup
	 * @return
	 *//*
	@RequestMapping(value="/updateTask", method = RequestMethod.GET)
	public ModelAndView getUpdatedTaskByTK(String triggerName,String triggerGroup){
		ServiceRequest serviceRequest = new ServiceRequest("getUpdateTaskBizAction",null);
		Map param = serviceRequest.getParameters();
		param.put("triggerName", triggerName);
		param.put("triggerGroup", triggerGroup);
		ServiceResponse serviceResponse = this.dispatchService(serviceRequest);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("scheduleJob", serviceResponse.getModel());
		modelAndView.setViewName("job/modifytask");
		return modelAndView;
	}
	
	@RequestMapping(value="/getAllRunSchedJobs", method = RequestMethod.GET)
	public ModelAndView getAllRunSchedJobs(HttpServletRequest request,
			HttpServletResponse response){
		ServiceRequest serviceRequest = new ServiceRequest("getAllRunTaskBizAction",null);
		ServiceResponse serviceResponse = this.dispatchService(serviceRequest);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("scheduleJobList", serviceResponse.getModel());
		modelAndView.setViewName("job/runtask");
		return modelAndView;
	}
	
	@RequestMapping(value="/showHisTask", method = RequestMethod.GET)
	public ModelAndView showHisTask(HttpServletRequest request,
			HttpServletResponse response){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("job/task-history");
		return modelAndView;
	}
	
	@RequestMapping(value="/queryHisTaskByCondition", method = RequestMethod.POST)
	@ResponseBody
	public Map queryHisTaskByCondition(HttpServletRequest request,
			HttpServletResponse response){
		ServiceRequest serviceRequest = new ServiceRequest("queryHisTaskByConditionBizAction",null);
		Map param = serviceRequest.getParameters();
		param.put("pageNo", request.getParameter("page"));
		param.put("pageSize", request.getParameter("rows"));
		param.put("jobId", request.getParameter("jobId"));
		param.put("jobName", request.getParameter("jobName"));
		param.put("taskStatus", request.getParameter("taskStatus"));
		ServiceResponse serviceResponse = this.dispatchService(serviceRequest);
		PageInfo pageInfo = (PageInfo) serviceResponse.getModel();
		Map result = new HashMap();
		if(null != pageInfo){
			result.put("rows", pageInfo.getList());
			result.put("total", pageInfo.getTotal());
		}
		return result;
	}
	
	@RequestMapping(value="/deleteHisTaskByJobId", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map deleteHisTaskByJobId(HttpServletRequest request,
			HttpServletResponse response,RedirectAttributes redirectAttributes){
		ServiceRequest serviceRequest = new ServiceRequest("deleteHisTaskBizAction",null);
		Map param = serviceRequest.getParameters();
		param.put("idJobLog", request.getParameter("idJobLog"));
		Map result = new HashMap();
		try{
			this.dispatchService(serviceRequest);
			redirectAttributes.addFlashAttribute("message", "PRIMARY KEY:"+request.getParameter("idJobLog")+"记录已删除");
			result.put("success", true);
			result.put("message", "操作成功");
		}catch(Exception e){
			result.put("mesage", "操作失败"+e.getMessage());
		}
		return result;
	}*/
	
	
	
}
