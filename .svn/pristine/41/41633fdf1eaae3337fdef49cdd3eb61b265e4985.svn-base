package cn.bnsr.edu_yun.frontstage.resource.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.bnsr.edu_yun.frontstage.base.po.Classification_entry;
import cn.bnsr.edu_yun.frontstage.base.service.Classification_entryService;
import cn.bnsr.edu_yun.frontstage.resource.po.File_catalog;
import cn.bnsr.edu_yun.frontstage.resource.service.File_catalogService;
@Controller
@RequestMapping("file_catalog")
public class File_catalogController {
	
	@Autowired
	private File_catalogService catalogService;
	@Autowired
	private Classification_entryService  classification_entryService;
	@RequestMapping("/selectAnyOne")
	public List<File_catalog> selectAnyOne(){
		Classification_entry entry = new Classification_entry();
		entry.setId("YJ002");
		List<Classification_entry> list = classification_entryService.selectAnyOne(entry);
		
		
		List<Long> list3 = new ArrayList<Long>();
		
		for(Classification_entry c:list){
			System.out.println(c.getId()+"uuuuuuuuuuuu");
			File_catalog catalog = new File_catalog();
			catalog.setClassfication_id(c.getId());
			
			if(catalogService.selectAnyOne(catalog).size()!=0){
				for(File_catalog f:catalogService.selectAnyOne(catalog)){
					list3.add(f.getId());	
				}
				
				
			}
			
			
			
		}
		System.out.println(list3.toString());
		for(Long i:list3){
			System.out.println(i+"zzzzzz");
		}
		
		return null;
	}
	
	

}
