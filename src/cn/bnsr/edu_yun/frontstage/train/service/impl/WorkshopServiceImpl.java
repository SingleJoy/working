package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.StudentRelationMapper;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.mapper.WorkshopMapper;
import cn.bnsr.edu_yun.frontstage.train.po.Workshop;
import cn.bnsr.edu_yun.frontstage.train.service.WorkshopService;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.StudentRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.WorkshopView;
import cn.bnsr.edu_yun.util.NumUtil;

public class WorkshopServiceImpl implements WorkshopService {

	@Autowired
	private WorkshopMapper workshopMapper;
	@Autowired
	private StudentRelationMapper studentRelationMapper;

	@Override
	public List<WorkshopView> showWorkshop(WorkshopView workshopView) {

		return workshopMapper.showWorkshop(workshopView);
	}

	@Override
	public int addWorkshop(Workshop workshop) {

		return workshopMapper.insertSelective(workshop);
	}

	@Override
	public int queryWorkshopCount(WorkshopView workshopView) {

		return workshopMapper.queryWorkshopCount(workshopView);
	}

	@Override
	public int updateWorkshop(Workshop workshop) {

		return workshopMapper.updateByPrimaryKeySelective(workshop);
	}

	@Override
	public Workshop getOne(Long id) {
		return workshopMapper.selectByPrimaryKey(id);
	}

	@Override
	public WorkshopView showWorkshopById(Long id) {

		WorkshopView workshopView = workshopMapper.showWorkshopById(id);
		List<StudentRelationView> studentRelationViews = studentRelationMapper.findWorkUser(id);
		List<StudentRelationView> studentRelationViews2 = studentRelationMapper.findWorkExpert(id);
		String username = "";
		String masterids = "";
		String expert="";
		for (StudentRelationView studentRelationView : studentRelationViews) {
			if (studentRelationView != null && studentRelationView.getUsername() != null) {
				username += studentRelationView.getUsername() + " ";
				masterids += studentRelationView.getUser_id()+",";
			}
		}
		if(studentRelationViews2!=null)
		for (StudentRelationView studentRelationView : studentRelationViews2) {
			if (studentRelationView != null && studentRelationView.getUsername() != null) {
				expert += studentRelationView.getUsername() + " ";
			}
		}
		workshopView.setWorkshop_user(username);
		if(masterids.length()>2){
			workshopView.setIds(masterids.substring(0, masterids.length()-1));
		}
		workshopView.setExpert(expert);
		return workshopView;
	}

	@Override
	public List<DataStatsView> workshopDataStats(DataStatsView dataStatsView) {
		return workshopMapper.workshopDataStats(dataStatsView);
	}

	@Override
	public List<WorkshopView> queryMyWorkshop(WorkshopView workshopView) {

		return workshopMapper.queryMyWorkshop(workshopView);
	}

	@Override
	public List<Workshop> queryWorkshops() {
		return workshopMapper.queryWorkshops();
	}

	@Override
	public List<WorkshopView> queryWorkshopCommunity(CommunityCenterView communityCenterView) {

		return workshopMapper.queryWorkshopCommunity(communityCenterView);
	}

	@Override
	public int queryWorkshopCommunityCount(CommunityCenterView communityCenterView) {

		return workshopMapper.queryWorkshopCommunityCount(communityCenterView);
	}

	@Override
	public int queryMyWorkshopCount(WorkshopView workshopView) {

		return workshopMapper.queryMyWorkshopCount(workshopView);
	}

	public List<WorkshopView> search(WorkshopView workshopView) {
		return workshopMapper.search(workshopView);
	}

	public Long total(WorkshopView workshopView) {
		return workshopMapper.total(workshopView);
	}

	@Override
	public DataGrid datagrid(WorkshopView workshopView) {
		DataGrid j = new DataGrid();
		workshopView.setPage(NumUtil.startingNum(workshopView.getPage(), workshopView.getRows()));
		j.setRows(search(workshopView));
		j.setTotal(total(workshopView));
		return j;
	}

	@Override
	public Long getMaxSeq(Long community_id) {
		return workshopMapper.getMaxSeq(community_id);
	}

	@Override
	public DataGrid masterDatagrid(StudentRelationView student) {
		DataGrid j = new DataGrid();
		if(student.getSource_id()!=null){
			student.setSource_type(0);
			student.setPage(NumUtil.startingNum(student.getPage(), student.getRows()));
			j.setRows(studentRelationMapper.findAll(student));
			j.setTotal(Long.valueOf(studentRelationMapper.countStudent(student)));
		}
		return j;
	}
}
