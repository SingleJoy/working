package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.MyContributionService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserPropertyService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.MyContributionView;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.File_catalogService;
import cn.bnsr.edu_yun.util.NumUtil;

/**
 * 我的贡献Controller
 * @author apple
 *
 */
@Controller
@RequestMapping("/my_contribution")
public class MyContributionController {
	
	private int state = 0;
	@Autowired
	private File_baseService file_baseService;
	@Autowired
	private MyContributionService myContributionService;
	@Autowired 
	private UserFileService userFile;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private File_catalogService file_catalogService;
	@Autowired
	private UserPropertyService userPropertyService;
	@RequestMapping("/goMyresources")
	public String goMyresources(){
		return "frontstage/base/personalCenter/my_contribution";
	}
	@RequestMapping("/showMyContribution")
	
	public ModelAndView  showMyContribution(HttpServletRequest request){
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		User user = (User) request.getSession().getAttribute("currentUser");
		
		long userId = user.getId();
		int fileType =Integer.parseInt(request.getParameter("fileType")) ;
		MyContributionView myContributionView = new MyContributionView();
		myContributionView.setUserId(userId);
		myContributionView.setStatus(0);
		if(fileType==4){
			myContributionView.setStatus(1);
		}
		if(fileType==5){
			myContributionView.setStatus(2);
		}
		if(fileType==6){
			myContributionView.setStatus(3);
		}
		
		myContributionView.setFileType(fileType);
		
		int page = Integer.parseInt(request.getParameter("page"));

		myContributionView.setRows(8);
		myContributionView.setPage(page);
		if(myContributionView.getPage()==0){
			myContributionView.setStartLine(0);
		}else{
			myContributionView.setStartLine(myContributionView.getPage()*myContributionView.getRows());
			
		}
		
		int total = myContributionService.queryTotalContribution(myContributionView);
		
		myContributionView.setTotal(total);
		myContributionView.setTotalPage(NumUtil.totalPage(total,8));
		
		List<MyContributionView> list = myContributionService.showMyContribution(myContributionView);
		for(MyContributionView m:list){
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(m.getUploadTime());
			String upload = String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE));
			m.setTime(upload);
			if(m.getCheckTime()!=null){
				calendar.setTime(m.getCheckTime());
				String check = String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE));
				m.setCheck(check);
			}
			if(m.getDeleteTime()!=null){
				calendar.setTime(m.getDeleteTime());
				String delete = String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE));
				m.setDelete(delete);
				
			}

		}
		
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
	    request.setAttribute("user", user);
	    request.setAttribute("userProperty", userProperty);
	    request.setAttribute("userInfo", userInfo);
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		request.setAttribute("fileType", fileType);
		request.setAttribute("Contribution", list);
		
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("myContributionView", myContributionView);
		modelAndView.setViewName("frontstage/base/personalCenter/my_contribution");
		return modelAndView;
	}
	
	@RequestMapping("/deteles")
	public ModelAndView deletes(HttpServletRequest request){
    User user = (User) request.getSession().getAttribute("currentUser");
   
		long userId = user.getId();
		int fileType =Integer.parseInt(request.getParameter("fileType")) ;
		int page =Integer.parseInt(request.getParameter("page")) ;
		String ids = request.getParameter("ids");
		String[] id=ids.split(",");
		for(String s:id){
			long count = Integer.parseInt(s);
			File_catalog file_catalog = file_catalogService.selectById(file_baseService.selectById(count).getCatalog_id());
			if(file_catalog.getType()==1){
				File_base fileBase = new File_base();
				fileBase.setId(count);
				byte status = 3;
				fileBase.setStatus(status);
				fileBase.setDelete_time(new Date());
				file_baseService.update(fileBase);
				UserProperty userProperty =userPropertyService.showUserProperty(userService.selectByPrimaryKey(userId).getProperty_id());
				UserProperty userProperty2 = new UserProperty();
				userProperty2.setUpload_count(userProperty.getUpload_count()-1);
				userProperty2.setId(userProperty.getId());
				userPropertyService.updateUserProperty(userProperty2);
			}
			if(file_catalog.getType()==2){
				File_base fileBase = new File_base();
				fileBase.setId(count);
				byte status = 3;
				fileBase.setStatus(status);
				file_baseService.update(fileBase);
				UserProperty userProperty =userPropertyService.showUserProperty(userService.selectByPrimaryKey(userId).getProperty_id());
				UserProperty userProperty2 = new UserProperty();
				userProperty2.setUpload_count(userProperty.getUpload_count()-1);
				userProperty2.setPublic_file_count(userProperty.getPublic_file_count()-1);
				userProperty2.setId(userProperty.getId());
				userPropertyService.updateUserProperty(userProperty2);
			}
			if(file_catalog.getType()==3){
				File_base fileBase = new File_base();
				fileBase.setId(count);
				byte status = 3;
				fileBase.setStatus(status);
				file_baseService.update(fileBase);
				UserProperty userProperty =userPropertyService.showUserProperty(userService.selectByPrimaryKey(userId).getProperty_id());
				UserProperty userProperty2 = new UserProperty();
				userProperty2.setUpload_count(userProperty.getUpload_count()-1);
				userProperty2.setPrivate_file_count(userProperty.getPrivate_file_count()-1);
				userProperty2.setId(userProperty.getId());
				userPropertyService.updateUserProperty(userProperty2);
			}
			
			
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/my_contribution/showMyContribution.action?state=1&fileType="+fileType+"&page="+page);
		return modelAndView;
	}

}
