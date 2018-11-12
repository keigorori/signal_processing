///////////////////////////////////////////////////////////
// wavファイルにバンドパスフィルタを掛けた結果をファイル出力
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('bandpass.sce'));// ディレクトリ変更
exec( '../filters/Bandpass.sci');
exec( '../plots/PlotFrequency.sci');

inputPath = '../data/white_10sec_1ch_16bit_48k.wav';
outputpath = './result/bandpass/bandpass.wav';

// ファイル入力
[input, samplingRate, bits]=wavread(inputPath);  // ファイル読み込み

// フィルタ適用
output = Bandpass(input, samplingRate, [4000, 8000], 256);

// ファイル出力
mkdir('result/bandpass');
savewave(outputpath,output, samplingRate, bits);

// 入力と出力をプロット
clf();
PlotFrequency(input, samplingRate, scf(0), 2)
PlotFrequency(output, samplingRate, scf(0), 6)
