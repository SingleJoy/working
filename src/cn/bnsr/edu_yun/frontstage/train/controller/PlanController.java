package cn.bnsr.edu_yun.frontstage.train.controller;


import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.po.Plan;
import cn.bnsr.edu_yun.frontstage.train.service.CommunityService;
import cn.bnsr.edu_yun.frontstage.train.service.PlanService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityView;
import cn.bnsr.edu_yun.frontstage.train.view.PlanView;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.NumUtil;

/**
 * 社区/工作坊-计划管理
 * @author heliwei
 * @date 2017年5月27日
 */
@Controller
@RequestMapping("/plan")
public class PlanController {
	private final Logger log = LoggerFactory.getLogger(PlanController.class);

	@Autowired
	private CommunityService communityService;
	@Autowired
	private PlanService planService;
	
	/**
	 * 社区/工作坊-计划数据列表
	 */
	@RequestMapping("to_plan_managers")
	public ModelAndView toPlanManagers(HttpServletRequest request,PlanView planView){
		ModelAndView mv = new ModelAndView();
		try{
			int source_type = Integer.parseInt(request.getParameter("source_type"));
			long id = Long.parseLong(request.getParameter("id"));
			String name = request.getParameter("name");
			int stamp = Integer.parseInt(request.getParameter("stamp"));
			planView.setName(name);
			planView.setSource_type(source_type);
			planView.setCommunity_id(id);
			planView.setStamp(stamp);
			planView.setPaging("1");
			planView.setRows(10);
			List<Plan> plans =null;
			if(planView.getPage()==0){
				planView.setStartLine(0);
			}else{
				planView.setStartLine(planView.getRows()*planView.getPage());
			}
			int total = planService.queryPlanTotalbyComId(planView);
			planView.setTotal(total);
			planView.setTotalPage(NumUtil.totalPage(total, planView.getRows()));
			if(source_type==0){
				CommunityView communityView = communityService.getById(id);
				communityView.setStamp(stamp);
				communityView.setSource_type(source_type);
				communityView.setId(id);
				plans = planService.queryPlansbyComId(planView);
				mv.addObject("communityView",communityView);
			}
			mv.addObject("planView", planView);
			mv.addObject("plans", plans);
			mv.setViewName("frontstage/train/community/plan_management");
			mv.addObject("head_title", "计划管理");
		}catch(Exception e){
			log.error("查询社区计划管理失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 跳转新建计划页面
	 */
	@RequestMapping("to_add_or_update_plan")
	public ModelAndView toCreatePlan(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		try{
			String id= request.getParameter("id");
			long community_id=Long.parseLong(request.getParameter("community_id"));
			CommunityView communityView = communityService.getById(community_id);
			int source_type = Integer.parseInt(request.getParameter("source_type"));
			communityView.setSource_type(source_type);
			if(id!=null){
				long idNum= Long.parseLong(id);
				if(idNum>0){
					Plan plan = planService.selectByPrimaryKey(idNum);
					mv.addObject("plan",plan);
				}
			}
			mv.addObject("communityView",communityView);
			mv.setViewName("frontstage/train/community/new_plan");
			mv.addObject("head_title", "创建计划");
		}catch(Exception e){
			log.error("跳转创建计划界面失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 创建/编辑计划
	 */
	@RequestMapping("save_plan")
	public ModelAndView savePlan(HttpServletRequest request,PlanView planView){
		ModelAndView mv = new ModelAndView();
		User user = (User) request.getSession().getAttribute("currentUser");
		try{
			planView.setUser_id(user.getId());
			planView.setCreate_time(new Date());
			Plan plan = new Plan();
			BeanUtils.copyProperties(planView, plan);
			if(plan.getStatus()==null){
				plan.setStatus(0);
			}
			if(plan.getId()==null||plan.getId()==0){
				planService.insert(plan);
			}else{
				planService.updateByPrimaryKeySelective(plan);
			}
		}catch(Exception e){
			log.error("创建计划失败",ExceptionUtil.getExceptionMessage(e));
		}
		mv.setViewName("redirect:/plan/to_plan_managers.action?id="+planView.getCommunity_id()+"&source_type=0&stamp=7");
		return mv;
	}
	
	/**
	 * 更新计划状态
	 */
	@RequestMapping("to_update_plan_status")
	public ModelAndView toUpdatePlanStatus(HttpServletRequest request,HttpServletResponse response){
		ModelAndView mv = new ModelAndView();
		try{
			String ids = request.getParameter("ids");
			int status = Integer.parseInt(request.getParameter("status"));
			int source_type = Integer.parseInt(request.getParameter("source_type"));
			long id = Long.parseLong(request.getParameter("id"));
			int stamp = Integer.parseInt(request.getParameter("stamp"));
			if(ids==null||ids.trim().length()<=0){
				return mv;
			}	
			if(status!=0&&status!=1&&status!=2){
				return mv;
			}
			String[] idStrs = ids.split(",");
			long[] idNums = new long[idStrs.length];
			for(int i=0;i<idStrs.length;i++){
				idNums[i] = Long.parseLong(idStrs[i]);
			}
			planService.batchUpdatePlanStatus(idNums, status);
			if(source_type==0){
				mv.setViewName("redirect:/plan/to_plan_managers.action?id="+id+"&source_type="+source_type+"&stamp="+stamp);
			}
		}catch(Exception e){
			log.error("更新计划状态失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 删除计划
	 */
	@RequestMapping("del_plan")
	public ModelAndView delPlan(HttpServletRequest request,PlanView planView){
		ModelAndView mv = new ModelAndView();
		try{
			planService.deleteByPrimaryKey(planView.getId());
			planView.setPage(0);
			mv.setViewName("redirect:/plan/to_plan_managers.action?id="
							+planView.getCommunity_id()+"&source_type="
							+planView.getSource_type()+"&stamp="
							+planView.getStamp());
		}catch(Exception e){
			log.error("删除计划失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
	
	/**
	 * 批量删除计划
	 */
	@RequestMapping("del_plans")
	public ModelAndView batchDelPlan(HttpServletRequest request,PlanView planView){
		ModelAndView mv = new ModelAndView();
		try{
			String ids = request.getParameter("ids");
			mv.setViewName("redirect:/plan/to_plan_managers.action?id="
					+planView.getId()+"&source_type="
					+planView.getSource_type()+"&stamp="
					+planView.getStamp());
			if(ids==null||ids.trim().length()==0){
				return mv;
			}
			String[] idStrs=ids.split(",");
			long[] idNums=new long[idStrs.length];
			for(int i=0;i<idStrs.length;i++){
				idNums[i] = Long.parseLong(idStrs[i]);
			}
			planService.batchDeleteByPrimaryKey(idNums);
			planView.setPage(0);
		}catch(Exception e){
			log.error("批量删除计划失败",ExceptionUtil.getExceptionMessage(e));
		}
		return mv;
	}
}
