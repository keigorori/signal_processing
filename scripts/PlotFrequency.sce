///////////////////////////////////////////////////////////
// 入力波形の周波数特性をプロット
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('PlotFrequency.sce'));// ディレクトリ変更
exec( '../plots/PlotFrequency.sci');

// ファイル入力
inputPath = '../data/';
inputFilename = 'white_10sec_1ch_16bit_48k.wav';

[input, samplingRate, bits] = wavread(inputPath + inputFilename);  // ファイル読み込み

// プロット
h = scf(1);
clf();
displayRect=[100, -90, 10000, 3];     // 表示領域
PlotFrequency(input, samplingRate, 'hn', h, 2, displayRect); // 出力波形
xgrid();
