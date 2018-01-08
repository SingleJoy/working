package cn.bnsr.edu_yun.frontstage.train.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.train.mapper.MessageFileMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.MessageMapper;
import cn.bnsr.edu_yun.frontstage.train.mapper.MessageRelationMapper;
import cn.bnsr.edu_yun.frontstage.train.po.Message;
import cn.bnsr.edu_yun.frontstage.train.po.MessageFile;
import cn.bnsr.edu_yun.frontstage.train.po.MessageRelation;
import cn.bnsr.edu_yun.frontstage.train.service.MessageService;
import cn.bnsr.edu_yun.frontstage.train.view.MessageView;

public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageMapper messageMapper;
	@Autowired
	private MessageRelationMapper messageRelationMapper;
	@Autowired
	private MessageFileMapper messageFileMapper;
	
	
	@Override
	public void saveMessage(MessageView messageView) {
		Message message = new Message();
		BeanUtils.copyProperties(messageView, message);
		message.setCreate_time(new Date());
		if(message.getStatus()==1){//发布
			message.setRelease_time(new Date());
		}
		messageMapper.insertSelective(message);
		MessageRelation messageRelation = new MessageRelation();
		BeanUtils.copyProperties(messageView, messageRelation);
		messageRelation.setMessage_id(message.getId());
		messageRelationMapper.insertSelective(messageRelation);
		if(messageView.getPath()!=""){
			MessageFile messageFile = new MessageFile();
			BeanUtils.copyProperties(messageView, messageFile);
			messageFile.setMessage_id(message.getId());
			messageFileMapper.insertSelective(messageFile);
		}
	}

	@Override
	public void updateMessage(MessageView messageView) {
		Message message = new Message();
		BeanUtils.copyProperties(messageView, message);
		if(message.getStatus()==1){//发布
			message.setRelease_time(new Date());
		}
		messageMapper.updateByPrimaryKeySelective(message);
		if(messageView.getMessage_relation_id()!=null){
			MessageRelation messageRelation = new MessageRelation();
			BeanUtils.copyProperties(messageView, messageRelation);
			messageRelation.setId(messageView.getMessage_relation_id());
			messageRelationMapper.updateByPrimaryKeySelective(messageRelation);
		}
		MessageFile messageFile = new MessageFile();
		BeanUtils.copyProperties(messageView, messageFile);
		if(messageView.getMessage_file_id()!=null){
			messageFile.setId(messageView.getMessage_file_id());
			messageFileMapper.updateByPrimaryKeySelective(messageFile);
		}else if(messageFile.getPath()!=null&&messageFile.getPath()!=""){
			messageFile.setMessage_id(message.getId());
			messageFileMapper.insertSelective(messageFile);
		}
	}

	@Override
	public List<MessageView> showAllMessage(MessageView messageView) {
		// TODO Auto-generated method stub
		return messageMapper.showAllMessage(messageView);
	}

	@Override
	public int countMessage(MessageView messageView) {
		// TODO Auto-generated method stub
		return messageMapper.countMessage(messageView);
	}

	@Override
	public void batchUpdateMessage(MessageView messageView) {
		Message message = new Message();
		BeanUtils.copyProperties(messageView, message);
		for(String id : messageView.getIds().split(",")){
			message.setId(Long.parseLong(id));
			messageMapper.updateByPrimaryKeySelective(message);
		}
		
	}

	@Override
	public MessageView selectOne(Long id) {
		// TODO Auto-generated method stub
		return messageMapper.selectOne(id);
	}

	@Override
	public MessageView showLastMessage(MessageView messageView) {
		if(messageView.getSource_id()==null||messageView.getSource_id()<=0){
			return null;
		}
		if(messageView.getSource_type()==null||messageView.getSource_type()<0){
			return null;
		}
		return messageMapper.showLastMessage(messageView);
	}

	@Override
	public List<MessageView> queryClassNotices(MessageView messageView) {
		return messageMapper.queryClassNotices(messageView);
	}

	@Override
	public void delClassNotice(long id) {
		messageMapper.deleteByPrimaryKey(id);
		messageRelationMapper.deleteByMessageId(id);
		messageFileMapper.deleteByMessageId(id);
	}

	@Override
	public void batchDelClassNotice(long[] ids) {
		for(int i=0;i<ids.length;i++){
			messageMapper.deleteByPrimaryKey(ids[i]);
			messageRelationMapper.deleteByMessageId(ids[i]);
			messageFileMapper.deleteByMessageId(ids[i]);
		}
	}

	@Override
	public int queryClassNoticesCount(MessageView messageView) {
		// TODO Auto-generated method stub
		return messageMapper.queryClassNoticesCount(messageView);
	}

	@Override
	public MessageView queryClassNoticeDetail(long id) {
		return messageMapper.queryClassNoticeDetail(id);
	}

	@Override
	public MessageFile selectMessageFile(long id) {
		
		return messageFileMapper.selectByPrimaryKey(id);
	}
}
