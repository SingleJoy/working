package cn.bnsr.edu_yun.frontstage.xbjy.view;

public class MemberStatisticsView {
	
	private String true_name;
	
	private int taskTotal;
	private int accomplishedTotal;
	private int articleTotal;
	public String getTrue_name() {
		return true_name;
	}
	public void setTrue_name(String true_name) {
		this.true_name = true_name;
	}
	public int getTaskTotal() {
		return taskTotal;
	}
	public void setTaskTotal(int taskTotal) {
		this.taskTotal = taskTotal;
	}
	public int getAccomplishedTotal() {
		return accomplishedTotal;
	}
	public void setAccomplishedTotal(int accomplishedTotal) {
		this.accomplishedTotal = accomplishedTotal;
	}
	public int getArticleTotal() {
		return articleTotal;
	}
	public void setArticleTotal(int articleTotal) {
		this.articleTotal = articleTotal;
	}
	public int getProblemTotal() {
		return problemTotal;
	}
	public void setProblemTotal(int problemTotal) {
		this.problemTotal = problemTotal;
	}
	private int problemTotal;

}
