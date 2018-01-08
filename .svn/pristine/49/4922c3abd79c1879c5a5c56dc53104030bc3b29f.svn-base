package cn.bnsr.edu_yun.backstage.base.service;

import java.util.List;

import cn.bnsr.edu_yun.backstage.base.po.DefaultImg;
import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.base.view.DefaultImgView;

public interface DefaultImgService {

	/**默认图片*/
	DataGrid datagrid(DefaultImgView defaultImg);
	
	DefaultImg selectOne(Long id);
	
	Integer getMaxSeq(DefaultImg img);
	
	void updateImg(DefaultImg img);
	
	void saveImg(DefaultImg img);
	
	/**前台轮播图片展示*/
	List<DefaultImgView> queryCarousel(DefaultImgView condition);
}
