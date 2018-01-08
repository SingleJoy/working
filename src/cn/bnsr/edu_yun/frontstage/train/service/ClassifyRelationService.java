package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.ClassifyRelation;
import cn.bnsr.edu_yun.frontstage.train.view.ClassifyRelationView;

public interface ClassifyRelationService {

	void saveClassifyRelation(ClassifyRelation classify);
	
	void updateClassifyRelation(ClassifyRelation classify);
	
	List<ClassifyRelationView> queryAllClassify(ClassifyRelationView classify);
	
	ClassifyRelation selectOne(Long id);
	
	void deleteClassify(Long id);
	
	List<ClassifyRelation> queryCLassifysByPid(Long parentId,Integer sourceType,
			Integer type);
	
	List<ClassifyRelation> getSonClassifys(Long parent_id);
	
	int countClassifyRelation(ClassifyRelationView classify);
	
	Integer getMaxSeq(ClassifyRelationView classify);
}
