package com.liferay.mobile.screens.auth.login.connector;

import com.liferay.mobile.android.service.Session;
import com.liferay.mobile.screens.auth.forgotpassword.connector.ForgotPasswordConnector;
import com.liferay.mobile.screens.service.v62.ScreensuserService;

import org.json.JSONObject;

/**
 * @author Javier Gamarra
 */
public class ScreensUserConnector62 implements ForgotPasswordConnector, CurrentUserConnector {

	public ScreensUserConnector62(Session session) {
		_screensuserService = new ScreensuserService(session);
	}

	@Override
	public void sendPasswordByEmailAddress(long companyId, String emailAddress) throws Exception {
		_screensuserService.sendPasswordByEmailAddress(companyId, emailAddress);
	}

	public void sendPasswordByScreenName(long companyId, String screenName) throws Exception {
		_screensuserService.sendPasswordByScreenName(companyId, screenName);
	}

	@Override
	public void sendPasswordByUserId(long userId) throws Exception {
		_screensuserService.sendPasswordByUserId(userId);
	}

	@Override
	public JSONObject getCurrentUser() throws Exception {
		return _screensuserService.getCurrentUser();
	}

	private ScreensuserService _screensuserService;
}
