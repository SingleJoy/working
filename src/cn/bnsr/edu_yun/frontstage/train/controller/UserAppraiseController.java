package cn.bnsr.edu_yun.frontstage.train.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserAppraiseReason;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.util.ResponseUtil;

/**
 * 用户评价相关  0-课程；1-培训；2- 班级
 * @author fangxiongwei
 * @date 2017年1月19日
 */
@Controller
@RequestMapping("user_appraise")
public class UserAppraiseController {
	private final Logger log = LoggerFactory.getLogger(UserAppraiseController.class);
	
	@Autowired
	private UserAppraiseService userAppraiseService;
	
	/**
	 * 进行评价
	 * @param appraise
	 * @param response
	 * @param request
	 * @throws Exception 
	 */
	@RequestMapping("/appraise")
	public void appraise(UserAppraise userAppraise,HttpServletResponse response,HttpServletRequest request,String reason) throws Exception{
		
		 HttpSession session=request.getSession();
	     User user=(User) session.getAttribute("currentUser");
		
	     userAppraise.setAppraise_time(new Date());
	     userAppraise.setUser_id(user.getId());
	   
		if(userAppraise.getId()==null){//新增评价
			UserAppraise userAppraise1= userAppraiseService.selectByCourseIdAndUserId(user.getId(), userAppraise.getSource_id(), userAppraise.getSource_type());
			if(userAppraise1==null){
			userAppraiseService.insertAppraise(userAppraise);
			 String strs[]=reason.split(",");
			 for(String strId:strs){
				 UserAppraiseReason userAppraiseReason=new UserAppraiseReason();
				 userAppraiseReason.setUser_appraise_id(userAppraise.getId());
				 userAppraiseReason.setAppraise_reason_id(Long.parseLong(strId));
				 userAppraiseReason.setUser_id(user.getId());
				 userAppraiseService.insertAppraiseReason(userAppraiseReason);
			 }
			}
			else{
				userAppraise.setId(userAppraise1.getId());
				userAppraiseService.updateAppraise(userAppraise);
			}
			
		}else{//修改评价
			
			userAppraiseService.updateAppraise(userAppraise);
			
		}
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	 result.put("userAppraise", userAppraise);
    	 ResponseUtil.write(response, result);
     
	}
	@RequestMapping("/appraise_m")
	public void appraiseM(UserAppraise userAppraise,HttpServletResponse response,HttpServletRequest request,String reason) throws Exception{
		userAppraise.setAppraise_time(new Date());
	  if(userAppraise.getId()==null){//新增评价
			UserAppraise userAppraise1= userAppraiseService.selectByCourseIdAndUserId(userAppraise.getUser_id(), userAppraise.getSource_id(), userAppraise.getSource_type());
			if(userAppraise1==null){
			userAppraiseService.insertAppraise(userAppraise);
			 String strs[]=reason.split(",");
			 for(String strId:strs){
				 UserAppraiseReason userAppraiseReason=new UserAppraiseReason();
				 userAppraiseReason.setUser_appraise_id(userAppraise.getId());
				 userAppraiseReason.setAppraise_reason_id(Long.parseLong(strId));
				 userAppraiseReason.setUser_id(userAppraise.getUser_id());
				 userAppraiseService.insertAppraiseReason(userAppraiseReason);
			 }
			}
			else{
				userAppraise.setId(userAppraise1.getId());
				userAppraiseService.updateAppraise(userAppraise);
			}
			
		}else{//修改评价
			
			userAppraiseService.updateAppraise(userAppraise);
			
		}
		 JSONObject result=new JSONObject();
    	 result.put("msg", true);
    	 result.put("userAppraise", userAppraise);
    	 ResponseUtil.write(response, result);
     
	}
}
