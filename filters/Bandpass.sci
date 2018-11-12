////////////////////////
// bandpass filter
////////////////////////
function output = Bandpass( input, samplingRate, cutoffFreq, filterOrder)
// wavのサイズ
N = size( input, 'c');
windowType = 'hn'; // ハン窓
cutoffFreq = cutoffFreq/samplingRate; // [0, 0.5]の係数に変換

//フィルタ生成＆適用
[ wft, wfm, fr] = wfir( 'bp', filterOrder, cutoffFreq, windowType, [1 0]);
output=convol( input, wft);
output = output(filterOrder:$); // 頭の(次数-1)サンプルは正しく出力されないので捨てる

endfunction