package cn.bnsr.edu_yun.backstage.base.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

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
import cn.bnsr.edu_yun.backstage.base.view.UserView;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.User_business_log;
import cn.bnsr.edu_yun.frontstage.base.service.BusinessLogService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_wealth")
public class WealthController extends BaseController{

	private final Logger log = LoggerFactory.getLogger(WealthController.class);
	@Autowired
	private BusinessLogService businessLogService;
	@Autowired
	private UserService userService;
	/**
	 *跳转用户页面
	 */
	@RequestMapping("/to_wealth")
	public ModelAndView to_wealth(HttpServletRequest request,UserView userView) {
		String weath_to_score= ConfigInfo.getString("weath_to_score");
		request.setAttribute("weath_to_score", weath_to_score);
		return new ModelAndView("backstage/base/wealth/wealth");
	}
	@RequestMapping("/to_wealth_edit")
	public ModelAndView to_wealth_edit(HttpServletRequest request,UserView userView) {
		
		return new ModelAndView("backstage/base/wealth/wealth_edit");
	}
	@RequestMapping("/to_msg")
	public ModelAndView to_wealth_msg(HttpServletRequest request,String type,String id) {
		request.setAttribute("type", type);
		request.setAttribute("id", id);
		return new ModelAndView("backstage/base/wealth/wealth_msg");
	}
	@RequestMapping("/msg")
	public void msg(HttpServletResponse response,int id,int page,int rows,int type) {
		 int start=rows*(page-1);
		 List<User_business_log> logs=null;
		 long total=0;
		 if(type==1){
		 logs=businessLogService.selectWealthByUserId(id, start, rows);
		 total=businessLogService.selectWealthByUserIdCount(id).size();
		 }
		 if(type==2){
			 logs=businessLogService.selectScoreByUserId(id, start, rows);
			 total=businessLogService.selectScoreByUserIdCount(id).size();
		 }
		DataGrid j = new DataGrid();
		j.setRows(logs);
		
		  j.setTotal(total);
		super.writeJson(j,response);
	}
	@RequestMapping("/edit_wealth")
	public void edit_wealth(HttpServletResponse response,User_business_log business_log,String ids) {
		Json j = new Json();
		String[] idsList=ids.split(",");
		for(String id:idsList){
			if(id!=null&&!id.trim().equals("")){
				try{
					business_log.setUser_id(Long.parseLong(id));
					User user=userService.selectByUserId(Long.parseLong(id));
					if(business_log.getType()==1){
						user.setWealth(business_log.getValue()+user.getWealth());
						business_log.setTotal_value(user.getWealth());
					}
					if(business_log.getType()==2){
						double value=business_log.getValue();
						user.setScore((long)value+user.getScore());
						long score=user.getScore();
						business_log.setTotal_value((double)score);
					}
					Date date=new Date();
					SimpleDateFormat formater=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					String time=formater.format(date);
					business_log.setOperation_time(time);
					businessLogService.insert(business_log);
					userService.updateUser(user);
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
	
	@RequestMapping("/change")
	public void change(HttpServletRequest request,HttpServletResponse response,String weath_to_score) {
		Json j = new Json();
		Properties pro=new Properties();
		ClassLoader loader = WealthController.class.getClassLoader();
		InputStream in = loader.getResourceAsStream("config.properties");
		System.out.println(in);
		try {
			pro.load(in);
			in.close();
			pro.setProperty("weath_to_score",weath_to_score);
			FileOutputStream fos = new FileOutputStream(request.getSession().getServletContext().getRealPath("/WEB-INF/classes/config.properties"));
			pro.store(fos, "倍数修改");
			fos.close();
			j.setSuccess(true);
			j.setMsg("修改成功！");
			super.writeJson(j,response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
}
