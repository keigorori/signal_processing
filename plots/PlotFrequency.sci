////////////////////////
// 周波数のプロット
////////////////////////
function PlotFrequency(signal, samplingRate, windowType, handle, style, displayRect)
// 波形サンプル数
N = size(signal, 'c');

// 窓の生成 & 補正係数設定
win = window(windowType, N);
if windowType =='hn'        // ハン窓
    win_adj_coef = 0.5;
elseif windowType =='hm'    // ハミング窓
    win_adj_coef = 0.54;
else                        // 矩形窓
    win_adj_coef = 1;
end

// フーリエ変換
FFT_abs = abs( fft(signal.*win) );          // 窓掛けた信号をfftして振幅をとる
FFT_normalize = FFT_abs / N;                // fft長による正規化(1/N))
FFT_adj = FFT_normalize * (2/win_adj_coef); //折り返し分を補正(2倍), 窓の影響を補正(1/win_adj_coef)
FFT_db = 20*log10(FFT_adj);                 // パワースペクトルに変換

// x軸(samplingRate/N：分解能、振幅スペクトルはN/2で線対称となるので0~N/2の範囲を使う)
xGrid = samplingRate*(0:(N/2))/N;

// プロット
scf(handle);
plot2d("ln", xGrid, FFT_db(1:size(xGrid,'c')), style, rect=displayRect);
xtitle('パワースペクトル', '[Hz]', '[dB]');

endfunction
