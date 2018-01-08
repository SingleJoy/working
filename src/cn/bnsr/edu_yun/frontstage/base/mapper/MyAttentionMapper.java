package cn.bnsr.edu_yun.frontstage.base.mapper;

import cn.bnsr.edu_yun.frontstage.base.view.MyAttentionView;

public interface MyAttentionMapper {
	public MyAttentionView showMyAttenation(MyAttentionView myAttentionView);//展示我关注的人
	public MyAttentionView showMyFans(MyAttentionView myAttentionView);//展示我的粉丝
	public int showMyAttenationCount(MyAttentionView myAttentionView);//展示我关注的人数量
	public int showMyFansCount(MyAttentionView myAttentionView);//展示我的粉丝数量

}
