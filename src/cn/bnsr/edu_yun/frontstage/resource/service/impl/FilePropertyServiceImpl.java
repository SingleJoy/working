package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_propertyMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_property;
import cn.bnsr.edu_yun.frontstage.resource.service.FilePropertyService;
import cn.bnsr.edu_yun.frontstage.resource.view.FileView;

public class FilePropertyServiceImpl implements FilePropertyService{
	@Autowired
	private File_propertyMapper filePropertyMapper;
	
	@Override
	public int insert(File_property property) {
		return filePropertyMapper.insertSelective(property);
	}
	
	@Override
	public FileView queryCount(List<String> proIds) {
		return filePropertyMapper.queryCount(proIds);
	}

	@Override
	public int update(File_property property) {
		// TODO Auto-generated method stub
		return filePropertyMapper.updateByPrimaryKeySelective(property);
	}

	@Override
	public double querScoreNum(Long userId) {
		double scoreNum = 0.0;
		//教师所传文件总评分
		String totalScore = filePropertyMapper.querScoreNum(userId,"score");
		//文件有评分总数
	    String toalScoreFile = filePropertyMapper.querScoreNum(userId,"num");
	    NumberFormat nf = new  DecimalFormat("0.0"); 
	    if(totalScore != null && toalScoreFile != null){
			scoreNum = Double.parseDouble(nf.format(Double.parseDouble(totalScore)
					/ Double.parseDouble(toalScoreFile)));
	    }
	    return scoreNum;
	}


}
