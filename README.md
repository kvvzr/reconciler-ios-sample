# reconciler-ios-sample

react-reconcilerを使ってiOS(UIKit)でレンダラーを作ってみるサンプルです

## コードの説明

### レンダラー

https://github.com/kvvzr/reconciler-ios-sample/tree/main/ReconcilerSample/Renderer

reconciler関連のコードがこの辺りにあります。HostConfigの定義もここです
JSのコードがReactBridge以下にあり、Swift側のコードを呼んでいることが確認できます

### ToDoアプリ(サンプル)

https://github.com/kvvzr/reconciler-ios-sample/tree/main/ReconcilerSample/TodoSample

Reactで書かれた簡単なサンプルです。アプリを起動すると、こちらが動いてる様子を確認できます

## ビルド方法

### Xcode
シンプルなiOSのプロジェクトになっているので、Xcodeで開いてビルドできます

### JS周りのビルド

必要であれば、ReactBridgeかTodoSampleディレクトリ内で以下を実行してください
```
# 初回はnpm installが必要
$ npm install

# JSのコードをiOSアプリ側に反映したいときは以下を実行してください
$ npm run build
```
