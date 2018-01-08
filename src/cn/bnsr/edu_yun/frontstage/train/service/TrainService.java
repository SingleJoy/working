package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.po.Train;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.CourseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainView;

public interface TrainService {

	List<TrainView> queryTrain(TrainView trainView);

	int queryTotalTrain(TrainView trainView);

	Long saveTrain(TrainView trainView);

	TrainView getByTrain(TrainView trainView);

	List<TrainView> queryTrainCenter(TrainView trainView);

	int queryTotalTrainCenter(TrainView trainView);

	Train getById(Long learnId);

	/**社区培训列表*/
	List<CommunityCenterView> queryCommunityTrain(CommunityCenterView ccv);
	/**社区培训总数*/
	int queryTotalCommunityTrain(CommunityCenterView ccv);
	
	/**加入的社区我的培训列表*/
	List<CommunityCenterView> queryMyCommunityTrain(CommunityCenterView ccv);
	/**加入的社区我的培训总数*/
	int queryTotalMyCommunityTrain(CommunityCenterView ccv);
	
	List<TrainView> queryMyTrain(TrainView trainView);
	
	 int queryMyTrainCount(TrainView trainView);
	 
	 /**后台*/
	 /**课程管理列表*/
	 public DataGrid datagrid(TrainView trainView);
	 
	 /**培训管理操作*/
	 void updateStatus(TrainView trainView);
	 
	 /**课程推荐、取消*/
	 void isRecommendTrain(TrainView trainView);
	 
	 /**查询最大推荐课程序号*/
	 int getMaxSeq();

}