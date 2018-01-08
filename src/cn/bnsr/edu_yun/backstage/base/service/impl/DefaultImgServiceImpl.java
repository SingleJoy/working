package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.mapper.DefaultImgMapper;
import cn.bnsr.edu_yun.backstage.base.po.DefaultImg;
import cn.bnsr.edu_yun.backstage.base.service.DefaultImgService;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.DefaultImgView;
import cn.bnsr.edu_yun.util.NumUtil;

public class DefaultImgServiceImpl implements DefaultImgService {

	@Autowired
	private DefaultImgMapper defaultImgMapper;
	@Override
	public DataGrid datagrid(DefaultImgView defaultImg) {
		DataGrid j = new DataGrid();
		defaultImg.setPage(NumUtil.startingNum(defaultImg.getPage(),defaultImg.getRows()));
		j.setRows(find(defaultImg));
		j.setTotal(total(defaultImg));
		return j;
	}
	
	private List<DefaultImgView> find(DefaultImgView defaultImg){
		return defaultImgMapper.find(defaultImg);
	}
	
	private Long total(DefaultImgView defaultImg){
		return defaultImgMapper.count(defaultImg);
	}

	@Override
	public DefaultImg selectOne(Long id) {
		return defaultImgMapper.selectByPrimaryKey(id);
	}

	@Override
	public Integer getMaxSeq(DefaultImg img) {
		return defaultImgMapper.getMaxSeq(img);
	}

	@Override
	public void updateImg(DefaultImg img) {
		defaultImgMapper.updateByPrimaryKeySelective(img);
	}

	@Override
	public void saveImg(DefaultImg img) {
		defaultImgMapper.insertSelective(img);
	}

	@Override
	public List<DefaultImgView> queryCarousel(DefaultImgView condition) {
		return defaultImgMapper.queryCarousel(condition);
	}

}
