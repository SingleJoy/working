package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.train.view.TrainExamStandardView;

public interface TrainExamStandardService {

	TrainExamStandardView queryByTrainId(Long trainId);
	
	void saveOrUpdate(TrainExamStandardView standardView);

	List<TrainExamStandardView> queryExamStandard(Long trainId,int type);
	/** 根据培训id和培训类型获取必修选修学时等信息 */
	List<TrainExamStandardView> queryTrainParseCountMessage(long id,int type);
}
