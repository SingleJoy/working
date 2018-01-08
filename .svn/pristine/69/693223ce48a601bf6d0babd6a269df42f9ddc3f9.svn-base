package cn.bnsr.edu_yun.frontstage.base.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;
import cn.bnsr.edu_yun.frontstage.base.view.TextBookView;

/**
 * 年级、章节、小节controller
 * @author fangxiongwei
 * @date 2016年9月5日
 */
@Controller
@RequestMapping("/book_cat")
public class BookCatController {
	@Autowired
	private BookCatService bookCatService;
	
	/**
	 * 查询年级章节小节信息
	 */
	@RequestMapping("/query_book_cat")
	@ResponseBody
	public  JSONArray  queryBookCat(HttpServletRequest request) {
		String bookId = request.getParameter("bookId");
		String parentId = request.getParameter("parentId");//-1,0,1
		String typeFlag = request.getParameter("typeFlag");
		TextBookView textBook = new TextBookView();
		List<BookCat> gradeList = bookCatService.queryBookCat(bookId);
		if(parentId.equals("-1")){
			textBook.setGradeList(gradeList);
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
		}else if(parentId.equals("0")){
			textBook.setChapterList(gradeList);
			if(typeFlag!=null && typeFlag.equals("six")){//查6级分类
				//小节
				List<BookCat> sectionList = null;
				if(gradeList!= null && gradeList.size()>0){
					sectionList = bookCatService.queryBookCat(gradeList.get(0).getId());
				}
				textBook.setSectionList(sectionList);
			}
		}else{
			textBook.setSectionList(gradeList);
		}
		
		return JSONArray.fromObject(textBook);
	}
	@RequestMapping("/only_query_book_cat")
	@ResponseBody
	public JSONArray only_query_book_cat(HttpServletRequest request){
		String bookId = request.getParameter("bookId");
		List<BookCat> gradeList = bookCatService.queryBookCat(bookId);
		JSONArray jsonArray = JSONArray.fromObject(gradeList);
		return jsonArray;
	}
}
