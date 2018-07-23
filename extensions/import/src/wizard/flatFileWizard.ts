/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the Source EULA. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/
'use strict';

import * as vscode from 'vscode';
import * as path from 'path';
import * as sqlops from 'sqlops';
import { fileConfig } from './fileConfig';
import { prosePreview } from './prosePreview';
import { modifyColumns } from './modifyColumns';
import { summary } from './summary';

export function flatFileWizard() {
	let wizard = sqlops.window.modelviewdialog.createWizard('Flat file import wizard');
		let page1 = sqlops.window.modelviewdialog.createWizardPage('New Table Details');
		let page2 = sqlops.window.modelviewdialog.createWizardPage('Preview Data');
		let page3 = sqlops.window.modelviewdialog.createWizardPage('Modify Columns');
		let page4 = sqlops.window.modelviewdialog.createWizardPage('Summary');
		page1.registerContent(async (view) => {
			await fileConfig(view);
		});
		page2.registerContent(async (view) => {
			await prosePreview(view);
		});
		page3.registerContent(async (view) => {
			await modifyColumns(view);
		});
		page4.registerContent(async (view) => {
			await summary(view);
		});
		wizard.registerOperation({
			displayName: 'test task',
			description: 'task description',
			connection: null,
			isCancelable: true,
			operation: (op) => {
			op.updateStatus(sqlops.TaskStatus.InProgress);
			op.updateStatus(sqlops.TaskStatus.InProgress, 'Task is running');
			setTimeout(() => {
				op.updateStatus(sqlops.TaskStatus.Succeeded);
			}, 5000);
		}});
		wizard.pages = [page1, page2, page3, page4];
		wizard.open();
}

//pageonecontent()