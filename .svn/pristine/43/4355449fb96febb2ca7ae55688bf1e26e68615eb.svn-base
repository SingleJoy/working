package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.Classification_entryService;
import cn.bnsr.edu_yun.frontstage.base.service.MyCollectService;
import cn.bnsr.edu_yun.frontstage.base.service.UserFileService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.MyCollectView;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.util.NumUtil;

@Controller
@RequestMapping("my_collect")
public class MyCollectController {
	private int state = 0;
	@Autowired
	private MyCollectService my_collectService;
	@Autowired
	private UserService userService;
	@Autowired
	private Classification_entryService classification_entryService;
	@Autowired
	private UserFileService userFileService;
	@Autowired
	private File_baseService file_baseService;
	@Autowired
	private UserInfoService userInfoService;
	@RequestMapping("goMyCollect")
	public String goMyCollect(){
		return"my_collection";
	}
	@RequestMapping("/showCollect")
	
	public ModelAndView  showCollect(HttpServletRequest request){
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		 User user = (User) request.getSession().getAttribute("currentUser");
		 long userId = user.getId();
		MyCollectView myCollectView = new MyCollectView();
		myCollectView.setUserId(userId);
		int page = Integer.parseInt(request.getParameter("page"));
		myCollectView.setRows(8);
		myCollectView.setPage(page);
		if(myCollectView.getPage()==0){
			myCollectView.setStartLine(0);
		}else{
			myCollectView.setStartLine(myCollectView.getPage()*myCollectView.getRows());
			
		}
		
		int total = my_collectService.queryTotalContribution(myCollectView);
		
		myCollectView.setTotal(total);
		myCollectView.setTotalPage(NumUtil.totalPage(total,8));
		
		
		
		List<MyCollectView> list = my_collectService.showCollert(myCollectView);
		for(MyCollectView m: list){
			
			m.setUploaderName(userService.selectByPrimaryKey(m.getUpload_user()).getUsername());
		
		}
        for(MyCollectView m: list){
//        	if(m.getCatalogId().length()==14){
//				Classification_entry entry = new Classification_entry();
//				
//				entry.setId(m.getCatalogId());
//				m.setGrade(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//			}
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(m.getCollectTime());
			String CollectTime = String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE));
			m.setTime(CollectTime);
		}
       
//        List<User_file> user_files = userFileService.selectFileByUser(userId);
//        for(User_file u:user_files){
//        	
//        	if(file_baseService.selectById(u.getFile_id())==null){
//        		userFileService.delete(u.getId());
//        	}
//        }
       
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
	    request.setAttribute("user", user);
	    request.setAttribute("userProperty", userProperty);
	    request.setAttribute("userInfo", userInfo);
	    request.setAttribute("state", state);
	    request.setAttribute("stamp", stamp);
        request.setAttribute("collect", list);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("frontstage/base/personalCenter/my_collection");
        modelAndView.addObject("myCollectView", myCollectView);
		return modelAndView;
	}
	@RequestMapping("/delete")
	public ModelAndView delete(HttpServletRequest request){
		long userId = Integer.parseInt(request.getParameter("userId"));
		long id = Integer.parseInt(request.getParameter("id"));
		userFileService.delete(id);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/my_collect/showCollect.action?userId="+userId);
		return modelAndView;
	}
	@RequestMapping("/deletes")
	public ModelAndView deletes(HttpServletRequest request){
//		User user = (User) request.getSession().getAttribute("currentUser");
//		 long userId = user.getId();
		 int page = Integer.parseInt(request.getParameter("page"));
		String ids = request.getParameter("ids");
		String[] id=ids.split(",");
		for(String s:id){
			userFileService.delete(Integer.parseInt(s));
		}
		//userFile.delete(id);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/my_collect/showCollect.action?state=2&page="+page);
		return modelAndView;
	}

}
