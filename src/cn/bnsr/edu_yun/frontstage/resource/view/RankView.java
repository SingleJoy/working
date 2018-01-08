package cn.bnsr.edu_yun.frontstage.resource.view;

import java.io.Serializable;

public class RankView implements Serializable{
	
	private static final long serialVersionUID = 4186702992383074451L;

	private String username;
	
	private int uploadCount;
	
	private long  user_id;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getUploadCount() {
		return uploadCount;
	}

	public void setUploadCount(int uploadCount) {
		this.uploadCount = uploadCount;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}



}
