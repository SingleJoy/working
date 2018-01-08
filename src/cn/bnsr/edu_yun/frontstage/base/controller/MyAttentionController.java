package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.UserSupport;
import cn.bnsr.edu_yun.frontstage.base.po.User_attent;
import cn.bnsr.edu_yun.frontstage.base.service.MyAttentionService;
import cn.bnsr.edu_yun.frontstage.base.service.UserAttentService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserPropertyService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.service.UserSupportService;
import cn.bnsr.edu_yun.frontstage.base.view.MyAttentionView;
import cn.bnsr.edu_yun.frontstage.base.view.UserCenterView;
import cn.bnsr.edu_yun.util.NumUtil;

/**
 * 我的关注controller
 * @author apple
 *
 */
@Controller
@RequestMapping("my_attention")
public class MyAttentionController {
	@Autowired
	private MyAttentionService myAttentionService;
	@Autowired
	private UserAttentService userAttentService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserSupportService userSupportService;
	@Autowired
	private UserPropertyService userPropertyService;
	private int state = 0;
	
	
	@RequestMapping("/showMyAttention")
	public ModelAndView showMyAttention(HttpServletRequest request){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("head_title", "我的关注");
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		User user = (User) request.getSession().getAttribute("currentUser");
		int type = Integer.parseInt(request.getParameter("type"));
		Long userId = user.getId();
		//MyAttentionView myAttentionView = new MyAttentionView();
		User_attent user_attent = new User_attent();
		user_attent.setUser_id(userId);
		int page = Integer.parseInt(request.getParameter("page"));
		user_attent.setRows(10);
		user_attent.setPage(page);
		if(user_attent.getPage()==0){
			user_attent.setStartLine(0);
		}else{
			user_attent.setStartLine(user_attent.getPage()*user_attent.getRows());
			
		}
        int total = userAttentService.queryTotalAttention(userId);
        
		
        user_attent.setTotal(total);
        user_attent.setTotalPage(NumUtil.totalPage(total,10));
		List<User_attent> attents = userAttentService.myAttenation(user_attent);
		List<MyAttentionView> list = new ArrayList<MyAttentionView>();
		for(User_attent u:attents){
			MyAttentionView myAttentionView = new MyAttentionView();
			myAttentionView.setUserId(u.getAttent_user_id());
			myAttentionView.setSupport(0);
			myAttentionView.setTeacher(0);
			
			if(userInfoService.getByUserId(u.getAttent_user_id())!=null){
				myAttentionView.setTeacher(1);
				
			}

			UserSupport userSupport= new UserSupport();
			userSupport.setUser_id(userId);
			userSupport.setSupport_id(u.getAttent_user_id());
			userSupportService.showSupport(userSupport);
			if(userSupportService.showSupport(userSupport)!=null){
			
				UserSupport userS = userSupportService.showSupport(userSupport);

				if(userS!=null){
					
					myAttentionView.setSupport(1);				
	
			}
	}
			if(myAttentionService.showMyAttenation(myAttentionView)!=null){
				list.add(myAttentionService.showMyAttenation(myAttentionView));
			}
			
			
			
		}


		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
		request.setAttribute("userProperty", userProperty);
		
		request.setAttribute("myAttention", list);
		request.setAttribute("type", type);

		UserInfo userInfo = userInfoService.getByUserId(user.getId());
		request.setAttribute("user", user);
		request.setAttribute("userInfo", userInfo);
		//个人中心统计数据  
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		modelAndView.addObject("userCenter", userCenter);
		
	    request.setAttribute("state", state);
	    request.setAttribute("stamp", stamp);
		modelAndView.addObject("userAttent",user_attent);
		modelAndView.setViewName("frontstage/base/personalCenter/my-concern");
		
		return modelAndView;
	}
	
	@RequestMapping("/showMyFans")
	public ModelAndView showMyFans(HttpServletRequest request){
		
		User user = (User) request.getSession().getAttribute("currentUser");
		int type = Integer.parseInt(request.getParameter("type"));
		Long userId = user.getId();
		User_attent user_attent = new User_attent();
		user_attent.setUser_id(userId);
		int page = Integer.parseInt(request.getParameter("page"));
		user_attent.setRows(10);
		user_attent.setPage(page);
		if(user_attent.getPage()==0){
			user_attent.setStartLine(0);
		}else{
			user_attent.setStartLine(user_attent.getPage()*user_attent.getRows());
			
		}
        int total = userAttentService.queryTotalFans(userId);
        
        
		
        user_attent.setTotal(total);
        user_attent.setTotalPage(NumUtil.totalPage(total,10));
		
		List<User_attent> fans = userAttentService.myFans(user_attent);
		List<MyAttentionView> list = new ArrayList<MyAttentionView>();
		for(User_attent u:fans){
			MyAttentionView myAttentionView = new MyAttentionView();
			myAttentionView.setUserId(u.getUser_id());
			myAttentionView.setSupport(0);
			myAttentionView.setTeacher(0);
			
			if(userInfoService.getByUserId(u.getUser_id())!=null){
				myAttentionView.setTeacher(1);
				
			}
			UserSupport userSupport= new UserSupport();
			userSupport.setUser_id(userId);
			userSupport.setSupport_id(u.getUser_id());
			userSupportService.showSupport(userSupport);
			if(userSupportService.showSupport(userSupport)!=null){
			
				UserSupport userS = userSupportService.showSupport(userSupport);

				if(userS!=null){
					myAttentionView.setSupport(1);				
	
			}
	}
			if(myAttentionService.showMyAttenation(myAttentionView)!=null){
				list.add(myAttentionService.showMyAttenation(myAttentionView));
			}
			
			
		}


		
		UserCenterView userCenter = userService.queryUserCenter(user.getId());
		request.setAttribute("userCenter", userCenter);
		
		request.setAttribute("myFans", list);
		request.setAttribute("type", type);
		request.setAttribute("state", state);
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
	    request.setAttribute("user", user);
	    request.setAttribute("userProperty", userProperty);
	    request.setAttribute("userInfo", userInfo);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("userAttent", user_attent);
		modelAndView.addObject("head_title", "我的粉丝");
		modelAndView.setViewName("frontstage/base/personalCenter/my-concern");
		
		return modelAndView;
	}
	@RequestMapping("/dzMyAttention")
	public ModelAndView dzMyAttention(HttpServletRequest request){
		User user = (User) request.getSession().getAttribute("currentUser");
		Long userId = user.getId();
		int page = Integer.parseInt(request.getParameter("page"));
		int type = Integer.parseInt(request.getParameter("type"));
		if(request.getParameter("dz")!=null){
			long dz = Integer.parseInt(request.getParameter("dz"));
			UserSupport userSupport4= new UserSupport();
			userSupport4.setUser_id(userId);
			userSupport4.setSupport_id(dz);
			userSupportService.showSupport(userSupport4);
			if(userSupportService.showSupport(userSupport4)!=null){
				boolean falg = false;
				UserSupport userS = userSupportService.showSupport(userSupport4);
				

				if(userS!=null){
					falg = true;		
	
			}
				
				if(!falg){
					
						UserSupport userSupport = new UserSupport();
						userSupport.setUser_id(userId);
						userSupport.setSupport_id(dz);

						//UserProperty userProperty2 = new UserProperty();
						UserProperty userProperty3 = new UserProperty();
						User user2 = userService.selectByPrimaryKey(dz);
						UserProperty userProperty = userPropertyService.showUserProperty(user2.getProperty_id());
						userProperty3.setId(userProperty.getId());
						userProperty3.setAgree_count(userProperty.getAgree_count()+1);
						userPropertyService.updateUserProperty(userProperty3);
						
						//userPropertyService.updateUserProperty(userProperty2);
						
						userSupportService.insertSupport(userSupport);
					
				}
				
			}
			else{
				UserSupport userSupport = new UserSupport();
				userSupport.setUser_id(userId);
				userSupport.setSupport_id(dz);

//				UserProperty userProperty2 = new UserProperty();
				UserProperty userProperty3 = new UserProperty();
				User user2 = userService.selectByPrimaryKey(dz);
				UserProperty userProperty = userPropertyService.showUserProperty(user2.getProperty_id());
				userProperty3.setId(userProperty.getId());
				userProperty3.setAgree_count(userProperty.getAgree_count()+1);
				userPropertyService.updateUserProperty(userProperty3);
				
//				userPropertyService.updateUserProperty(userProperty2);
				
				userSupportService.insertSupport(userSupport);
			}
			
			
		}
		ModelAndView modelAndView = new ModelAndView();
		if(type==1){
			modelAndView.setViewName("redirect:/my_attention/showMyAttention.action?type="+type+"&page="+page);
		}else{
			modelAndView.setViewName("redirect:/my_attention/showMyFans.action?type="+type+"&page="+page);
		}
		
		return modelAndView;
	}
	

}