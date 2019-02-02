////////////////////////
// Comb filter
// IIR コムフィルタ
// frequency:Hz
// alpha:フィードバックの係数(-1 < alpha < 1)
////////////////////////

function [output, wfm, fr] = CombFilter(input, samplingRate, frequency, alpha)
N = size( input, 'c');          // 入力サンプル数

// 周波数から遅延サンプル数を求める
delaySamples = samplingRate/frequency;

// TODO:減衰量から遅延後に掛ける係数を求める

// 伝達関数
z = poly(0, "z");
h = 1 / (1-alpha*z^(-delaySamples));
H = syslin('d', h);   // システムとして定義

// フィルタ適用
output = flts(input, H);

// 周波数応答
T = 1 / samplingRate;
fr = linspace(0, samplingRate/2, samplingRate/2);
zfr = exp(%i*2*%pi*fr*T);   // zにe^(-2πifT)を入れて周波数応答を出す
hh = horner(h, zfr);
wfm = abs(hh);  // 振幅スペクトル

// ノーマライズ(フィルター後にやるべきかも)
peak = max(wfm);
wfm = wfm / peak;
output = output / peak;

endfunction
