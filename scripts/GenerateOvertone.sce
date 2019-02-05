///////////////////////////////////////////////////////////
// 倍音列を生成
///////////////////////////////////////////////////////////
clear();
cd(get_absolute_file_path('GenerateOvertone.sce'));// ディレクトリ変更
exec( '../plots/PlotFrequency.sci');
exec( '../plots/PlotFrequencyResponse.sci');

// 生成波形情報
samplingRate = 48000;
bits = 16;
duration = 1.5;     // sec
fundamentalFrequency = 500; // Hz
amplitude = 0;     // dB(パワー)
attenuationType = '1/n^2'; // 減衰タイプ

samples = samplingRate * duration;  // サンプル数
nyquistFrequency = samplingRate / 2;    // ナイキスト周波数
amp = 10^(amplitude / (2*10));   // 振幅のリニア値

// 出力
output = zeros(samples);
ts = 0:1/samplingRate:duration;

f = fundamentalFrequency;
n = 1;
while f < nyquistFrequency
    f = n * fundamentalFrequency;
    // sin波生成
    tmp = sin(2*%pi * f * ts);
    
    // 減衰量
    select attenuationType
    case '1/n' then
        atte = 1/n;
    case '1/n^2' then
        atte = 1/(n^2);
    else
        atte = 1;
    end

    tmp = tmp * amp * atte;
    output = output + tmp;
    n = n + 1;
end


// ファイル出力
outputpath = './result/overtone/';
outputFilename = 'overtone_' + string(fundamentalFrequency) + '.wav';

mkdir(outputpath);
savewave(outputpath + outputFilename, output, samplingRate, bits);

// プロット
h = scf(1);
clf();
displayRect=[100, -90, 10000, 3];     // 表示領域
PlotFrequency(output, samplingRate, 'hn', h, 2, displayRect); // 出力波形
xgrid();
