///////////////////////////////////////////////////////////
// wavファイルにバンドパスフィルタを掛けた結果をファイル出力
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('ApplyBPF.sce'));// ディレクトリ変更
exec( '../filters/Bandpass.sci');
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

// ファイル入力
inputPath = '../data/';
inputFilename = 'white_10sec_1ch_16bit_48k.wav';
[input, samplingRate, bits] = wavread(inputPath + inputFilename);  // ファイル読み込み

// 周波数の指定方法
cutoffMode = 'high_low'
if cutoffMode == 'center_band' then
    // 中心周波数から両端のカットオフ周波数を求める
    centerHz        = 3000;                    // 中心周波数
    band1_n         = 1                        // 1/n oct.バンド
    oct1_n          = nthroot(2, 2*band1_n);   // 2の(2n)乗根
    cutoffLowHz     = centerHz / oct1_n;
    cutoffHighHz    = centerHz * oct1_n;
elseif cutoffMode == 'high_low' then
    cutoffLowHz     = 1000;
    cutoffHighHz    = 2000;
end

// フィルタ適用
[output, freqResponse, freqGrid] = Bandpass(input, samplingRate, cutoffLowHz, cutoffHighHz, -60, 10);

// ファイル出力
outputpath = './result/bandpass/';
outputFilename = 'bandpass.wav';
if cutoffMode == 'center_band' then
    outputFilename = 'bandpass_' + 'c' + string(centerHz) + '_frac1_' + string(band1_n) + 'oct' + '.wav';
elseif cutoffMode == 'high_low' then
    outputFilename = 'bandpass_' + 'L' + string(cutoffLowHz) + '_H' + string(cutoffHighHz) + '.wav';
end

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

