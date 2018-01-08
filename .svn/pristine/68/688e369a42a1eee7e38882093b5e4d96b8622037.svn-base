package cn.bnsr.edu_yun.backstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.backstage.base.service.SubjectService;
import cn.bnsr.edu_yun.frontstage.base.mapper.BookCatMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.PubverListMapper;
import cn.bnsr.edu_yun.frontstage.base.mapper.SubjectListMapper;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.po.PubverList;
import cn.bnsr.edu_yun.frontstage.base.po.SubjectList;

public class SubjectServiceImpl implements SubjectService{

	@Autowired
	private SubjectListMapper subMapper;
	@Autowired
	private PubverListMapper pubmapper;
	@Autowired
	private BookCatMapper bookCatMapper;
	
	@Override
	public List<SubjectList> selectByPid(String parent_id) {
		// TODO Auto-generated method stub
	
			return subMapper.selectByPid(parent_id);
		
		
	}


	@Override
	public List<PubverList> selectByPid1(String parent_id) {
		// TODO Auto-generated method stub
		return pubmapper.selectByPid(parent_id);
	}


	@Override
	public int edit(PubverList pubverList) {
		// TODO Auto-generated method stub
	
		return pubmapper.updateByPrimaryKeySelective(pubverList);
	}


	@Override
	public PubverList findPubverByKey(String id) {
		// TODO Auto-generated method stub
		return pubmapper.selectByPrimaryKey(id);
	}


	@Override
	public SubjectList findSubjectByKey(String id) {
		// TODO Auto-generated method stub
		return subMapper.selectByPrimaryKey(id);
	}

	@Override
	public BookCat findBookCatByKey(String id) {
		// TODO Auto-generated method stub
		return bookCatMapper.selectByPrimaryKey(id);
	}

	@Override
	public int edit(SubjectList pubver_list) {
		// TODO Auto-generated method stub
		return subMapper.updateByPrimaryKeySelective(pubver_list);
	}


	@Override
	public List<BookCat> selectByPid2(String parent_id) {
		// TODO Auto-generated method stub
		return bookCatMapper.selectByPid(parent_id);
	}


	@Override
	public int insertSubject(SubjectList subjectList) {
		// TODO Auto-generated method stub
		return subMapper.insertSelective(subjectList);
	}


	@Override
	public int insertPubverList(PubverList pubverList) {
		// TODO Auto-generated method stub
		return pubmapper.insertSelective(pubverList);
	}


	@Override
	public int insertBookCat(BookCat bookCat) {
		// TODO Auto-generated method stub
		return bookCatMapper.insertSelective(bookCat);
	}


	@Override
	public int updateSubject(SubjectList subjectList) {
		// TODO Auto-generated method stub
		return subMapper.updateByPrimaryKeySelective(subjectList);
	}


	@Override
	public int updatePubverList(PubverList pubverList) {
		// TODO Auto-generated method stub
		return pubmapper.updateByPrimaryKeySelective(pubverList);
	}


	@Override
	public int updateBookCat(BookCat bookCat) {
		// TODO Auto-generated method stub
		return bookCatMapper.updateByPrimaryKeySelective(bookCat);
	}


	@Override
	public int deleteSubject(String id) {
		// TODO Auto-generated method stub
		return subMapper.deleteByPrimaryKey(id);
	}


	@Override
	public int deletePubverList(String id) {
		// TODO Auto-generated method stub
		return pubmapper.deleteByPrimaryKey(id);
	}


	@Override
	public int deleteBookCat(String id) {
		// TODO Auto-generated method stub
		return bookCatMapper.deleteByPrimaryKey(id);
	}

}
