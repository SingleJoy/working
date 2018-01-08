package cn.bnsr.edu_yun.backstage.resource.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.resource.service.FileAmountService;
import cn.bnsr.edu_yun.backstage.resource.view.AmountView;
import cn.bnsr.edu_yun.frontstage.resource.mapper.FileAmountMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.FileAmount;
import cn.bnsr.edu_yun.util.NumUtil;

public class FileAmountServiceImpl implements FileAmountService{
	@Autowired 
	private  FileAmountMapper  fileAmountMapper;
	
	
	public DataGrid datagrid(AmountView amountView) {
		DataGrid j = new DataGrid();
		amountView.setPage(NumUtil.startingNum(amountView.getPage(),amountView.getRows()));
		j.setRows(changeModel(find(amountView)));
		j.setTotal(total(amountView));
		return j;
	}

	private List<AmountView> changeModel(List<FileAmount> classifyList) {
		List<AmountView> classifys = new ArrayList<AmountView>();
		if (classifyList != null && classifyList.size() > 0) {
			for (FileAmount tu : classifyList) {
				AmountView u = new AmountView();
				BeanUtils.copyProperties(tu, u);
				classifys.add(u);
			}
		}
		return classifys;
	}

	private List<FileAmount> find(AmountView amountView) {
		return fileAmountMapper.find(amountView);
	}

	private Long total(AmountView amountView) {
		return fileAmountMapper.count(amountView);
	}
	
	
	@Override
	public void save(AmountView amountView) {
		FileAmount r = new FileAmount();
		BeanUtils.copyProperties(amountView, r);
		r.setCreate_time(new Date());
		r.setStatus((byte) 0);
		fileAmountMapper.insertSelective(r);
	}


	@Override
	public void update(AmountView amountView) {
		FileAmount r = new FileAmount();
		BeanUtils.copyProperties(amountView, r);
		fileAmountMapper.updateByPrimaryKeySelective(r);
	}

	@Override
	public void delete(String ids) {
		if (ids != null) {
			for (String id : ids.split(",")) {
				fileAmountMapper.deleteByPrimaryKey(Long.parseLong(id.trim()));
			}
		}
	}

	@Override
	public List<FileAmount> findAllAmount() {
		return fileAmountMapper.findAllAmount();
	}

}
