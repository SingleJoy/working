package cn.bnsr.edu_yun.backstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.School;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.SchoolService;
/**
 * 学校管理
 */

@Controller
@RequestMapping("/back_school")
public class BackSchoolController  extends BaseController{
	private final Logger log = LoggerFactory.getLogger(BackSchoolController.class);
	@Autowired
	private SchoolService schoolService;
	@Autowired
	private AreaService areaService;
	@RequestMapping("/to_school")
	public ModelAndView toMenu(){
		return new ModelAndView("backstage/base/school/school");
	}
	@RequestMapping("/to_school_add")
	public ModelAndView subjectAdd() {
		return new ModelAndView("backstage/base/school/school_add");
	}
	@RequestMapping("/to_school_edit")
	public ModelAndView subjectEdit() {
		return new ModelAndView("backstage/base/school/school_edit");
	}
	@RequestMapping("toList")
	public void toList(HttpServletResponse response,int page,int rows,School school){
		  int start=rows*(page-1);
		  if(school==null){
			  school=  new School();
		  }
		 
		  List<School> list=schoolService.selectByPage(school.getSchoolName(),school.getProvinceId(),school.getCityId(),school.getCountyId(),start, rows);
			DataGrid j = new DataGrid();
			j.setRows(list);
			long total=0;
			
				total = schoolService.selectAll(school.getSchoolName(),school.getProvinceId(),school.getCityId(),school.getCountyId());
		
			j.setTotal(total);
			super.writeJson(j,response);
	}
	
	@RequestMapping("save_school")
	public void save_school(HttpServletResponse response,String pid,String schoolName){
		Json j = new Json();
		School school=new School();
		Area area=areaService.selectByid(pid);
		String area_id=area.getArea_id();
		String provinceId=null;
		String cityId=null;
		String countyId=null;
		if(area_id.length()>=5){
			provinceId=areaService.selectByArea_id(area_id.substring(0, 5)).getId();
		}
			if(area_id.length()>=8){
				cityId=areaService.selectByArea_id(area_id.substring(0, 8)).getId();
		}
			if(area_id.length()==11){
				countyId=	areaService.selectByArea_id(area_id).getId();
			}
		school.setCountyId(countyId);
		school.setProvinceId(provinceId);
		school.setCityId(cityId);
		school.setSchoolName(schoolName);
		school.setSchoolType("JJ");
		schoolService.insert(school);
		j.setSuccess(true);
    	j.setMsg("添加成功！");
    	super.writeJson(j,response);
	}
	@RequestMapping("edit_school")
	public void edit_school(HttpServletResponse response,long id,String schoolName){
		Json j = new Json();
		School school =new School();
		school.setId(id);
		school.setSchoolName(schoolName);
		schoolService.update(school);
		j.setSuccess(true);
    	j.setMsg("修改成功！");
    	super.writeJson(j,response);
		
	}
	@RequestMapping("delete_school")
	public void delete_school(HttpServletResponse response,String ids){
		Json j = new Json();
		String[] idsList=ids.split(",");
		for(String id:idsList){
			if(id!=null&&!id.trim().equals("")){
				schoolService.delete(Long.parseLong(id));
			}
			}
		j.setSuccess(true);
    	j.setMsg("删除成功！");
    	super.writeJson(j,response);
	}
	
}
