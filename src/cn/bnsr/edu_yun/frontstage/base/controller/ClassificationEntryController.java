package cn.bnsr.edu_yun.frontstage.base.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.bnsr.edu_yun.frontstage.base.po.Classification_entry;
import cn.bnsr.edu_yun.frontstage.base.service.Classification_entryService;

@Controller
@RequestMapping("classification_entry")
public class ClassificationEntryController {
	@Autowired
	private Classification_entryService classification_entryService;
	@RequestMapping("/goIndex")
	public String goIndex(){
		return "my-resources";
	}
	/**
	 * 设置下拉框学段的值
	 * @return JSONArray
	 * @throws IOException 
	 */
	@RequestMapping("/toSee")
	@ResponseBody
	public  JSONArray  toSee(HttpServletRequest request) {
		
		Classification_entry entry = new Classification_entry();
		entry.setParent_id("YJ");
		List<Classification_entry> list = classification_entryService.selectAnyOne(entry);
	
		JSONArray jsonArray = JSONArray.fromObject(list);

		

		
		
		
		return jsonArray;
		
	}
	/**
	 * 设置其他下拉框的值
	 * @param request
	 * @return json
	 */
	@RequestMapping("/seeOther")
	@ResponseBody
	public JSONArray seeOther(HttpServletRequest request){
		String id = request.getParameter("id");
		Classification_entry entry = new Classification_entry();
		entry.setParent_id(id);
		List<Classification_entry> list =  classification_entryService.selectAnyOne(entry);
		JSONArray jsonArray = JSONArray.fromObject(list);
		return jsonArray;
		
	}

}
