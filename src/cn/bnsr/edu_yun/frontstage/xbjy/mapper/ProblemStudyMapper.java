package cn.bnsr.edu_yun.frontstage.xbjy.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.xbjy.po.ProblemStudy;
import cn.bnsr.edu_yun.frontstage.xbjy.view.ProblemStudyView;

public interface ProblemStudyMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int insert(ProblemStudy record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int insertSelective(ProblemStudy record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    ProblemStudy selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int updateByPrimaryKeySelective(ProblemStudy record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int updateByPrimaryKeyWithBLOBs(ProblemStudy record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table problem_study
     *
     * @mbggenerated Sat Apr 01 12:54:33 CST 2017
     */
    int updateByPrimaryKey(ProblemStudy record);
    
    Integer countDiscussion(ProblemStudyView problemStudyView);
    
    List<ProblemStudyView>selectProblemList(ProblemStudyView problemStudyView);
    
    int selectProblemListCount(ProblemStudyView problemStudyView);
}