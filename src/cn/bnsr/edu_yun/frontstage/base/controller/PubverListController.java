package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.service.PubverListService;
import cn.bnsr.edu_yun.frontstage.base.view.TextBookView;

/**
 * 版本controller
 * @author fangxiongwei
 * @date 2016年9月5日
 */
@Controller
@RequestMapping("/pubver")
public class PubverListController {
	@Autowired
	private PubverListService pubverListService;
	@Autowired
	private BookCatService bookCatService;
	
	/**
	 * 查询版本信息
	 */
	@RequestMapping("/query_pubver")
	@ResponseBody
	public  JSONArray  queryPubver(HttpServletRequest request) {
		String pubId = request.getParameter("pubId");
		String typeFlag = request.getParameter("typeFlag");
		TextBookView textBook = new TextBookView();
		//教材版本
		List<PubverList> editionList = pubverListService.queryPubver(pubId);
		//年级
		List<BookCat> gradeList = null;
		if(editionList.size()>0){
			gradeList = bookCatService.queryBookCat(editionList.get(0).getId());
		}
		if(typeFlag!=null && typeFlag.equals("six")){//查6级分类
			//章节
			List<BookCat> chapterList = null;
			if(gradeList != null && gradeList.size()>0){
				chapterList = bookCatService.queryBookCat(gradeList.get(0).getId());
			}
			//小节
			List<BookCat> sectionList = null;
			if(chapterList != null && chapterList.size()>0){
				sectionList = bookCatService.queryBookCat(chapterList.get(0).getId());
			}
			textBook.setChapterList(chapterList);
			textBook.setSectionList(sectionList);
		}
		textBook.setEditionList(editionList);
		textBook.setGradeList(gradeList);
		return JSONArray.fromObject(textBook);
	}
	/**
	 * 只查询版本信息
	 */
	@RequestMapping("/only_query_pubver")
	@ResponseBody
	public JSONArray only_query_pubver(HttpServletRequest request){
		String pubId = request.getParameter("pubId");
		//教材版本
		List<PubverList> editionList = pubverListService.queryPubver(pubId);
		JSONArray jsonArray = JSONArray.fromObject(editionList);
		return jsonArray;
	}
}
