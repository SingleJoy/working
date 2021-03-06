package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CourseHourFile;
import cn.bnsr.edu_yun.frontstage.train.view.CourseHourFileView;

public interface CourseHourFileService {

	void saveHourFile(CourseHourFile courseHourFile);

	List<CourseHourFileView> getHourFile(String hourId);

	void deleteHourFile(String id);

	void deleteByHourId(String hourId);
	
}
