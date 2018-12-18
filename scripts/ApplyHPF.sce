///////////////////////////////////////////////////////////
// wavファイルにハイパスフィルタを掛けた結果をファイル出力
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('ApplyHPF.sce'));// ディレクトリ変更
exec( '../filters/Highpass.sci');
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

// ファイル入力
inputPath = '../data/';
inputFilename = 'white_10sec_1ch_16bit_48k.wav';
[input, samplingRate, bits] = wavread(inputPath + inputFilename);  // ファイル読み込み

// カットオフ周波数
cutoffHz = 3000;

// フィルタ適用
[output, freqResponse, freqGrid] = Highpass(input, samplingRate, cutoffHz, -60, 10);

// ファイル出力
outputpath = './result/highpass/';
outputFilename = 'highpass_' + string(cutoffHz) + '.wav';
mkdir(outputpath);
savewave(outputpath + outputFilename, output, samplingRate, bits);

// プロット
h = scf(1);
clf();
displayRect=[100, -90, 10000, 3];     // 表示領域
//PlotFrequency(input, samplingRate, 'hn', h, 2, displayRect); // 入力波形
PlotFrequency(output, samplingRate, 'hn', h, 2, displayRect); // 出力波形
xgrid();

h = scf(2);
clf();
PlotFrequencyResponse(freqResponse, freqGrid, h, 6, displayRect); // 周波数応答
xgrid();

