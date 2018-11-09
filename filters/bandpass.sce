////////////////////////
// bandpass filter
////////////////////////
cd(get_absolute_file_path('bandpass.sce'));// ディレクトリ変更

filepath = '../data/white_10sec_1ch_16bit_48k.wav';
outputpath = './result/bandpass.wav';

// ファイル入力
[input,Fs,bits]=wavread(filepath);  // ファイル読み込み
N = size(input,'c');    // wavのサイズ

// フィルタ設定
filter_order = 256;
cutoff_freq = [5000/Fs,10000/Fs];
window_type = 'hn' // ハン窓

//フィルタ生成＆適用
[wft,wfm,fr]=wfir('bp', filter_order, cutoff_freq, window_type,[1 0]);
output=convol(input,wft);
output = output(filter_order:$); // 頭の(次数-1)サンプルは正しく出力されないので捨てる

// ファイル出力
mkdir('result');
savewave(outputpath,output, Fs, bits);



////////////////////////
// プロット
////////////////////////
// フーリエ変換(振幅特性を測るため絶対値をとる)
win = window('hn',N);
FFT_in = abs( fft(input.*win)/sqrt(N) );
FFT_in_db = 10*log10(FFT_in);
FFT_out = abs( fft(output.*win)/sqrt(N));
FFT_out_db = 10*log10(FFT_out);

// x軸の設定(Fs/N：分解能、振幅スペクトルはN/2で線対称となるので0~N/2の範囲を使う)
axis_x = Fs*(0:(N/2))/N;

// グラフ出力
clf();
scf(0);
plot2d("ln",axis_x, FFT_in_db(1:size(axis_x,'c')), 2);
plot2d("ln",axis_x, FFT_out_db(1:size(axis_x,'c')), 6);
xtitle('FFT','[Hz]','[dB]');
