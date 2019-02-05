///////////////////////////////////////////////////////////
// 矩形波を生成
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('GenerateRect.sce'));// ディレクトリ変更
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

// 生成波形情報
samplingRate = 48000;
bits = 16;
duration = 30.0;     // sec
frequency = 2000; // Hz
amplitude = -3;     // dB(振幅)

samples = samplingRate * duration;  // サンプル数
nyquistFrequency = samplingRate / 2;    // ナイキスト周波数
amp = 10^(amplitude / 10);   // 振幅のリニア値

// 出力
output = zeros(samples);
ts = 0:1/samplingRate:duration;

// 理想の矩形波だとエイリアスノイズが出るのでsinの合成で生成する
f = frequency;
k = 1;
while f < nyquistFrequency
    n = 2*k - 1;    // 奇数次倍音のみ
    f = n * frequency;
    // sin波生成
    tmp = sin(2*%pi * f * ts);
    // 指定振幅と減衰量(1/n)
    output = output + (tmp * (amp/n));
    k = k + 1;
end

// ファイル出力
outputpath = './result/rect/';
outputFilename = 'rect_' + string(frequency) +  'hz' + '.wav';

mkdir(outputpath);
savewave(outputpath + outputFilename, output, samplingRate, bits);

// プロット
h = scf(1);
clf();
displayRect=[100, -90, 10000, 3];     // 表示領域
PlotFrequency(output, samplingRate, 'hn', h, 2, displayRect); // 出力波形
xgrid();
