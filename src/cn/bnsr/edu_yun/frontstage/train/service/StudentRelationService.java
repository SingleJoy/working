package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.StudentRelation;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.StudentRelationView;

public interface StudentRelationService {

	Integer countStudent(StudentRelationView student);
	
	void saveStudentRelation(StudentRelation student);
	
	void updateStudentRelation(StudentRelation student);
	
	List<StudentRelationView> findAll(StudentRelationView student);
	
	void delStudentRelation(Long id);
	
	List<StudentRelationView> exportStudent(Long source_id,Integer source_type,String ids);

	/**用户数据统计*/
	List<DataStatsView> studentDataStats(DataStatsView dataStatsView);

	/**退出社区/工作坊 */
	void quitStudent(String source_id, String source_type, Long user_id);
	
	List<StudentRelationView> findWorkUSer(Long source_id);
	
	List<StudentRelationView> findWorkExpert (Long source_id);
	
	/**清除社区/工作坊的角色 */
	void clearStudent(Long source_id, int i, int role_type);
	
	/**获取社区/工作坊某类人姓名，以，拼接*/
	String getStuNames(Long source_id,int source_type,int role_type);
	
	/**获取社区/工作坊某类人id，以，拼接*/
	String getStuIds(Long source_id,int source_type,int role_type);

}
