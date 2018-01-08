package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.base.po.User_attent;

public interface UserAttentService {

	public int insert(User_attent userAttent);
	public User_attent selectattent(long user_id,long attent_user_id);
	public List<User_attent>  myAttenation(User_attent userAttent);//查找我关注的人
	public List<User_attent>  myFans(User_attent userAttent);//查找我的粉丝
	public int delete(long id);//删除关注记录，取消关注
	public int queryTotalAttention(long userId);//我关注的人的总数
	public int queryTotalFans(long userId);//我的粉丝总数
	public User_attent selectById(Long UserId);//根据id查找
}
