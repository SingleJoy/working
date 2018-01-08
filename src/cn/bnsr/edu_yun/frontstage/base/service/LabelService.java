package cn.bnsr.edu_yun.frontstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.LabelView;
import cn.bnsr.edu_yun.frontstage.base.po.Label;

public interface LabelService {

	public DataGrid datagrid(LabelView labelView);

	public void save(LabelView labelView);

	public void update(LabelView labelView);

	public void delete(String ids);

	/**查询所有标签，0-资源；1-课程*/
	public List<Label> findAllLabel(int type);


}
