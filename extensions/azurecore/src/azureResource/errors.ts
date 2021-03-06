/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the Source EULA. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

'use strict';

export class AzureResourceCredentialError extends Error {
	constructor(
		message: string,
		public innerError: Error
	) {
		super(message);
	}
}
