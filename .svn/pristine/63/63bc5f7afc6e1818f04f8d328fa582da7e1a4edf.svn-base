package cn.bnsr.edu_yun.backstage.base.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.service.SubjectService;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.base.view.SubjectView;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.util.ExceptionUtil;

/**
 * 科目管理
 * @author fangxiongwei	
 * @date 2016年9月18日
 */
@Controller
@RequestMapping("/back_subject")
public class SubjectController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(SubjectController.class);
	@Autowired
	private SubjectService subjectService;

	@RequestMapping("/to_subject")
	public ModelAndView toSubject(){
		return new ModelAndView("backstage/base/subject/subject");
	}
	@RequestMapping("/to_subject_other")
	public ModelAndView to_subject_other(){
		return new ModelAndView("backstage/base/subject/subject_other");
	}
	@RequestMapping("/to_subject_menu")
	public ModelAndView to_subject_menu(){
		return new ModelAndView("backstage/base/subject/subject_menu");
	}
	@RequestMapping("/to_subjectList")
	public ModelAndView to_subjectList(){
		return new ModelAndView("backstage/base/subject/subjectList");
	}
	@RequestMapping("/to_subject_add")
	public ModelAndView subjectAdd() {
		return new ModelAndView("backstage/base/subject/subject_add");
	}
	@RequestMapping("/to_subject_add0")
	public ModelAndView subjectAdd0() {
		return new ModelAndView("backstage/base/subject/subject_add0");
	}
	@RequestMapping("/to_subject_edit")
	public ModelAndView subjectEdit() {
		return new ModelAndView("backstage/base/subject/subject_edit");
	}
	@RequestMapping("/toList")
	public void toList(HttpServletResponse response,SubjectView sub){
		List<SubjectView> list=new ArrayList<SubjectView>();
		
		if(sub.getId()==null||sub.getId().trim().equals("")){
			List<SubjectList> subjectList=subjectService.selectByPid("0");
			
			for(SubjectList subject:subjectList){
				List<SubjectView> children=new ArrayList<SubjectView>();
				SubjectView view=new SubjectView();
				view.setId(subject.getId());
				view.setPid(subject.getParent_id());
				view.setText(subject.getSubjectName());
				view.setChecked(subject.getStatus()==1);
				List<SubjectList> subjectList1=subjectService.selectByPid(subject.getId());
				for(SubjectList subject1:subjectList1){
					List<SubjectView> children1=new ArrayList<SubjectView>();
					SubjectView view1=new SubjectView();
					view1.setId(subject1.getId());
					view1.setPid(subject1.getParent_id());
					view1.setText(subject1.getSubjectName());
					view1.setChecked(subject1.getStatus()==1);
					List<PubverList> pubverList=subjectService.selectByPid1(subject1.getId());
					for(PubverList pubver:pubverList){
						SubjectView view2=new SubjectView();
						view2.setId(pubver.getId());
						view2.setPid(pubver.getParent_id());
						view2.setText(pubver.getVersionName());
						view2.setChecked(pubver.getStatus()==1);
						children1.add(view2);
					}
					
					view1.setChildren(children1);
					children.add(view1);
				}
				view.setChildren(children);
				list.add(view);
			}
		}
		
		
		
		super.writeJson(list,response);
		
		
		
	}
	
	@RequestMapping("/toList_other")
	public void toList_other(HttpServletResponse response,SubjectView sub){
		List<SubjectView> list=new ArrayList<SubjectView>();
		
		if(sub.getId()==null||sub.getId().trim().equals("")){
			List<SubjectList> subjectList=subjectService.selectByPid("0");
			
			for(SubjectList subject:subjectList){
				List<SubjectView> children=new ArrayList<SubjectView>();
				SubjectView view=new SubjectView();
				view.setId(subject.getId());
				view.setPid(subject.getParent_id());
				view.setText(subject.getSubjectName());
				view.setChecked(subject.getStatus()==1);
				List<SubjectList> subjectList1=subjectService.selectByPid(subject.getId());
				for(SubjectList subject1:subjectList1){
					if(subject1.getStatus()==2){
						continue;
					}
					SubjectView view1=new SubjectView();
					view1.setId(subject1.getId());
					view1.setPid(subject1.getParent_id());
					view1.setText(subject1.getSubjectName());
					view1.setChecked(subject1.getStatus()==1);
					
					children.add(view1);
				}
				view.setChildren(children);
				list.add(view);
			}
		}
		
	
		
		super.writeJson(list,response);
		
		
		
	}
	
	@RequestMapping("/edit")
	public void edit(HttpServletResponse response,String ids,String olds){
		String[] oldList=olds.split(",");
		String[] idsList=ids.split(",");
		 for(String id:oldList){ 
			 if(!id.trim().equals("")&&id.length()>5){
		
	PubverList pub=subjectService.findPubverByKey(id);
	pub.setStatus(0);
	subjectService.edit(pub);
			 }
		 }
		
	 for(String id:idsList){
		 if(!id.trim().equals("")&&id.length()>5){
			 PubverList pub=subjectService.findPubverByKey(id);
				pub.setStatus(1);
				subjectService.edit(pub);
			 
		 }
	 }
		
		
		JSONObject result=new JSONObject();
		super.writeJson(result, response);
	}
	@RequestMapping("/edit_other")
	public void edit_other(HttpServletResponse response,String ids,String olds){
		String[] oldList=olds.split(",");
		String[] idsList=ids.split(",");
		 for(String id:oldList){ 
			 if(!id.trim().equals("")&&id.length()>2){
	SubjectList sub=subjectService.findSubjectByKey(id);
	sub.setStatus(0);
	subjectService.edit(sub);
			 }
		 }
		
	 for(String id:idsList){
		 if(!id.trim().equals("")&&id.length()>2){
			 SubjectList sub=subjectService.findSubjectByKey(id);
				sub.setStatus(1);
				subjectService.edit(sub);
			 
		 }
	 }
		
		
		JSONObject result=new JSONObject();
		super.writeJson(result, response);
	}
	@RequestMapping("/toListSub")
	public void toListSub(HttpServletResponse response,SubjectView sub){
		List<SubjectView> list=new ArrayList<SubjectView>();
		
		if(sub.getId()==null||sub.getId().trim().equals("")){
			sub.setId("0");
		}
		if(sub.getId().length()<3){
	List<SubjectList> subjectList=subjectService.selectByPid(sub.getId());
			
			for(SubjectList subject:subjectList){
		        SubjectView view=new SubjectView();
				view.setId(subject.getId());
				if(	subjectService.selectByPid(subject.getId()).size()>0){
					view.setState("closed");	
					}
				if(	subjectService.selectByPid1(subject.getId()).size()>0){
				view.setState("closed");	
				}
				view.setPid(subject.getParent_id());
				view.setPname(sub.getName());
				view.setName(subject.getSubjectName());
				view.setText(subject.getSubjectName());
				view.setChecked(subject.getStatus()==1);
				list.add(view);
		}
		
		}else if(sub.getId().length()<6){
List<PubverList> pubverList=subjectService.selectByPid1(sub.getId());
			
			for(PubverList pubver:pubverList){
		        SubjectView view=new SubjectView();
				view.setId(pubver.getId());
				if(subjectService.selectByPid2(pubver.getId()).size()>0){
				view.setState("closed");	
				}
				view.setPid(pubver.getParent_id());
				view.setPname(sub.getName());
				view.setName(pubver.getVersionName());
				view.setText(pubver.getVersionName());
				view.setChecked(pubver.getStatus()==1);
				list.add(view);
		}
		}else{
			List<BookCat> bookCat=subjectService.selectByPid2(sub.getId());
			for(BookCat book:bookCat){
				SubjectView view=new SubjectView();
				view.setId(book.getId());
				if(	subjectService.selectByPid2(book.getId()).size()>0){
					view.setState("closed");	
					}
				view.setPid(book.getParent_id());
				view.setPname(sub.getName());
				view.setName(book.getBookCatelogName());
				view.setText(book.getBookCatelogName());
				list.add(view);
			}
		}
		
		super.writeJson(list,response);
		
		
		
	}
	@RequestMapping("/save_subject0")
	public void add0(HttpServletResponse response,String name,String id){
		int status=0;
		Json j = new Json();
		boolean flag=true;
		try {
			SubjectList sub=new SubjectList();
        	sub.setStatus(status);
        	if(id==null||subjectService.findSubjectByKey(id)!=null||id.length()!=2){
        		j.setMsg("添加失败！");
        	}else{
        		sub.setId(id);
            	sub.setParent_id("0");
            	sub.setSubjectName(name);
            	subjectService.insertSubject(sub);
        		j.setSuccess(true);
            	j.setMsg("添加成功！");
        	}
		} catch (Exception e) {
			e.printStackTrace();
		}
		 super.writeJson(j,response);
	}
	@RequestMapping("/save_subject")
	public void add(HttpServletResponse response,String name,String pid){
		int status=0;
		Json j = new Json();
		int i=1;
		String id="";
		boolean flag=true;
		
		try{
			if(pid.trim().equals("")||pid==null){
				j.setMsg("添加失败！");
				i=1000;
			}
			else if(pid.length()<3){
        	SubjectList sub=new SubjectList();
        	sub.setStatus(status);
        	while(flag){
        		if(i<10){
        	id=pid+0+0+i;
        		}else if(i<100){
        			id=pid+0+i;
        		}else{
        			id=pid+i;
        		}
        		if(subjectService.findSubjectByKey(id)!=null){
        			i++;
        			continue;
        		}else{
        			flag=false;
        		}
        	}
        	 if(i>999){
             	j.setMsg("添加失败！");
             }else{
        	sub.setId(id);
        	sub.setParent_id(pid);
        	sub.setSubjectName(name);
        	subjectService.insertSubject(sub);
             }
        }else if(pid.length()<6){
        	PubverList pub=new PubverList();
        	pub.setStatus(status);
        	while(flag){
        		if(i<10){
        	id=pid+0+0+i;
        		}else if(i<100){
        			id=pid+0+i;
        		}else{
        			id=pid+i;
        		}
        		if(subjectService.findPubverByKey(id)!=null){
        			i++;
        			continue;
        		}else{
        			flag=false;
        		}
        	}
        	 if(i>999){
              	j.setMsg("添加失败！");
              }else{
         	pub.setId(id);
         	pub.setParent_id(pid);
         	pub.setVersionName(name);
         	subjectService.insertPubverList(pub);
              }
	}else{
		
		while(flag){
    		if(i<10){
    	id=pid+0+0+i;
    		}else if(i<100){
    			id=pid+0+i;
    		}else{
    			id=pid+i;
    		}
    		if(subjectService.findBookCatByKey(id)!=null){
    			i++;
    			continue;
    		}else{
    			flag=false;
    		}
    	}
		BookCat book=new BookCat();
		 if(i>999){
           	j.setMsg("添加失败！");
           }else{
        book.setId(id);
        book.setParent_id(pid);
        book.setBookCatelogName(name);
      	subjectService.insertBookCat(book);
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
	
	@RequestMapping("/edit_subject")
	public void edit_subject(HttpServletResponse response,String name,String id){
		
		Json j = new Json();
		
		try{
        if(id.length()<6){
        	SubjectList sub=new SubjectList();
        	sub.setId(id);
        	sub.setSubjectName(name);
        	subjectService.updateSubject(sub);
             
        }else if(id.length()<9){
        	PubverList pub=new PubverList();
            pub.setId(id);
            pub.setVersionName(name);
         	subjectService.updatePubverList(pub);
            
	}else{
		BookCat book=new BookCat();
		book.setId(id);
        book.setBookCatelogName(name);
      	subjectService.updateBookCat(book);
          
	}
        }catch (Exception e) {
        	log.error("栏目修改添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("修改失败！");
		}
     
    	j.setSuccess(true);
    	j.setMsg("修改成功！");
      
        super.writeJson(j,response);
	}
	
	@RequestMapping("/delete_subject")
	public void delete_subject(HttpServletResponse response,String id){
		
		Json j = new Json();
	 try{
        if(id.length()<6){
        	
        	subjectService.deleteSubject(id);
             
        }else if(id.length()<9){
        
          
        	subjectService.deletePubverList(id);
	}else{
		
    	subjectService.deleteBookCat(id);
          
	}
        }catch (Exception e) {
        	log.error("栏目删除添加失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
     
    	j.setSuccess(true);
    	j.setMsg("删除成功！");
      
        super.writeJson(j,response);
	}
	@RequestMapping("/check_id")
	public void check_id(HttpServletResponse response,String paramName){
	if(paramName!=null&&paramName.length()==2&&subjectService.findSubjectByKey(paramName)==null)
	super.writeJson(true, response);
	else 
		super.writeJson(false, response);	
	}
	
}
