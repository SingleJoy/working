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

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.OrderView;
import cn.bnsr.edu_yun.frontstage.base.po.Order;
import cn.bnsr.edu_yun.frontstage.base.service.OrderService;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 订单管理
 * @author liyajun
 * @date 2016年10月14日
 */
@Controller
@RequestMapping("/back_order")
public class BackOrderController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BackOrderController.class);
	@Autowired
	private OrderService orderService;

	/**
	 *跳转订单页面
	 */
	@RequestMapping("/to_order")
	public ModelAndView to_order(HttpServletRequest request) {
		
		return new ModelAndView("backstage/base/order/order");
	}
	/**
	 *跳转订单页面
	 */
	@RequestMapping("/to_order_edit")
	public ModelAndView to_order_edit(HttpServletRequest request) {
		
		return new ModelAndView("backstage/base/order/order_edit");
	}
	/**
	 * 用户datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletResponse response,OrderView orderView) {
		
	    List<Order> orderList=null;	
	    String username=orderView.getUsername();
		String order_number=orderView.getOrder_number();
		int page=orderView.getPage();
		int rows=orderView.getRows();
		String sort=orderView.getSort(); 
		String order=orderView.getOrder();
		if(username==null){
			username="";
		}
		if(order_number==null){
			order_number="";
		}
	    int start=rows*(page-1);
		if(sort.equals("create_time")){
			if(order.equals("desc"))
			orderList=orderService.selectAllByTime("%"+username+"%","%"+order_number+"%",start,rows);
			else
			orderList=orderService.selectAllByTimeASC("%"+username+"%","%"+order_number+"%",start,rows);
		}
		if(sort.equals("transaction_amount")){
			if(order.equals("desc"))
				orderList=orderService.selectAllByAmount("%"+username+"%","%"+order_number+"%",start,rows);
				else
			    orderList=orderService.selectAllByAmountASC("%"+username+"%","%"+order_number+"%",start,rows);
			}
		DataGrid j = new DataGrid();
		j.setRows(orderList);
		long total=orderService.selectAll().size();
		j.setTotal(total);
		super.writeJson(j,response);
	}
	/**
	 *删除
	 */
	@RequestMapping("/delete_order")
	public void delete_order(HttpServletResponse response,String ids ) {
		Json j = new Json();
		String[] idsList=ids.split(",");
		for(String id:idsList){
			if(id!=null&&!id.trim().equals("")){
				try{
				orderService.delete(Long.parseLong(id));
				j.setSuccess(true);
				j.setMsg("删除成功！");
				}catch (Exception e) {
					log.error("订单删除失败",ExceptionUtil.getExceptionMessage(e));
					j.setMsg("删除失败！");
				}
			}
		}
		super.writeJson(j,response);
	}
	/**
	 *修改
	 */
	@RequestMapping("/edit_order")
	public void edit_order(HttpServletResponse response,Order order ) {
		Json j = new Json();
		try{
			orderService.update(order);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		}catch (Exception e) {
			log.error("订单编辑失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("编辑失败！");
		}
		super.writeJson(j,response);
	}
}
