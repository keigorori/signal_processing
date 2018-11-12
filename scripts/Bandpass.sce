///////////////////////////////////////////////////////////
// wavファイルにバンドパスフィルタを掛けた結果をファイル出力
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('bandpass.sce'));// ディレクトリ変更
exec( '../filters/Bandpass.sci');
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

inputPath = '../data/white_10sec_1ch_16bit_48k.wav';
outputpath = './result/bandpass/bandpass.wav';

// ファイル入力
[input, samplingRate, bits] = wavread(inputPath);  // ファイル読み込み

// フィルタ適用
[output, freqResponse, freqGrid] = Bandpass(input, samplingRate, [4000, 8000], 2048);

// ファイル出力
mkdir('result/bandpass');
savewave(outputpath,output, samplingRate, bits);

// プロット
h = scf(1);
clf();
//PlotFrequency(input, samplingRate, h, 2); // 入力波形
PlotFrequency(output, samplingRate, h, 2); // 出力波形
PlotFrequencyResponse(freqResponse, freqGrid, h, 6); // 周波数応答


