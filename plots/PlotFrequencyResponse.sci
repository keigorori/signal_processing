////////////////////////
// 周波数応答のプロット
////////////////////////
function PlotFrequencyResponse(frequencyResponse, frequencyGrid, handle, style)

// デシベル変換
fr_dB = 20*log10(frequencyResponse);

// プロット
scf(handle);
plot2d("ln", frequencyGrid, fr_dB(1:size(frequencyGrid,'c')), style);
xtitle('Frequency response', '[Hz]', '[dB]');

endfunction
