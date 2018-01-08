package cn.bnsr.edu_yun.backstage.base.view;

public class LetterView extends PageBase {
	
	private Long id;
	
	private String ids;
	
	private Long user_id;//用户id
	
	private Long to_user_id;//相关用户id
	
	private Integer type;//1:发送2:接受
	
	private String letter_content;//
	
	private Integer is_read;//是否读过1，是2，否
	
	private String send_time;//
	
	private String sender;//发信人	
	
	private String receiver;//收信人
	
	private String timeStart;//起始时间
	
	private String timeEnd;//终止时间
	
	private int openId;//展开ID 

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUser_id() {
		return user_id;
	}

	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}

	public Long getTo_user_id() {
		return to_user_id;
	}

	public void setTo_user_id(Long to_user_id) {
		this.to_user_id = to_user_id;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getLetter_content() {
		return letter_content;
	}

	public void setLetter_content(String letter_content) {
		this.letter_content = letter_content;
	}

	public Integer getIs_read() {
		return is_read;
	}

	public void setIs_read(Integer is_read) {
		this.is_read = is_read;
	}

	public String getSend_time() {
		return send_time;
	}

	public void setSend_time(String send_time) {
		this.send_time = send_time;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getTimeEnd() {
		return timeEnd;
	}

	public void setTimeEnd(String timeEnd) {
		this.timeEnd = timeEnd;
	}

	public int getOpenId() {
		return openId;
	}

	public void setOpenId(int openId) {
		this.openId = openId;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}


}
