package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.frontstage.train.po.Workshop;
import cn.bnsr.edu_yun.frontstage.train.view.CommunityCenterView;
import cn.bnsr.edu_yun.frontstage.train.view.DataStatsView;
import cn.bnsr.edu_yun.frontstage.train.view.StudentRelationView;
import cn.bnsr.edu_yun.frontstage.train.view.WorkshopView;

public interface WorkshopService {

	/**
	 * 社区里工作坊列表
	 * 
	 * @param workshopView
	 * @return
	 */
	public List<WorkshopView> showWorkshop(WorkshopView workshopView);

	/**
	 * 创建工作坊
	 * 
	 * @param workshop
	 * @return
	 */
	public int addWorkshop(Workshop workshop);

	/**
	 * 修改工作坊
	 * 
	 * @param workshop
	 * @return
	 */
	public int updateWorkshop(Workshop workshop);

	int queryWorkshopCount(WorkshopView workshopView);

	public Workshop getOne(Long id);
	
	WorkshopView showWorkshopById(Long id);

	/**工作坊数据统计*/
	public List<DataStatsView> workshopDataStats(DataStatsView dataStatsView);
	
	  List<WorkshopView> queryMyWorkshop(WorkshopView workshopView);

    public List<Workshop> queryWorkshops();
    
    List<WorkshopView> queryWorkshopCommunity(CommunityCenterView communityCenterView);

    int queryWorkshopCommunityCount(CommunityCenterView communityCenterView);

    int queryMyWorkshopCount(WorkshopView workshopView);
    
    //后台
    DataGrid datagrid(WorkshopView workshopView);
    /**
	 * 推荐时获取最大推荐序号
	 */
    Long getMaxSeq(Long community_id);
    
    DataGrid masterDatagrid(StudentRelationView student);
    
}
