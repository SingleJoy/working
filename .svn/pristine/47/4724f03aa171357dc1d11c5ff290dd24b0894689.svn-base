package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.Notice;
import cn.bnsr.edu_yun.frontstage.base.po.Notification;
import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.NoticeService;
import cn.bnsr.edu_yun.frontstage.base.service.NotificationService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserPropertyService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("/attent")
public class UserAttentController {

	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserPropertyService userPropertyService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private NotificationService notificationService;
	@RequestMapping("/attent")
	public ModelAndView insert(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String userId=request.getParameter("user_id");
		long attent_user_id=Long.parseLong(userId);
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		JSONObject result=new JSONObject();
		if(user==null){
			result.put("msg", "请登录");
		}
		else{
		long user_id=user.getId();
		
		if(attent_user_id==user_id){
			result.put("msg", "不能关注自己");
		}
		else{
			//是否关注过了
			
			
			 User_attent	 userAttent	=	userAttentService.selectattent(user_id, attent_user_id);
			if(userAttent!=null){
				result.put("msg", "取消关注成功");
				UserProperty userProperty_user=userService.selectUserPropertyById(user.getProperty_id());
				userProperty_user.setAttent_count(userProperty_user.getAttent_count()-1);
				userService.updateProperty(userProperty_user);
				
				User attent=userService.selectByUserId(attent_user_id);
				UserProperty userProperty_attent=userService.selectUserPropertyById(attent.getProperty_id());
				userProperty_attent.setIs_attented_count(userProperty_attent.getIs_attented_count()-1);
				userService.updateProperty(userProperty_attent);
	     		userAttentService.delete(userAttent.getId());
	     		Notification notification=new Notification();
	     		Date date = new Date();
	    		notification.setIs_read(1);
	    		notification.setCreate_time(date);
	    		notification.setNotice_time(date);
	    		notification.setUser_id(attent_user_id);
	    		notification.setOther_user_id(user.getId());
	    		notification.setNotice_type_id(8);
	    		notificationService.insert(notification);
			}
			else{
				 userAttent=new User_attent();
			userAttent.setAttent_time(new Date());
			userAttent.setAttent_user_id(attent_user_id);
			
			userAttent.setUser_id(user_id);
			int i= userAttentService.insert(userAttent);
			
			UserProperty userProperty_user=userService.selectUserPropertyById(user.getProperty_id());
			userProperty_user.setAttent_count(userProperty_user.getAttent_count()+1);
			userService.updateProperty(userProperty_user);
			
			User attent=userService.selectByUserId(attent_user_id);
			UserProperty userProperty_attent=userService.selectUserPropertyById(attent.getProperty_id());
			userProperty_attent.setIs_attented_count(userProperty_attent.getIs_attented_count()+1);
			userService.updateProperty(userProperty_attent);
     		
			
			result.put("msg", "关注成功");
			Notification notification=new Notification();
     		Date date = new Date();
    		notification.setIs_read(1);
    		notification.setCreate_time(date);
    		notification.setNotice_time(date);
    		notification.setUser_id(attent_user_id);
    		notification.setOther_user_id(user.getId());
    		notification.setNotice_type_id(7);
    		notificationService.insert(notification);
		}
		}
		}
		
		ResponseUtil.write(response, result);
		
		
		return null;
		
	}

	@RequestMapping("/delete_attent")
	public ModelAndView delete_attent(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String userId=request.getParameter("user_id");
		long attent_user_id=Long.parseLong(userId);
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("currentUser");
		JSONObject result=new JSONObject();
		if(user==null){
//			result.put("msg", "请登录");
		}
		else{
		long user_id=user.getId();
		
		if(attent_user_id==user_id){
	//		result.put("msg", "不能关注自己");
		}
		else{
			//是否关注过了
			
			
			 User_attent	 userAttent	=	userAttentService.selectattent(user_id, attent_user_id);
			if(userAttent!=null){

				User user2 = userService.selectByUserId(userAttent.getUser_id());
				UserProperty userProperty = userPropertyService.showUserProperty(user2.getProperty_id());
				
				UserProperty userProperty2 = new UserProperty();
				userProperty2.setId(userProperty.getId());
				userProperty2.setAttent_count(userProperty.getAttent_count()-1);
				userService.updateProperty(userProperty2);
				
				User user3 = userService.selectByUserId(userAttent.getAttent_user_id());
				UserProperty userProperty3 = userPropertyService.showUserProperty(user3.getProperty_id());
				
				UserProperty userProperty4 = new UserProperty();
				userProperty4.setId(userProperty3.getId());
				
				userProperty4.setIs_attented_count(userProperty3.getIs_attented_count()-1);
				userService.updateProperty(userProperty4);

				userAttentService.delete(userAttent.getId());
				Notice notice = new Notice();
	     		Date now = new Date();
	     		notice.setTime(now);
	     		notice.setType(2);
	     		notice.setUser_id(attent_user_id);
	     		notice.setMessage(user.getUsername()+"取消了对您的关注");
	     		noticeService.insertNotice(notice);
				result.put("msg", "已经取消关注成功！");
				Notification notification=new Notification();
	     		Date date = new Date();
	    		notification.setIs_read(1);
	    		notification.setCreate_time(date);
	    		notification.setNotice_time(date);
	    		notification.setUser_id(attent_user_id);
	    		notification.setOther_user_id(user.getId());
	    		notification.setNotice_type_id(8);
	    		notificationService.insert(notification);
			}
			else{

			result.put("msg", "关注已取消");
		}
		}
		}
		
		ResponseUtil.write(response, result);
		
		
		return null;
		
	}
	
	
}
