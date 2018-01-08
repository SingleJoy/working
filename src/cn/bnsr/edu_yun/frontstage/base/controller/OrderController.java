package cn.bnsr.edu_yun.frontstage.base.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.Order;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_business_log;
import cn.bnsr.edu_yun.frontstage.base.service.BusinessLogService;
import cn.bnsr.edu_yun.frontstage.base.service.OrderService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.User_file;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ResponseUtil;
/**
 * 订单Controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping("order")
public class OrderController {
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private BusinessLogService businessLogService;
	@Autowired
	private File_baseService  file_baseService;
	@Autowired
	private UserFileService userFileService;
	private int state = 0;
	/**
	 * 跳转到我的订单
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/goOrder")
	public ModelAndView	goOrder(HttpServletRequest request,HttpServletResponse response){
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		int 	pageSize= Integer.parseInt(request.getParameter("pageSize"));
		int	pageNo= Integer.parseInt(request.getParameter("pageNo"));
	    int totalPage=0;
		HttpSession session=request.getSession();
	User user=(User) session.getAttribute("currentUser");
	ModelAndView modelAndView = new ModelAndView();
	if(user!=null){
		 int total=orderService.selectByUserIdCount(user.getId()).size();
		    if(total%pageSize==0){
		  		  totalPage=total/pageSize;
		  	 }else{
		  		 totalPage=(total/pageSize)+1;
		  	 }
		  	 int start=(pageNo)*pageSize;
		System.out.println("用户ID"+user.getId());
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
		String success=request.getParameter("is_success");
		List<Order> orders = null;
		if(success==null){
			 orders=orderService.selectByUserId(user.getId(),  start, pageSize);
		}
		else{
			int is_success=Integer.parseInt(success);
			total=orderService.selectByUserIdSuccessCount(user.getId(), is_success).size();
			orders=orderService.selectByUserIdSuccess(user.getId(), is_success,start, pageSize);
		}
		
		modelAndView.addObject("success",success);
		modelAndView.addObject("orders",orders);
		modelAndView.addObject("user", user);
		modelAndView.addObject("pageNo", pageNo);
		modelAndView.addObject("pageSize", pageSize);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("total", total);
		modelAndView.addObject("userProperty",userProperty);
		modelAndView.addObject("userInfo",userInfo);
	}
		
	    request.setAttribute("state", state);
	    request.setAttribute("stamp", stamp);
		modelAndView.setViewName("frontstage/base/personalCenter/my_order");
		return modelAndView;
		
	}
	/**
	 * 删除我的订单
	 * @param request
	 * @param response
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteOrder")
	public String deleteOrder(HttpServletRequest request,HttpServletResponse response, String ids) throws Exception{
		
		String[] idList=ids.split(",");
		for(String id:idList){
			long order_id=Long.parseLong(id);
			orderService.deleteOrder(order_id);
			System.out.println("取消订单"+order_id);
		}
		
	
		JSONObject result=new JSONObject();
		ResponseUtil.write(response, result);
		return null;
		
		
		
	}
	/**
	 * 从我的订单跳转到支付
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/to_order")
	public	ModelAndView to_order(HttpServletRequest request,HttpServletResponse response, String id) throws Exception{
		long order_id=Long.parseLong(id);
		Order order=orderService.selectById(order_id);
		File_base fileBase=file_baseService.selectById(order.getBuy_id());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("order", order);
		modelAndView.addObject("fileBase", fileBase);
		modelAndView.setViewName("frontstage/base/pay");
	
		return modelAndView;
		
		
		
	}
	/**
	 * 支付订单
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/submitOrder")
	public String submitOrder(HttpServletRequest request,HttpServletResponse response, String id) throws Exception{
		long order_id=Long.parseLong(id);
		Order order=orderService.selectById(order_id);
		JSONObject result=new JSONObject();
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		
		User_file buyFile=userFileService.selectBuyFile(user.getId(), order.getBuy_id());
		if(buyFile!=null){
			result.put("msg", "已经支付过了");
		}
		else{
		if(user.getWealth()>order.getAmount()){
		order.setStatus(2);
		order.setCreate_time(new Date());
		orderService.updateOrder(order);
		double wealth=user.getWealth()-order.getAmount();
		user.setWealth(wealth);
		
		String weath_to_score= ConfigInfo.getString("weath_to_score");
		double amount=order.getAmount();//倍数
		long amount_score=(long)amount*Long.parseLong(weath_to_score);
		long score=0;
		if(user.getScore()!=null){
			score=user.getScore();
		}
		user.setScore(amount_score+score);
		userService.updateUser(user);
		
		File_base fileBase=file_baseService.selectById(order.getBuy_id());
		User file_user=userService.selectByUserId(fileBase.getUpload_user());
		file_user.setWealth(file_user.getWealth()+order.getAmount());
		userService.updateUser(file_user);
		
		User_business_log log=new User_business_log();
		log.setUser_id(user.getId());
		Date date=new Date();
		SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String time=formater.format(date);
		log.setOperation_time(time);
		log.setOperation_description("购买了文件 "+fileBase.getFilename()+" 增加了"+amount_score+"积分" );
		byte type1=2;
		log.setType(type1);
		long value=amount_score;
		log.setValue((double)value);
		long total=user.getScore();
		log.setTotal_value((double)total);
		businessLogService.insert(log);
		
		log.setUser_id(user.getId());
	    log.setOperation_time(time);
		log.setOperation_description("购买文件");
		byte type2=1;
		log.setType(type2);
		log.setValue(0-amount);
		double total1=user.getWealth();
		log.setTotal_value(total1);
		businessLogService.insert(log);
		
		log.setUser_id(file_user.getId());
	    log.setOperation_time(time);
		log.setOperation_description("售出文件");
	
		log.setType(type2);
		log.setValue(amount);
	    double total2=file_user.getWealth();
		log.setTotal_value(total2);
		businessLogService.insert(log);
		
		User_file userFile=new User_file();
		userFile.setFile_id(order.getBuy_id());
		userFile.setUser_id(user.getId());
		userFile.setTime(date);
		byte userFileType=4;
		userFile.setType(userFileType);
		userFileService.insert(userFile);
		
		System.out.println("提交订单"+order_id);
		result.put("msg", "支付成功");
		}else{
			result.put("msg", "支付失败，金额不足");
		}
		}
		ResponseUtil.write(response, result);
		return null;
		
		
		
	}
	/**
	 * 取消订单
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cancelOrder")
	public String cancelOrder(HttpServletRequest request,HttpServletResponse response, String id) throws Exception{
		long order_id=Long.parseLong(id);
		Order order=orderService.selectById(order_id);
		JSONObject result=new JSONObject();
		order.setStatus(0);
		orderService.updateOrder(order);
		
		ResponseUtil.write(response, result);
		return null;
		
		
		
	}
	/**
	 * 生成订单
	 */
	@RequestMapping("/addOrder")
	public ModelAndView addOrder(HttpServletRequest request,HttpServletResponse response,String fileBase_id) throws Exception{
		
		long file_id=Long.parseLong(fileBase_id);
		
		File_base fileBase=file_baseService.selectById(file_id);
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		
		Order order=new Order();
		Date date=new Date();
		order.setCreate_time(date);
		order.setBuy_id(file_id);
		order.setUser_id(user.getId());
		order.setAmount(fileBase.getValue());
		order.setStatus(1);
		long time=date.getTime();
		Random ra =new Random();
		String num=time+"";
		for(int i=0;i<6;i++){
			num+=ra.nextInt(10);
		}
		//long order_number=Long.parseLong(num);
		order.setNumber(num+"");
		orderService.insertOrder(order);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("order", order);
		modelAndView.addObject("fileBase", fileBase);
		modelAndView.addObject("head_title", "生成订单");
		modelAndView.setViewName("frontstage/base/pay");
		return modelAndView;
		
		
	}
	
	
	public static void main(String[] args) {
		Random ran=new Random();
		String dd = Math.abs(ran.nextLong())+"";
		System.out.println(dd.length());//订单号
	}
}
