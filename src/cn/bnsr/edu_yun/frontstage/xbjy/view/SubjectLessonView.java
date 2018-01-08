package cn.bnsr.edu_yun.frontstage.xbjy.view;

public class SubjectLessonView extends LessonView{

	private String str;
	private String subject_title;

	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		setSubject_title(str);
		if(str.equals("YW")){
			this.str="IN (\"CZ001\",\"GZ001\",\"XX001\")";
		}else if(str.equals("SX")){
			this.str="IN (\"CZ002\",\"GZ002\",\"XX002\")";
		}else if(str.equals("WY")){
			this.str="IN (\"CZ003\",\"GZ003\",\"XX003\")";
		}else if(str.equals("WL")){
			this.str="IN (\"CZ005\",\"GZ005\")";
		}else if(str.equals("HX")){
			this.str="IN (\"CZ006\",\"GZ006\")";
		}else if(str.equals("SW")){
			this.str="IN (\"CZ007\",\"GZ008\")";
		}else if(str.equals("DL")){
			this.str="IN (\"CZ012\",\"GZ009\")";
		}else if(str.equals("LS")){
			this.str="IN (\"CZ009\",\"GZ007\")";
		}else if(str.equals("ZZ")){
			this.str="IN (\"GZ004\")";
		}else if(str.equals("QT")){
			this.str="NOT IN (\"CZ001\",\"GZ001\",\"XX001\",\"CZ002\",\"GZ002\",\"XX002\",\"CZ003\",\"GZ003\",\"XX003\",\"CZ005\",\"GZ005\",\"CZ006\",\"GZ006\",\"CZ007\",\"GZ008\",\"CZ012\",\"GZ009\",\"CZ009\",\"GZ007\",\"GZ004\")";
		}
		
		
	}

	public String getSubject_title() {
		return subject_title;
	}

	public void setSubject_title(String subject_title) {
		this.subject_title = subject_title;
	}
}
