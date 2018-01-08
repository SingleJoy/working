package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.AreaView;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;

public interface AreaService {

	public int insertArea(Area area);
	List<Area> selectByPid(String parentId);
	int update(Area area);
	Area selectByid(String id);
	List<Area> selectAll();
	List<SubjectList> selectSAll();
	List<PubverList> seletPAll();
	int	insertBook(BookCat book);
	int	insertSubject(SubjectList subject);
	int insertPubver(PubverList pubver);
	List<PubverList> selectAllProject(String str,String sub);
	int deleteArea(String id);
	Area selectByArea_id(String area_id);
	
	List<Area> queryArea(String paranetId);
	
	void openArea(String ids,String parentId);
	
	Area selectByName(String area_name);
	
	List<Area> selectProvinceList(Area area);
}
