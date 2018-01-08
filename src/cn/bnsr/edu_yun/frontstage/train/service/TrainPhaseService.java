package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.view.TrainPhaseView;
import cn.bnsr.edu_yun.frontstage.train.view.TrainView;

public interface TrainPhaseService {

	List<TrainPhaseView> queryTrainPhase(Long trainId,Long userId);

	void saveTrainPhase(TrainPhaseView trainPhaseView);

	void deleteTrainPhase(Long id);
	
	/**查询该培训所有阶段总学时要求*/
	int searchTotalHours(Long trainId);
	/** 查询培训是否存在至少一个阶段 */
	int queryPhaseOfTrainPhaseCount(Long train_id);
	/* 查询培训对应的阶段 */
	List<TrainPhaseView> queryTrainParseBaseMessage(TrainView trainView);
}
