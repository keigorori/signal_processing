////////////////////////
// highpass filter
// FIR カイザー窓
// cutoffFreq:Hz
// stopBandAttenuation:dB(パワー)
// stansitionBand:Hz
////////////////////////

function [output, wfm, fr] = Highpass(input, samplingRate, cutoffFreq, stopBandAttenuation, transitionBand)
// 減衰量からカイザー窓のパラメータを求める
// ひとまず-50dBより大きいものだけ対応
alpha = 0.1102*(-stopBandAttenuation-8.7);

// 減衰量と遷移帯域から次数を求める
tb = transitionBand * (2*%pi) / samplingRate;
filterOrder = (-stopBandAttenuation-7.95) / (2.285*tb);
filterOrder = ceil(filterOrder);
// HPFでは次数を奇数にする必要あり
if modulo(filterOrder,2) == 0 then
    filterOrder = filterOrder + 1;
end;

N = size( input, 'c');          // サンプル数
windowType = 'kr';              // カイザー窓
windowParameter = [alpha 0];
cutoffFreq = cutoffFreq/samplingRate; // [0, 0.5]の係数に変換
cf = [cutoffFreq 0];

// フィルタ生成＆適用(窓関数法)
[wft, wfm, fr] = wfir('hp', filterOrder, cf, windowType, windowParameter);
output=convol( input, wft);
output = output(filterOrder:$); // 頭の(次数-1)サンプルは正しく出力されないので捨てる

// 周波数応答(wfirのwfm出力は256サンプル固定なので自前で計算)
[wfm, fr] = frmag(wft, N/2);
fr = fr * samplingRate;

endfunction
