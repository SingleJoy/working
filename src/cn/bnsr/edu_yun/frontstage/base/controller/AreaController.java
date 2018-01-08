package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.School;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;
import cn.bnsr.edu_yun.frontstage.base.service.SchoolService;
import cn.bnsr.edu_yun.util.MyArrayComparator;
/**
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/area")
public class AreaController {
	@Autowired
	private AreaService areaService;
	@Autowired
	private SchoolService schoolService;
/*
@Autowired
private AreaService areaService;
@Autowired
private SchoolService schoolService;

@RequestMapping("/getArea")
    public ModelAndView getArea(HttpServletRequest request,HttpServletResponse response){
	
	ModelAndView modelAndView=new ModelAndView();
	
	modelAndView.setViewName("frontstage/index2");
	
	
	String str=MetaTest.getAreaList();
	
JSONArray a=JSONArray.fromObject(str);
Iterator<Object> it = a.iterator();
List<Area> areaList=new ArrayList<Area>();
while (it.hasNext()) {
 JSONObject ob = (JSONObject) it.next();

System.out.println(ob.get("nodeName"));
String id=((String) ob.get("id"));	//地区id
String parentId=((String) ob.get("parentId"));		//父地区id ，父地区为根节点时 ，值为-1
String nodeName=(String) ob.get("nodeName");	//地区名称。
int vNo=(Integer)ob.get("vNo");			//当前地区数据版本号，获取地区操作日志，进行更新时使用。

Area area=new Area();
area.setArea_name(nodeName);
area.setId(id+"");
area.setParentId(parentId);
area.setvNo(vNo);

areaService.insertArea(area);

areaList.add(area);

}

modelAndView.addObject("area", areaList);
	
		return modelAndView;
    	
    }

@RequestMapping("/getArea2")
public ModelAndView getArea2(HttpServletRequest request,HttpServletResponse response,String area_id){

ModelAndView modelAndView=new ModelAndView();

modelAndView.setViewName("frontstage/index2");

List<SubjectList> subjectList=areaService.selectSAll();
int index=1;

for(SubjectList subject:subjectList){

	if(subject.getSeqNo()<4){
		continue;
	}

String str	=MetaTest.getPubVerList(subject.getSubjectId());
if(str.length()<20){
		continue;
	}
JSONArray a = JSONArray.fromObject(str);
		
Iterator<Object> it = a.iterator();
       int i=1;
	while (it.hasNext()) {
  		JSONObject ob = (JSONObject) it.next();
  		String ab="";
		if(i<10){
			ab="00"+i;
		}
		else if(i<100){
			ab="0"+i;
		}else{
			ab=""+i;
		}
		i++;
  		String versionId=(String) ob.get("versionId");
  		String versionName=(String) ob.get("versionName");
  		
  		PubverList pubver=new PubverList();
  		pubver.setId(subject.getId()+ab);
  		pubver.setParent_id(subject.getId());
  		pubver.setSubjectId(subject.getSubjectId());
  		pubver.setVersionId(versionId);
  		pubver.setVersionName(versionName);
  		pubver.setSeqNo(index);
  		index++;
  		areaService.insertPubver(pubver);
  		
  		
	}
	

}
	



	return modelAndView;
	
}

@RequestMapping("/getArea1")
public ModelAndView getArea1(HttpServletRequest request,HttpServletResponse response){
	
	ModelAndView modelAndView=new ModelAndView();
	
get(671,0,163388);
	
	
	modelAndView.setViewName("frontstage/index2");
	return modelAndView;
	
	
	
}

  void getValue(String pid){
	  List<Area> areaList=areaService.selectByPid(pid);
		int i=1;
	  for(Area area:areaList){
			String a="";
			if(i<10){
				a="00"+i;
			}
			else if(i<100){
				a="0"+i;
			}else{
				a=""+i;
			}
			i++;
			String value=areaService.selectByid(area.getParentId()).getArea_id();
			area.setArea_parentid(value);
			area.setArea_id(value+a);
			areaService.update(area);
			getValue(area.getId());
			
		}
	  
	  
	  
  }

  public void getV(int area_id){
	  List<Area> areaList=areaService.selectAll();

	  for(Area area:areaList){
	
	 
  	if(area.getCount()<area_id){
	  		continue;
	  	}
	  	try{
	  		String str=MetaTest.getSchoolList(area.getId(), "JJ");
	  		JSONArray a=null;
	  	
	  		if(str.length()<20){
	  			continue;
	  		}
	  		try{
	  		 a=JSONArray.fromObject(str);
	  		}catch (Exception e) {
			e.printStackTrace();
			continue;
			}
	  
	  	Iterator<Object> it = a.iterator();
	  	
	  	
	int n=1;
	if(area.getCount()==area_id){
		n=0;
	}
	  	while (it.hasNext()) {
	  		JSONObject ob = (JSONObject) it.next();

//	  		System.out.println(ob.get("nodeName"));
//	  		String id=((String) ob.get("id"));	//地区id
//	  		String parentId=((String) ob.get("parentId"));		//父地区id ，父地区为根节点时 ，值为-1
//	  		String nodeName=(String) ob.get("nodeName");	//地区名称。
//	  		int vNo=(Integer)ob.get("vNo");			//当前地区数据版本号，获取地区操作日志，进行更新时使用。

	  		String	schoolId=((String) ob.get("schoolId"));
	  		if(schoolId.equals("297e8425402ee56d01402f3effb60c8c")){
	  			n=1;
	  		}
	  		if(n==0){
	  			continue;
	  		}
	  		if(schoolId.equals("297e8425402ee56d01402f3effb60c8c")){
	  			continue;
	  		}
	  		//学校id
	  		String provinceId=((String) ob.get("provinceId"));	//学校所在省id，没有为“”
	  		String cityId=((String) ob.get("cityId"));	//学校所在市id，没有为“”
	  		String countyId	=((String) ob.get("countyId"));//学校所在县id，没有为“”
	  		String schoolName=((String) ob.get("schoolName"));	//学校名称
	  		String	schoolType=	"JJ";
	  		int vNo=(Integer)ob.get("vNo");

	  		
	  		
	  		
	  		School sc=new School();
	  		sc.setCountyId(countyId);
	  		sc.setCityId(cityId);
	  		sc.setProvinceId(provinceId);
	  		sc.setSchoolId(schoolId);
	  		sc.setSchoolName(schoolName);
	  		sc.setSchoolType(schoolType);
	  		sc.setvNo(vNo);
	  		
	  		schoolService.insert(sc);
	  		
	  		}
	  	
	  	}catch (Exception e) {
			getV(area.getCount());
		}
	  }


  }
  @RequestMapping("/getArea20")
  public ModelAndView getArea20(HttpServletRequest request,HttpServletResponse response,String area_id){

	  ModelAndView modelAndView=new ModelAndView();
	  
	  
	  List<Area> areaList=areaService.selectAll();

	  int i=1;
	  for(Area area:areaList){
		  area.setCount(i);
		  i++;
		  areaService.update(area);
		  
	  }
	  
	  
	  
		modelAndView.setViewName("frontstage/index2");
		
		return modelAndView;
	  
  }
  void get(int no,int st, int seq){
		List<PubverList> pubverList=areaService.seletPAll();
		for(PubverList pubver:pubverList){
			if(pubver.getSeqNo()<no){
		  		continue;
		  	}
		  	try{
		  		String str=MetaTest.getBookCat(pubver.getVersionId());
		  		JSONArray a=null;
		  	
		  		if(str.length()<20){
		  			continue;
		  		}
		  		try{
		  		 a=JSONArray.fromObject(str);
		  		}catch (Exception e) {
				e.printStackTrace();
				continue;
				}
		  	 	Iterator<Object> it = a.iterator();
			  	
			  	
		  		int n=1;
		  		if(pubver.getSeqNo()==no&&st==0){
		  			n=0;
		  		}
		  	
		  		  	while (it.hasNext()) {
		  		  		JSONObject ob = (JSONObject) it.next();

//		  		  		System.out.println(ob.get("nodeName"));
//		  		  		String id=((String) ob.get("id"));	//地区id
//		  		  		String parentId=((String) ob.get("parentId"));		//父地区id ，父地区为根节点时 ，值为-1
//		  		  		String nodeName=(String) ob.get("nodeName");	//地区名称。
//		  		  		int vNo=(Integer)ob.get("vNo");			//当前地区数据版本号，获取地区操作日志，进行更新时使用。

		  		  		String	bookCatelogId=((String) ob.get("bookCatelogId"));
		  		  		if(bookCatelogId.equals("362880194c57a7f3014c62b052f201a5")){
		  		  			n=1;
		  		  		}
		  		  		if(n==0){
		  		  			continue;
		  		  		}
		  		  		if(bookCatelogId.equals("362880194c57a7f3014c62b052f201a5")){
		  		  			continue;
		  		  		}
		  		  	String	parentId=((String) ob.get("parentId"));
		  		  String	bookCatelogName=((String) ob.get("bookCatelogName"));
		        	int vNo=	((Integer) ob.get("vNo"));
		        	String	c_code=((String) ob.get("c_code"));	
		        	String	parent_code=((String) ob.get("parent_code"));	
		  	BookCat book=new BookCat();
		  	book.setBookCatelogId(bookCatelogId);
		  	book.setBookCatelogName(bookCatelogName);
		  	book.setParent_id(parent_code);
		   book.setId(c_code);
		  	book.setParentId(parentId);
		  	book.setVersionId(pubver.getVersionId());
		  	book.setvNo(vNo);
		  	book.setSeqNo(seq++);
		  	areaService.insertBook(book);
		  		 
		  		  	}
		  		
		  	}catch (Exception e) {
		  		e.printStackTrace();
		  	
				get(pubver.getSeqNo(),1,seq);
			}
		}
	}
	
  */
	@RequestMapping("/showArea")
	@ResponseBody
	public JSONArray showArea(HttpServletRequest request){
		String parentId=request.getParameter("parentId");
		List<Area> list= areaService.selectByPid(parentId);
		MyArrayComparator comparator = new MyArrayComparator();
		Collections.sort(list,comparator); 
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray;
	}
	@RequestMapping("/showSchool")
	@ResponseBody
	public JSONArray showSchool(HttpServletRequest request){
		String countyId=request.getParameter("countyId");
		List<School> list= schoolService.selectByCountyId(countyId);
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray;
	}
	@RequestMapping("/showProvinceSchool")
	@ResponseBody
	public JSONArray showProvinceSchool(HttpServletRequest request){
		String provinceId=request.getParameter("provinceId");
		List<School> list= schoolService.selectByProvinceId(provinceId);
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray;
	}
	@RequestMapping("/showCitySchool")
	@ResponseBody
	public JSONArray showCitySchool(HttpServletRequest request){
		String cityId=request.getParameter("cityId");
		List<School> list= schoolService.selectByCityId(cityId);
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray;
	}
	

}
