package cn.bnsr.edu_yun.frontstage.xbjy.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.bnsr.edu_yun.frontstage.base.po.User;
import cn.bnsr.edu_yun.frontstage.train.service.UserAppraiseService;
import cn.bnsr.edu_yun.frontstage.xbjy.mapper.LessonUserIdentityMapper;
import cn.bnsr.edu_yun.frontstage.xbjy.po.LessonUserIdentity;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonAttachmentService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserIdentityService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.LessonUserTaskService;
import cn.bnsr.edu_yun.frontstage.xbjy.service.ProblemStudyService;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonAttachmentView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonHeadView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonLeftView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserIdentityView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.LessonUserTaskView;
import cn.bnsr.edu_yun.frontstage.xbjy.view.ProblemStudyView;

public class LessonUserIdentityServiceImpl implements LessonUserIdentityService{

	@Autowired
	private LessonUserIdentityMapper lessonUserIdentityMapper;
	@Autowired
	private LessonUserTaskService lessonUserTaskService;
	@Autowired
	private ProblemStudyService problemStudyService;
	@Autowired
	private LessonAttachmentService lessonAttachmentService;
	@Autowired
	private UserAppraiseService userAppraiseService;
	
	@Override
	public void saveAll(LessonUserIdentityView lessonUserIdentityView) {
		LessonUserIdentity lessonUserIdentity = new LessonUserIdentity();
		BeanUtils.copyProperties(lessonUserIdentityView, lessonUserIdentity);

		lessonUserIdentityMapper.insertSelective(lessonUserIdentity);
		
	}
	
	@Override
	public List<LessonUserIdentityView> findTeacher(LessonUserIdentityView lessonUserIdentityView) {
		return lessonUserIdentityMapper.findTeacher(lessonUserIdentityView);
	}


	@Override  
	public void deleteUser(String checkedId) {  
	    lessonUserIdentityMapper.deleteUser(checkedId.split(","));  
	} 
	
	@Override
	public List<LessonUserIdentityView> findUserByIdentity(LessonUserIdentityView lessonUserIdentityView) {
		return lessonUserIdentityMapper.findUserByIdentity(lessonUserIdentityView);
	}
	
	@Override  
	public void setUserIdentityBylu(LessonUserIdentityView lessonUserIdentityView) {  
	    lessonUserIdentityMapper.setUserIdentityBylu(lessonUserIdentityView);  
	}
	
	@Override  
	public void setUserIdentity(LessonUserIdentityView lessonUserIdentityView) {  
	    lessonUserIdentityMapper.setUserIdentity(lessonUserIdentityView);  
	}
	
	@Override
	public LessonUserIdentity getById(Long id) {
		return lessonUserIdentityMapper.selectByPrimaryKey(id);
	}
	
	@Override
	public Integer countMember(LessonUserIdentityView lessonUserIdentityView) {
		return lessonUserIdentityMapper.countMember(lessonUserIdentityView);
	}
	
	@Override
	public LessonUserIdentityView findUserIdentity(LessonUserIdentityView lessonUserIdentityView) {
		return lessonUserIdentityMapper.findUserIdentity(lessonUserIdentityView);
	}
	
	@Override
	public List<LessonUserIdentityView> findTeacherNozd(LessonUserIdentityView lessonUserIdentityView) {
		return lessonUserIdentityMapper.findTeacherNozd(lessonUserIdentityView);
	}
	//获取整个课例左侧权限必要信息
	@Override
	public LessonLeftView getLessonLeft(Long lesson_id,User user){
		LessonLeftView lessonLeftView = new LessonLeftView();
		LessonUserIdentityView lessonUserIdentityView =new LessonUserIdentityView();
		LessonUserTaskView lessonUserTaskView =new LessonUserTaskView();
		lessonUserIdentityView.setLesson_id(lesson_id);
		lessonUserTaskView.setLesson_id(lesson_id);
		
		
		lessonUserIdentityView.setIdentity(-1);
		//不管身份得到所有组员信息
		List<LessonUserIdentityView> lessonUserIdentitys =findTeacher(lessonUserIdentityView);

		//查看登录用户是否在组员当中
		int userInLesson = 0;
		if(user!=null){
			for(int i=0;i<lessonUserIdentitys.size();i++){
				if(user.getId()==lessonUserIdentitys.get(i).getUser_id()){
					userInLesson =1;
				}
			}
		}
		
		//获取登录用户在课例中所有任务（权限）
		int UserIdentity = -1;
		if(user!=null){
		lessonUserTaskView.setUser_id(user.getId());
		lessonUserIdentityView.setUser_id(user.getId());
		if(findUserIdentity(lessonUserIdentityView)!=null){
		UserIdentity = findUserIdentity(lessonUserIdentityView).getIdentity();
		}
		}else{
			lessonUserTaskView.setUser_id(-1);
		}
		//当前用户在课例中被分配的所有任务
		List<LessonUserTaskView> lessonUserPurviewList =lessonUserTaskService.findPurview(lessonUserTaskView);
		
		//大环节权限
		int UserPlan = 0;
		int UserPrepare = 0;
		int UserClass = 0;
		int UserAssessment = 0;
		int UserIntrospection = 0;
		if(lessonUserPurviewList!=null){
			for(int i=0;i<lessonUserPurviewList.size();i++){
				if(lessonUserPurviewList.get(i).getPurview()<200&&lessonUserPurviewList.get(i).getPurview()>100){
					UserPlan =1;
				}else if(lessonUserPurviewList.get(i).getPurview()<300&&lessonUserPurviewList.get(i).getPurview()>200){
					UserPrepare =1;
				}else if(lessonUserPurviewList.get(i).getPurview()<400&&lessonUserPurviewList.get(i).getPurview()>300){
					UserClass =1;
				}else if(lessonUserPurviewList.get(i).getPurview()<500&&lessonUserPurviewList.get(i).getPurview()>400){
					UserAssessment =1;
				}else if(lessonUserPurviewList.get(i).getPurview()<600&&lessonUserPurviewList.get(i).getPurview()>500){
					UserIntrospection =1;
				}
			}
			}
		//如果当前登录用户是组长，则必有计划权限
		lessonUserIdentityView.setIdentity(0);
		List<LessonUserIdentityView> lessonUserIdentityZz =findUserByIdentity(lessonUserIdentityView);
		if(user!=null&&lessonUserIdentityZz.size()>0){
		if(user.getId()==lessonUserIdentityZz.get(0).getUser_id()){
			UserPlan =1;
		}
		}
		//判断全部任务的完成状态  未完成
		/************
		int plan101 = 1;

		List<LessonUserTaskView> lessonUserTasks =new ArrayList();
		lessonUserTaskView.setPurview(101);
		lessonUserTasks =lessonUserTaskService.findByPurview(lessonUserTaskView);
		if(lessonUserTasks!=null && lessonUserTasks.size()>0){
			for(int i=0;i<lessonUserTasks.size();i++){
				if(lessonUserTasks.get(i).getStatus()==0){
					plan101=0;
				}
			}
			}else{
				plan101=2;
			}
			**********/
		lessonLeftView.setPlan101(purviewStatus(lessonUserTaskView,101));
		lessonLeftView.setPlan102(purviewStatus(lessonUserTaskView,102));
		lessonLeftView.setPlan103(purviewStatus(lessonUserTaskView,103));
		lessonLeftView.setPrepare201(purviewStatus(lessonUserTaskView,201));
		lessonLeftView.setPrepare202(purviewStatus(lessonUserTaskView,202));
		lessonLeftView.setPrepare203(purviewStatus(lessonUserTaskView,203));
		lessonLeftView.setPrepare204(purviewStatus(lessonUserTaskView,204));
		lessonLeftView.setClass301(purviewStatus(lessonUserTaskView,301));
		lessonLeftView.setClass302(purviewStatus(lessonUserTaskView,302));
		lessonLeftView.setClass303(purviewStatus(lessonUserTaskView,303));
		lessonLeftView.setClass304(purviewStatus(lessonUserTaskView,304));
		lessonLeftView.setAssessment401(purviewStatus(lessonUserTaskView,401));
		lessonLeftView.setAssessment402(purviewStatus(lessonUserTaskView,402));
		lessonLeftView.setAssessment403(purviewStatus(lessonUserTaskView,403));
		lessonLeftView.setIntrospection501(purviewStatus(lessonUserTaskView,501));
		lessonLeftView.setIntrospection502(purviewStatus(lessonUserTaskView,502));
		lessonLeftView.setIntrospection503(purviewStatus(lessonUserTaskView,503));
		
		lessonLeftView.setUserIdentity(UserIdentity);
		lessonLeftView.setUserPlan(UserPlan);
		lessonLeftView.setUserPrepare(UserPrepare);
		lessonLeftView.setUserClass(UserClass);
		lessonLeftView.setUserAssessment(UserAssessment);
		lessonLeftView.setUserIntrospection(UserIntrospection);
		lessonLeftView.setLessonUserPurviewList(lessonUserPurviewList);
		lessonLeftView.setLessonUserList(lessonUserIdentitys);
		lessonLeftView.setUser(user);
		lessonLeftView.setUserInLesson(userInLesson);
		
		return lessonLeftView;
	}
	
	//获取整个课例头文件必要信息
	@Override
	public  LessonHeadView getLessonHead(Long lesson_id){
		LessonHeadView lessonHeadView = new LessonHeadView();
		LessonUserIdentityView lessonUserIdentityView =new LessonUserIdentityView();
		LessonUserTaskView lessonUserTaskView =new LessonUserTaskView();
		ProblemStudyView problemStudyView =new ProblemStudyView();
		LessonAttachmentView lessonAttachmentView =new LessonAttachmentView();
		
		lessonUserIdentityView.setLesson_id(lesson_id);
		lessonUserTaskView.setLesson_id(lesson_id);
		problemStudyView.setLesson_id(lesson_id);
		lessonAttachmentView.setLesson_id(lesson_id);
		
		
		lessonUserIdentityView.setIdentity(-1);
		lessonHeadView.setMemberTotal(countMember(lessonUserIdentityView));
				
		lessonUserTaskView.setUser_id(-1);
		lessonUserTaskView.setStatus(-1);
		lessonHeadView.setTaskTotal(lessonUserTaskService.countTask(lessonUserTaskView));
				
		lessonUserTaskView.setStatus(2);
		lessonHeadView.setAccomplishedTotal(lessonUserTaskService.countTask(lessonUserTaskView));
				
		problemStudyView.setUser_id(-1);
		problemStudyView.setPurview(-1);
		lessonHeadView.setProblemTotal(problemStudyService.countDiscussion(problemStudyView));
			
		lessonAttachmentView.setUser_id(-1);
		lessonAttachmentView.setPurview(-1);
		lessonHeadView.setArticleTotal(lessonAttachmentService.countAttachment(lessonAttachmentView));
		
		
		//评价总数
		long lessonTotalAppraise = userAppraiseService.selectCountBySourceId(lesson_id,3);
		//评价总分
		Integer lessonTotalScore=userAppraiseService.selectTotalScore(lesson_id,3);
		 
		lessonHeadView.setLessonTotalAppraise(lessonTotalAppraise);
		if (lessonTotalAppraise != 0 && lessonTotalScore != null){
			lessonHeadView.setLessonTotalScore(Integer.parseInt((lessonTotalScore/lessonTotalAppraise)+""));
		}else{
			lessonHeadView.setLessonTotalScore(5);
		}
		return lessonHeadView;
	}
	
	
	@Override
	public Integer purviewStatus(LessonUserTaskView lessonUserTaskView ,int purview) {
		int status = 1;//0为未完成1为已完成2为未指定

		List<LessonUserTaskView> lessonUserTasks =new ArrayList();
		lessonUserTaskView.setPurview(purview);
		lessonUserTasks =lessonUserTaskService.findByPurview(lessonUserTaskView);
		if(lessonUserTasks!=null && lessonUserTasks.size()>0){
			for(int i=0;i<lessonUserTasks.size();i++){
				if(lessonUserTasks.get(i).getStatus()==0){
					status=0;
				}
			}
			}else{
				status=2;
			}
		return status;
	}
	
}
