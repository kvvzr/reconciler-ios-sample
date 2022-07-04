/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/index.jsx":
/*!***********************!*\
  !*** ./src/index.jsx ***!
  \***********************/
/***/ (() => {

eval("function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }\n\nfunction _nonIterableSpread() { throw new TypeError(\"Invalid attempt to spread non-iterable instance.\\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.\"); }\n\nfunction _iterableToArray(iter) { if (typeof Symbol !== \"undefined\" && iter[Symbol.iterator] != null || iter[\"@@iterator\"] != null) return Array.from(iter); }\n\nfunction _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }\n\nfunction _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest(); }\n\nfunction _nonIterableRest() { throw new TypeError(\"Invalid attempt to destructure non-iterable instance.\\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.\"); }\n\nfunction _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === \"string\") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === \"Object\" && o.constructor) n = o.constructor.name; if (n === \"Map\" || n === \"Set\") return Array.from(o); if (n === \"Arguments\" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }\n\nfunction _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }\n\nfunction _iterableToArrayLimit(arr, i) { var _i = arr == null ? null : typeof Symbol !== \"undefined\" && arr[Symbol.iterator] || arr[\"@@iterator\"]; if (_i == null) return; var _arr = []; var _n = true; var _d = false; var _s, _e; try { for (_i = _i.call(arr); !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i[\"return\"] != null) _i[\"return\"](); } finally { if (_d) throw _e; } } return _arr; }\n\nfunction _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }\n\nvar _ReactBridge = ReactBridge,\n    register = _ReactBridge.register;\nvar _React = React,\n    useState = _React.useState;\n\nvar TodoItem = function TodoItem(_ref) {\n  var title = _ref.title;\n\n  // これは雑なTODO管理\n  var _useState = useState(false),\n      _useState2 = _slicedToArray(_useState, 2),\n      done = _useState2[0],\n      setDone = _useState2[1];\n\n  return /*#__PURE__*/React.createElement(\"hstack\", null, /*#__PURE__*/React.createElement(\"toggle\", {\n    isOn: done,\n    onChange: function onChange(value) {\n      setDone(value);\n    }\n  }), /*#__PURE__*/React.createElement(\"text\", {\n    strike: done\n  }, title));\n};\n\nregister(function () {\n  var _useState3 = useState(\"\"),\n      _useState4 = _slicedToArray(_useState3, 2),\n      text = _useState4[0],\n      setText = _useState4[1];\n\n  var _useState5 = useState([]),\n      _useState6 = _slicedToArray(_useState5, 2),\n      todos = _useState6[0],\n      setTodos = _useState6[1];\n\n  return /*#__PURE__*/React.createElement(\"vstack\", null, /*#__PURE__*/React.createElement(\"hstack\", null, /*#__PURE__*/React.createElement(\"textfield\", {\n    text: text,\n    placeholder: \"Todo\",\n    onChange: function onChange(text) {\n      setText(text);\n    }\n  }), /*#__PURE__*/React.createElement(\"button\", {\n    title: \"Add\",\n    onClick: function onClick() {\n      if (!text) {\n        return;\n      }\n\n      setTodos([].concat(_toConsumableArray(todos), [{\n        title: text\n      }]));\n      setText(\"\");\n    }\n  })), /*#__PURE__*/React.createElement(\"scroll\", null, /*#__PURE__*/React.createElement(\"vstack\", null, todos.map(function (todo) {\n    return /*#__PURE__*/React.createElement(TodoItem, {\n      title: todo.title\n    });\n  }))));\n});\n\n//# sourceURL=webpack://todo-sample/./src/index.jsx?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = {};
/******/ 	__webpack_modules__["./src/index.jsx"]();
/******/ 	
/******/ })()
;