package cn.bnsr.edu_yun.backstage.base.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.AreaView;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SubjectView;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.IpInterceptService;
import cn.bnsr.edu_yun.util.ExceptionUtil;
import cn.bnsr.edu_yun.util.MyArrayComparator;
/**
 * 地区管理 
 */
@Controller
@RequestMapping("/back_area")
public class BackAreaController  extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackAreaController.class);
	@Autowired
	private AreaService areaService;
	@Autowired
	private IpInterceptService ipInterceptService;
	
	
	@RequestMapping("/to_area")
	public ModelAndView toArea(){
		return new ModelAndView("backstage/base/area/area");
	}
	@RequestMapping("/to_area_add")
	public ModelAndView areaAdd() {
		return new ModelAndView("backstage/base/area/area_add");
	}
	@RequestMapping("/to_area_edit")
	public ModelAndView areaEdit() {
		return new ModelAndView("backstage/base/area/area_edit");
	}
	@RequestMapping("/toListSub")
	public void toListSub(HttpServletResponse response,SubjectView sub){
		List<SubjectView> list=new ArrayList<SubjectView>();
		MyArrayComparator comparator = new MyArrayComparator();
		if(sub.getId()==null||sub.getId().trim().equals("")){
			
			List<Area> areaList=areaService.selectByPid("-1");
			
			Collections.sort(areaList,comparator); 
			for(Area area:areaList){
				 SubjectView view=new SubjectView();
				 view.setId(area.getId());
				 if(areaService.selectByPid(area.getId()).size()>0){
						view.setState("closed");	
				 }
				 view.setPid(area.getParentId());
				 view.setName(area.getArea_name());
				 view.setText(area.getArea_name());
					list.add(view);
			}
			
		}else {
	
			List<Area> areaList=areaService.selectByPid(sub.getId());
			Collections.sort(areaList,comparator); 
			for(Area area:areaList){
				 SubjectView view=new SubjectView();
				 view.setId(area.getId());
				 if(areaService.selectByPid(area.getId()).size()>0){
						view.setState("closed");	
				 }
				 view.setPid(area.getParentId());
				 view.setName(area.getArea_name());
				 view.setText(area.getArea_name());
					list.add(view);
			}
		
	
		}
		
		super.writeJson(list,response);
		
		
		
	}
	@RequestMapping("/save_area")
	public void add(HttpServletResponse response,String name,String pid){
		
		Json j = new Json();
		int i=1;
		String id="";
		boolean flag=true;
		Area pArea=areaService.selectByid(pid);
		String apid=pArea.getArea_id();
		try{
			if(pid.trim().equals("")||pid==null){
				j.setMsg("添加失败！");
				i=1000;
			}
		else{
		
		while(flag){
    		if(i<10){
    			
    	id=apid+0+0+i;
    		}else if(i<100){
    			id=apid+0+i;
    		}else{
    			id=apid+i;
    		}
    		if(areaService.selectByid(id)!=null){
    			i++;
    			continue;
    		}else{
    			flag=false;
    		}
    	}
		Area area=new Area();
		 if(i>999){
           	j.setMsg("添加失败！");
           }else{
        	   area.setId(id);
        	   area.setArea_id(id);
        	   area.setArea_parentid(apid);
        	   area.setParentId(pid);
        	   area.setArea_name(name);
      	areaService.insertArea(area);
           }
	}
        }catch (Exception e) {
        	log.error("栏目添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("添加失败！");
		}
        if(i<999){
    	j.setSuccess(true);
    	j.setMsg("添加成功！");
        }
        super.writeJson(j,response);
	}
	
	@RequestMapping("/edit_area")
	public void edit_area(HttpServletResponse response,String name,String id){
		
		Json j = new Json();
		
		try{
   
			Area area=new Area();
			area.setId(id);
			area.setArea_name(name);
			areaService.update(area);
          
	
        }catch (Exception e) {
        	log.error("栏目修改添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("修改失败！");
		}
     
    	j.setSuccess(true);
    	j.setMsg("修改成功！");
      
        super.writeJson(j,response);
	}
	
	@RequestMapping("/delete_area")
	public void delete_area(HttpServletResponse response,String id){
		
		Json j = new Json();
	 try{
       
        	
        	areaService.deleteArea(id);
         
          
	
        }catch (Exception e) {
        	log.error("栏目删除添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
     
    	j.setSuccess(true);
    	j.setMsg("删除成功！");
      
        super.writeJson(j,response);
	}
	@RequestMapping("/toListSubByPid")
	public void toListSubByPid(HttpServletResponse response,String pid){
		List<SubjectView> list=new ArrayList<SubjectView>();
		
	
	
			List<Area> areaList=areaService.selectByPid(pid);
			MyArrayComparator comparator = new MyArrayComparator();
			Collections.sort(areaList,comparator); 
			for(Area area:areaList){
				 SubjectView view=new SubjectView();
				 view.setId(area.getId());
				 view.setPid(area.getParentId());
				 view.setName(area.getArea_name());
				 view.setText(area.getArea_name());
					list.add(view);
			}
		
	
		
		
		super.writeJson(list,response);
	}
	
	@RequestMapping("/to_area1")
	public ModelAndView toArea1(HttpServletRequest request,String parentId){
		ModelAndView mv = new ModelAndView("backstage/base/area/area1");
		List<Area> areaList = areaService.queryArea(parentId);
		MyArrayComparator comparator = new MyArrayComparator();
		Collections.sort(areaList,comparator); 
		mv.addObject("areaList", areaList);
		mv.addObject("parentId", parentId);
		return mv;
	}
	
	
	/**
	 * 批量修改角色
	 */
	@RequestMapping("/open_area")
	public ModelAndView openArea(HttpServletResponse response,String id,String parentId){
		try {
			areaService.openArea(id,parentId);
			ipInterceptService.deleteAll();
		} catch (Exception e) {
			log.error("开放省份失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/back_area/to_area1.action?parentId="+parentId);
		
	}
	
	@RequestMapping("/queryProvince")
	public void queryProvince(HttpServletResponse response,Area area){
		List<Area> provincelist = new ArrayList<>();
		try {
			provincelist=areaService.selectProvinceList(area);
			MyArrayComparator comparator = new MyArrayComparator();
			Collections.sort(provincelist,comparator); 
		} catch (Exception e) {
			log.error("查询开放省份失败",ExceptionUtil.getExceptionMessage(e));
			e.printStackTrace();
		}
		super.writeJson(provincelist,response);
	}
	
}
