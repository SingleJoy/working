package cn.bnsr.edu_yun.frontstage.base.controller;

import java.text.ParseException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.base.po.UserInfo;
import cn.bnsr.edu_yun.frontstage.base.po.UserProperty;
import cn.bnsr.edu_yun.frontstage.base.po.User_business_log;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.service.BusinessLogService;
import cn.bnsr.edu_yun.frontstage.base.service.MyResourcesService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.base.service.UserInfoService;
import cn.bnsr.edu_yun.frontstage.base.service.UserService;
import cn.bnsr.edu_yun.frontstage.base.view.MyResourcesView;
import cn.bnsr.edu_yun.frontstage.resource.service.File_baseService;
import cn.bnsr.edu_yun.frontstage.resource.view.ResourceView;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;

@Controller
@RequestMapping("my_resources")
public class MyResourcesController {
	public String columnId;
	@Autowired
	private MyResourcesService  myResourcesService;
	@Autowired
	private File_baseService  file_baseService;
	@Autowired
	private UserService userService;
	@Autowired
	private BusinessLogService businessLogService;
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private SubjectListService subjectListService;
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private BookCatService bookCatService;
	private int state = 0;
	
	@RequestMapping("/showMyResources")
	public ModelAndView showFile_base(HttpServletRequest request,HttpServletResponse response,ResourceView resourceView) throws ParseException{
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		String classification_entryId = null;
		String stage = null;
		String subject = null;
		String edition = null;
		String grade = null;
		if(!"".equals(request.getParameter("stage"))){
			stage = request.getParameter("stage");
			request.setAttribute("stageId", stage);
		}
		if(!"".equals(request.getParameter("subject"))){
			subject = request.getParameter("subject");
			request.setAttribute("subjectId", subjectListService.selectById(subject)==null?null: subjectListService.selectById(subject).getId());
			request.setAttribute("subjectList", subjectListService.querySubject(stage)==null?null: subjectListService.querySubject(stage));
		}
		if(!"".equals(request.getParameter("edition"))){
			edition = request.getParameter("edition");
			request.setAttribute("editionId", pubverListService.selectById(edition)==null?null:pubverListService.selectById(edition).getId());
			request.setAttribute("editionList", pubverListService.queryPubver(subject)==null?null:pubverListService.queryPubver(subject));
		}
		if(!"".equals(request.getParameter("grade"))){
			grade = request.getParameter("grade");
			request.setAttribute("gradeId", bookCatService.selectById(grade)==null?null:bookCatService.selectById(grade).getId());
			request.setAttribute("gradeList", bookCatService.queryBookCat(edition)==null?null:bookCatService.queryBookCat(edition));
		}
		
		
		
		
		
		if(!"".equals(grade)&&grade!=null){
			classification_entryId = grade;
		}else if(!"".equals(edition)&&edition!=null){
			classification_entryId = edition;
		}else if(!"".equals(subject)&&subject!=null){
			classification_entryId = subject;
		}else{
			classification_entryId = stage;
		}
		//int flag = Integer.parseInt(request.getParameter("flag"));
//		if(resourceView.getGradeId()!=null){
//			
//		 System.out.println(bookCatService.selectBybooId(resourceView.getGradeId()).getParent_id()+"tttttttttt");
//		 classification_entryId=bookCatService.selectBybooId(resourceView.getGradeId()).getParent_id();//栏目id
//		
//		//学段
//		SubjectList subject = subjectListService.selectById(resourceView.getStageId());
//		resourceView.setStage(subject.getSubjectName());
//		//科目
//		List<SubjectList> subjectList =  subjectListService.querySubject(resourceView.getStageId());
//		//教材版本
//		List<PubverList> editionList = null;
//		if(subjectList.size()>0){
//			if(resourceView.getSubjectId() == null){
//				editionList = pubverListService.queryPubver(subjectList.get(0).getSubjectId());
//				resourceView.setSubjectId(subjectList.get(0).getSubjectId());
//			}else{
//				editionList = pubverListService.queryPubver(resourceView.getSubjectId());
//				resourceView.setSubjectId(resourceView.getSubjectId());
//			}
//			resourceView.setSubject(resourceView.getSubject()==null?subjectList.get(0).getSubjectName():resourceView.getSubject());
//		}
//		//年级
//		List<BookCat> gradeList = null;
//		if(editionList.size()>0){
//			if(resourceView.getEditionId()==null){
//				gradeList = bookCatService.queryBookCat(editionList.get(0).getVersionId());
//				resourceView.setEditionId(editionList.get(0).getVersionId());
//			}else{
//				gradeList = bookCatService.queryBookCat(resourceView.getEditionId());
//				resourceView.setEditionId(resourceView.getEditionId());
//			}
//			resourceView.setEdition(resourceView.getEdition()==null?editionList.get(0).getVersionName():resourceView.getEdition());
//		}
//			
//		}
			
			

			 
			
		
		//String fileType = request.getParameter("fileType");
		columnId = request.getParameter("columnId");
		
		
		
		MyResourcesView resourcesModel = new MyResourcesView();
		User user = (User) request.getSession().getAttribute("currentUser");
		long userId = user.getId();
		resourcesModel.setUpload_user(userId);
		int page = Integer.parseInt(request.getParameter("page"));
		resourcesModel.setRows(8);
		resourcesModel.setPage(page);
		if(resourcesModel.getPage()==0){
			resourcesModel.setStartLine(0);
		}else{
			resourcesModel.setStartLine(resourcesModel.getPage()*resourcesModel.getRows());
			
		}
		resourcesModel.setUpload_user(userId);
		resourcesModel.setClassification_entryId(classification_entryId);
		resourcesModel.setColumnId(Integer.parseInt(columnId));
		int total = myResourcesService.queryTotalResources(resourcesModel);
        resourcesModel.setTotal(total);
        resourcesModel.setTotalPage(NumUtil.totalPage(total,8));
		
		
		
		//byte  i=;
//		resourcesModel.setFileType(fileType);
		
		List<MyResourcesView> list4 = myResourcesService.showMyResources(resourcesModel);
		
		
		
		
//		
//		for(MyResourcesView m:list4){
//			
//			if(m.getCatalogId().length()==5){
//				Classification_entry entry = new Classification_entry();
//				entry.setId(m.getCatalogId());
//				m.setPhase(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//			}
//			if(m.getCatalogId().length()==8){
//				Classification_entry entry = new Classification_entry();
//				entry.setId(m.getCatalogId().substring(0, 5));
//				
//				m.setPhase(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId());
//				m.setsubject(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//			}
//			if(m.getCatalogId().length()==11){
//				Classification_entry entry = new Classification_entry();
//				entry.setId(m.getCatalogId().substring(0, 5));
//				m.setPhase(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId().substring(0, 8));
//				m.setsubject(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId());
//				m.setVersion(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//			}
//			if(m.getCatalogId().length()==14){
//				Classification_entry entry = new Classification_entry();
//				entry.setId(m.getCatalogId().substring(0, 5));
//				m.setPhase(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId().substring(0, 8));
//				m.setsubject(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId().substring(0, 11));
//				m.setVersion(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//				entry.setId(m.getCatalogId());
//				m.setGrade(classification_entryService.selectAnyOne(entry).get(0).getClassification_name());
//			}
//		}
		for(MyResourcesView m:list4){
			if(m.getUploadTime()!=null){
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(m.getUploadTime());
				String sj = String.valueOf(calendar.get(Calendar.YEAR))+"-"+String.valueOf(calendar.get(Calendar.MONTH)+1)+"-"+String.valueOf(calendar.get(Calendar.DATE));
				m.setTime(sj);
			}
		}
		
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
	    UserInfo userInfo=	userInfoService.getByUserId(user.getId());
	    request.setAttribute("user", user);
	    request.setAttribute("userProperty", userProperty);
	    request.setAttribute("userInfo", userInfo);
	    //request.setAttribute("fileType", Integer.parseInt(fileType));
		request.setAttribute("columnId", Integer.parseInt(columnId));
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		request.setAttribute("resources", list4);
		request.setAttribute("resourceView", resourceView);
		ModelAndView andView = new ModelAndView();
		andView.addObject("resourcesModel", resourcesModel);
		andView.setViewName("frontstage/base/personalCenter/my_resources");
		
		return andView;
	}
	@RequestMapping("/deletes")
	public ModelAndView deletes(HttpServletRequest request){
		long userId = Integer.parseInt(request.getParameter("userId"));
		String ids = request.getParameter("ids");
		String[] id=ids.split(",");
		for(String s:id){
			long i = Integer.parseInt(s);
			file_baseService.delete(i);
			
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/my_resources/showMyResources.action?state=4&flag=0&columnId=0&fileType=1&userId="+userId);
		return modelAndView;
	}
	@RequestMapping("/goScore")
	public ModelAndView	goScore(HttpServletRequest request,HttpServletResponse response){
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		String stamp = request.getParameter("stamp");
		HttpSession session=request.getSession();
	User user=(User) session.getAttribute("currentUser");
	ModelAndView modelAndView = new ModelAndView();
	int 	pageSize= Integer.parseInt(request.getParameter("pageSize"));
	int	pageNo= Integer.parseInt(request.getParameter("pageNo"));
    int totalPage=0;
	if(user!=null){
		   int total=businessLogService.selectScoreByUserIdCount(user.getId()).size();
		    if(total%pageSize==0){
		  		  totalPage=total/pageSize;
		  	 }else{
		  		 totalPage=(total/pageSize)+1;
		  	 }
		  	 int start=(pageNo)*pageSize;
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
		 UserInfo userInfo=	userInfoService.getByUserId(user.getId());
		List<User_business_log> logs=businessLogService.selectScoreByUserId(user.getId(),start, pageSize);
		request.setAttribute("state", state);
		modelAndView.addObject("stamp", stamp);
		modelAndView.addObject("logs", logs);
		modelAndView.addObject("user", user);
		modelAndView.addObject("pageNo", pageNo);
		modelAndView.addObject("pageSize", pageSize);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("total", total);
		modelAndView.addObject("userProperty",userProperty);
		modelAndView.addObject("userInfo",userInfo);
	}
		
	
		modelAndView.setViewName("frontstage/base/personalCenter/my_score");
		return modelAndView;
		
	}
	@RequestMapping("/goIncome")
	public ModelAndView	goIncome(HttpServletRequest request,HttpServletResponse response){
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
	    int total=businessLogService.selectWealthByUserIdCount(user.getId()).size();
	    if(total%pageSize==0){
	  		  totalPage=total/pageSize;
	  	 }else{
	  		 totalPage=(total/pageSize)+1;
	  	 }
	  	 int start=(pageNo)*pageSize;
		long user_propertyId=user.getProperty_id();
		UserProperty userProperty=userService.selectUserPropertyById(user_propertyId);
		 UserInfo userInfo=	userInfoService.getByUserId(user.getId());
		List<User_business_log> logs=businessLogService.selectWealthByUserId(user.getId(), start, pageSize);
		request.setAttribute("state", state);
		request.setAttribute("stamp", stamp);
		modelAndView.addObject("logs", logs);
		modelAndView.addObject("pageNo", pageNo);
		modelAndView.addObject("pageSize", pageSize);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("total", total);
		modelAndView.addObject("user", user);
		modelAndView.addObject("userProperty",userProperty);
		modelAndView.addObject("userInfo",userInfo);
	}
		
	
		modelAndView.setViewName("frontstage/base/personalCenter/my_income");
		return modelAndView;
		
	}
	
	
	@RequestMapping("/deleteScore")
	public String deleteScore(HttpServletRequest request,HttpServletResponse response, String id) throws Exception{
		long score_id=Long.parseLong(id);
		businessLogService.deleteScore(score_id);
		JSONObject result=new JSONObject();
		ResponseUtil.write(response, result);
		return null;
		
		
		
	}
	
	
}
