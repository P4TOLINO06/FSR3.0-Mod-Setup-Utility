// ---- FNV Hash 7c845ee5518dcf0b

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 Parameters01 : packoffset(c6);
  float4 Parameters02 : packoffset(c7);
  float4 Parameters03 : packoffset(c8);
  float4 Parameters04 : packoffset(c9);
  float4 Parameters05 : packoffset(c10);
  float4 ParamsArray01[16] : packoffset(c11);
  float4 Matrix01[4] : packoffset(c27);
  float4 Matrix02[4] : packoffset(c31);
  float4 Matrix03[4] : packoffset(c35);
  float4 Matrix04[4] : packoffset(c39);
  float4 Matrix05[4] : packoffset(c43);
  float4x4 tmatrix01 : packoffset(c47);
  float4x4 tmatrix02 : packoffset(c51);
  float4 tmatrix03[4] : packoffset(c55);
  float4 tmatrix04[4] : packoffset(c59);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState Sampler18_s : register(s14);
Texture2D<float4> Texture0 : register(t0);
Texture2D<float4> Texture3 : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = ScreenSize.yy * v0.xy;
  r0.z = ScreenSize.z * r0.y;
  r1.xyzw = Texture0.Sample(Sampler18_s, r0.xz).xyzw;
  r0.y = cmp(0.999989986 < r1.x);
  if (r0.y != 0) discard;
  r0.y = saturate(1 + -r1.x);
  r1.xyzw = Texture3.Sample(Sampler18_s, r0.xz).xyzw;
  r2.y = ScreenSize.y * ScreenSize.z;
  r2.x = ScreenSize.y;
  r0.y = 1 / r0.y;
  r3.xyzw = r2.xyxy * float4(-7,-7,7,7) + r0.xzxz;
  r4.xyzw = Texture0.SampleLevel(Sampler18_s, r3.xy, 0).xyzw;
  r5.xyzw = Texture3.SampleLevel(Sampler18_s, r3.xy, 0).xyzw;
  r0.w = saturate(1 + -r4.x);
  r0.w = -r0.w * r0.y + 1;
  r1.y = 6 * r0.w;
  r1.y = -abs(r1.y) * 0.75 + 0.5;
  r0.w = saturate(-r0.w * 1.5 + r1.y);
  r1.y = r5.x * r0.w;
  r1.x = r1.x * 0.0625 + r1.y;
  r0.w = 0.0625 + r0.w;
  r4.xyzw = r2.xyxy * float4(7,-7,-7,7) + r0.xzxz;
  r5.xyzw = Texture0.SampleLevel(Sampler18_s, r4.xy, 0).xyzw;
  r6.xyzw = Texture3.SampleLevel(Sampler18_s, r4.xy, 0).xyzw;
  r1.y = saturate(1 + -r5.x);
  r1.y = -r1.y * r0.y + 1;
  r1.z = 6 * r1.y;
  r1.z = -abs(r1.z) * 0.75 + 0.5;
  r1.y = saturate(-r1.y * 1.5 + r1.z);
  r1.x = r6.x * r1.y + r1.x;
  r0.w = r1.y + r0.w;
  r5.xyzw = Texture0.SampleLevel(Sampler18_s, r4.zw, 0).xyzw;
  r4.xyzw = Texture3.SampleLevel(Sampler18_s, r4.zw, 0).xyzw;
  r1.y = saturate(1 + -r5.x);
  r1.y = -r1.y * r0.y + 1;
  r1.z = 6 * r1.y;
  r1.z = -abs(r1.z) * 0.75 + 0.5;
  r1.y = saturate(-r1.y * 1.5 + r1.z);
  r1.x = r4.x * r1.y + r1.x;
  r0.w = r1.y + r0.w;
  r4.xyzw = Texture0.SampleLevel(Sampler18_s, r3.zw, 0).xyzw;
  r3.xyzw = Texture3.SampleLevel(Sampler18_s, r3.zw, 0).xyzw;
  r1.y = saturate(1 + -r4.x);
  r1.y = -r1.y * r0.y + 1;
  r1.z = 6 * r1.y;
  r1.z = -abs(r1.z) * 0.75 + 0.5;
  r1.y = saturate(-r1.y * 1.5 + r1.z);
  r1.x = r3.x * r1.y + r1.x;
  r0.w = r1.y + r0.w;
  r3.xyzw = r2.xyxy * float4(-7,0,0,-7) + r0.xzxz;
  r4.xyzw = Texture0.SampleLevel(Sampler18_s, r3.xy, 0).xyzw;
  r5.xyzw = Texture3.SampleLevel(Sampler18_s, r3.xy, 0).xyzw;
  r1.y = saturate(1 + -r4.x);
  r1.y = -r1.y * r0.y + 1;
  r1.z = 6 * r1.y;
  r1.z = -abs(r1.z) * 0.75 + 0.5;
  r1.y = saturate(-r1.y * 1.5 + r1.z);
  r1.x = r5.x * r1.y + r1.x;
  r0.w = r1.y + r0.w;
  r4.xyzw = Texture0.SampleLevel(Sampler18_s, r3.zw, 0).xyzw;
  r3.xyzw = Texture3.SampleLevel(Sampler18_s, r3.zw, 0).xyzw;
  r1.y = saturate(1 + -r4.x);
  r1.y = -r1.y * r0.y + 1;
  r1.z = 6 * r1.y;
  r1.z = -abs(r1.z) * 0.75 + 0.5;
  r1.y = saturate(-r1.y * 1.5 + r1.z);
  r1.x = r3.x * r1.y + r1.x;
  r0.w = r1.y + r0.w;
  r2.xyzw = r2.xyxy * float4(7,0,0,7) + r0.xzxz;
  r3.xyzw = Texture0.SampleLevel(Sampler18_s, r2.xy, 0).xyzw;
  r4.xyzw = Texture3.SampleLevel(Sampler18_s, r2.xy, 0).xyzw;
  r0.x = saturate(1 + -r3.x);
  r0.x = -r0.x * r0.y + 1;
  r0.z = 6 * r0.x;
  r0.z = -abs(r0.z) * 0.75 + 0.5;
  r0.x = saturate(-r0.x * 1.5 + r0.z);
  r0.z = r4.x * r0.x + r1.x;
  r0.x = r0.w + r0.x;
  r1.xyzw = Texture0.SampleLevel(Sampler18_s, r2.zw, 0).xyzw;
  r2.xyzw = Texture3.SampleLevel(Sampler18_s, r2.zw, 0).xyzw;
  r0.w = saturate(1 + -r1.x);
  r0.y = -r0.w * r0.y + 1;
  r0.w = 6 * r0.y;
  r0.w = -abs(r0.w) * 0.75 + 0.5;
  r0.y = saturate(-r0.y * 1.5 + r0.w);
  r0.z = r2.x * r0.y + r0.z;
  r0.x = r0.x + r0.y;
  r0.x = 1 / r0.x;
  o0.xyzw = r0.zzzz * r0.xxxx;
  return;
}