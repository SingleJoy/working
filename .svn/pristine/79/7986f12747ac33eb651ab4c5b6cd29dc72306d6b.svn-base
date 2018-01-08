package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.LabelView;
import cn.bnsr.edu_yun.frontstage.base.mapper.LabelMapper;
import cn.bnsr.edu_yun.frontstage.base.po.Label;
import cn.bnsr.edu_yun.frontstage.base.service.LabelService;
import cn.bnsr.edu_yun.util.NumUtil;

public class LabelServiceImpl implements LabelService{
	@Autowired
	private LabelMapper labelMapper;
	
	@Override
	public DataGrid datagrid(LabelView labelView) {
		DataGrid j = new DataGrid();
		labelView.setPage(NumUtil.startingNum(labelView.getPage(),labelView.getRows()));
		j.setRows(changeModel(find(labelView)));
		j.setTotal(total(labelView));
		return j;
	}
	
	private List<LabelView> changeModel(List<Label> labelList) {
		List<LabelView> labels = new ArrayList<LabelView>();
		if (labelList != null && labelList.size() > 0) {
			for (Label tu : labelList) {
				LabelView u = new LabelView();
				BeanUtils.copyProperties(tu, u);
				labels.add(u);
			}
		}
		return labels;
	}
	
	private List<Label> find(LabelView labelView) {
		return labelMapper.find(labelView);
	}

	private Long total(LabelView labelView) {
		return labelMapper.count(labelView);
	}
	

	@Override
	public void save(LabelView labelView) {
		Label r = new Label();
		BeanUtils.copyProperties(labelView, r);
		r.setCreate_time(new Date());
		labelMapper.insertSelective(r);
		
	}

	@Override
	public void update(LabelView labelView) {
		Label r = new Label();
		BeanUtils.copyProperties(labelView, r);
		labelMapper.updateByPrimaryKeySelective(r);
		
	}

	@Override
	public void delete(String ids) {
		if (ids != null) {
			for (String id : ids.split(",")) {
				labelMapper.deleteByPrimaryKey(Long.parseLong(id.trim()));
			}
		}
	}

	@Override
	public List<Label> findAllLabel(int type) {
		return labelMapper.findAllLabel(type);
	}


}
