package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.AreaView;
import cn.bnsr.edu_yun.frontstage.base.mapper.AreaMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.BookCatMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.PubverListMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.SubjectListMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Area;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;
import cn.bnsr.edu_yun.frontstage.base.service.AreaService;

public class AreaServiceImpl implements AreaService{

	@Autowired 
	private AreaMapper areaMapper;
	@Autowired
	private SubjectListMapper subjectmapper;
	@Autowired
	private PubverListMapper pubvermapper;
	@Autowired
	private BookCatMapper bookCatMapper;
	@Override
	public int insertArea(Area area) {
		// TODO Auto-generated method stub
		return areaMapper.insertSelective(area);
	}

	@Override
	public List<Area> selectByPid(String parentId) {
		// TODO Auto-generated method stub
		return areaMapper.selectByPid(parentId);
	}

	@Override
	public int update(Area area) {
		// TODO Auto-generated method stub
		return areaMapper.updateByPrimaryKeySelective(area);
	}

	@Override
	public Area selectByid(String id) {
		// TODO Auto-generated method stub
		return areaMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Area> selectAll() {
		// TODO Auto-generated method stub
		return areaMapper.selectAll();
	}

	@Override
	public int insertSubject(SubjectList subject) {
		// TODO Auto-generated method stub
		return subjectmapper.insertSelective(subject);
	}

	@Override
	public int insertPubver(PubverList pubver) {
		// TODO Auto-generated method stub
		return pubvermapper.insertSelective(pubver);
	}

	@Override
	public List<SubjectList> selectSAll() {
		// TODO Auto-generated method stub
		return subjectmapper.selectAll();
	}

	@Override
	public List<PubverList> seletPAll() {
		// TODO Auto-generated method stub
		return pubvermapper.selectAll();
	}

	@Override
	public int insertBook(BookCat book) {
		// TODO Auto-generated method stub
		return bookCatMapper.insertSelective(book);
	}

	@Override
	public List<PubverList> selectAllProject(String str, String sub) {
		// TODO Auto-generated method stub
		return pubvermapper.selectAllProject(str, sub);
	}

	@Override
	public int deleteArea(String id) {
		// TODO Auto-generated method stub
		return areaMapper.deleteByPrimaryKey(id);
	}

	@Override
	public Area selectByArea_id(String area_id) {
		// TODO Auto-generated method stub
		return areaMapper.selectByArea_id(area_id);
	}

	


	@Override
	public void openArea(String ids,String parentId) {
		areaMapper.closeArea(parentId);
		for(String id:ids.split(",")){
			Area area = new Area();
			area.setId(id);
			area.setIs_open(0);//开放
			areaMapper.updateByPrimaryKeySelective(area);
		}
	}

	@Override
	public List<Area> queryArea(String paranetId) {
		return areaMapper.selectByPid(paranetId);
	}


	@Override
	public List<Area> selectProvinceList(Area area) {
		// TODO Auto-generated method stub
		return areaMapper.selectProvinceList(area);
	}

	@Override
	public Area selectByName(String area_name) {
		return areaMapper.selectByName(area_name);
	}




	
}
