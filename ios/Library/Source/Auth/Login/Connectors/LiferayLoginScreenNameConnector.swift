//
//  LiferayLoginEmailConnector.swift
//  Liferay-iOS-Widgets-Swift-Sample
//
//  Created by jmWork on 28/09/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

import UIKit


class LiferayLoginScreenNameConnector: LiferayLoginBaseConnector {

	override func sendGetUserRequest(#service: LRUserService_v62, error: NSErrorPointer) -> NSDictionary? {
		return service.getUserByScreenNameWithCompanyId(
				(LiferayServerContext.instance.companyId as NSNumber).longLongValue,
				screenName: userName,
				error: error)
	}

}
