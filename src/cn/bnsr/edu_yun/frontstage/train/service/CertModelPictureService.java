package cn.bnsr.edu_yun.frontstage.train.service;

import java.util.List;

import cn.bnsr.edu_yun.frontstage.train.po.CertModelPicture;
import cn.bnsr.edu_yun.frontstage.train.view.CertModelPictureView;

public interface CertModelPictureService {

	void saveCertModelPicture(CertModelPicture certModelPicture);
	
	Integer countCertModelPicture(CertModelPictureView certModelPictureView);
	
	List<CertModelPictureView> selectAllPicture(CertModelPictureView certModelPictureView);
	
	void deleteCertModelPicture(Long id);
	
	CertModelPicture selectOne(Long id);
	/**
	 * 
	 * 获取默认图片（头像、课程、培训.....）
	 * @param type
	 * @return
	 */
	CertModelPicture getDefaultImg(Integer type);
	
	void updateCertModelPicture(CertModelPicture certModelPicture);
}
