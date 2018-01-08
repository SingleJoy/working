package cn.bnsr.edu_yun.frontstage.tiku.view;

import cn.bnsr.edu_yun.backstage.base.view.PageBase;

public class TestPaperQuestionView extends PageBase{
	
	private long id;
	private long question_id;
	private long parent_question_id;
	private long testPaper_id;
	private Integer questions_number;
	private String stem;
	private int type;
	private int difficulty;
	private double questions_score;
	private long belong_to;
	private int belong_type;
	private String hour_title;
	private String option_a;//选项A
	private String option_b;//B
	private String option_c;//C
	private String option_d;//D
	private String option_e;//E
	private String right_key;
	private Integer is_son;
	private String answer;//回答
	private long exam_id;//考试id，具体的某人的考试
	private long exam_answer_id;//具体某人做的题目的id
	private Double answer_score;//考试中一题的得分
	private int is_right;//是否正确,0-对；1-错
	private String answer_comment;//题目评价
	private String exam_comment;//考试评价
	private int status;//处理子题筛选问答题用
	private Integer question_status;//问题的状态 1-正常 2-已删除
	private Integer question_type;//删除后 记录问题类型
	private Integer question_is_son;//删除后记录问题是否是子题 0-是 1-否
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(long question_id) {
		this.question_id = question_id;
	}
	public long getParent_question_id() {
		return parent_question_id;
	}
	public void setParent_question_id(long parent_question_id) {
		this.parent_question_id = parent_question_id;
	}
	public long getTestPaper_id() {
		return testPaper_id;
	}
	public void setTestPaper_id(long testPaper_id) {
		this.testPaper_id = testPaper_id;
	}
	public Integer getQuestions_number() {
		return questions_number;
	}
	public void setQuestions_number(Integer questions_number) {
		this.questions_number = questions_number;
	}
	public String getStem() {
		return stem;
	}
	public void setStem(String stem) {
		this.stem = stem;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(int difficulty) {
		this.difficulty = difficulty;
	}
	public double getQuestions_score() {
		return questions_score;
	}
	public void setQuestions_score(double questions_score) {
		this.questions_score = questions_score;
	}
	public long getBelong_to() {
		return belong_to;
	}
	public void setBelong_to(long belong_to) {
		this.belong_to = belong_to;
	}
	public int getBelong_type() {
		return belong_type;
	}
	public void setBelong_type(int belong_type) {
		this.belong_type = belong_type;
	}
	public String getHour_title() {
		return hour_title;
	}
	public void setHour_title(String hour_title) {
		this.hour_title = hour_title;
	}
	public String getOption_a() {
		return option_a;
	}
	public void setOption_a(String option_a) {
		this.option_a = option_a;
	}
	public String getOption_b() {
		return option_b;
	}
	public void setOption_b(String option_b) {
		this.option_b = option_b;
	}
	public String getOption_c() {
		return option_c;
	}
	public void setOption_c(String option_c) {
		this.option_c = option_c;
	}
	public String getOption_d() {
		return option_d;
	}
	public void setOption_d(String option_d) {
		this.option_d = option_d;
	}
	public String getOption_e() {
		return option_e;
	}
	public void setOption_e(String option_e) {
		this.option_e = option_e;
	}
	public String getRight_key() {
		return right_key;
	}
	public void setRight_key(String right_key) {
		this.right_key = right_key;
	}
	public Integer getIs_son() {
		return is_son;
	}
	public void setIs_son(Integer is_son) {
		this.is_son = is_son;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public long getExam_id() {
		return exam_id;
	}
	public void setExam_id(long exam_id) {
		this.exam_id = exam_id;
	}
	public long getExam_answer_id() {
		return exam_answer_id;
	}
	public void setExam_answer_id(long exam_answer_id) {
		this.exam_answer_id = exam_answer_id;
	}
	public int getIs_right() {
		return is_right;
	}
	public void setIs_right(int is_right) {
		this.is_right = is_right;
	}
	public String getAnswer_comment() {
		return answer_comment;
	}
	public void setAnswer_comment(String answer_comment) {
		this.answer_comment = answer_comment;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Double getAnswer_score() {
		return answer_score;
	}
	public void setAnswer_score(Double answer_score) {
		this.answer_score = answer_score;
	}
	public String getExam_comment() {
		return exam_comment;
	}
	public void setExam_comment(String exam_comment) {
		this.exam_comment = exam_comment;
	}
	public Integer getQuestion_status() {
		return question_status;
	}
	public void setQuestion_status(Integer question_status) {
		this.question_status = question_status;
	}
	public Integer getQuestion_type() {
		return question_type;
	}
	public void setQuestion_type(Integer question_type) {
		this.question_type = question_type;
	}
	public Integer getQuestion_is_son() {
		return question_is_son;
	}
	public void setQuestion_is_son(Integer question_is_son) {
		this.question_is_son = question_is_son;
	}
}
