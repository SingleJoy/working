package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_base;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.service.ResourceArrangeService;
import cn.bnsr.edu_yun.frontstage.resource.view.ResourceArrangeView;

@Controller
@RequestMapping("my_resource_arrange")

public class ResourceArrangeController {
	 private String  start=null;
	 private String end=null;
	 private int state=0;
	@Autowired
	private ResourceArrangeService resourceArrangeService;
	@Autowired
	private File_baseService fileBaseService;
	@Autowired
	private UserService userService;
	@Autowired
	private UserInfoService userInfoService;
	@RequestMapping("/goResourcesRank")
	public String goResourcesRank(){
		return "resources_rank";
	}
	@RequestMapping("/showResourceArrange")
	
	public ModelAndView showResourceArrange(HttpServletRequest request){
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		long userId = Integer.parseInt(request.getParameter("userId"));
		int columnId =Integer.parseInt(request.getParameter("columnId")) ;//栏目id
		int secondary = Integer.parseInt(request.getParameter("secondary")) ;//次级目录id
		int section = Integer.parseInt(request.getParameter("section"));//时间段
		 start=request.getParameter("start");
		 end=request.getParameter("end");
		 
		ResourceArrangeView  resourceArrangeView = new ResourceArrangeView();
		resourceArrangeView.setStart(start);
		resourceArrangeView.setEnd(end);
		Calendar now2 = Calendar.getInstance(); 
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
		String nowTime = dateFormat.format(now);//格式化当前时间
		if(section==0&&"".equals(start)&&"".equals(end)){

			resourceArrangeView.setStart(null);
			resourceArrangeView.setEnd(null);
		}
		resourceArrangeView.setUserId(userId);

		
		if(section!=0&&"".equals(start)&&"".equals(end)){
			
			now2.setTime(now);
			now2.set(Calendar.DATE, now2.get(Calendar.DATE) - section);//获取前？天的时间
		
			resourceArrangeView.setStart(dateFormat.format(now2.getTime()));
			resourceArrangeView.setEnd(nowTime);
		}else if(!"".equals(start)&&"".equals(end)){
			end=nowTime;
			resourceArrangeView.setStart(start);
			resourceArrangeView.setEnd(nowTime);
		}
		
		System.out.println(resourceArrangeView.getEnd()+"ggggggggg");
		resourceArrangeView.setColumnId(columnId);
		resourceArrangeView.setSecondary(secondary);
		List<ResourceArrangeView> list = resourceArrangeService.showResourceArrange(resourceArrangeView);
		for(ResourceArrangeView r:list){
			Calendar calendar =Calendar.getInstance();
			calendar.setTime(r.getUploadTime());
			r.setTime(String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE)));
		}
		User user = (User) request.getSession().getAttribute("currentUser");
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
	    request.setAttribute("user", user);
	    request.setAttribute("userProperty", userProperty);
	    request.setAttribute("userInfo", userInfo);
		request.setAttribute("section", section);
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		request.setAttribute("secondary", secondary);
		request.setAttribute("columnId", columnId);
		request.setAttribute("ResourceArrange", list);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontstage/base/personalCenter/resources_rank");
		
		
		return modelAndView;
	}
@RequestMapping("/showResourceArrangeJson")
@ResponseBody
	public JSONArray showResourceArrangeJson(HttpServletRequest request){
	long userId = Integer.parseInt(request.getParameter("userId"));
	int columnId =Integer.parseInt(request.getParameter("columnId")) ;//栏目id
	int secondary = Integer.parseInt(request.getParameter("secondary")) ;//次级目录id
	int section = Integer.parseInt(request.getParameter("section"));//时间段
	 
	 
	ResourceArrangeView  resourceArrangeView = new ResourceArrangeView();
	Calendar now2 = Calendar.getInstance(); 
	Date now = new Date();
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
	String nowTime = dateFormat.format(now);//格式化当前时间
	resourceArrangeView.setStart(start);
	resourceArrangeView.setEnd(end);
	
	if(section!=0&&"".equals(start)&&"".equals(end)){
		
		now2.setTime(now);
		now2.set(Calendar.DATE, now2.get(Calendar.DATE) - section);//获取前？天的时间
	
		resourceArrangeView.setStart(dateFormat.format(now2.getTime()));
		resourceArrangeView.setEnd(nowTime);
	}else if(!"".equals(start)&&!"".equals(end)){
		resourceArrangeView.setStart(start);
		resourceArrangeView.setEnd(nowTime);
	}
	    resourceArrangeView.setUserId(userId);
		resourceArrangeView.setColumnId(columnId);
		resourceArrangeView.setSecondary(secondary);
		List<ResourceArrangeView> list = resourceArrangeService.showResourceArrange(resourceArrangeView);
		for(ResourceArrangeView r:list){
			Calendar calendar =Calendar.getInstance();
			calendar.setTime(r.getUploadTime());
			r.setTime(String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE)));
		}
		
		JSONArray jsonArray = JSONArray.fromObject(list);
		
		
		
		
		return jsonArray;
	}
   @RequestMapping("delete")
   public ModelAndView delete(HttpServletRequest request){
	   long id = Integer.parseInt(request.getParameter("id"));
	   long userId = Integer.parseInt(request.getParameter("userId"));
		int columnId =Integer.parseInt(request.getParameter("columnId")) ;//栏目id
		
		int secondary = Integer.parseInt(request.getParameter("secondary")) ;//次级目录id
		int section = Integer.parseInt(request.getParameter("section"));//时间段
		start=request.getParameter("start");
		 end=request.getParameter("end");
		  File_base fileBase = new File_base();
		  fileBase.setId(id);
		  long count = 0;
		  fileBase.setUpload_user(count);
		 fileBaseService.update(fileBase);
		 ModelAndView modelAndView = new ModelAndView();
		 modelAndView.setViewName("redirect:/my_resource_arrange/showResourceArrange.action?userId="+userId+"&columnId="+columnId
				 +"&secondary="+secondary+"&section="+section+"&start="+start+"&end="+end);
	   return modelAndView;
   }

}
