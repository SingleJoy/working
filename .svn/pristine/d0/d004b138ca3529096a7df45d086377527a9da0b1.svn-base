package cn.bnsr.edu_yun.backstage.community.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SessionInfo;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.SubjectListService;
import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.po.Community;
import cn.bnsr.edu_yun.frontstage.train.po.StudentRelation;
import cn.bnsr.edu_yun.frontstage.train.service.CertModelPictureService;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityRelationService;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityService;
import cn.bnsr.edu_yun.frontstage.train.service.StudentRelationService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityView;
import cn.bnsr.edu_yun.util.ConfigInfo;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.MyArrayComparator;
import cn.bnsr.edu_yun.util.NumUtil;
import cn.bnsr.edu_yun.util.ResponseUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/back_community")
public class BackCommunityController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(BackCommunityController.class);
	
	@Autowired
	private AreaService areaService;
	@Autowired
	private CommunityService communityService;
	@Autowired
	private CertModelPictureService certModelPictureService;
	@Autowired
	private SubjectListService subjectListService;
	@Autowired
	private CommunityRelationService communityRelationService;
	@Autowired
	private StudentRelationService studentRelationService;
	
	
	/**
	 *跳转社区页面
	 */
	@RequestMapping("/to_community")
	public ModelAndView toCommunity(HttpServletRequest request) {
		return new ModelAndView("backstage/community/community");
	}
	
	/**
	 * 课例datagrid
	 */
	@RequestMapping("/datagrid")
	public void datagrid(HttpServletRequest request,HttpServletResponse response,CommunityView communityView) {
		String name = request.getParameter("q");
		if(name!=null&&name.length()>0){
			communityView.setName(name);
		}
		super.writeJson(communityService.datagrid(communityView),response);
	}
	
	/**
	 * 开启/关闭社区
	 */
	@RequestMapping("/update_status")
	public void updateStatus(HttpServletResponse response, String ids,Integer status) {
		Json j = new Json();
		try{
			for(String id:ids.split(",")){
				Community community = new Community();
				community.setId(Long.parseLong(id));
				community.setStatus(status);
				communityService.updateCommunity(community);
			}
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("推荐操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	
	/**
	 *跳转推荐课例页面
	 */
	@RequestMapping("/to_recommend_community")
	public ModelAndView toRecommendCommunity(HttpServletRequest request) {
		return new ModelAndView("backstage/community/recommend_community");
	}
	
	
	/**
	 * 推荐时获取最大推荐序号
	 * @throws Exception 
	 */
	@RequestMapping("/get_max_seq")
	public void getMaxSeq(HttpServletResponse response){
	    
		Json j = new Json();
		try{
			Long seq = communityService.getMaxSeq();
			if(seq!=null){
				j.setObj(seq+1);
			}else{
				j.setObj(1);
			}
			j.setSuccess(true);
			j.setMsg("操作成功！");
		} catch (Exception e) {
			log.error("获取最大推荐序号操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("操作失败！");
		}
		super.writeJson(j,response);
	}
	

	/**
	 *跳转添加社区页面
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/to_community_add")
	public ModelAndView toCommunityAdd(HttpServletRequest request, CommunityView communityView) {
		ModelAndView mv = new ModelAndView("backstage/community/community_add");
		List<Area> provinceList = areaService.selectByPid("1");
		MyArrayComparator comparator = new MyArrayComparator();
		Collections.sort(provinceList, comparator);
		mv.addObject("provinceList", provinceList);
		// 学段list
		List<SubjectList> periodList = subjectListService.querySubject("0");
		mv.addObject("periodList", periodList);
		Long communityId = communityView.getId();
		if(communityId!=null){
			communityView = communityService.getById(communityId);
			String areaId = communityView.getArea_id();// 所属地区id
			if (areaId!=null&&areaId.length()>0&&!areaId.equals("1")) {// 不是全国
				// 所属地区信息
				Area area = areaService.selectByid(areaId);
				String areaParentId = area.getParentId();// 所属父id
				if (areaParentId.equals("1")) {// 省级
					communityView.setProvince(areaId);
					communityView.setCity("-1");
					communityView.setCounty("-1");
				} else {// 市县级
					List<Area> cityList = new ArrayList<Area>();
					if (area.getArea_id().length() < 9) {// 市级
						cityList = areaService.selectByPid(areaParentId);
						Collections.sort(cityList, comparator);
						communityView.setProvince(areaParentId);
						communityView.setCity(areaId);
						communityView.setCounty("-1");
					} else {// 县级
						Area cityArea = areaService.selectByid(areaParentId);// 市
						Area provinceArea = areaService.selectByid(cityArea.getParentId());// 省
						// 市级
						cityList = areaService.selectByPid(cityArea.getParentId());
						Collections.sort(cityList, comparator);
						// 县级
						List<Area> countyList = areaService.selectByPid(areaParentId);
						Collections.sort(countyList, comparator);
						request.setAttribute("countyList", countyList);
						communityView.setProvince(provinceArea.getId());
						communityView.setCity(areaParentId);
						communityView.setCounty(areaId);
					}
					mv.addObject("cityList", cityList);
				}
			}
			List<CommunityRelationView> crList = communityRelationService.searchSubjects(communityId);
			List<String> list = new ArrayList<String>();
			if (crList.size() > 0) {
				for (CommunityRelationView cr : crList) {
					if (cr.getType() == 0) {// 学段
						communityView.setPeriods(cr.getSubjects());
					} else {// 学科
						communityView.setSubjects(cr.getSubjects());
					}
				}
				if (!communityView.getPeriods().equals("")) {
					list = NumUtil.getList(communityView.getPeriods());
				}
			}
			if (list.size() > 0) {
				// 根据选中的学段查询所有学科
				List<SubjectList> periodSubjectList = subjectListService.searchSubject(list);
				mv.addObject("periodSubjectList", periodSubjectList);
			}
			String start_time = communityView.getStart_time();
			if(start_time!=null&&start_time.length()>0){
				communityView.setStart_time(start_time.substring(0, 10));
			}
			String end_time = communityView.getEnd_time();
			if(end_time!=null&&end_time.length()>0){
				communityView.setEnd_time(end_time.substring(0, 10));
			}
			String adminNames = studentRelationService.getStuNames(communityId, 0, 0);
			String adminIds = studentRelationService.getStuIds(communityId, 0, 0);
			communityView.setAdmins(adminNames);;
			communityView.setIds(adminIds);;
			mv.addObject("communityView", communityView);
		}
		return mv;
	}
	
	
	
	/**
	 * 保存社区
	 */
	@RequestMapping("/save_community")
	public void saveCommunity(HttpServletRequest request,HttpServletResponse response,Community community) {
		Json j = new Json();
		int i = 0;
		try{
			String periods = request.getParameter("periods");// 学段
			String subjects = request.getParameter("subjects");// 学科
			String userIds = request.getParameter("community_user_id");
			if (community.getId() != null) {
				// 全删
				communityRelationService.deleteByCommunityId(community.getId());
				communityRelationService.saveCommunityRelation(periods, subjects, community.getId());
				studentRelationService.clearStudent(community.getId(), 0, 0);
				communityService.updateCommunity(community);
				i++;
			}else{
				HttpSession session = request.getSession();
				SessionInfo sessionInfo= (SessionInfo)session.getAttribute("sessionInfo");
				if (community.getHead_img() == null) {
					CertModelPicture defaultImg = certModelPictureService.getDefaultImg(6);
					community.setHead_img(defaultImg.getPath());
					community.setIs_default_img(0);
					community.setHead_img_name("Default.png");
				} else {
					community.setIs_default_img(1);
				}
				community.setUser_id(sessionInfo.getUserId());
				community.setStatus(0);
				community.setCreate_time(new Date());
				communityService.saveCommunityBackstage(community);
				communityRelationService.saveCommunityRelation(periods, subjects, community.getId());
			}
			if(userIds!=null){
				for(String user_id:userIds.split(",")){
					StudentRelation sr = new StudentRelation();
					sr.setUser_id(Long.parseLong(user_id.trim()));
					sr.setRole_type(0);
					sr.setSource_id(community.getId());
					sr.setSource_type(0);
					studentRelationService.saveStudentRelation(sr);
				}
			}
			j.setSuccess(true);
			if(i!=0){
				j.setMsg("编辑成功！");
			}else{
				j.setMsg("保存成功！");
			}
		} catch (Exception e) {
			log.error("保存社区操作失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("保存失败！");
		}
		super.writeJson(j,response);
	}
	
	
	@RequestMapping("/upload_img")
	public void upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String orifileName = file.getOriginalFilename();
		String communityPicture = ConfigInfo.getString("communityPicture");
		String path = request.getSession().getServletContext().getRealPath(communityPicture);
		Date date = new Date();
		long time = date.getTime();
		String fileName = "img" + time;
		String format = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
		Random ra = new Random();
		fileName = fileName + ra.nextInt(10) + format;
		File targetFile = new File(path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		// 保存
		try {
			file.transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject result = new JSONObject();
		result.put("fileName", communityPicture + "/" + fileName);
		result.put("oname", orifileName);
		ResponseUtil.write(response, result);

	}
	
	/**
	 *跳转添加坊主页面
	 */
	@RequestMapping("/to_select_master")
	public ModelAndView toSelectMaster(HttpServletRequest request) {
		return new ModelAndView("backstage/community/select_master");
	}

	
}
