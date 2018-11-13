////////////////////////
// 周波数応答のプロット
////////////////////////
function PlotFrequencyResponse(frequencyResponse, frequencyGrid, handle, style, diplayRect)

// パワースペクトル
fr_dB = 20*log10(frequencyResponse);

// プロット
scf(handle);
plot2d("ln", frequencyGrid, fr_dB(1:size(frequencyGrid,'c')), style, rect=displayRect);
xtitle('周波数応答', '[Hz]', '[dB]');

endfunction
