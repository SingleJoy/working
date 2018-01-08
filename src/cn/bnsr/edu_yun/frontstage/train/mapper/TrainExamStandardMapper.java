package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.bnsr.edu_yun.frontstage.train.po.TrainExamStandard;
import cn.bnsr.edu_yun.frontstage.train.view.TrainExamStandardView;

public interface TrainExamStandardMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insert(TrainExamStandard record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int insertSelective(TrainExamStandard record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    TrainExamStandard selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKeySelective(TrainExamStandard record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table train_exam_standard
     *
     * @mbggenerated Tue Dec 20 15:07:28 CST 2016
     */
    int updateByPrimaryKey(TrainExamStandard record);
    
	List<TrainExamStandardView> queryExamStandard(@Param("trainId")Long trainId,@Param("type")int type);

	TrainExamStandardView queryByTrainId(Long trainId);
	
	List<TrainExamStandardView> queryTrainParseCountMessage(@Param("id")long id,@Param("type")int type);
}