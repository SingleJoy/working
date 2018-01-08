package cn.bnsr.edu_yun.frontstage.resource.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.resource.po.File_comment;

public interface FileCommentService {

	public  int insert(File_comment fileComment);
	
	 List<File_comment> selectCommentByFileId(long file_id);
	 
	 List<File_comment> selectCommentByFileIdAndUserId(long file_id,long user_id);
	 List<File_comment> selectCommentByFileIdAll(long file_id,Integer status,long start,long pageSize);
	 int selectCountByFile(long file_id,Integer status);
	 int update(File_comment file_comment);
}
