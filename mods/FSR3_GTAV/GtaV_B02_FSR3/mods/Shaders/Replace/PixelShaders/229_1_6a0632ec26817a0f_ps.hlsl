// ---- FNV Hash 6a0632ec26817a0f

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 DynamicScaling : packoffset(c6);
  float4 Parameters01 : packoffset(c7);
  float4 Parameters02 : packoffset(c8);
  float4 Parameters03 : packoffset(c9);
  float4 Parameters04 : packoffset(c10);
  float4 Parameters05 : packoffset(c11);
  float4 Parameters06 : packoffset(c12);
  float4 Parameters07 : packoffset(c13);
  float4 Parameters08 : packoffset(c14);
  float4 Matrix01[4] : packoffset(c15);
  float4 Matrix02[4] : packoffset(c19);
  float4 Matrix03[4] : packoffset(c23);
  float4 Matrix04[4] : packoffset(c27);
  float4 Matrix05[4] : packoffset(c31);
  float SSAOsplitcount : packoffset(c35) = {2};
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

SamplerState Sampler8_s : register(s8);
SamplerState Sampler9_s : register(s9);
Texture2D<float4> Texture0 : register(t0);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.y = Parameters01.y * Parameters01.z;
  r0.x = Parameters01.y;
  r1.xyzw = r0.xyxy * float4(-0.75,-0.75,0.75,0.75) + v1.xyxy;
  r0.xyzw = r0.xyxy * float4(0.75,-0.75,-0.75,0.75) + v1.xyxy;
  r2.x = Texture0.Sample(Sampler9_s, r1.xy).x;
  r2.w = Texture0.Sample(Sampler9_s, r1.zw).x;
  r2.y = Texture0.Sample(Sampler9_s, r0.xy).x;
  r2.z = Texture0.Sample(Sampler9_s, r0.zw).x;
  r0.xyzw = float4(1,1,1,1) + -r2.xyzw;
  r0.xyzw = max(float4(9.99999972e-10,9.99999972e-10,9.99999972e-10,9.99999972e-10), r0.xyzw);
  r0.xyzw = float4(1,1,1,1) / r0.xyzw;
  r1.x = Texture0.Sample(Sampler8_s, v1.xy).x;
  r1.x = 1 + -r1.x;
  r1.x = max(9.99999972e-10, r1.x);
  r1.x = 1 / r1.x;
  r0.xyzw = r0.xyzw / r1.xxxx;
  r0.xyzw = float4(1,1,1,1) + -r0.xyzw;
  r1.xyzw = float4(16,16,16,16) * r0.xyzw;
  r1.xyzw = -abs(r1.xyzw) * float4(0.75,0.75,0.75,0.75) + float4(0.5,0.5,0.5,0.5);
  r0.xyzw = saturate(-r0.xyzw * float4(4,4,4,4) + r1.xyzw);
  r0.xyzw = r0.xyzw + r0.xyzw;
  r0.xyzw = r0.xyzw * r0.xyzw;
  o0.xyzw = min(float4(1,1,1,1), r0.xyzw);
  return;
}