const electron = require('electron');

const {app}           = electron;
const {ipcMain}       = electron;
const {BrowserWindow} = electron;

let win;
let winDefaultOptions = {
	width: 480, height: 140, x: 200, y: 200, frame: false
}

/**
 * 表示ダイアログを作成
 */
app.on('ready', () => {
	win = new BrowserWindow(winDefaultOptions);

	win.loadURL('file://' + __dirname + '/dialog.html'); // template file
win.webContents.openDevTools();	// debug用
});
app.on('window-all-closed', app.quit);

// 移動処理
let offset = {x: 0, y: 0};
ipcMain.on('mouse-down', (e, clientX, clientY) => {
	offset.x = clientX, offset.y = clientY;
});
ipcMain.on('mouse-move', (e, posX, posY) => {
	win.setPosition(posX - offset.x, posY - offset.y);
});
// 終了時
ipcMain.on('quit', (e) => {
	app.quit();
});
