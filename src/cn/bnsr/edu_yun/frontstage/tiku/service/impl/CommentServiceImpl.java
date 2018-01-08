package cn.bnsr.edu_yun.frontstage.tiku.service.impl;

import java.util.Date;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.view.DataGrid;
import cn.bnsr.edu_yun.backstage.tiku.view.CommentView;
import cn.bnsr.edu_yun.frontstage.tiku.mapper.CommentMapper;
import cn.bnsr.edu_yun.frontstage.tiku.po.Comment;
import cn.bnsr.edu_yun.frontstage.tiku.service.CommentService;
import cn.bnsr.edu_yun.util.NumUtil;

public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	
	@Override
	public DataGrid datagrid(CommentView commentView) {
		DataGrid datagrid = new DataGrid();
		commentView.setPage(NumUtil.startingNum(commentView.getPage(), commentView.getRows()));
		datagrid.setRows(commentMapper.findAll(commentView));
		datagrid.setTotal(commentMapper.count(commentView));
		return datagrid;
	}

	@Override
	public void save(CommentView commentView) {
		Comment comment = new Comment();
		BeanUtils.copyProperties(commentView, comment);
		comment.setCreate_time(new Date());
		commentMapper.insertSelective(comment);

	}

	@Override
	public void update(CommentView commentView) {
		Comment comment = new Comment();
		BeanUtils.copyProperties(commentView, comment);
		commentMapper.updateByPrimaryKeySelective(comment);
	}

	@Override
	public CommentView getByPrimaryKey(Long id) {
		CommentView commentView = new CommentView();
		BeanUtils.copyProperties(commentMapper.selectByPrimaryKey(id), commentView);
		return commentView;
	}

	@Override
	public void delete(String ids) {
		if(ids!=null){
			for(String id:ids.split(",")){
				commentMapper.deleteByPrimaryKey(Long.parseLong(id.trim()));
			}
		}

	}

}
