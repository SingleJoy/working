package cn.bnsr.edu_yun.backstage.train.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.bnsr.edu_yun.backstage.base.controller.BaseController;
import cn.bnsr.edu_yun.backstage.base.view.Json;
import cn.bnsr.edu_yun.backstage.train.view.TopicAnswerView;
import cn.bnsr.edu_yun.frontstage.train.service.TopicAnswerService;
import cn.bnsr.edu_yun.frontstage.train.service.TopicQuestionService;
import cn.bnsr.edu_yun.frontstage.train.view.TopicQuestionView;
import cn.bnsr.edu_yun.util.ExceptionUtil;

@Controller
@RequestMapping("/back_questions")
public class QuestionsAnswersController extends BaseController {

	
    private final Logger log = LoggerFactory.getLogger(QuestionsAnswersController.class);
	
	@Autowired
	private TopicQuestionService topicQuestionService;
	
	@Autowired
	private TopicAnswerService topicAnswerService;
	
	/**
	 *跳转问题页面
	 */
	@RequestMapping("/to_questions")
	public ModelAndView toQuestionsAnswers(){
		return new ModelAndView("backstage/train/questions/questions");
	}
	
	/**
	 *跳转详细问题页面
	 */
	@RequestMapping("/to_question_detail")
	public ModelAndView toQuestionDetail(HttpServletRequest request,String questionId){
		request.setAttribute("questionId", questionId);
		return new ModelAndView("backstage/train/questions/question_detail");
	}
	

	/**
	 *跳转详细回复页面
	 */
	@RequestMapping("/to_answer_detail")
	public ModelAndView toAnswerDetail(HttpServletRequest request,String id){
		ModelAndView modelandview = new ModelAndView();
		try{
			TopicAnswerView topicAnswerView = null;
			if(id!=null){
				topicAnswerView = topicAnswerService.getById(Long.parseLong(id.trim()));
				if(topicAnswerView.getAnswerContent()!=null&&topicAnswerView.getAnswerContent()!=""){
					topicAnswerView.setAnswerContent(topicAnswerView.getAnswerContent().replace("\"", "\'").trim());
			    }
				modelandview.addObject(topicAnswerView);
		    	modelandview.setViewName("backstage/train/questions/answer_detail");
			}
		}catch(Exception e){
			log.error("跳转笔记详细信息页面失败",ExceptionUtil.getExceptionMessage(e));
		}
		return modelandview;
	}
	
	/**
	 * 获得问题datagrid
	 */
	@RequestMapping("/questions_datagrid")
	public void questionsDatagrid(HttpServletResponse response,TopicQuestionView topicQuestionsView) {
		super.writeJson(topicQuestionService.datagrid(topicQuestionsView),response);
	}

	/**
	 * 问题删除
	 */
	@RequestMapping("/delete_questions") 
	public void deleteQuestions(HttpServletResponse response,TopicQuestionView topicQuestionView){
		Json j = new Json();
		try{
			topicQuestionService.delete(topicQuestionView.getIds());
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("问题删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
	
	
	/**
	 * 详细问题
	 */
	@RequestMapping("/queryOneQuestion") 
	public void queryOneQuestion(HttpServletResponse response,HttpServletRequest request){
		Json j = new Json();
		try{
			String questionId = request.getParameter("questionId");
			TopicQuestionView topicQuestionView = topicQuestionService.getById(Long.parseLong(questionId.trim()));
			j.setObj(topicQuestionView);
			j.setSuccess(true);
			j.setMsg("查询成功！");
		} catch (Exception e) {
			log.error("详细问题查询失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("查询失败！");
		}
		super.writeJson(j,response);
	}

	/**
	 * 获得回答datagrid
	 */
	@RequestMapping("/answers_datagrid")
	public void answersDatagrid(HttpServletResponse response,HttpServletRequest request,TopicAnswerView topicAnswerView) {
		Long questionId = Long.parseLong(request.getParameter("questionId").trim());
		topicAnswerView.setQuestionId(questionId);
		super.writeJson(topicAnswerService.datagrid(topicAnswerView),response);
	}
	
	/**
	 * 回复删除
	 */
	@RequestMapping("/delete_answers") 
	public void deleteAnswers(HttpServletResponse response,TopicAnswerView topicAnswerView){
		Json j = new Json();
		try{
			topicAnswerService.delete(topicAnswerView.getIds());;
			j.setSuccess(true);
			j.setMsg("删除成功！");
		} catch (Exception e) {
			log.error("回复删除失败",ExceptionUtil.getExceptionMessage(e));
			j.setMsg("删除失败！");
		}
		
		super.writeJson(j,response);
	}
	
}
