package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.backstage.train.view.UserAppraiseView;
import cn.bnsr.edu_yun.frontstage.base.po.AppraiseReason;
import cn.bnsr.edu_yun.frontstage.base.po.UserAppraiseReason;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;

public interface UserAppraiseService {
	/**
	 * 新增评价
	 * @param userAppraise
	 * @return
	 */
	public int insertAppraise(UserAppraise userAppraise);
	/**
	 * 修改评价
	 * @param userAppraise
	 * @return
	 */
	public int updateAppraise(UserAppraise userAppraise);
	/**
	 * 主键查询
	 * @param id
	 * @return
	 */
	public UserAppraise selectById(Long id);
	/**
	 * fangxiongwei modify
	 * 通过id\来源类型0-课程；1-培训；2-班级
	 * 分页查询所有评价
	 */
	public List<UserAppraisView>  selectBySourceId(long sourceId,long start,long pageSize,int sourceType);
	
	/**
	 * fangxiongwei modify
	 * 通过id\来源类型0-课程；1-培训；2-班级查询所有评价的总数
	 */
	public long selectCountBySourceId(long sourceId,int sourceType);
	
	public UserAppraise selectByCourseIdAndUserId(long user_id,long course_id,int source_type);
	
    public DataGrid datagrid(UserAppraiseView cev);
	
	public void delete(String ids);
	
	public UserAppraiseView getById(Long id,Integer source_type);
	
	//改变状态
	public void updateStatus(String ids,String status);
    
   
	/**
	 * 总评价分数
	 * @param course_id
	 * @return
	 */
	Integer selectTotalScore(long sourceId,int sourceType);
	
	/**
	 * 查询评价统计信息
	 * @param contentStatiView
	 * @return
	 */
	List<ContentStatiView> userAppriContentStati(ContentStatiView contentStatiView);
	
	DataGrid datagrid(AppraiseReasonView appraiseReasonview);
	
	 void saveReason(AppraiseReason appraiseReason);
	
	 void deleteReason(Long id);
	
	 void updateReason(AppraiseReason appraiseReason);
	 
	 List<AppraiseReasonView> selectByType(AppraiseReasonView appraiseReasonView);
	 
	 int insertAppraiseReason(UserAppraiseReason u);
}
