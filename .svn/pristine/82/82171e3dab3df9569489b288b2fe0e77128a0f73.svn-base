package cn.bnsr.edu_yun.backstage.resource.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.resource.service.ResourceStatsService;
import cn.bnsr.edu_yun.backstage.resource.view.ResourceStatsView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 资源统计
 * @author fangxiongwei
 * @date 2016年9月27日
 */
@Controller
@RequestMapping("/back_resource_stats")
public class ResourceStatsController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(ResourceStatsController.class);
	
	@Autowired
	private ResourceStatsService resourceStatsService;
	
	/**
	 *跳转资源统计页面
	 */
	@RequestMapping("/to_resource_stats")
	public ModelAndView toResourceStats(HttpServletRequest request){
		String resourceType = request.getParameter("resourceType");
		String timeType = request.getParameter("timeType");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		request.setAttribute("resourceType", resourceType);
		request.setAttribute("timeType", timeType);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		return new ModelAndView("backstage/resource/resourceStats/resource_stats");
	}
	/**
	 * 查询统计数据
	 * @param fileStats
	 * @return
	 */
	@RequestMapping("/query_resource_stats")
	public void queryFileStats(HttpServletResponse response,ResourceStatsView resourceStats){
		Json j = new Json();
		try {
			List<ResourceStatsView> resourceStatsList = resourceStatsService.queryResourceStats(resourceStats);
			j.setSuccess(true);
			j.setObj(resourceStatsList);
			j.setMsg("查询统计数据成功!");
		} catch (Exception e) {
			log.error("查询统计数据失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询统计数据失败！");
		}
		super.writeJson(j,response);
	}
}
