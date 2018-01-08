package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.content.view.ContentStatiView;
import cn.bnsr.edu_yun.backstage.train.view.UserAppraiseView;
import cn.bnsr.edu_yun.frontstage.base.mapper.AppraiseReasonMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.UserAppraiseReasonMapper;
import cn.bnsr.edu_yun.frontstage.base.po.AppraiseReason;
import cn.bnsr.edu_yun.frontstage.base.po.UserAppraiseReason;
import cn.bnsr.edu_yun.frontstage.train.mapper.UserAppraiseMapper;
import cn.bnsr.edu_yun.frontstage.train.po.UserAppraise;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.train.view.AppraiseReasonView;
import cn.bnsr.edu_yun.frontstage.train.view.UserAppraisView;
import cn.bnsr.edu_yun.util.NumUtil;

public class UserAppraiseServiceImpl implements UserAppraiseService{
	@Autowired
	private UserAppraiseMapper userAppraiseMapper;
	@Autowired
	private AppraiseReasonMapper appraiseReasonMapper;
	@Autowired
	private UserAppraiseReasonMapper userAppraiseReasonMapper;
	@Override
	public int insertAppraise(UserAppraise userAppraise) {
		
		return userAppraiseMapper.insertSelective(userAppraise);
	}

	@Override
	public int updateAppraise(UserAppraise userAppraise) {
		
		return userAppraiseMapper.updateByPrimaryKeySelective(userAppraise);
	}

	@Override
	public UserAppraise selectById(Long id) {
		
		return userAppraiseMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<UserAppraisView> selectBySourceId(long sourceId, long start,
			long pageSize,int sourceType) {
		return  userAppraiseMapper.selectBySourceId(sourceId, start, pageSize,sourceType);
	}

	@Override
	public long selectCountBySourceId(long sourceId,int sourceType) {
		
		return userAppraiseMapper.selectCountBySourceId(sourceId,sourceType);
	}

	@Override
	public UserAppraise selectByCourseIdAndUserId(long user_id, long course_id, int source_type) {
		
		return userAppraiseMapper.selectByCourseIdAndUserId(user_id, course_id, source_type);
	}
	
	@Override
	public DataGrid datagrid(UserAppraiseView userAppraiseView) {
		DataGrid j = new DataGrid();
		userAppraiseView.setPage(NumUtil.startingNum(userAppraiseView.getPage(),userAppraiseView.getRows()));
		j.setRows(userAppraiseMapper.search(userAppraiseView));
		j.setTotal(userAppraiseMapper.count(userAppraiseView));
		return j;
	}
	
	@Override
	public void delete(String ids) {
		if(ids!=null){
			for(String id:ids.split(",")){
				userAppraiseMapper.deleteByPrimaryKey(Long.parseLong(id.trim()));
			}
		}

	}

	@Override
	public UserAppraiseView getById(Long id,Integer source_type) {
		 return userAppraiseMapper.getById(id,source_type);
	}

	@Override
	public Integer selectTotalScore(long sourceId,int sourceType) {
		
		return userAppraiseMapper.selectTotalScore(sourceId,sourceType);
	}
	

	@Override
	public void updateStatus(String ids, String status) {
		if(ids!=null&&status!=null){
			String[] keys = ids.split(",");
			String[] states = status.split(",");
			for(int i=0;i<keys.length;i++){
				UserAppraise userAppraise = new UserAppraise();
				userAppraise.setId(Long.parseLong(keys[i].trim()));
				userAppraise.setStatus(Integer.parseInt(states[i].trim()));
				userAppraiseMapper.updateByPrimaryKeySelective(userAppraise);
			}
		}
		
	}

	@Override
	public List<ContentStatiView> userAppriContentStati(
			ContentStatiView contentStatiView) {
		return userAppraiseMapper.userAppriContentStati(contentStatiView);
	}
	@Override
	public DataGrid datagrid(AppraiseReasonView appraiseReasonView) {
		DataGrid j = new DataGrid();
		appraiseReasonView.setPage(NumUtil.startingNum(appraiseReasonView.getPage(),appraiseReasonView.getRows()));
		j.setRows(slectAll(appraiseReasonView));
		j.setTotal(total());
		return j;
	}
	
	private Long total() {
		
		return appraiseReasonMapper.total();
	}

	private List<AppraiseReasonView> slectAll(AppraiseReasonView appraiseReasonView) {
		
		return appraiseReasonMapper.selectAll(appraiseReasonView);
	}

	@Override
	public void saveReason(AppraiseReason appraiseReason) {
		Date date =new Date();
		appraiseReason.setCreate_time(date);
		appraiseReason.setUpdate_time(date);
		appraiseReasonMapper.insertSelective(appraiseReason);
		}

	@Override
	public void deleteReason(Long id) {
		
		appraiseReasonMapper.deleteByPrimaryKey(id);
		
	}

	@Override
	public void updateReason(AppraiseReason appraiseReason) {
		appraiseReason.setUpdate_time(new Date());
		appraiseReasonMapper.updateByPrimaryKeySelective(appraiseReason);
		}

	@Override
	public List<AppraiseReasonView> selectByType(AppraiseReasonView appraiseReasonView) {
	
		return appraiseReasonMapper.selectByType(appraiseReasonView);
	}

	@Override
	public int insertAppraiseReason(UserAppraiseReason u) {
		
		return userAppraiseReasonMapper.insertSelective(u);
	}
}
