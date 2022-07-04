import React from "expose-loader?exposes=React!react";
import Reconciler from "react-reconciler";
import {
	ConcurrentRoot,
	DiscreteEventPriority,
	ContinuousEventPriority,
	DefaultEventPriority
} from 'react-reconciler/constants'

global.setTimeout =
	(func, delay) => {
		HostConfigSwift.setTimeout(func, delay);
	};

const shallowDiff = (oldObj, newObj) => {
	const uniqueProps = new Set([...Object.keys(oldObj), ...Object.keys(newObj)]);
	// console.log("waiwai", "-----")
	// Array.from(uniqueProps).forEach((propName) => {
	// 	console.log("waiwai", typeof oldObj[propName], typeof newObj[propName], oldObj[propName], newObj[propName], oldObj[propName] != newObj[propName])
	// })
	return Array.from(uniqueProps).filter(propName => oldObj[propName] !== newObj[propName]);
};

const rootHostContext = {};
const childHostContext = {};

const HostConfig = {
	supportsMutation: true,
	createInstance(type, props) {
		return HostConfigSwift.createInstance(type, props);
	},
	createTextInstance(text, rootContainer, hostContext, internalHandle) {
		return HostConfigSwift.createTextInstance(text);
	},
	appendInitialChild: (parent, child) => {
		HostConfigSwift.appendInitialChild(parent, child);
	},
	finalizeInitialChildren: (domElement, type, props) => {},
	prepareUpdate(instance, type, oldProps, newProps, rootContainer, hostContext) {
		return shallowDiff(oldProps, newProps);
		// return [];
	},
	shouldSetTextContent: (type, props) => {
		return typeof props.children === "string" || typeof props.children === "number";
	},
	getRootHostContext: () => {
		return rootHostContext;
	},
	getChildHostContext: () => {
		return childHostContext;
	},
	prepareForCommit: () => {
		return null;
	},
	resetAfterCommit: () => {},
	scheduleTimeout(fn, delay) {
		HostConfigSwift.setTimeout(fn, delay);
	},
	appendChild(parent, child) {
		HostConfigSwift.appendChild(parent, child);
	},
	appendChildToContainer(container, child) {
		HostConfigSwift.appendChildToContainer(container, child);
	},
	insertBefore(parentInstance, child, beforeChild) {
		HostConfigSwift.insertBefore(parentInstance, child, beforeChild);
	},
	insertInContainerBefore(container, child, beforeChild) {
		HostConfigSwift.insertInContainerBefore(container, child, beforeChild);
	},
	removeChild(parentInstance, child) {
		HostConfigSwift.removeChild(parentInstance, child);
	},
	removeChildFromContainer(container, child) {
		HostConfigSwift.removeChildFromContainer(container, child);
	},
	resetTextContent(instance) {
		HostConfigSwift.resetTextContent(instance);
	},
	commitTextUpdate(textInstance, prevText, nextText) {
		HostConfigSwift.commitTextUpdate(textInstance, prevText, nextText);
	},
	commitUpdate(
		instance,
		updatePayload,
		type,
		prevProps,
		nextProps,
		internalHandle,
	) {
		HostConfigSwift.commitUpdate(
			instance,
			updatePayload,
			type,
			prevProps,
			nextProps,
		);
	},
	hideInstance(instance) {
		HostConfigSwift.hideInstance(instance);
	},
	hideTextInstance(instance) {
		HostConfigSwift.hideTextInstance(instance);
	},
	unhideInstance(instance, props) {
		HostConfigSwift.unhideInstance(instance, props);
	},
	unhideTextInstance(instance, text) {
		HostConfigSwift.unhideTextInstance(instance, text);
	},
	clearContainer(container) {
		HostConfigSwift.clearContainer(container);
	},
	supportsMicrotasks: true,
	scheduleMicrotask(fn) {
		HostConfigSwift.queueMicrotask(fn)
	},
	getCurrentEventPriority() {
		switch (HostConfigSwift.getCurrentEventPriority()) {
		case "DiscreteEventPriority":
			return DiscreteEventPriority;
		case "ContinuousEventPriority":
			return ContinuousEventPriority;
		default:
			return DefaultEventPriority;
		}
	},
	detachDeletedInstance(instance) {
	}
};

const ReactReconcilerInst = Reconciler(HostConfig);

let RootComponent = null;
let renderContainer = null;

global.render =
	() => {
		if (RootComponent == null) {
			return;
		}
		if (renderContainer == null) {
			renderContainer = ReactReconcilerInst.createContainer("root", ConcurrentRoot);
		}
		ReactReconcilerInst.updateContainer(<RootComponent />, renderContainer)
	};

global.ReactBridge =
	{
		register: (value) => {
			RootComponent = value;
		},
	};
