package cn.bnsr.edu_yun.backstage.base.view;

import java.util.List;

public class SubjectView {

			private	String id;
			private	String pid;
			private String text;
			private String state = "open";
			private boolean checked;
			private String iconcls;
			private List<SubjectView> children;
			private String name="默认";
			private String pname;
			
			public String getId() {
				return id;
			}
			public void setId(String id) {
				this.id = id;
			}
			public String getPid() {
				return pid;
			}
			public void setPid(String pid) {
				this.pid = pid;
			}
			public String getText() {
				return text;
			}
			public void setText(String text) {
				this.text = text;
			}
			public String getState() {
				return state;
			}
			public void setState(String state) {
				this.state = state;
			}
			public boolean isChecked() {
				return checked;
			}
			public void setChecked(boolean checked) {
				this.checked = checked;
			}
			public String getIconcls() {
				return iconcls;
			}
			public void setIconcls(String iconcls) {
				this.iconcls = iconcls;
			}
			public List<SubjectView> getChildren() {
				return children;
			}
			public void setChildren(List<SubjectView> children) {
				this.children = children;
			}
			public String getName() {
				return name;
			}
			public void setName(String name) {
				this.name = name;
			}
			public String getPname() {
				return pname;
			}
			public void setPname(String pname) {
				this.pname = pname;
			}
			
			
}
