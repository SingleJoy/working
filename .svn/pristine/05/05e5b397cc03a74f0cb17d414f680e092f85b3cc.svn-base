package cn.bnsr.edu_yun.backstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.OrderStatsView;
import cn.bnsr.edu_yun.frontstage.base.service.OrderService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 订单统计
 * @author fangxiongwei
 * @date 2016年10月17日
 */
@Controller
@RequestMapping("/back_order_stats")
public class OrderStatsController extends BaseController{
	private final Logger log = LoggerFactory.getLogger(OrderStatsController.class);
	
	@Autowired
	private OrderService orderService;
	
	/**
	 *跳转订单统计页面
	 */
	@RequestMapping("/to_order_stats")
	public ModelAndView toorderStats(HttpServletRequest request){
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		request.setAttribute("month", month);
		request.setAttribute("year", year);
		return new ModelAndView("backstage/base/orderstats/order_stats");
	}
	/**
	 * 查询订单统计数据
	 */
	@RequestMapping("/query_order_stats")
	public void queryorderStats(HttpServletResponse response,OrderStatsView orderStats){
		Json j = new Json();
		try {
			List<OrderStatsView> orderStatsList = orderService.queryOrderStats(orderStats);
			j.setSuccess(true);
			j.setObj(orderStatsList);
			j.setMsg("查询统计数据成功!");
		} catch (Exception e) {
			log.error("查询统计数据失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询统计数据失败！");
		}
		super.writeJson(j,response);
	}

}
