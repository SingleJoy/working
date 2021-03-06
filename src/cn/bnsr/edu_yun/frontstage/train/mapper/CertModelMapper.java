package cn.bnsr.edu_yun.frontstage.train.mapper;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CertModel;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelView;

public interface CertModelMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int deleteByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int insert(CertModel record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int insertSelective(CertModel record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    CertModel selectByPrimaryKey(Long id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int updateByPrimaryKeySelective(CertModel record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int updateByPrimaryKeyWithBLOBs(CertModel record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table cert_model
     *
     * @mbggenerated Tue Mar 28 10:57:01 CST 2017
     */
    int updateByPrimaryKey(CertModel record);
    
    List<CertModelView> selectAllCertModel(CertModelView certModelView);
    
    Integer countCertModel(CertModelView certModelView);
    
    CertModelView queryCertModel(Long id);
}