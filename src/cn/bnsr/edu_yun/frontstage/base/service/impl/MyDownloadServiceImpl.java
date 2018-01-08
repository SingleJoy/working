package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.MyDownloadMapper;
import cn.bnsr.edu_yun.frontstage.base.service.MyDownloadService;
import cn.bnsr.edu_yun.frontstage.base.view.MyCollectView;

public class MyDownloadServiceImpl implements MyDownloadService{
	@Autowired
	private MyDownloadMapper myDownloadMapper;

	@Override
	public List<MyCollectView> showDownload(MyCollectView myCollectView) {
		// TODO Auto-generated method stub
		return myDownloadMapper.showDownload(myCollectView);
	}

	@Override
	public int queryTotalDownload(MyCollectView myCollectView) {
		// TODO Auto-generated method stub
		return myDownloadMapper.queryTotalDownload(myCollectView);
	}

}
