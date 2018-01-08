package cn.bnsr.edu_yun.frontstage.resource.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.resource.mapper.File_commentMapper;
import cn.bnsr.edu_yun.frontstage.resource.po.File_comment;
import cn.bnsr.edu_yun.frontstage.resource.service.FileCommentService;

public class FileCommentServiceImpl implements FileCommentService {

	@Autowired
	private File_commentMapper fileCommentMapper;
	@Override
	public int insert(File_comment fileComment) {
		// TODO Auto-generated method stub
		return fileCommentMapper.insertSelective(fileComment);
	}
	@Override
	public List<File_comment> selectCommentByFileId(long file_id) {
		// TODO Auto-generated method stub
		return fileCommentMapper.selectCommentByFileId(file_id);
	}
	@Override
	public List<File_comment> selectCommentByFileIdAndUserId(long file_id,
			long user_id) {
		// TODO Auto-generated method stub
		return fileCommentMapper.selectCommentByFileIdAndUserId(file_id, user_id);
	}
	@Override
	public List<File_comment> selectCommentByFileIdAll(long file_id,
			Integer status, long start, long pageSize) {
		
		return fileCommentMapper.selectCommentByFileIdAll(file_id, status, start, pageSize);
	}
	@Override
	public int selectCountByFile(long file_id, Integer status) {
		// TODO Auto-generated method stub
		return fileCommentMapper.selectCountByFile(file_id, status);
	}
	@Override
	public int update(File_comment file_comment) {
		// TODO Auto-generated method stub
		return fileCommentMapper.updateByPrimaryKeySelective(file_comment);
	}

}
