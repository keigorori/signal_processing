////////////////////////
// 周波数のプロット
////////////////////////
function PlotFrequency(signal, samplingRate, windowType, handle, style)
// 波形サンプル数
N = size(signal, 'c');

// フーリエ変換
win = window(windowType, N);
FFT = abs( fft(signal.*win)/sqrt(N) ); // 振幅をとる
FFT_db = 20*log10(FFT);

// x軸(samplingRate/N：分解能、振幅スペクトルはN/2で線対称となるので0~N/2の範囲を使う)
xGrid = samplingRate*(0:(N/2))/N;

// プロット
scf(handle);
plot2d("ln", xGrid, FFT_db(1:size(xGrid,'c')), style);
xtitle('FFT', '[Hz]', '[dB]');

endfunction
