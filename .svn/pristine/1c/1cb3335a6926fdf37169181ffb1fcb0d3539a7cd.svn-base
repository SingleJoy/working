package cn.bnsr.edu_yun.frontstage.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.mapper.BookCatMapper;
import cn.bnsr.edu_yun.frontstage.base.po.BookCat;
import cn.bnsr.edu_yun.frontstage.base.service.BookCatService;

public class BookCatServiceImpl implements BookCatService{
	@Autowired
	private BookCatMapper bookCatMapper;
	
	@Override
	public List<BookCat> queryBookCat(String bookId) {
		return bookCatMapper.queryBookCat(bookId);
	}

	@Override
	public BookCat selectBybooId(String bookCatelogId) {
		// TODO Auto-generated method stub
		return bookCatMapper.selectBybooId(bookCatelogId);
	}

	@Override
	public BookCat selectById(String id) {
		// TODO Auto-generated method stub
		return bookCatMapper.selectByPrimaryKey(id);
	}

}
