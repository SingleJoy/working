package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.tiku.mapper.QuestionMapper;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.QuestionMaterialMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.Question;
import cn.bnsr.edu_yun.frontstage.tiku.po.QuestionMaterial;
import cn.bnsr.edu_yun.frontstage.tiku.service.QuestionService;
import cn.bnsr.edu_yun.frontstage.tiku.view.QuestionView;
import cn.bnsr.edu_yun.util.NumUtil;

public class QuestionServiceImpl implements QuestionService {
	@Autowired
	private QuestionMapper questionMapper;
	@Autowired
	private QuestionMaterialMapper questionMaterialMapper;

	@Override
	public List<QuestionView> queryQuestion(QuestionView questionView) {
		List<QuestionView> questionViews=questionMapper.queryQuestion(questionView);
		for(QuestionView q:questionViews){
			StringBuffer stem=new StringBuffer(q.getStem());
			int i=stem.indexOf("<img");
		   while(i>0){
			  int j=stem.indexOf("/>");
			 stem=stem.replace(i, j+2, " ");
			  q.setIsImg(1);
			  i=stem.indexOf("<img");
			}
		    String lastStem=new String(stem).replace("<p>","").replace("</p>","");
		    
			q.setStem(lastStem);
		}
		
		return questionViews;
	}

	@Override
	public int queryTotalCourse(QuestionView questionView) {
		return questionMapper.queryTotalCourse(questionView);
	}

	@Override
	public List<QuestionView> searchQuestion(String questionIds) {
		return questionMapper.searchQuestion(NumUtil.getList(questionIds));
	}

	@Override
	public int insertSelect(QuestionView questionView) {
		Question question = null;
		if(questionView.getId()!=null){
			question = questionMapper.selectByPrimaryKey(questionView.getId());
		}else{
			question = new Question();
		}
		question.setDifficulty(questionView.getDifficulty());
		question.setBelong_to(questionView.getBelong_to());
		question.setBelong_type(questionView.getBelong_type());
		question.setStem(questionView.getStem());
		// 分类，空
		question.setUser_id(questionView.getUserId());
		Date date = new Date();
		if (questionView.getId() == null) {
			question.setCreate_time(date);
		}
		question.setUpdate_time(date);
		question.setIs_son(questionView.getIs_son());
		question.setType(questionView.getType());
		question.setScore(questionView.getScore());
		question.setCourse_id(questionView.getCourseId());
		question.setAnalysis(questionView.getAnalysis());
		question.setIs_item(questionView.getIs_item());
		List<String> rightKeys = questionView.getRight_key();
		StringBuffer sb = new StringBuffer();
		for (String key : rightKeys) {
			if (sb.length() != 0) {
				sb.append(",");
			}
			sb.append(key);
		}
		String right_key = new String(sb);
		question.setRight_key(right_key);
		question.setOption_a(questionView.getOption_a());
		question.setOption_b(questionView.getOption_b());
		if(questionView.getOption_c()!=null&&!"".equals(questionView.getOption_c().trim())){
			question.setOption_c(questionView.getOption_c());
		}else{
			question.setOption_c(null);
		}
		if(questionView.getOption_d()!=null&&!"".equals(questionView.getOption_d().trim())){
			question.setOption_d(questionView.getOption_d());
		}else{
			question.setOption_d(null);
		}
		if(questionView.getOption_e()!=null&&!"".equals(questionView.getOption_e().trim())){
			question.setOption_e(questionView.getOption_e());
		}else{
			question.setOption_e(null);
		}
		if (questionView.getId() == null) {
			int i = questionMapper.insertSelective(question);
			if (questionView.getIs_son() == 0) {
				QuestionMaterial questionMaterial = new QuestionMaterial();
				Long question_id = questionView.getPid();
				questionMaterial.setQuestion_id(question_id);
				Long son_question_id = question.getId();
				questionMaterial.setSon_question_id(son_question_id);
				questionMaterialMapper.insert(questionMaterial);
			}
			return i;
		} else {
			question.setId(questionView.getId());
			return questionMapper.updateByPrimaryKeyWithBLOBs(question);
		}
	}

	@Override
	public int insertFill(QuestionView questionView) {
		Question question = new Question();
		question.setDifficulty(questionView.getDifficulty());
		question.setBelong_to(questionView.getBelong_to());
		question.setBelong_type(questionView.getBelong_type());
		// 分类，空
		question.setUser_id(questionView.getUserId());
		Date date = new Date();
		if (questionView.getId() == null) {
			question.setCreate_time(date);
		}
		question.setUpdate_time(date);
		question.setIs_son(questionView.getIs_son());
		question.setType(questionView.getType());
		question.setScore(questionView.getScore());
		question.setCourse_id(questionView.getCourseId());
		question.setAnalysis(questionView.getAnalysis());
		String stemStr = questionView.getStem();
		String regex = "\\[\\[";
		String[] strs = stemStr.split(regex);
		StringBuffer sb = new StringBuffer();
		StringBuffer sb1 = new StringBuffer();
		int i = 0;
		for (String str : strs) {
			if (i == 0) {
				sb.append(str);
			} else {
				int index = str.indexOf("]]");
				if (index != -1) {
					String c = str.substring(index + 2);
					if (sb1.length() != 0) {
						sb1.append(",");
					}
					sb1.append(str.substring(0, index));
					sb.append("______" + c);
				} else {
					sb.append(str + "[[");
				}
			}
			i++;
		}
		question.setStem(new String(sb));
		question.setRight_key(new String(sb1));
		if (questionView.getId() == null) {
			int i2 = questionMapper.insertSelective(question);
			if (questionView.getIs_son() == 0) {
				QuestionMaterial questionMaterial = new QuestionMaterial();
				Long question_id = questionView.getPid();
				questionMaterial.setQuestion_id(question_id);
				Long son_question_id = question.getId();
				questionMaterial.setSon_question_id(son_question_id);
				questionMaterialMapper.insert(questionMaterial);
			}
			return i2;
		} else {
			question.setId(questionView.getId());
			return questionMapper.updateByPrimaryKeySelective(question);
		}
	}

	@Override
	public int insertJudgeAndQa(QuestionView questionView) {
		Question question = new Question();
		question.setDifficulty(questionView.getDifficulty());
		question.setBelong_to(questionView.getBelong_to());
		question.setBelong_type(questionView.getBelong_type());
		// 分类，空
		question.setUser_id(questionView.getUserId());
		Date date = new Date();
		if (questionView.getId() == null) {
			question.setCreate_time(date);
		}
		question.setUpdate_time(date);
		question.setIs_son(questionView.getIs_son());
		question.setType(questionView.getType());
		question.setScore(questionView.getScore());
		question.setCourse_id(questionView.getCourseId());
		question.setAnalysis(questionView.getAnalysis());
		question.setStem(questionView.getStem());
		String rightKey="";
		for(String key:questionView.getRight_key()){
			rightKey+=key;
		}
		question.setRight_key(rightKey);
		if (questionView.getId() == null) {
			int i = questionMapper.insertSelective(question);
			questionView.setId(question.getId());
			if (questionView.getIs_son() == 0) {
				QuestionMaterial questionMaterial = new QuestionMaterial();
				Long question_id = questionView.getPid();
				questionMaterial.setQuestion_id(question_id);
				Long son_question_id = question.getId();
				questionMaterial.setSon_question_id(son_question_id);
				questionMaterialMapper.insert(questionMaterial);
			}
			return i;
		} else {
			question.setId(questionView.getId());
			return questionMapper.updateByPrimaryKeySelective(question);
		}
	}

	@Override
	public int insertScience(QuestionView questionView) {
		Question question = new Question();
		question.setDifficulty(questionView.getDifficulty());
		question.setBelong_to(questionView.getBelong_to());
		question.setBelong_type(questionView.getBelong_type());
		// 分类，空
		question.setUser_id(questionView.getUserId());
		Date date = new Date();
		if (questionView.getId() == null) {
			question.setCreate_time(date);
		}
		question.setUpdate_time(date);
		question.setIs_son(questionView.getIs_son());
		question.setType(questionView.getType());
		question.setScore(questionView.getScore());
		question.setCourse_id(questionView.getCourseId());
		question.setAnalysis(questionView.getAnalysis());
		question.setStem(questionView.getStem());
		if (questionView.getId() == null) {
			int i = questionMapper.insertSelective(question);
			questionView.setId(question.getId());
			return i;
		} else {
			question.setId(questionView.getId());
			return questionMapper.updateByPrimaryKeySelective(question);
		}
	}

	@Override
	public Question selectById(Long id) {

		return questionMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<QuestionView> querySonQuestion(QuestionView questionView) {

		return questionMapper.querySonQuestion(questionView);
	}

	@Override
	public int deleteQuestion(long id) {
		Question question = selectById(id);
		if (question.getIs_son() == 0) {
			questionMaterialMapper.deleteBySonId(id);
		}
		return questionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int querySonQuestionCount(QuestionView questionView) {

		return questionMapper.querySonQuestionCount(questionView);
	}

	@Override
	public List<Question> selectAllsonQuestion(Long id) {

		return questionMapper.selectAllsonQuestion(id);
	}

	@Override
	public QuestionView selectEveryQuestionTypeCount(QuestionView questionView) {

		return questionMapper.selectEveryQuestionTypeCount(questionView);
	}
	
}
