///////////////////////////////////////////////////////////
// wavファイルにコムフィルタを掛けた結果をファイル出力
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('ApplyCombFilter.sce'));// ディレクトリ変更
exec( '../filters/CombFilter.sci');
exec( '../filters/Highpass.sci');
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

// ファイル入力
inputPath = '../data/';
//inputFilename = 'click_1ch_16bit_48k.wav';
inputFilename = 'white_10sec_1ch_16bit_48k.wav';
[input, samplingRate, bits] = wavread(inputPath + inputFilename);  // ファイル読み込み

frequency = 500
alpha = 0.99;
// フィルタ適用
[output, freqResponse, freqGrid] = CombFilter(input, samplingRate, frequency, alpha);

// ファイル出力
outputpath = './result/comb/';
outputFilename = basename(inputFilename) + '_comb' + string(frequency) + '_' + string(alpha) + '.wav';

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

